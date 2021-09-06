// ignore_for_file: avoid_catching_errors
import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as gql;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:oxidized/oxidized.dart';
import 'package:source_span/source_span.dart';
import 'package:crypto/crypto.dart' show sha256;
import 'introspection.dart';

/// Transforms any [Map] into `Map<String, dynamic>`.
Map<String, dynamic>? foldToStringDynamic(Map map) {
  return map.keys.fold<Map<String, dynamic>>(
    <String, dynamic>{},
    (out, Object? k) => out..[k.toString()] = map[k],
  );
}

/// A Dart implementation of a GraphQL server.
class GraphQL {
  /// Any custom types to include in introspection information.
  final List<GraphQLType> customTypes = [];

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s,
  /// when the related field has no resolver.
  final FutureOr<T> Function<T, P>(P, String, Map<String, dynamic>)?
      defaultFieldResolver;

  GraphQLSchema _schema;

  // TODO: https://www.apollographql.com/docs/apollo-server/performance/apq/
  final Map<String, DocumentNode> persistedQueries = {};

  GraphQL(
    GraphQLSchema schema, {
    bool introspect = true,
    this.defaultFieldResolver,
    List<GraphQLType> customTypes = const <GraphQLType>[],
  }) : _schema = schema {
    if (customTypes.isNotEmpty) {
      this.customTypes.addAll(customTypes);
    }

    if (introspect) {
      final allTypes = fetchAllTypes(schema, this.customTypes);

      _schema = reflectSchema(_schema, allTypes);

      for (final type in allTypes.toSet()) {
        if (!this.customTypes.contains(type)) {
          this.customTypes.add(type);
        }
      }
    }

    if (_schema.queryType != null) this.customTypes.add(_schema.queryType!);
    if (_schema.mutationType != null) {
      this.customTypes.add(_schema.mutationType!);
    }
    if (_schema.subscriptionType != null) {
      this.customTypes.add(_schema.subscriptionType!);
    }
  }

  Object? computeValue(
    GraphQLType? targetType,
    ValueNode node,
    Map<String, dynamic>? values,
  ) =>
      node.accept(GraphQLValueComputer(targetType, values));

  GraphQLType convertType(TypeNode node) {
    if (node is ListTypeNode) {
      return GraphQLListType<Object?, Object?>(convertType(node.type));
    } else if (node is NamedTypeNode) {
      switch (node.name.value) {
        case 'Int':
          return graphQLInt;
        case 'Float':
          return graphQLFloat;
        case 'String':
          return graphQLString;
        case 'Boolean':
          return graphQLBoolean;
        case 'ID':
          return graphQLId;
        case 'Date':
        case 'DateTime':
          return graphQLDate;
        default:
          return customTypes.firstWhere(
            (t) => t.name == node.name.value,
            orElse: () => throw ArgumentError(
              'Unknown GraphQL type: "${node.name.value}"',
            ),
          );
      }
    } else {
      throw ArgumentError('Invalid GraphQL type: "${node.span!.text}"');
    }
  }

  // TODO: the output should be nullable
  // TODO: the output should contain a list of GraphQLExceptions from the resolvers
  // if there are query inputs or validation errors, it is handled with thrown exceptions, but
  // if there are errors inside resolvers, those should be returned
  // https://graphql.org/learn/serving-over-http/
  //   - field should only be included if the error occurred during execution.
  Future<Object> parseAndExecute(
    String text, {
    String? operationName,

    /// [sourceUrl] may be either a [String], a [Uri], or `null`.
    dynamic sourceUrl,
    Map<String, Object?>? variableValues,
    Map<String, Object?>? extensions,
    Object? initialValue,
    Map<String, Object?>? globalVariables,
  }) {
    final document = getDocumentNode(
      text,
      sourceUrl: sourceUrl,
      extensions: extensions,
    );
    return executeRequest(
      _schema,
      document,
      operationName: operationName,
      initialValue: initialValue,
      variableValues: variableValues,
      globalVariables: globalVariables,
    );
  }

