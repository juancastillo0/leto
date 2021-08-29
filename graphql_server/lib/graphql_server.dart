// ignore_for_file: avoid_catching_errors
import 'dart:async';
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as gql;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:source_span/source_span.dart';
import 'introspection.dart';

/// Transforms any [Map] into `Map<String, dynamic>`.
Map<String, dynamic> foldToStringDynamic(Map map) {
  return map == null
      ? null
      : map.keys.fold<Map<String, dynamic>>(
          <String, dynamic>{},
          (out, k) => out..[k.toString()] = map[k],
        );
}

/// A Dart implementation of a GraphQL server.
class GraphQL {
  /// Any custom types to include in introspection information.
  final List<GraphQLType /*!*/ > customTypes = [];

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s,
  /// when the related field has no resolver.
  final FutureOr<T> Function<T>(T, String, Map<String, dynamic>)
      defaultFieldResolver;

  GraphQLSchema _schema;

  GraphQL(
    GraphQLSchema schema, {
    bool introspect = true,
    this.defaultFieldResolver,
    List<GraphQLType> customTypes = const <GraphQLType>[],
  }) : _schema = schema {
    if (customTypes?.isNotEmpty == true) {
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

    if (_schema.queryType != null) this.customTypes.add(_schema.queryType);
    if (_schema.mutationType != null) {
      this.customTypes.add(_schema.mutationType);
    }
    if (_schema.subscriptionType != null) {
      this.customTypes.add(_schema.subscriptionType);
    }
  }

  Object computeValue(
    GraphQLType targetType,
    ValueNode node,
    Map<String, dynamic> values,
  ) =>
      node.accept(GraphQLValueComputer(targetType, values));

  GraphQLType /*!*/ convertType(TypeNode node) {
    if (node is ListTypeNode) {
      return GraphQLListType(convertType(node.type));
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
      throw ArgumentError('Invalid GraphQL type: "${node.span.text}"');
    }
  }

  Future<Object> parseAndExecute(
    String text, {
    String operationName,
    // [sourceUrl] may be either a [String], a [Uri], or `null`.
    dynamic sourceUrl,
    Map<String, dynamic> variableValues = const {},
    Object initialValue,
    Map<String, dynamic> globalVariables,
  }) {
    final errors = <GraphQLExceptionError>[];
    DocumentNode document;

    try {
      document = gql.parseString(text, url: sourceUrl);
    } on SourceSpanException catch (e) {
      errors.add(GraphQLExceptionError(
        e.message,
        locations: [
          GraphExceptionErrorLocation.fromSourceLocation(e.span.start),
        ],
      ));
    }

    if (errors.isNotEmpty) {
      throw GraphQLException(errors);
    }

    return executeRequest(
      _schema,
      document,
      operationName: operationName,
      initialValue: initialValue,
      variableValues: variableValues,
      globalVariables: globalVariables,
    );
  }

  Future<Object> executeRequest(
    GraphQLSchema schema,
    DocumentNode document, {
    String operationName,
    Map<String, dynamic> variableValues = const <String, dynamic>{},
    Object initialValue,
    Map<String, dynamic> globalVariables,
  }) async {
    final operation = getOperation(document, operationName);
    final coercedVariableValues = coerceVariableValues(
        schema, operation, variableValues ?? <String, dynamic>{});
    if (operation.type == OperationType.query) {
      return await executeQuery(document, operation, schema,
          coercedVariableValues, initialValue, globalVariables);
    } else if (operation.type == OperationType.subscription) {
      return await subscribe(document, operation, schema, coercedVariableValues,
          globalVariables, initialValue);
    } else {
      return executeMutation(document, operation, schema, coercedVariableValues,
          initialValue, globalVariables);
    }
  }

  OperationDefinitionNode getOperation(
    DocumentNode document,
    String operationName,
  ) {
    final ops = document.definitions.whereType<OperationDefinitionNode>();

    if (operationName == null) {
      return ops.length == 1
          ? ops.first
          : throw GraphQLException.fromMessage(
              'This document does not define any operations.');
    } else {
      return ops.firstWhere((d) => d.name.value == operationName,
          orElse: () => throw GraphQLException.fromMessage(
              'Missing required operation "$operationName".'));
    }
  }

  Map<String, dynamic> coerceVariableValues(
    GraphQLSchema schema,
    OperationDefinitionNode operation,
    Map<String, dynamic> variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final variableDefinitions = operation.variableDefinitions ?? [];

    for (final variableDefinition in variableDefinitions) {
      final variableName = variableDefinition.variable.name.value;
      final variableType = variableDefinition.type;
      final defaultValue = variableDefinition.defaultValue;
      final value = variableValues[variableName];

      if (value == null) {
        if (defaultValue != null) {
          coercedValues[variableName] = computeValue(
              convertType(variableType), defaultValue.value, variableValues);
        } else if (variableType.isNonNull) {
          throw GraphQLException.fromSourceSpan(
              'Missing required variable "$variableName".',
              variableDefinition.span);
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
                        variableDefinition.span.start,
                      )
                    ],
                  ),
                )
                .toList(),
          );
        } else {
          coercedValues[variableName] = type.deserialize(value);
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
    Object initialValue,
    Map<String, dynamic> globalVariables,
  ) async {
    final queryType = schema.queryType;
    final selectionSet = query.selectionSet;
    return await executeSelectionSet(document, selectionSet, queryType,
        initialValue, variableValues, globalVariables);
  }

  Future<Map<String, dynamic>> executeMutation(
    DocumentNode document,
    OperationDefinitionNode mutation,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Object initialValue,
    Map<String, dynamic> globalVariables,
  ) async {
    final mutationType = schema.mutationType;

    if (mutationType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a mutation type.');
    }

    final selectionSet = mutation.selectionSet;
    return await executeSelectionSet(document, selectionSet, mutationType,
        initialValue, variableValues, globalVariables);
  }

  Future<Stream<Map<String, dynamic>>> subscribe(
    DocumentNode document,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
    Object initialValue,
  ) async {
    final sourceStream = await createSourceEventStream(
        document, subscription, schema, variableValues, initialValue);
    return mapSourceToResponseEvent(sourceStream, subscription, schema,
        document, initialValue, variableValues, globalVariables);
  }

  Future<Stream> createSourceEventStream(
    DocumentNode document,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Map<String, dynamic> variableValues,
    Object initialValue,
  ) {
    final selectionSet = subscription.selectionSet;
    final subscriptionType = schema.subscriptionType;
    if (subscriptionType == null) {
      throw GraphQLException.fromSourceSpan(
          'The schema does not define a subscription type.', subscription.span);
    }
    final groupedFieldSet =
        collectFields(document, subscriptionType, selectionSet, variableValues);
    if (groupedFieldSet.length != 1) {
      throw GraphQLException.fromSourceSpan(
          'The grouped field set from this query must have exactly one entry.',
          selectionSet.span);
    }
    final fields = groupedFieldSet.entries.first.value;
    final fieldNode = fields.first;
    final fieldName = fieldNode.alias?.value ?? fieldNode.name.value;
    final argumentValues =
        coerceArgumentValues(subscriptionType, fieldNode, variableValues);
    return resolveFieldEventStream(
        subscriptionType, initialValue, fieldName, argumentValues);
  }

  Stream<Map<String, dynamic>> mapSourceToResponseEvent(
    Stream sourceStream,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    DocumentNode document,
    Object initialValue,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async* {
    await for (final event in sourceStream) {
      yield await executeSubscriptionEvent(document, subscription, schema,
          event, variableValues, globalVariables);
    }
  }

  Future<Map<String, dynamic>> executeSubscriptionEvent(
    DocumentNode document,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object initialValue,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    final selectionSet = subscription.selectionSet;
    final subscriptionType = schema.subscriptionType;
    if (subscriptionType == null) {
      throw GraphQLException.fromSourceSpan(
          'The schema does not define a subscription type.', subscription.span);
    }
    try {
      final data = await executeSelectionSet(document, selectionSet,
          subscriptionType, initialValue, variableValues, globalVariables);
      return {'data': data};
    } on GraphQLException catch (e) {
      return {
        'data': null,
        'errors': [e.errors.map((e) => e.toJson()).toList()]
      };
    }
  }

  Future<Stream> resolveFieldEventStream(
    GraphQLObjectType subscriptionType,
    Object rootValue,
    String fieldName,
    Map<String, dynamic> argumentValues,
  ) async {
    final field = subscriptionType.fields.firstWhere((f) => f.name == fieldName,
        orElse: () {
      throw GraphQLException.fromMessage(
          'No subscription field named "$fieldName" is defined.');
    });
    final resolver = field.resolve;
    final result = await resolver(rootValue, argumentValues);
    if (result is Stream) {
      return result;
    } else {
      return Stream.fromIterable([result]);
    }
  }

  Future<Map<String, dynamic>> executeSelectionSet(
    DocumentNode document,
    SelectionSetNode selectionSet,
    GraphQLObjectType objectType,
    Object objectValue,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    final groupedFieldSet =
        collectFields(document, objectType, selectionSet, variableValues);
    final resultMap = <String, dynamic>{};
    final futureResultMap = <String, FutureOr<dynamic>>{};

    for (final responseKey in groupedFieldSet.keys) {
      final fields = groupedFieldSet[responseKey];
      for (final field in fields) {
        final fieldNode = field;
        final fieldName = fieldNode.alias?.value ?? fieldNode.name.value;
        FutureOr<dynamic> futureResponseValue;

        if (fieldName == '__typename') {
          futureResponseValue = objectType.name;
        } else {
          final fieldType = objectType.fields
              .firstWhere((f) => f.name == fieldName, orElse: () => null)
              ?.type;
          if (fieldType == null) continue;
          futureResponseValue = executeField(
              document,
              fieldName,
              objectType,
              objectValue,
              fields,
              fieldType,
              Map<String, dynamic>.from(globalVariables ?? <String, dynamic>{})
                ..addAll(variableValues),
              globalVariables);
        }

        futureResultMap[responseKey] = futureResponseValue;
      }
    }
    for (final f in futureResultMap.keys) {
      resultMap[f] = await futureResultMap[f];
    }
    return resultMap;
  }

  Future<Object> executeField(
    DocumentNode document,
    String fieldName,
    GraphQLObjectType objectType,
    Object objectValue,
    List<FieldNode> fields,
    GraphQLType fieldType,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    final field = fields[0];
    final argumentValues =
        coerceArgumentValues(objectType, field, variableValues);
    final resolvedValue = await resolveFieldValue(
        objectType,
        objectValue,
        fieldName,
        Map<String, dynamic>.from(globalVariables ?? {})
          ..addAll(argumentValues ?? {}));
    return completeValue(document, fieldName, fieldType, fields, resolvedValue,
        variableValues, globalVariables);
  }

  Map<String, dynamic> coerceArgumentValues(
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
            '${objectType.name} has no field named "$fieldName".'));
    final argumentDefinitions = desiredField.inputs;

    for (final argumentDefinition in argumentDefinitions) {
      final argumentName = argumentDefinition.name;
      final argumentType = argumentDefinition.type;
      final defaultValue = argumentDefinition.defaultValue;

      final argumentValue = argumentValues
          .firstWhere((a) => a.name.value == argumentName, orElse: () => null);

      if (argumentValue == null) {
        if (defaultValue != null || argumentDefinition.defaultsToNull) {
          coercedValues[argumentName] = defaultValue;
        } else if (argumentType is GraphQLNonNullableType) {
          throw GraphQLException.fromMessage(
              'Missing value for argument "$argumentName" of field "$fieldName".');
        } else {
          continue;
        }
      } else {
        try {
          final validation = argumentType.validate(
            argumentName,
            computeValue(argumentType, argumentValue.value, variableValues),
          );

          if (!validation.successful) {
            final errors = <GraphQLExceptionError>[
              GraphQLExceptionError(
                'Type coercion error for value of argument'
                ' "$argumentName" of field "$fieldName".',
                locations: [
                  GraphExceptionErrorLocation.fromSourceLocation(
                      argumentValue.value.span.start)
                ],
              )
            ];

            for (final error in validation.errors) {
              errors.add(
                GraphQLExceptionError(
                  error,
                  locations: [
                    GraphExceptionErrorLocation.fromSourceLocation(
                        argumentValue.value.span.start)
                  ],
                ),
              );
            }

            throw GraphQLException(errors);
          } else {
            final coercedValue = validation.value;
            coercedValues[argumentName] = coercedValue;
          }
        } on TypeError catch (e) {
          throw GraphQLException(<GraphQLExceptionError>[
            GraphQLExceptionError(
              'Type coercion error for value of argument "$argumentName" of field "$fieldName".',
              locations: [
                GraphExceptionErrorLocation.fromSourceLocation(
                    argumentValue.value.span.start)
              ],
            ),
            GraphQLExceptionError(
              e.toString(),
              locations: [
                GraphExceptionErrorLocation.fromSourceLocation(
                    argumentValue.value.span.start)
              ],
            ),
          ]);
        }
      }
    }

    return coercedValues;
  }

  Future<T> resolveFieldValue<T>(
    GraphQLObjectType objectType,
    T objectValue,
    String fieldName,
    Map<String, dynamic> argumentValues,
  ) async {
    final field = objectType.fields.firstWhere((f) => f.name == fieldName);

    if (objectValue is Map) {
      return objectValue[fieldName] as T;
    } else if (field.resolve == null) {
      if (defaultFieldResolver != null) {
        return await defaultFieldResolver(
            objectValue, fieldName, argumentValues);
      }

      return null;
    } else {
      return await field.resolve(objectValue, argumentValues) as T;
    }
  }

  Future<Object> completeValue(
    DocumentNode document,
    String fieldName,
    GraphQLType fieldType,
    List<SelectionNode> fields,
    Object result,
    Map<String, dynamic> variableValues,
    Map<String, dynamic> globalVariables,
  ) async {
    if (fieldType is GraphQLNonNullableType) {
      final innerType = fieldType.ofType;
      final completedResult = await completeValue(document, fieldName,
          innerType, fields, result, variableValues, globalVariables);

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
      final futureOut = [];

      for (final resultItem in result as Iterable) {
        futureOut.add(completeValue(document, '(item in "$fieldName")',
            innerType, fields, resultItem, variableValues, globalVariables));
      }

      final out = [];
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

      final subSelectionSet = mergeSelectionSets(fields);
      return await executeSelectionSet(document, subSelectionSet, objectType,
          result, variableValues, globalVariables);
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
      possibleTypes = type.possibleTypes;
    } else {
      throw ArgumentError();
    }

    final errors = <GraphQLExceptionError>[];

    for (final t in possibleTypes) {
      try {
        final validation =
            t.validate(fieldName, foldToStringDynamic(result as Map));

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

  SelectionSetNode mergeSelectionSets(List<SelectionNode> fields) {
    final selections = <SelectionNode>[];

    for (final field in fields) {
      if (field is FieldNode && field.selectionSet != null) {
        selections.addAll(field.selectionSet.selections);
      } else if (field is InlineFragmentNode && field.selectionSet != null) {
        selections.addAll(field.selectionSet.selections);
      }
    }

    return SelectionSetNode(selections: selections);
  }

  Map<String, List<FieldNode>> collectFields(
    DocumentNode document,
    GraphQLObjectType objectType,
    SelectionSetNode selectionSet,
    Map<String, dynamic> variableValues, {
    List visitedFragments,
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
            .firstWhere((f) => f.name.value == fragmentSpreadName,
                orElse: () => null);

        if (fragment == null) continue;
        final fragmentType = fragment.typeCondition;
        if (!doesFragmentTypeApply(objectType, fragmentType)) continue;
        final fragmentSelectionSet = fragment.selectionSet;
        final fragmentGroupFieldSet = collectFields(
            document, objectType, fragmentSelectionSet, variableValues);

        for (final responseKey in fragmentGroupFieldSet.keys) {
          final fragmentGroup = fragmentGroupFieldSet[responseKey];
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
          final fragmentGroup = fragmentGroupFieldSet[responseKey];
          final groupForResponseKey =
              groupedFields.putIfAbsent(responseKey, () => []);
          groupForResponseKey.addAll(fragmentGroup);
        }
      }
    }

    return groupedFields;
  }

  Object getDirectiveValue(
    String name,
    String argumentName,
    SelectionNode selection,
    Map<String, dynamic> variableValues,
  ) {
    if (selection is! FieldNode) return null;
    final directive = (selection as FieldNode).directives.firstWhere((d) {
      if (d.arguments.isEmpty) return false;
      final vv = d.arguments[0].value;
      if (vv is VariableNode) {
        return vv.name.value == name;
      } else {
        return computeValue(null, vv, variableValues) == name;
      }
    }, orElse: () => null);

    if (directive == null) return null;
    if (directive.arguments[0].name.value != argumentName) return null;

    final vv = directive.arguments[0].value;
    if (vv is VariableNode) {
      final vname = vv.name;
      if (!variableValues.containsKey(vname)) {
        throw GraphQLException.fromSourceSpan(
            'Unknown variable: "$vname"', vv.span);
      }
      return variableValues[vname];
    }
    return computeValue(null, vv, variableValues);
  }

  bool doesFragmentTypeApply(
      GraphQLObjectType objectType, TypeConditionNode fragmentType) {
    final typeNode = NamedTypeNode(
        name: fragmentType.on.name,
        span: fragmentType.on.span,
        isNonNull: fragmentType.on.isNonNull);
    final type = convertType(typeNode);
    if (type is GraphQLObjectType && !type.isInterface) {
      for (final field in type.fields) {
        if (!objectType.fields.any((f) => f.name == field.name)) return false;
      }
      return true;
    } else if (type is GraphQLObjectType && type.isInterface) {
      return objectType.isImplementationOf(type);
    } else if (type is GraphQLUnionType) {
      return type.possibleTypes.any((t) => objectType.isImplementationOf(t));
    }

    return false;
  }
}

class GraphQLValueComputer extends SimpleVisitor<Object> {
  final GraphQLType targetType;
  final Map<String, dynamic> variableValues;

  GraphQLValueComputer(this.targetType, this.variableValues);

  @override
  Object visitBooleanValueNode(BooleanValueNode node) => node.value;

  @override
  Object visitEnumValueNode(EnumValueNode node) {
    if (targetType == null) {
      throw GraphQLException.fromSourceSpan(
          'An enum value was given, but in this context, its type cannot be deduced.',
          node.span);
    } else if (targetType is! GraphQLEnumType) {
      throw GraphQLException.fromSourceSpan(
          'An enum value was given, but the type "${targetType.name}" is not an enum.',
          node.span);
    } else {
      final enumType = targetType as GraphQLEnumType;
      final matchingValue = enumType.values
          .firstWhere((v) => v.name == node.name.value, orElse: () => null);
      if (matchingValue == null) {
        throw GraphQLException.fromSourceSpan(
            'The enum "${targetType.name}" has no member named "${node.name.value}".',
            node.span);
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
  Object visitNullValueNode(NullValueNode node) => null;

  @override
  Object visitStringValueNode(StringValueNode node) => node.value;

  @override
  Object visitVariableNode(VariableNode node) =>
      variableValues[node.name.value];
}
