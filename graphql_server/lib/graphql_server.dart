import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';
import 'package:gql/document.dart' as gql_doc;
import 'package:gql/language.dart' as gql;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/src/extension.dart';
import 'package:source_span/source_span.dart';

import 'introspection.dart';
import 'src/graphql_result.dart';
import 'src/schema_helpers.dart';

export 'src/build_schema.dart';
export 'src/extension.dart';
export 'src/graphql_result.dart';

/// A Dart implementation of a GraphQL server.
class GraphQL {
  /// Any custom types to include in introspection information.
  final List<GraphQLType> customTypes = [];

  /// Extensions implement additional funcionalities to the
  /// server's parsing, validation and execution.
  /// For example, extensions for tracing [GraphQLTracingExtension],
  /// logging, error handling or caching
  final List<GraphQLExtension> extensionList;

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s, when the related field has no resolver.
  final FutureOr<Object?> Function<P>(P object, String fieldName, ReqCtx<P>)?
      defaultFieldResolver;

  GraphQLSchema _schema;

  final Map<Object, Object?> initialGlobalVariables;

  late final DocumentNode schemaNode = () {
    final schemaStr = printSchema(_schema);
    final node = gql.parseString(schemaStr);
    return node;
  }();

  /// If validate is false, a parsed document is executed without
  /// being validated with the provided schema
  final bool validate;

  GraphQL(
    GraphQLSchema schema, {
    bool introspect = true,
    this.validate = true,
    this.defaultFieldResolver,
    this.extensionList = const [],
    List<GraphQLType> customTypes = const <GraphQLType>[],
    Map<Object, Object?>? globalVariables,
  })  : initialGlobalVariables = globalVariables ?? const {},
        _schema = schema {
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

    if (_schema.queryType != null) {
      this.customTypes.add(_schema.queryType!);
    }
    if (_schema.mutationType != null) {
      this.customTypes.add(_schema.mutationType!);
    }
    if (_schema.subscriptionType != null) {
      this.customTypes.add(_schema.subscriptionType!);
    }
  }

  // TODO:
  // if there are query inputs or validation errors, it is handled with thrown exceptions, but
  // if there are errors inside resolvers, those should be returned
  // https://graphql.org/learn/serving-over-http/
  //   - field should only be included if the error occurred during execution.
  Future<GraphQLResult> parseAndExecute(
    String text, {
    String? operationName,

    /// The text document's source
    /// may be either a [String], a [Uri], or `null`.
    dynamic sourceUrl,
    Map<String, Object?>? variableValues,
    Map<String, Object?>? extensions,
    Object? initialValue,
    Map<Object, Object?>? globalVariables,
  }) async {
    final _globalVariables = globalVariables ?? <Object, Object?>{};
    for (final e in initialGlobalVariables.entries) {
      _globalVariables.putIfAbsent(e.key, () => e.value);
    }

    return withExtensions(
      (next, p1) => p1.executeRequest(
        next,
        _globalVariables,
        extensions,
      ),
      () async {
        try {
          final document = getDocumentNode(
            text,
            sourceUrl: sourceUrl,
            extensions: extensions,
            globals: _globalVariables,
          );
          final result = await executeRequest(
            _schema,
            document,
            operationName: operationName,
            initialValue: initialValue ?? _globalVariables,
            variableValues: variableValues,
            globalVariables: _globalVariables,
            extensions: extensions,
          );

          return result;
        } on GraphQLException catch (e) {
          return GraphQLResult(
            null,
            errors: e.errors,
            didExecute: false,
          );
        }
      },
    );
  }

  T withExtensions<T>(
    T Function(T Function() next, GraphQLExtension) call,
    T Function() next,
  ) {
    if (extensionList.isEmpty) {
      return next();
    } else {
      T Function() _next = next;
      for (final e in extensionList) {
        final _currNext = _next;
        _next = () => call(_currNext, e);
      }
      return _next();
    }
  }