  DocumentNode getDocumentNode(
    String text, {
    dynamic sourceUrl,
    Map<String, Object?>? extensions,
  }) {
    // '/graphql?extensions={"persistedQuery":{"version":1,"sha256Hash":"ecf4edb46db40b5132295c0291d62fb65d6759a9eedfa4d5d612dd5ec54a6b38"}}'
    final persistedQuery =
        extensions == null ? null : extensions['persistedQuery'];

    String? sha256Hash;
    if (persistedQuery is Map<String, Object?>) {
      final version = int.tryParse(persistedQuery['version'] as String? ?? '');
      sha256Hash = persistedQuery['sha256Hash']! as String;
      // TODO: PERSISTED_QUERY_NOT_FOUND
    }

    final errors = <GraphQLExceptionError>[];
    late final DocumentNode document;
    if (persistedQueries.containsKey(text)) {
      document = persistedQueries[text]!;
    } else {
      final digestHex = sha256.convert(utf8.encode(text)).toString();
      if (persistedQueries.containsKey(digestHex)) {
        document = persistedQueries[digestHex]!;
      } else {
        try {
          document = gql.parseString(text, url: sourceUrl);
        } on SourceSpanException catch (e) {
          errors.add(GraphQLExceptionError(
            e.message,
            locations: [
              GraphExceptionErrorLocation.fromSourceLocation(e.span?.start),
            ],
          ));
        }

        if (errors.isNotEmpty) {
          throw GraphQLException(errors);
        }
        persistedQueries[digestHex] = document;
      }
    }
    return document;
  }

  Future<Object> executeRequest(
    GraphQLSchema schema,
    DocumentNode document, {
    String? operationName,
    Map<String, dynamic>? variableValues,
    Object? initialValue,
    Map<String, dynamic>? globalVariables,
  }) async {
    final _globalVariables = globalVariables ?? <String, dynamic>{};
    final operation = getOperation(document, operationName);
    final coercedVariableValues =
        coerceVariableValues(schema, operation, variableValues);
    if (operation.type == OperationType.query) {
      return executeQuery(document, operation, schema, coercedVariableValues,
          initialValue, _globalVariables);
    } else if (operation.type == OperationType.subscription) {
      return subscribe(document, operation, schema, coercedVariableValues,
          _globalVariables, initialValue);
    } else {
      return executeMutation(document, operation, schema, coercedVariableValues,
          initialValue, _globalVariables);
    }
  }

  OperationDefinitionNode getOperation(
    DocumentNode document,
    String? operationName,
  ) {
    final ops = document.definitions.whereType<OperationDefinitionNode>();

    if (operationName == null) {
      return ops.length == 1
          ? ops.first
          : throw GraphQLException.fromMessage(
              'This document does not define any operations.');
    } else {
      return ops.firstWhere(
        (d) => d.name!.value == operationName,
        orElse: () => throw GraphQLException.fromMessage(
          'Missing required operation "$operationName".',
        ),
      );
    }
  }

  Map<String, dynamic> coerceVariableValues(
    GraphQLSchema schema,
    OperationDefinitionNode operation,
    Map<String, dynamic>? variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final variableDefinitions = operation.variableDefinitions;

    for (final variableDefinition in variableDefinitions) {
      final variableName = variableDefinition.variable.name.value;
      final variableType = variableDefinition.type;
      final defaultValue = variableDefinition.defaultValue;
      final Object? value = variableValues?[variableName];

      if (value == null) {
        if (defaultValue != null) {
          coercedValues[variableName] = computeValue(
              convertType(variableType), defaultValue.value!, variableValues);
        } else if (variableType.isNonNull) {
          throw GraphQLException.fromSourceSpan(
              'Missing required variable "$variableName".',
              variableDefinition.span!);
        }
      } else {
        final type = convertType(variableType);
        final validation = type.validate(variableName, value);

        if (!validation.successful) {
          throw GraphQLException(
            validation.errors
                .map(
                  (e) => GraphQLExceptionError(
                    e,
                    locations: [
                      GraphExceptionErrorLocation.fromSourceLocation(
                        variableDefinition.span?.start,
                      )
                    ],
                  ),
                )
                .toList(),
          );
        } else {
          final coercedValue = type.deserialize(
            schema.serdeCtx,
            value,
          ) as Object?;
          coercedValues[variableName] = coercedValue;
        }
      }
    }

    return coercedValues;
  }

  Future<Map<String, dynamic>> executeQuery(
    DocumentNode document,
    OperationDefinitionNode query,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Object? initialValue,
    Map<String, dynamic> globalVariables,
  ) async {
    final queryType = schema.queryType;
    final selectionSet = query.selectionSet;
    if (queryType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a query type.');
    }
    return executeSelectionSet(schema.serdeCtx, document, selectionSet,
        queryType, initialValue, variableValues, globalVariables);
  }

  Future<Map<String, dynamic>> executeMutation(
    DocumentNode document,
    OperationDefinitionNode mutation,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Object? initialValue,
    Map<String, dynamic> globalVariables,
  ) async {
    final mutationType = schema.mutationType;

    if (mutationType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a mutation type.');
    }

    final selectionSet = mutation.selectionSet;
    return executeSelectionSet(schema.serdeCtx, document, selectionSet,
        mutationType, initialValue, variableValues, globalVariables);
  }

  Future<Stream<Map<String, dynamic>>> subscribe(
    DocumentNode document,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
    Object? initialValue,
  ) async {
    final sourceStream = await createSourceEventStream(document, subscription,
        schema, variableValues, globalVariables, initialValue);
    return mapSourceToResponseEvent(sourceStream, subscription, schema,
        document, initialValue, variableValues, globalVariables);
  }

  Future<MapEntry<String, Stream<Object?>>> createSourceEventStream(
    DocumentNode document,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Map<String, dynamic>? globalVariables,
    Object? initialValue,
  ) async {
    final selectionSet = subscription.selectionSet;
    final subscriptionType = schema.subscriptionType;
    if (subscriptionType == null) {
      throw GraphQLException.fromSourceSpan(
          'The schema does not define a subscription type.',
          subscription.span!);
    }
    final groupedFieldSet =
        collectFields(document, subscriptionType, selectionSet, variableValues);
    if (groupedFieldSet.length != 1) {
      throw GraphQLException.fromSourceSpan(
          'The grouped field set from this query must have exactly one entry.',
          selectionSet.span!);
    }
    final fields = groupedFieldSet.entries.first.value;
    final fieldNode = fields.first;
    final fieldName = fieldNode.alias?.value ?? fieldNode.name.value;
    final argumentValues = coerceArgumentValues(
        schema.serdeCtx, subscriptionType, fieldNode, variableValues);
    final stream = await resolveFieldEventStream(
      subscriptionType,
      initialValue,
      fieldName,
      argumentValues,
      globalVariables,
    );
    // TODO: don't use MapEntry
    return MapEntry(fieldName, stream);
  }