  DocumentNode getDocumentNode(
    String text, {
    dynamic sourceUrl,
    Map<String, Object?>? extensions,
    required Map<Object, Object?> globals,
  }) {
    return withExtensions(
        (next, ext) => ext.getDocumentNode(next, text, globals, extensions),
        () {
      try {
        final document = gql.parseString(text, url: sourceUrl);
        return document;
      } on SourceSpanException catch (e) {
        throw GraphQLException([
          GraphQLExceptionError(
            e.message,
            locations: GraphQLErrorLocation.listFromSource(e.span?.start),
          )
        ]);
      } catch (e) {
        throw GraphQLException.fromMessage('Invalid GraphQL document: $e');
      }
    });
  }

  Future<GraphQLResult> executeRequest(
    GraphQLSchema schema,
    DocumentNode document, {
    String? operationName,
    Map<String, dynamic>? variableValues,
    required Object initialValue,
    required Map<Object, Object?> globalVariables,
    Map<String, dynamic>? extensions,
  }) async {
    if (validate) {
      final validationException = withExtensions<GraphQLException?>(
        (n, e) => e.validate(n, schema, document, globalVariables, extensions),
        () {
          // final gqlSchema = gql_schema.GraphQLSchema.fromNode(node);
          final errors = gql_doc.validateRequest(schemaNode, document);
          if (errors.isEmpty) {
            return null;
          }
          return GraphQLException([
            ...errors.map(
              (e) => GraphQLExceptionError(
                e.message ?? 'Invalid operation.',
                locations: GraphQLErrorLocation.listFromSource(
                  e.node?.span?.start,
                ),
              ),
            )
          ]);
        },
      );
      if (validationException != null) {
        throw validationException;
      }
    }

    final operation = getOperation(document, operationName);
    final coercedVariableValues =
        coerceVariableValues(schema, operation, variableValues);
    final ctx = ResolveCtx(
      document: document,
      globalVariables: globalVariables,
      schema: schema,
      variableValues: coercedVariableValues,
      extensions: extensions,
    );

    try {
      final Object? data;
      switch (operation.type) {
        case OperationType.query:
          data = await executeQuery(ctx, operation, schema, initialValue);
          break;
        case OperationType.subscription:
          data = await subscribe(ctx, operation, schema, initialValue);
          break;
        case OperationType.mutation:
          data = await executeMutation(ctx, operation, schema, initialValue);
          break;
      }
      return GraphQLResult(data, errors: ctx.errors);
    } on GraphQLException catch (e) {
      return GraphQLResult(
        null,
        errors: ctx.errors.followedBy(e.errors).toList(),
      );
    }
  }