  Stream<Map<String, Object?>> mapSourceToResponseEvent(
    MapEntry<String, Stream<Object?>> sourceStream,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    DocumentNode document,
    Object? initialValue,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async* {
    await for (final event in sourceStream.value) {
      try {
        final selectionSet = subscription.selectionSet;
        final subscriptionType = schema.subscriptionType;

        final data = await executeSelectionSet(
          schema.serdeCtx,
          document,
          selectionSet,
          subscriptionType!,
          // TODO: improve this. Send same level field for execution?
          _SubscriptionEvent({sourceStream.key: event}),
          variableValues,
          globalVariables,
        );

        // completeValue(
        //   schema.serdeCtx,
        //   document,
        //   sourceStream.key,
        //   ctx.objectField.type,
        //   ctx.field,
        //   event,
        //   variableValues,
        //   globalVariables,
        // )
        yield {'data': data};
      } on GraphQLException catch (e) {
        yield {
          'data': null,
          'errors': [e.errors.map((e) => e.toJson()).toList()]
        };
      }
    }
  }

  Future<Stream<Object?>> resolveFieldEventStream(
    GraphQLObjectType subscriptionType,
    Object? rootValue,
    String fieldName,
    Map<String, dynamic> argumentValues,
    Map<String, dynamic>? globalVariables,
  ) async {
    final field = subscriptionType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () {
        throw GraphQLException.fromMessage(
            'No subscription field named "$fieldName" is defined.');
      },
    );
    final resolver = field.resolve!;
    final reqCtx = ReqCtx(
      args: argumentValues,
      object: rootValue,
      globals: globalVariables ?? {},
      // TODO:
      parentCtx: null,
    );
    final Object? result = await resolver(rootValue, reqCtx);
    if (result is Stream) {
      return result;
    } else {
      return Stream.fromIterable([result]);
    }
  }

  Future<Map<String, dynamic>> executeSelectionSet(
    SerdeCtx serdeCtx,
    DocumentNode document,
    SelectionSetNode selectionSet,
    GraphQLObjectType<Object?> objectType,
    Object? objectValue,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    final groupedFieldSet =
        collectFields(document, objectType, selectionSet, variableValues);
    final resultMap = <String, dynamic>{};
    final futureResultMap = <String, FutureOr<dynamic>>{};

    final objectCtx = ResolveObjectCtx(
      serdeCtx: serdeCtx,
      objectType: objectType,
      objectValue: objectValue,
      // TODO:
      // variableValues:
      //     Map<String, dynamic>.from(globalVariables ?? <String, dynamic>{})
      //       ..addAll(variableValues),
      variableValues: variableValues,
      globalVariables: globalVariables,
    );

    for (final responseKey in groupedFieldSet.keys) {
      final fields = groupedFieldSet[responseKey]!;
      for (final field in fields) {
        final fieldNode = field;
        final fieldName = fieldNode.alias?.value ?? fieldNode.name.value;
        FutureOr<dynamic> futureResponseValue;

        if (fieldName == '__typename') {
          futureResponseValue = objectType.name;
        } else {
          final objectField = objectType.fields.firstWhereOrNull(
            (f) => f.name == fieldName,
          );
          if (objectField == null) continue;
          futureResponseValue = executeField<Object?, Object?>(
            document,
            ResolveFieldCtx(
              objectCtx: objectCtx,
              objectField: objectField,
              fieldName: fieldName,
              field: field,
            ),
          );
        }

        futureResultMap[responseKey] = futureResponseValue;
      }
    }
    for (final f in futureResultMap.keys) {
      resultMap[f] = await futureResultMap[f];
    }
    return resultMap;
  }

  Future<T> executeField<T, P>(
    DocumentNode document,
    ResolveFieldCtx<T, P> ctx,
  ) async {
    final objectCtx = ctx.objectCtx;
    final argumentValues = coerceArgumentValues(
      objectCtx.serdeCtx,
      objectCtx.objectType,
      ctx.field,
      objectCtx.variableValues,
    );
    final resolvedValue = await resolveFieldValue<T, P>(
      objectCtx.serdeCtx,
      ctx.objectField,
      objectCtx.objectValue,
      objectCtx.serializedObject,
      ctx.fieldName,
      argumentValues,
      objectCtx.globalVariables,
    );
    return await completeValue(
      objectCtx.serdeCtx,
      document,
      ctx.fieldName,
      ctx.objectField.type,
      ctx.field,
      resolvedValue,
      objectCtx.variableValues,
      objectCtx.globalVariables,
    ) as T;
  }

  Map<String, dynamic> coerceArgumentValues(
    SerdeCtx serdeCtx,
    GraphQLObjectType objectType,
    FieldNode field,
    Map<String, dynamic> variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final argumentValues = field.arguments;
    final fieldName = field.alias?.value ?? field.name.value;
    final desiredField = objectType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () => throw FormatException(
          '${objectType.name} has no field named "$fieldName".'),
    );
    final argumentDefinitions = desiredField.inputs;

    for (final argumentDefinition in argumentDefinitions) {
      final argumentName = argumentDefinition.name;
      final argumentType = argumentDefinition.type;
      final Object? defaultValue = argumentDefinition.defaultValue;

      final argumentValue =
          argumentValues.firstWhereOrNull((a) => a.name.value == argumentName);

      if (argumentValue == null) {
        if (defaultValue != null || argumentDefinition.defaultsToNull) {
          coercedValues[argumentName] = defaultValue;
        } else if (argumentType is GraphQLNonNullableType) {
          throw GraphQLException.fromMessage(
            'Missing value for argument "$argumentName" of field "$fieldName".',
          );
        } else {
          continue;
        }
      } else {
        try {
          // TODO: verify
          final node = argumentValue.value;
          if (node is VariableNode &&
              variableValues.containsKey(node.name.value)) {
            /// variable values where already validated and
            /// coerced in coerceVariableValues
            coercedValues[argumentName] = variableValues[node.name.value];
            continue;
          }
          final value = computeValue(
            argumentType,
            node,
            variableValues,
          );
          final validation = argumentType.validate(
            argumentName,
            value,
          );

          if (!validation.successful) {
            final errors = <GraphQLExceptionError>[
              GraphQLExceptionError(
                'Type coercion error for value of argument'
                ' "$argumentName" of field "$fieldName".',
                locations: [
                  GraphExceptionErrorLocation.fromSourceLocation(
                      argumentValue.value.span?.start)
                ],
              )
            ];

            for (final error in validation.errors) {
              errors.add(
                GraphQLExceptionError(
                  error,
                  locations: [
                    GraphExceptionErrorLocation.fromSourceLocation(
                        argumentValue.value.span?.start)
                  ],
                ),
              );
            }

            throw GraphQLException(errors);
          } else {
            final Object? coercedValue = validation.value;
            coercedValues[argumentName] = coercedValue;
          }
        } on TypeError catch (e) {
          throw GraphQLException(<GraphQLExceptionError>[
            GraphQLExceptionError(
              'Type coercion error for value of argument '
              '"$argumentName" of field "$fieldName".',
              locations: [
                GraphExceptionErrorLocation.fromSourceLocation(
                    argumentValue.value.span?.start)
              ],
            ),
            GraphQLExceptionError(
              e.toString(),
              locations: [
                GraphExceptionErrorLocation.fromSourceLocation(
                    argumentValue.value.span?.start)
              ],
            ),
          ]);
        }
      }
    }