  OperationDefinitionNode getOperation(
    DocumentNode document,
    String? operationName,
  ) {
    final ops = document.definitions.whereType<OperationDefinitionNode>();

    if (ops.isEmpty) {
      throw GraphQLException.fromMessage(
          'This document does not define any operations.');
    } else if (operationName == null) {
      return ops.length == 1
          ? ops.first
          : throw GraphQLException.fromMessage(
              'Multiple operations found, please provide an operation name.');
    } else {
      return ops.firstWhere(
        (d) => d.name!.value == operationName,
        orElse: () => throw GraphQLException.fromMessage(
          'Operation named "$operationName" not found in query.',
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
      final type = convertType(variableType, customTypes);
      final span = variableDefinition.span ??
          variableDefinition.variable.span ??
          variableDefinition.variable.name.span;
      final locations = GraphQLErrorLocation.listFromSource(
        span?.start,
      );

      if (!GraphQLFieldInput.isInputType(type)) {
        throw GraphQLExceptionError(
          'Variable "$variableName" expected value of type "$type"'
          ' which cannot be used as an input type.',
          locations: locations,
        );
      }

      final defaultValue = variableDefinition.defaultValue;
      if (variableValues == null || !variableValues.containsKey(variableName)) {
        if (defaultValue?.value != null) {
          coercedValues[variableName] = computeValue(
            type,
            defaultValue!.value!,
            variableValues,
          );
        }
      } else {
        final Object? value = variableValues[variableName];
        if (value == null) {
          if (variableValues.containsKey(variableName))
            coercedValues[variableName] = null;
        } else {
          // TODO: should we just deserialize with a result?
          final validation = type.validate(variableName, value);

          if (!validation.successful) {
            throw GraphQLException(
              validation.errors
                  .map((e) => GraphQLExceptionError(e, locations: locations))
                  .toList(),
            );
          } else {
            final coercedValue = type.deserialize(
              schema.serdeCtx,
              validation.value!,
            );
            coercedValues[variableName] = coercedValue;
          }
        }
      }
      if (variableType.isNonNull && coercedValues[variableName] == null) {
        throw GraphQLException.fromSourceSpan(
            coercedValues.containsKey(variableName)
                ? 'Required variable "$variableName" of type $type must not be null.'
                : 'Missing required variable "$variableName" of type $type',
            span!);
      }
    }

    return coercedValues;
  }

  Future<Map<String, dynamic>> executeQuery(
    ResolveCtx ctx,
    OperationDefinitionNode query,
    GraphQLSchema schema,
    Object initialValue,
  ) async {
    final queryType = schema.queryType;
    final selectionSet = query.selectionSet;
    if (queryType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a query type.');
    }
    return executeSelectionSet(ctx, selectionSet, queryType, initialValue,
        serial: false);
  }

  Future<Map<String, dynamic>> executeMutation(
    ResolveCtx ctx,
    OperationDefinitionNode mutation,
    GraphQLSchema schema,
    Object initialValue,
  ) async {
    final mutationType = schema.mutationType;

    if (mutationType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a mutation type.');
    }

    final selectionSet = mutation.selectionSet;
    return executeSelectionSet(ctx, selectionSet, mutationType, initialValue,
        serial: true);
  }

  Future<Stream<GraphQLResult>> subscribe(
    ResolveCtx baseCtx,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object initialValue,
  ) async {
    final sourceStream = await createSourceEventStream(
        baseCtx, subscription, schema, initialValue);
    return mapSourceToResponseEvent(
        baseCtx, sourceStream, subscription, schema, initialValue);
  }

  Future<MapEntry<String, Stream<Object?>>> createSourceEventStream(
    ResolveCtx baseCtx,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object initialValue,
  ) async {
    final selectionSet = subscription.selectionSet;
    final subscriptionType = schema.subscriptionType;
    if (subscriptionType == null) {
      throw GraphQLException.fromSourceSpan(
          'The schema does not define a subscription type.',
          subscription.span!);
    }
    final groupedFieldSet = collectFields(baseCtx.document, subscriptionType,
        selectionSet, baseCtx.variableValues);
    if (groupedFieldSet.length != 1) {
      throw GraphQLException.fromSourceSpan(
          'The grouped field set from this query must have exactly one entry.',
          selectionSet.span!);
    }
    final fields = groupedFieldSet.entries.first.value;
    final fieldNode = fields.first;
    final fieldName = fieldNode.name.value;
    final argumentValues = coerceArgumentValues(
        schema.serdeCtx, subscriptionType, fieldNode, baseCtx.variableValues);
    final stream = await resolveFieldEventStream(
      subscriptionType,
      initialValue,
      fieldName,
      argumentValues,
      baseCtx.globalVariables,
    );
    // TODO: don't use MapEntry
    return MapEntry(fieldName, stream);
  }

  Stream<GraphQLResult> mapSourceToResponseEvent(
    ResolveCtx baseCtx,
    MapEntry<String, Stream<Object?>> sourceStream,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object? initialValue,
  ) {
    return sourceStream.value.asyncMap((event) {
      final ctx = ResolveCtx(
        document: baseCtx.document,
        extensions: baseCtx.extensions,
        globalVariables: <Object, Object?>{...baseCtx.globalVariables},
        schema: baseCtx.schema,
        variableValues: baseCtx.variableValues,
      );
      return withExtensions(
        (next, p1) => p1.executeSubscriptionEvent(
          next,
          ctx,
          baseCtx.globalVariables,
        ),
        () async {
          /// ExecuteSubscriptionEvent
          try {
            final selectionSet = subscription.selectionSet;
            final subscriptionType = schema.subscriptionType;

            final data = await executeSelectionSet(
              ctx,
              selectionSet,
              subscriptionType!,
              // TODO: improve this. Send same level field for execution?
              // maybe with [completeValue]
              _SubscriptionEvent({sourceStream.key: event}),
              serial: false,
            );
            return GraphQLResult(
              data,
              errors: ctx.errors,
            );
          } on GraphQLException catch (e) {
            return GraphQLResult(
              null,
              errors: ctx.errors.followedBy(e.errors).toList(),
            );
          }
        },
      );
    });
  }

  Future<Stream<Object?>> resolveFieldEventStream(
    GraphQLObjectType subscriptionType,
    Object rootValue,
    String fieldName,
    Map<String, dynamic> argumentValues,
    Map<Object, dynamic> globalVariables,
  ) async {
    final field = subscriptionType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () {
        throw GraphQLException.fromMessage(
            'No subscription field named "$fieldName" is defined.');
      },
    );
    final reqCtx = ReqCtx(
      args: argumentValues,
      object: rootValue,
      globals: globalVariables,
      // TODO:
      parentCtx: null,
    );

    final Object? result;
    if (field.subscribe != null) {
      result = await field.subscribe!(rootValue, reqCtx);
    } else {
      result = await field.resolve!(rootValue, reqCtx);
    }

    if (result is Stream) {
      return result;
    } else {
      return Stream.fromIterable([result]);
    }
  }

  Future<Map<String, dynamic>> executeSelectionSet(
    ResolveCtx baseCtx,
    SelectionSetNode selectionSet,
    GraphQLObjectType<Object> objectType,
    Object objectValue, {
    required bool serial,
    ResolveObjectCtx? parentCtx,
    Object? pathItem,
  }) async {
    final groupedFieldSet = collectFields(
      baseCtx.document,
      objectType,
      selectionSet,
      baseCtx.variableValues,
    );
    final resultMap = <String, dynamic>{};
    final futureResultMap = <String, FutureOr<dynamic>>{};

    final objectCtx = ResolveObjectCtx(
      base: baseCtx,
      objectType: objectType,
      objectValue: objectValue,
      parent: parentCtx,
      pathItem: pathItem,
    );

    if (groupedFieldSet.isEmpty && validate) {
      throw GraphQLExceptionError(
        'Must select some fields in object ${objectType.name}.',
        locations: GraphQLErrorLocation.listFromSource(
          selectionSet.span?.start,
        ),
        path: objectCtx.path.toList(),
      );
    }

    // If during ExecuteSelectionSet() a field with a non‐null fieldType throws
    // a field error then that error must propagate to this entire selection set,
    // either resolving to null if allowed or further propagated to a parent field.
    // TODO: try {}
    for (final groupEntry in groupedFieldSet.entries) {
      final responseKey = groupEntry.key;
      final fields = groupEntry.value;
      final field = fields.first;
      final fieldName = field.name.value;
      final fieldSpan = field.span ?? field.alias?.span ?? field.name.span;
      final alias = field.alias?.value ?? fieldName;
      final fieldPath = [...objectCtx.path, alias];
      FutureOr<dynamic> futureResponseValue;

      if (fieldName == '__typename') {
        futureResponseValue = objectType.name;
      } else {
        final objectField = objectType.fields.firstWhereOrNull(
          (f) => f.name == fieldName,
        );
        if (objectField == null) {
          if (validate) {
            throw GraphQLExceptionError(
              'Unknown field name $fieldName for type ${objectType.name}.',
              locations: GraphQLErrorLocation.listFromSource(fieldSpan?.start),
              path: fieldPath,
            );
          } else {
            continue;
          }
        }
        if (validate &&
            objectField.type.realType is GraphQLScalarType &&
            (field.selectionSet?.selections.isNotEmpty ?? false)) {
          throw GraphQLExceptionError(
            'Can´t have fields on scalar $fieldName (${objectField.type})'
            ' of object type ${objectType.name}.',
            locations: GraphQLErrorLocation.listFromSource(fieldSpan?.start),
            path: fieldPath,
          );
        }
        futureResponseValue = withExtensions<FutureOr<Object?>>(
            (n, e) => e.executeField(n, objectCtx, objectField, alias),
            () async {
          try {
            // improved debugging
            // ignore: unnecessary_await_in_return
            return await executeField(
              fields,
              objectCtx,
              objectField,
              pathItem: alias,
            );
          } on Exception catch (e) {
            final err =
                GraphQLException.fromException(e, fieldPath, span: fieldSpan);
            if (objectField.type.isNullable) {
              // TODO: add only one error?
              baseCtx.errors.add(err.errors.first);
              return null;
            } else {
              throw err;
            }
          }
        });
      }
      if (serial) {
        await futureResponseValue;
      }

      futureResultMap[responseKey] = futureResponseValue;
    }
    for (final entry in futureResultMap.entries) {
      resultMap[entry.key] = await entry.value;
    }
    return resultMap;
  }

  /// Returns the serialized value of type [objectField] for [ctx]
  /// by [coerceArgumentValues], executing the resolvers [resolveFieldValue]
  /// and serializing the result [completeValue]
  Future<T?> executeField<T extends Object, P extends Object>(
    List<FieldNode> fields,
    ResolveObjectCtx<P> ctx,
    GraphQLObjectField<T, Object, P> objectField, {
    required Object pathItem,
  }) async {
    final field = fields.first;
    final fieldName = field.name.value;
    final argumentValues = coerceArgumentValues(
      ctx.serdeCtx,
      ctx.objectType,
      field,
      ctx.variableValues,
    );
    final resolvedValue = await resolveFieldValue<T, P>(
      ctx,
      objectField,
      fieldName,
      argumentValues,
    );
    return await completeValue(
      ctx,
      fieldName,
      objectField.type,
      fields,
      resolvedValue,
      pathItem: pathItem,
    ) as T?;
  }

  Map<String, dynamic> coerceArgumentValues(
    SerdeCtx serdeCtx,
    GraphQLObjectType objectType,
    FieldNode field,
    Map<String, dynamic> variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final argumentValues = field.arguments;
    final fieldName = field.name.value;
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
        if (defaultValue != null) {
          coercedValues[argumentName] = defaultValue;
        } else if (argumentType.isNonNullable) {
          // TODO: "Missing value for argument" repeated 3 times
          throw GraphQLException.fromMessage(
            'Missing value for argument "$argumentName" of type $argumentType'
            ' for field "$fieldName".',
          );
        } else {
          continue;
        }
      } else {
        // try {
        // TODO: verify
        // TODO: check subscriptions
        final node = argumentValue.value;
        final span = node.span ??
            argumentValue.span ??
            argumentValue.value.span ??
            argumentValue.name.span;
        if (node is VariableNode) {
          /// variable values where already validated and
          /// coerced in [coerceVariableValues]
          final variableName = node.name.value;
          final Object? value = variableValues.containsKey(variableName)
              ? variableValues[variableName]
              : defaultValue;
          coercedValues[argumentName] = value;
          if (value == null && argumentType.isNonNullable) {
            throw GraphQLException.fromMessage(
              variableValues.containsKey(variableName)
                  ? 'Variable value for argument "$argumentName" of type $argumentType'
                      ' for field "$fieldName" must not be null.'
                  : 'Missing variable "$variableName" for argument "$argumentName" of type $argumentType'
                      ' for field "$fieldName".',
              location: span?.start,
            );
          }
          continue;
        }
        final value = computeValue(
          argumentType,
          node,
          variableValues,
        );
        final Object? coercedValue;
        // TODO: try a validation first, if not successful check argumentDefinition.type.isNullable
        if (value == null) {
          if (argumentDefinition.type.isNullable) {
            coercedValue = null;
          } else {
            throw GraphQLException.fromMessage(
              'Argument "$argumentName" of type $argumentType'
              ' for field "$fieldName" must not be null.',
              location: span?.start,
            );
          }
        } else {
          final validation = argumentType.validate(
            argumentName,
            value,
          );
          final locations = GraphQLErrorLocation.listFromSource(
            argumentValue.span?.start ??
                argumentValue.value.span?.start ??
                argumentValue.name.span?.start,
          );
          if (!validation.successful) {
            final errors = <GraphQLExceptionError>[
              GraphQLExceptionError(
                'Type coercion error for argument "$argumentName" ($argumentType)'
                ' of field "$fieldName". Got value $value.',
                locations: locations,
              )
            ];

            for (final error in validation.errors) {
              errors.add(
                GraphQLExceptionError(
                  error,
                  locations: locations,
                ),
              );
            }

            throw GraphQLException(errors);
          } else {
            final serialized = validation.value!;
            coercedValue = argumentDefinition.type.deserialize(
              serdeCtx,
              serialized,
            );
          }
          coercedValues[argumentName] = coercedValue;
        }

        // TODO: remove try catch
        // } on TypeError catch (e) {
        //   throw GraphQLException(<GraphQLExceptionError>[
        //     GraphQLExceptionError(
        //       'Type coercion error for value of argument '
        //       '"$argumentName" of field "$fieldName".',
        //       locations: locations,
        //     ),
        //     GraphQLExceptionError(
        //       e.toString(),
        //       locations: [
        //         GraphQLErrorLocation.fromSourceLocation(
        //             argumentValue.value.span?.start)
        //       ],
        //     ),
        //   ]);
        // }
      }
    }