    return coercedValues;
  }

  Future<T> resolveFieldValue<T, P>(
    SerdeCtx serdeCtx,
    GraphQLObjectField<T, Object?, P> field,
    P objectValue,
    Map<String, Object?>? Function() serealizedValue,
    String fieldName,
    Map<String, dynamic> argumentValues,
    Map<String, dynamic> globalVariables,
  ) async {
    // TODO: put field.resolve first
    if (objectValue is _SubscriptionEvent) {
      return objectValue.event[fieldName] as T;
    } else if (field.resolve != null) {
      return await field.resolve!(
        objectValue,
        ReqCtx<P>(
          args: argumentValues,
          object: objectValue,
          globals: globalVariables,
          // TODO:
          parentCtx: null,
        ),
      );
    } else if (objectValue is Map) {
      return objectValue[fieldName] as T;
    } else {
      final serealized = serealizedValue();
      if (serealized != null) {
        return serealized[fieldName] as T;
      }
      if (defaultFieldResolver != null) {
        return await defaultFieldResolver!(
            objectValue, fieldName, argumentValues);
      }

      return null as T;
    }
  }

  Future<Object?> completeValue(
    SerdeCtx serdeCtx,
    DocumentNode document,
    String fieldName,
    GraphQLType fieldType,
    SelectionNode field,
    Object? result,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    if (fieldType is GraphQLNonNullableType) {
      final innerType = fieldType.ofType;
      final completedResult = await completeValue(serdeCtx, document, fieldName,
          innerType, field, result, variableValues, globalVariables);

      if (completedResult == null) {
        throw GraphQLException.fromMessage(
            'Null value provided for non-nullable field "$fieldName".');
      } else {
        return completedResult;
      }
    }

    if (result == null) {
      return null;
    }

    if (fieldType is GraphQLListType) {
      if (result is! Iterable) {
        throw GraphQLException.fromMessage(
          'Value of field "$fieldName" must be a list '
          'or iterable, got $result instead.',
        );
      }

      final innerType = fieldType.ofType;
      final futureOut = <Future<Object?>>[];

      for (final resultItem in result) {
        futureOut.add(completeValue(
            serdeCtx,
            document,
            '(item in "$fieldName")',
            innerType,
            field,
            resultItem,
            variableValues,
            globalVariables));
      }

      final out = <Object?>[];
      for (final f in futureOut) {
        out.add(await f);
      }

      return out;
    }

    if (fieldType is GraphQLScalarType) {
      try {
        final validation = fieldType.validate(fieldName, result);

        if (!validation.successful) {
          return null;
        } else {
          return validation.value;
        }
      } on TypeError {
        throw GraphQLException.fromMessage(
          'Value of field "$fieldName" must be '
          '${fieldType.valueType}, got $result instead.',
        );
      }
    }

    if (fieldType is GraphQLObjectType || fieldType is GraphQLUnionType) {
      GraphQLObjectType objectType;

      if (fieldType is GraphQLObjectType && !fieldType.isInterface) {
        objectType = fieldType;
      } else {
        objectType = resolveAbstractType(fieldName, fieldType, result);
      }

      final subSelectionSet = mergeSelectionSets(field);
      return executeSelectionSet(serdeCtx, document, subSelectionSet,
          objectType, result, variableValues, globalVariables);
    }

    throw UnsupportedError('Unsupported type: $fieldType');
  }

  GraphQLObjectType resolveAbstractType(
    String fieldName,
    GraphQLType type,
    Object result,
  ) {
    List<GraphQLObjectType> possibleTypes;

    if (type is GraphQLObjectType) {
      if (type.isInterface) {
        possibleTypes = type.possibleTypes;
      } else {
        return type;
      }
    } else if (type is GraphQLUnionType) {
      possibleTypes = type.possibleTypes.cast();
    } else {
      throw ArgumentError();
    }

    final errors = <GraphQLExceptionError>[];

    for (final t in possibleTypes) {
      try {
        // TODO: should we serialize?
        final serialized = t.serializeSafe(result);
        final validation = t.validate(
          fieldName,
          serialized,
        );

        if (validation.successful) {
          return t;
        }

        errors.addAll(validation.errors.map((m) => GraphQLExceptionError(m)));
      } on GraphQLException catch (e) {
        errors.addAll(e.errors);
      }
    }

    errors.insert(
      0,
      GraphQLExceptionError('Cannot convert value $result to type $type.'),
    );

    throw GraphQLException(errors);
  }

  SelectionSetNode mergeSelectionSets(SelectionNode field) {
    final selections = <SelectionNode>[];

    if (field is FieldNode && field.selectionSet != null) {
      selections.addAll(field.selectionSet!.selections);
    } else if (field is InlineFragmentNode) {
      selections.addAll(field.selectionSet.selections);
    }

    return SelectionSetNode(selections: selections);
  }

  Map<String, List<FieldNode>> collectFields(
    DocumentNode document,
    GraphQLObjectType? objectType,
    SelectionSetNode selectionSet,
    Map<String, dynamic> variableValues, {
    List<Object?>? visitedFragments,
  }) {
    final groupedFields = <String, List<FieldNode>>{};
    visitedFragments ??= [];

    for (final selection in selectionSet.selections) {
      if (getDirectiveValue('skip', 'if', selection, variableValues) == true) {
        continue;
      }
      if (getDirectiveValue('include', 'if', selection, variableValues) ==
          false) {
        continue;
      }

      if (selection is FieldNode) {
        final responseKey = selection.alias?.value ?? selection.name.value;
        final groupForResponseKey =
            groupedFields.putIfAbsent(responseKey, () => []);
        groupForResponseKey.add(selection);
      } else if (selection is FragmentSpreadNode) {
        final fragmentSpreadName = selection.name.value;
        if (visitedFragments.contains(fragmentSpreadName)) continue;
        visitedFragments.add(fragmentSpreadName);
        final fragment = document.definitions
            .whereType<FragmentDefinitionNode>()
            .firstWhereOrNull((f) => f.name.value == fragmentSpreadName);

        if (fragment == null) continue;
        final fragmentType = fragment.typeCondition;
        if (!doesFragmentTypeApply(objectType, fragmentType)) continue;
        final fragmentSelectionSet = fragment.selectionSet;
        final fragmentGroupFieldSet = collectFields(
            document, objectType, fragmentSelectionSet, variableValues);

        for (final responseKey in fragmentGroupFieldSet.keys) {
          final fragmentGroup = fragmentGroupFieldSet[responseKey]!;
          final groupForResponseKey =
              groupedFields.putIfAbsent(responseKey, () => []);
          groupForResponseKey.addAll(fragmentGroup);
        }
      } else if (selection is InlineFragmentNode) {
        final fragmentType = selection.typeCondition;
        if (fragmentType != null &&
            !doesFragmentTypeApply(objectType, fragmentType)) continue;
        final fragmentSelectionSet = selection.selectionSet;
        final fragmentGroupFieldSet = collectFields(
            document, objectType, fragmentSelectionSet, variableValues);

        for (final responseKey in fragmentGroupFieldSet.keys) {
          final fragmentGroup = fragmentGroupFieldSet[responseKey]!;
          final groupForResponseKey =
              groupedFields.putIfAbsent(responseKey, () => []);
          groupForResponseKey.addAll(fragmentGroup);
        }
      }
    }

    return groupedFields;
  }

  Object? getDirectiveValue(
    String name,
    String argumentName,
    SelectionNode selection,
    Map<String, dynamic> variableValues,
  ) {
    if (selection is! FieldNode) return null;
    final directive = selection.directives.firstWhereOrNull((d) {
      if (d.arguments.isEmpty) return false;
      final vv = d.arguments[0].value;
      if (vv is VariableNode) {
        return vv.name.value == name;
      } else {
        return computeValue(null, vv, variableValues) == name;
      }
    });

    if (directive == null) return null;
    if (directive.arguments[0].name.value != argumentName) return null;

    final vv = directive.arguments[0].value;
    if (vv is VariableNode) {
      final vname = vv.name;
      if (!variableValues.containsKey(vname)) {
        throw GraphQLException.fromSourceSpan(
            'Unknown variable: "$vname"', vv.span!);
      }
      return variableValues[vname as String];
    }
    return computeValue(null, vv, variableValues);
  }

  bool doesFragmentTypeApply(
    GraphQLObjectType? objectType,
    TypeConditionNode fragmentType,
  ) {
    final typeNode = NamedTypeNode(
        name: fragmentType.on.name,
        span: fragmentType.on.span,
        isNonNull: fragmentType.on.isNonNull);
    final type = convertType(typeNode);
    if (type is GraphQLObjectType && !type.isInterface) {
      for (final field in type.fields) {
        if (!objectType!.fields.any((f) => f.name == field.name)) return false;
      }
      return true;
    } else if (type is GraphQLObjectType && type.isInterface) {
      return objectType!.isImplementationOf(type);
    } else if (type is GraphQLUnionType) {
      return type.possibleTypes
          .any((t) => objectType!.isImplementationOf(t as GraphQLObjectType));
    }

    return false;
  }
}

class GraphQLValueComputer extends SimpleVisitor<Object> {
  final GraphQLType? targetType;
  final Map<String, dynamic>? variableValues;

  GraphQLValueComputer(this.targetType, this.variableValues);

  @override
  Object visitBooleanValueNode(BooleanValueNode node) => node.value;

  @override
  Object? visitEnumValueNode(EnumValueNode node) {
    if (targetType == null) {
      throw GraphQLException.fromSourceSpan(
          'An enum value was given, but in this context, its type cannot be deduced.',
          node.span!);
    } else if (targetType is! GraphQLEnumType) {
      throw GraphQLException.fromSourceSpan(
          'An enum value was given, but the type "${targetType!.name}" is not an enum.',
          node.span!);
    } else {
      final enumType = targetType as GraphQLEnumType;
      final matchingValue =
          enumType.values.firstWhereOrNull((v) => v.name == node.name.value);
      if (matchingValue == null) {
        throw GraphQLException.fromSourceSpan(
          'The enum "${targetType!.name}" has no member named "${node.name.value}".',
          node.span!,
        );
      } else {
        return matchingValue.value;
      }
    }
  }

  @override
  Object visitFloatValueNode(FloatValueNode node) => node.value;

  @override
  Object visitIntValueNode(IntValueNode node) => node.value;