    return coercedValues;
  }

  Future<T?> resolveFieldValue<T extends Object, P extends Object>(
    ResolveObjectCtx<P> ctx,
    GraphQLObjectField<T, Object, P> field,
    String fieldName,
    Map<String, dynamic> argumentValues,
  ) async {
    final objectValue = ctx.objectValue;
    if (objectValue is _SubscriptionEvent) {
      return objectValue.event[fieldName] as T?;
    } else if (field.resolve != null) {
      return await field.resolve!(
        objectValue,
        ReqCtx<P>(
          args: argumentValues,
          object: objectValue,
          globals: ctx.globalVariables,
          // TODO:
          parentCtx: null,
        ),
      );
    } else if (objectValue is Map && objectValue.containsKey(fieldName)) {
      final Object? value = objectValue[fieldName];
      // TODO: support functions with more params?
      return await _extractResult(value) as T?;
    } else {
      final serealized = ctx.serializedObject();
      if (serealized != null && serealized.containsKey(fieldName)) {
        final value = serealized[fieldName];
        return await _extractResult(value) as T?;
      }
      if (defaultFieldResolver != null) {
        final value = await defaultFieldResolver!(
          objectValue,
          fieldName,
          ReqCtx<P>(
            args: argumentValues,
            object: objectValue,
            globals: ctx.globalVariables,
            // TODO:
            parentCtx: null,
          ),
        );
        return value as T?;
      }

      return null;
    }
  }

  FutureOr<Object?> _extractResult(Object? result) {
    // TODO: support functions with more params?
    if (result is Function()) {
      return _extractResult(result());
    } else if (result is Future) {
      return result.then(_extractResult);
    } else {
      return result;
    }
  }

  /// Returns the serialized value of type [fieldType]
  /// from a resolved [_result] for [fieldName]
  /// given the Object context ([ctx])
  Future<Object?> completeValue(
    ResolveObjectCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    List<SelectionNode> fields,
    Object? _result, {
    required Object pathItem,
  }) async {
    final Object? result = await _extractResult(_result);
    return withExtensions(
        (next, e) => e.completeValue(next, ctx, fieldName, fieldType, result),
        () async {
      if (fieldType.isNullable && result == null) {
        return null;
      }
      final path = ctx.path.followedBy([pathItem]).toList();
      Future<Object?> _completeScalar(GraphQLScalarType fieldType) async {
        // try {
        Object? _result = result;
        if (fieldType.generic.isValueOfType(_result)) {
          _result = fieldType.serialize(_result!);
        }
        final validation = fieldType.validate(fieldName, _result);

        if (!validation.successful) {
          throw GraphQLException.fromMessage(
            'Value of field "$fieldName" must be '
            '$fieldType, got $result instead.',
            path: path,
          );
        } else {
          return validation.value;
        }
        // TODO:
        // } on TypeError {
        // throw GraphQLException.fromMessage(
        //   'Value of field "$fieldName" must be '
        //   '${fieldType.generic.type}, got $result instead.',
        //   path: path,
        // );
        // }
      }

      Future<Object?> _completeObjectOrUnion(GraphQLType fieldType) async {
        GraphQLObjectType objectType;

        if (fieldType is GraphQLObjectType && !fieldType.isInterface) {
          objectType = fieldType;
        } else {
          objectType = resolveAbstractType(fieldName, fieldType, result);
        }

        final subSelectionSet = mergeSelectionSets(fields);
        return executeSelectionSet(
            ctx.base, subSelectionSet, objectType, result!,
            serial: false, parentCtx: ctx, pathItem: pathItem);
      }

      return fieldType.when(
        enum_: _completeScalar,
        scalar: _completeScalar,
        input: (_) => throw UnsupportedError('Unsupported type: $fieldType'),
        object: _completeObjectOrUnion,
        union: _completeObjectOrUnion,
        nonNullable: (fieldType) async {
          final innerType = fieldType.ofType;
          final completedResult = await completeValue(
            ctx,
            fieldName,
            innerType,
            fields,
            result,
            pathItem: pathItem,
          );

          if (completedResult == null) {
            throw GraphQLException.fromMessage(
              'Null value provided for non-nullable field "${ctx.objectType}.$fieldName".',
              path: path,
            );
          } else {
            return completedResult;
          }
        },
        list: (fieldType) async {
          if (result is! Iterable) {
            throw GraphQLException.fromMessage(
                'Value of field "$fieldName" must be a list '
                'or iterable, got $result instead.',
                path: path);
          }

          final innerType = fieldType.ofType;
          final futureOut = <Future<Object?> Function()>[];

          final listCtx = ResolveObjectCtx(
            base: ctx.base,
            pathItem: fieldName,
            objectType: ctx.objectType,
            objectValue: ctx.objectValue,
            parent: ctx,
          );

          int i = 0;
          for (final resultItem in result) {
            final _i = i++;
            futureOut.add(
              () async {
                try {
                  return await completeValue(
                    listCtx,
                    '$fieldName[$_i]',
                    innerType,
                    fields,
                    resultItem,
                    pathItem: _i,
                  );
                } on Exception catch (error, stackTrace) {
                  final field = fields.first;
                  final fieldSpan = field is FieldNode
                      ? field.span ?? field.alias?.span ?? field.name.span
                      : field.span;
                  final err = GraphQLException.fromException(
                    error,
                    [...path, _i],
                    span: fieldSpan,
                  );
                  if (innerType.isNullable) {
                    ctx.base.errors.add(err.errors.first);
                    return null;
                  } else {
                    throw err;
                  }
                }
              },
            );
          }

          return Future.wait(futureOut.map((e) => e()));
        },
      );
    });
  }

  GraphQLObjectType resolveAbstractType(
    String fieldName,
    GraphQLType type,
    Object? result,
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

    // Try to match with the type's generic
    final matchingTypes =
        possibleTypes.where((t) => t.generic.isValueOfType(result));
    // If there is only one match, return it,
    if (matchingTypes.length == 1) {
      return matchingTypes.first;
    }
    if (result is Map && result['__typename'] is String) {
      final _typename = result['__typename'] as String;
      final t = possibleTypes.firstWhereOrNull((t) => t.name == _typename);
      if (t != null) {
        return t;
      }
    }
    // No match or multiple found, try each one and validate the output
    for (final t in possibleTypes) {
      try {
        // TODO: should we serialize?
        // this should/t serialize nested fields
        final serialized = t.serializeSafe(result);
        final validation = t.validate(
          fieldName,
          serialized,
        );

        if (validation.successful) {
          return t;
        }

        errors.addAll(validation.errors.map(
          (m) => GraphQLExceptionError(m),
        ));
      } on GraphQLException catch (e) {
        errors.addAll(e.errors);
      }
    }

    errors.insert(
      0,
      GraphQLExceptionError(
        'Cannot convert value $result to type $type.',
      ),
    );

    // TODO: check if there is only one type matching
    // throw GraphQLException(errors);
    return throw GraphQLException(errors);
  }

  SelectionSetNode mergeSelectionSets(List<SelectionNode> fields) {
    final selections = <SelectionNode>[];

    for (final field in fields) {
      if (field is FieldNode && field.selectionSet != null) {
        selections.addAll(field.selectionSet!.selections);
      } else if (field is InlineFragmentNode) {
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
    List<Object?>? visitedFragments,
  }) {
    final groupedFields = <String, List<FieldNode>>{};
    visitedFragments ??= [];

    for (final selection in selectionSet.selections) {
      if (selection is FieldNode &&
          getDirectiveValue(
                  'skip', 'if', selection.directives, variableValues) ==
              true) {
        continue;
      }
      // TODO: test
      if (selection is FieldNode &&
          getDirectiveValue(
                  'include', 'if', selection.directives, variableValues) ==
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
            document, objectType, fragmentSelectionSet, variableValues,
            visitedFragments: visitedFragments);

        for (final groupEntry in fragmentGroupFieldSet.entries) {
          final responseKey = groupEntry.key;
          final fragmentGroup = groupEntry.value;
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
            document, objectType, fragmentSelectionSet, variableValues,
            visitedFragments: visitedFragments);

        for (final groupEntry in fragmentGroupFieldSet.entries) {
          final responseKey = groupEntry.key;
          final fragmentGroup = groupEntry.value;
          final groupForResponseKey =
              groupedFields.putIfAbsent(responseKey, () => []);
          groupForResponseKey.addAll(fragmentGroup);
        }
      }
    }

    return groupedFields;
  }

  bool doesFragmentTypeApply(
    GraphQLObjectType objectType,
    TypeConditionNode fragmentType,
  ) {
    final typeNode = NamedTypeNode(
        name: fragmentType.on.name,
        span: fragmentType.on.span,
        isNonNull: fragmentType.on.isNonNull);
    final type = convertType(typeNode, customTypes);

    return type.whenMaybe(
      object: (type) {
        if (!type.isInterface) {
          // TODO: if objectType and fragmentType are the same type,
          // return true, otherwise return false.
          // return type == objectType; should work
          for (final field in type.fields) {
            if (!objectType.fields.any((f) => f.name == field.name))
              return false;
          }
          return true;
        } else {
          return objectType.isImplementationOf(type);
        }
      },
      union: (type) => type.possibleTypes
          .any((t) => objectType.isImplementationOf(t as GraphQLObjectType)),
      orElse: (_) => false,
    );
  }
}