  @override
  Object visitListValueNode(ListValueNode node) {
    return node.values.map((v) => v.accept(this)).toList();
  }

  @override
  Object visitObjectValueNode(ObjectValueNode node) {
    return Map.fromEntries(node.fields.map((f) {
      return MapEntry(f.name.value, f.value.accept(this));
    }));
  }

  @override
  Object? visitNullValueNode(NullValueNode node) => null;

  @override
  Object visitStringValueNode(StringValueNode node) => node.value;

  @override
  Object? visitVariableNode(VariableNode node) =>
      variableValues?[node.name.value];
}

class ResolveCtx {
  final DocumentNode document;
  final OperationDefinitionNode operation;
  final GraphQLSchema schema;
  final Map<String, dynamic> variableValues;
  final Object? rootValue;

  const ResolveCtx({
    required this.document,
    required this.operation,
    required this.schema,
    required this.variableValues,
    required this.rootValue,
  });
}

class ResolveObjectCtx<P> {
  final SerdeCtx serdeCtx;
  final GraphQLObjectType<P> objectType;
  final P objectValue;
  final Map<String, dynamic> variableValues;
  final Map<String, dynamic> globalVariables;

  Option<Map<String, dynamic>>? _serializedObject;
  Map<String, Object?>? serializedObject() {
    if (objectValue == null) {
      _serializedObject = const None();
    }
    if (_serializedObject == null) {
      try {
        _serializedObject = Some(objectType.serializeSafe(objectValue)!);
      } catch (e, _) {
        _serializedObject = const None();
      }
    }
    return _serializedObject!.toNullable();
  }
  // serdeCtx.toJson(objectValue)! as Map<String, Object?>;

  ResolveObjectCtx({
    required this.serdeCtx,
    required this.objectType,
    required this.objectValue,
    required this.variableValues,
    required this.globalVariables,
  });
}

class ResolveFieldCtx<T, P> {
  final ResolveObjectCtx<P> objectCtx;
  final String fieldName;
  final FieldNode field;
  final GraphQLObjectField<T, Object?, P> objectField;

  const ResolveFieldCtx({
    required this.objectCtx,
    required this.fieldName,
    required this.field,
    required this.objectField,
  });
}

class _SubscriptionEvent {
  final Map<String, Object?> event;

  const _SubscriptionEvent(this.event);
}