class ResolveCtx {
  final errors = <GraphQLExceptionError>[];
  final GraphQLSchema schema;
  SerdeCtx get serdeCtx => schema.serdeCtx;
  final DocumentNode document;
  final Map<String, dynamic> variableValues;
  final Map<Object, dynamic> globalVariables;
  final Map<String, dynamic>? extensions;

  ResolveCtx({
    required this.schema,
    required this.document,
    required this.variableValues,
    required this.globalVariables,
    required this.extensions,
  });
}

class ResolveObjectCtx<P extends Object> {
  final ResolveCtx base;

  SerdeCtx get serdeCtx => base.serdeCtx;
  Map<String, dynamic> get variableValues => base.variableValues;
  Map<Object, dynamic> get globalVariables => base.globalVariables;
  DocumentNode get document => base.document;

  final GraphQLObjectType<P> objectType;
  final P objectValue;
  final ResolveObjectCtx<Object>? parent;
  final Object? pathItem;

  Iterable<Object> get path => parent == null
      ? [if (pathItem != null) pathItem!]
      : parent!.path.followedBy([if (pathItem != null) pathItem!]);

  ResolveObjectCtx({
    required this.pathItem,
    required this.base,
    required this.objectType,
    required this.objectValue,
    required this.parent,
  });

  bool _didSerialized = false;
  Map<String, dynamic>? _serializedObject;
  Map<String, Object?>? serializedObject() {
    if (!_didSerialized) {
      try {
        try {
          final serializer = serdeCtx.ofValue(objectType.generic.type);
          if (serializer != null) {
            _serializedObject =
                serializer.toJson(objectValue)! as Map<String, dynamic>;
          } else {
            _serializedObject =
                serdeCtx.toJson(objectValue)! as Map<String, dynamic>;
          }
        } catch (e) {
          _serializedObject = objectType.serializeSafe(
            objectValue,
            nested: false,
          );
        }
      } catch (_) {}
      _didSerialized = true;
    }
    return _serializedObject;
  }
}

// class ResolveFieldCtx<T, P> {
//   final ResolveObjectCtx<P> objectCtx;
//   final String fieldName;
//   final FieldNode field;
//   final GraphQLObjectField<T, Object?, P> objectField;

//   const ResolveFieldCtx({
//     required this.objectCtx,
//     required this.fieldName,
//     required this.field,
//     required this.objectField,
//   });
// }

class _SubscriptionEvent {
  final Map<String, Object?> event;

  const _SubscriptionEvent(this.event);
}
