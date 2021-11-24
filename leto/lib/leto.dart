import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as gql;
import 'package:leto_schema/introspection.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart'
    show
        collectFields,
        computeValue,
        convertType,
        fragmentsFromDocument,
        isInputType,
        mergeSelectionSets,
        possibleSelectionsCallback;
import 'package:leto_schema/validate.dart';
import 'package:source_span/source_span.dart';

import 'src/extensions/extension.dart';
import 'src/graphql_result.dart';

export 'package:gql/ast.dart' show OperationType;
export 'package:leto_schema/leto_schema.dart'
    show
        GraphQLException,
        GraphQLError,
        ScopedMap,
        ScopeRef,
        RefWithDefault,
        GlobalsHolder;

export 'src/extensions/extension.dart';
export 'src/graphql_result.dart';

class GraphQLConfig {
  /// Extensions implement additional functionalities to the
  /// server's parsing, validation and execution.
  /// For example, extensions for tracing [GraphQLTracingExtension],
  /// logging, error handling or caching [GraphQLPersistedQueries]
  final List<GraphQLExtension> extensions;

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s, when the related field has no resolver.
  final FutureOr<Object?> Function(Object? parent, Ctx)? defaultFieldResolver;

  /// If validate is false, a parsed document is executed without
  /// being validated with the provided schema
  final bool? validate;

  /// Whether to introspect the [GraphQLSchema]
  ///
  /// This will change the Query type of the [schema] by adding
  /// introspection fields, useful for client code generators or other
  /// tools like UI explorers.
  /// More information in: [reflectSchema]
  final bool? introspect;

  final ScopedMap? globalVariables;

  const GraphQLConfig({
    this.introspect,
    this.validate,
    this.defaultFieldResolver,
    this.extensions = const <GraphQLExtension>[],
    this.globalVariables,
  });
}

/// A Dart implementation of a GraphQL server.
///
/// Parses, validates and executes GraphQL requests using the
/// provided [GraphQLSchema].
class GraphQL {
  /// Extensions implement additional functionalities to the
  /// server's parsing, validation and execution.
  /// For example, extensions for tracing [GraphQLTracingExtension],
  /// logging, error handling or caching [GraphQLPersistedQueries]
  final List<GraphQLExtension> extensions;

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s, when the related field has no resolver.
  final FutureOr<Object?> Function(Object? parent, Ctx)? defaultFieldResolver;

  /// Variables passed to all executed requests
  final ScopedMap baseGlobalVariables;

  /// If validate is false, a parsed document is executed without
  /// being validated with the provided schema
  final bool validate;

  /// Whether to introspect the [GraphQLSchema]
  ///
  /// This will change the Query type of the [schema] by adding
  /// introspection fields, useful for client code generators or other
  /// tools like UI explorers.
  /// More information in: [reflectSchema]
  final bool introspect;

  /// The schema used for executing GraphQL requests
  final GraphQLSchema schema;

  /// A Dart implementation of a GraphQL server.
  ///
  /// Parses, validates and executes GraphQL requests using the
  /// provided [GraphQLSchema].
  GraphQL(
    this.schema, {
    bool? introspect,
    bool? validate,
    this.defaultFieldResolver,
    this.extensions = const [],
    ScopedMap? globalVariables,
  })  : baseGlobalVariables = globalVariables ?? ScopedMap.empty(),
        introspect = introspect ?? true,
        validate = validate ?? true;

  /// Creates a [GraphQL] executor from a [GraphQLConfig]
  factory GraphQL.fromConfig(GraphQLSchema schema, GraphQLConfig config) =>
      GraphQL(
        schema,
        validate: config.validate,
        introspect: config.introspect,
        defaultFieldResolver: config.defaultFieldResolver,
        extensions: config.extensions,
        globalVariables: config.globalVariables,
      );

  static final _resolveCtxRef = ScopeRef<ExecutionCtx>('ResolveCtx');

  /// Gets the [ExecutionCtx] of a request from a [scope].
  /// null when the execution stage hasn't started.
  static ExecutionCtx? getResolveCtx(GlobalsHolder scope) =>
      _resolveCtxRef.get(scope);

  static final _graphQLExecutorRef = ScopeRef<GraphQL>('GraphQLExecutor');

  /// Gets the [GraphQL] executor from a [scope].
  /// Always non-null for scopes derived from [parseAndExecute]
  static GraphQL? fromCtx(GlobalsHolder scope) =>
      _graphQLExecutorRef.get(scope);

  /// Parses the GraphQL document in [query] and executes [operationName]
  /// or the only operation in the document if not given.
  ///
  /// Throws [InvalidOperationType] if the operation
  /// for the given [query] and [operationName] is not in [validOperationTypes].
  /// May throw other exceptions if a [GraphQLExtension] in [extensions] throws.
  Future<GraphQLResult> parseAndExecute(
    String query, {
    String? operationName,

    /// The text document's source
    /// may be either a [String], a [Uri], or `null`.
    dynamic sourceUrl,
    Map<String, Object?>? variableValues,
    Map<String, Object?>? extensions,
    Object? rootValue,
    Map<Object, Object?>? globalVariables,
    List<OperationType> validOperationTypes = OperationType.values,
  }) async {
    final _globalVariables = globalVariables == null
        ? ScopedMap.empty(baseGlobalVariables)
        : ScopedMap(globalVariables, baseGlobalVariables);
    _graphQLExecutorRef.setScoped(_globalVariables, this);

    final preExecuteCtx = RequestCtx(
      extensions: extensions,
      globals: _globalVariables,
      operationName: operationName,
      query: query,
      rootValue: rootValue ?? _globalVariables,
      rawVariableValues: variableValues,
      schema: schema,
    );

    return withExtensions(
      (next, p1) => p1.executeRequest(
        next,
        preExecuteCtx,
      ),
      () async {
        try {
          final document = getDocumentNode(
            query,
            sourceUrl: sourceUrl,
            extensions: extensions,
            globals: _globalVariables,
            ctx: preExecuteCtx,
          );

          final operation = getOperation(document, operationName);
          if (!validOperationTypes.contains(operation.type)) {
            throw InvalidOperationType(
              preExecuteCtx,
              document,
              operation,
              validOperationTypes,
            );
          }
          final result = await executeRequest(
            schema,
            document,
            rootValue: rootValue ?? _globalVariables,
            variableValues: variableValues,
            globalVariables: _globalVariables,
            extensions: extensions,
            baseCtx: preExecuteCtx,
            operation: operation,
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
    if (extensions.isEmpty) {
      return next();
    } else {
      T Function() _next = next;
      for (final e in extensions) {
        final _currNext = _next;
        _next = () => call(_currNext, e);
      }
      return _next();
    }
  }

  DocumentNode getDocumentNode(
    String query, {
    dynamic sourceUrl,
    Map<String, Object?>? extensions,
    required ScopedMap globals,
    required RequestCtx ctx,
  }) {
    return withExtensions((next, ext) => ext.getDocumentNode(next, ctx), () {
      try {
        final document = gql.parseString(query, url: sourceUrl);
        return document;
      } on SourceSpanException catch (e, s) {
        throw GraphQLException([
          GraphQLError(
            e.message,
            locations: GraphQLErrorLocation.listFromSource(e.span?.start),
            sourceError: e,
            stackTrace: s,
          )
        ]);
      } catch (e, s) {
        throw GraphQLException.fromMessage(
          'Invalid GraphQL document: $e',
          sourceError: e,
          stackTrace: s,
        );
      }
    });
  }

  Future<GraphQLResult> executeRequest(
    GraphQLSchema schema,
    DocumentNode document, {
    Map<String, dynamic>? variableValues,
    required Object rootValue,
    required ScopedMap globalVariables,
    Map<String, dynamic>? extensions,
    required RequestCtx baseCtx,
    required OperationDefinitionNode operation,
  }) async {
    if (validate) {
      final validationException = withExtensions<GraphQLException?>(
        (n, e) => e.validate(n, baseCtx, document),
        () {
          final errors = validateDocument(schema, document);
          if (errors.isEmpty) {
            return null;
          }
          return GraphQLException(errors);
        },
      );
      if (validationException != null) {
        throw validationException;
      }
    }

    final coercedVariableValues =
        coerceVariableValues(schema, operation, variableValues);
    final ctx = ExecutionCtx(
      document: document,
      operation: operation,
      globals: globalVariables,
      variableValues: coercedVariableValues,
      requestCtx: baseCtx,
    );
    _resolveCtxRef.setScoped(ctx.globals, ctx);

    try {
      final Object? data;
      switch (operation.type) {
        case OperationType.query:
          data = await executeQuery(ctx, operation, schema, rootValue);
          break;
        case OperationType.subscription:
          data = await subscribe(ctx, operation, schema, rootValue);
          break;
        case OperationType.mutation:
          data = await executeMutation(ctx, operation, schema, rootValue);
          break;
      }
      return GraphQLResult(data, errors: ctx.errors);
    } on GraphQLException catch (e) {
      final errors = ctx.errors.followedBy(e.errors).toList();
      return GraphQLResult(
        null,
        errors: errors,
        didExecute: operation.type != OperationType.subscription,
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
        (d) => d.name?.value == operationName,
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
      final type = convertType(variableType, schema.typeMap);
      final span = variableDefinition.span ??
          variableDefinition.variable.span ??
          variableDefinition.variable.name.span;
      final locations = GraphQLErrorLocation.listFromSource(
        span?.start,
      );

      if (!isInputType(type)) {
        throw GraphQLError(
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
          if (variableValues.containsKey(variableName)) {
            coercedValues[variableName] = null;
          }
        } else {
          // TODO: should we just deserialize with a result?
          final validation = type.validate(variableName, value);

          if (!validation.successful) {
            throw GraphQLException(
              validation.errors
                  .map((e) => GraphQLError(e, locations: locations))
                  .toList(),
            );
          } else {
            final Object? coercedValue = type.deserialize(
              schema.serdeCtx,
              // Nullability change was validation.value!
              validation.value,
            );
            coercedValues[variableName] = coercedValue;
          }
        }
      }
      if (variableType.isNonNull && coercedValues[variableName] == null) {
        throw GraphQLException.fromMessage(
          coercedValues.containsKey(variableName)
              ? 'Required variable "$variableName" of'
                  ' type $type must not be null.'
              : 'Missing required variable "$variableName" of type $type',
          location: span?.start,
        );
      }
    }

    return coercedValues;
  }

  Future<Map<String, dynamic>> executeQuery(
    ExecutionCtx ctx,
    OperationDefinitionNode query,
    GraphQLSchema schema,
    Object rootValue,
  ) async {
    final queryType = schema.queryType;
    final selectionSet = query.selectionSet;
    if (queryType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a query type.');
    }
    return executeSelectionSet(ctx, selectionSet, queryType, rootValue,
        serial: false);
  }

  Future<Map<String, dynamic>> executeMutation(
    ExecutionCtx ctx,
    OperationDefinitionNode mutation,
    GraphQLSchema schema,
    Object rootValue,
  ) async {
    final mutationType = schema.mutationType;

    if (mutationType == null) {
      throw GraphQLException.fromMessage(
          'The schema does not define a mutation type.');
    }

    final selectionSet = mutation.selectionSet;
    return executeSelectionSet(ctx, selectionSet, mutationType, rootValue,
        serial: true);
  }

  Future<Stream<GraphQLResult>> subscribe(
    ExecutionCtx baseCtx,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object rootValue,
  ) async {
    final sourceStream =
        await createSourceEventStream(baseCtx, subscription, schema, rootValue);
    return mapSourceToResponseEvent(
        baseCtx, sourceStream, subscription, schema, rootValue);
  }

  Future<MapEntry<FieldNode, Stream<Object?>>> createSourceEventStream(
    ExecutionCtx baseCtx,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object rootValue,
  ) async {
    final selectionSet = subscription.selectionSet;
    final subscriptionType = schema.subscriptionType;
    if (subscriptionType == null) {
      throw GraphQLException.fromMessage(
        'The schema does not define a subscription type.',
      );
    }
    final fragments = fragmentsFromDocument(baseCtx.document);
    final groupedFieldSet = collectFields(baseCtx.schema, fragments,
        subscriptionType, selectionSet, baseCtx.variableValues);
    if (validate && groupedFieldSet.length != 1) {
      throw GraphQLError(
        'The grouped field set for subscriptions must have exactly one entry.',
        locations: [
          if (selectionSet.selections.isNotEmpty)
            ...GraphQLErrorLocation.firstFromNodes(selectionSet.selections)
        ],
      );
    }

    final objCtx = ObjectExecutionCtx(
      executionCtx: baseCtx,
      groupedFieldSet: groupedFieldSet,
      objectType: subscriptionType,
      objectValue: rootValue,
      parent: null,
      pathItem: null,
    );
    final fields = groupedFieldSet.entries.first.value;
    final fieldNode = fields.first;
    final fieldName = fieldNode.name.value;
    final desiredField = subscriptionType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () => throw GraphQLError(
        '${subscriptionType.name} has no field named "$fieldName".',
        locations: GraphQLErrorLocation.listFromSource(
            (fieldNode.span ?? fieldNode.name.span)?.start),
      ),
    );

    final argumentValues = coerceArgumentValues(
        schema.serdeCtx, desiredField, fieldNode, baseCtx.variableValues);
    final stream = await resolveFieldEventStream(
      objCtx,
      subscriptionType,
      rootValue,
      fieldNode,
      argumentValues,
    );
    return MapEntry(fieldNode, stream);
  }

  Stream<GraphQLResult> mapSourceToResponseEvent(
    ExecutionCtx streamCtx,
    MapEntry<FieldNode, Stream<Object?>> sourceStream,
    OperationDefinitionNode subscription,
    GraphQLSchema schema,
    Object rootValue,
  ) {
    // final fieldName = sourceStream.key.name.value;
    // final span = sourceStream.key.span ??
    //     sourceStream.key.alias?.span ??
    //     sourceStream.key.name.span;
    // Future<GraphQLResult?> prev = Future.value();

    return sourceStream.value.asyncMap(
      (event) async {
        final ctx = ExecutionCtx(
          requestCtx: streamCtx.requestCtx,
          document: streamCtx.document,
          operation: streamCtx.operation,
          globals: streamCtx.globals.child(),
          variableValues: streamCtx.variableValues,
        );
        _resolveCtxRef.setScoped(ctx.globals, ctx);

        // final _prev = prev;
        return withExtensions<Future<GraphQLResult>>(
          (next, p1) async => p1.executeSubscriptionEvent(
            next,
            ctx,
            streamCtx.globals,
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
                SubscriptionEvent._(event),
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
        // prev = curr.then<GraphQLResult>((event) async {
        //   await _prev;
        //   sink.add(event);
        //   return event;
        // });
      },
      // handleError: (error, stackTrace, sink) {
      //   if (handleSubscriptionError) {
      //     prev.then(
      //       (Object? value) {
      //         final exception = GraphQLException.fromException(
      //           error,
      //           [fieldName],
      //           span: span,
      //         );
      //         sink.add(GraphQLResult(
      //           {fieldName: null},
      //           errors: exception.errors,
      //         ));
      //       },
      //     );
      //   } else {
      //     prev.then((Object? _) {
      //       sink.addError(error, stackTrace);
      //       sink.close();
      //     });
      //   }
      // },
      // handleDone: (_) {},
    );
    // return transformer.bind(sourceStream.value);
  }

  Future<Stream<Object?>> resolveFieldEventStream(
    ObjectExecutionCtx ctx,
    GraphQLObjectType subscriptionType,
    Object rootValue,
    FieldNode fieldNode,
    Map<String, dynamic> argumentValues,
  ) async {
    final fieldName = fieldNode.name.value;
    final pathItem = fieldNode.alias?.value ?? fieldName;
    final field = subscriptionType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () {
        throw GraphQLException.fromMessage(
            'No subscription field named "$fieldName" is defined.');
      },
    );

    final reqCtx = Ctx<Object?>(
      args: argumentValues,
      field: field,
      objectCtx: ctx,
      pathItem: pathItem,
      lookahead: possibleSelectionsCallback(
        ctx.executionCtx.schema,
        field.type,
        ctx.groupedFieldSet[pathItem]!,
        ctx.executionCtx.document,
        ctx.executionCtx.variableValues,
      ),
    );

    final Object? result;
    try {
      if (field.subscribe != null) {
        result = await field.subscribe!(rootValue, reqCtx);
      } else if (rootValue is Map<String, Object?> &&
          rootValue.containsKey(fieldName)) {
        final value = rootValue[fieldName];
        result = await _extractResult(value);
      } else {
        result = null;
      }
      if (result is! Stream) {
        throw GraphQLError(
          'Could not resolve subscription field event stream for "$fieldName".',
        );
      }
    } catch (e, s) {
      throw mapException(
        ThrownError(
          error: e,
          stackTrace: s,
          path: [pathItem],
          span: fieldNode.span ?? fieldNode.alias?.span ?? fieldNode.name.span,
          objectCtx: reqCtx.objectCtx,
          type: reqCtx.field.type,
          ctx: reqCtx,
          location: ThrownErrorLocation.subscribe,
        ),
      );
    }

    return result; // Result.captureStream(stream).map((event) {});
  }

  Future<Map<String, dynamic>> executeSelectionSet(
    ExecutionCtx baseCtx,
    SelectionSetNode selectionSet,
    GraphQLObjectType<Object?> objectType,
    Object objectValue, {
    required bool serial,
    ObjectExecutionCtx? parentCtx,
    Object? pathItem,
  }) async {
    final fragments = fragmentsFromDocument(baseCtx.document);
    final groupedFieldSet = collectFields(
      baseCtx.schema,
      fragments,
      objectType,
      selectionSet,
      baseCtx.variableValues,
    );
    final resultMap = <String, dynamic>{};
    final futureResultMap = <String, FutureOr<dynamic>>{};

    final objectCtx = ObjectExecutionCtx(
      executionCtx: baseCtx,
      objectType: objectType,
      objectValue: objectValue,
      parent: parentCtx,
      pathItem: pathItem,
      groupedFieldSet: groupedFieldSet,
    );

    if (groupedFieldSet.isEmpty && validate) {
      throw GraphQLError(
        'Must select some fields in object ${objectType.name}.',
        locations: GraphQLErrorLocation.listFromSource(
          selectionSet.span?.start,
        ),
        path: objectCtx.path.toList(),
      );
    }

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
        final GraphQLObjectField? objectField;
        final _introspect =
            introspect && objectType == baseCtx.schema.queryType;
        if (_introspect && fieldName == '__type') {
          objectField = typeIntrospectionTypeField;
        } else if (_introspect && fieldName == '__schema') {
          objectField = schemaIntrospectionTypeField;
        } else {
          objectField = objectType.fieldByName(fieldName);
        }
        if (objectField == null) {
          if (validate) {
            throw GraphQLError(
              'Unknown field name $fieldName for type ${objectType.name}.',
              locations: GraphQLErrorLocation.listFromSource(fieldSpan?.start),
              path: fieldPath,
            );
          } else {
            continue;
          }
        }
        final _objectField = objectField;
        if (validate &&
            objectField.type is GraphQLScalarType &&
            (field.selectionSet?.selections.isNotEmpty ?? false)) {
          throw GraphQLError(
            'Can´t have fields on scalar $fieldName (${objectField.type})'
            ' of object type ${objectType.name}.',
            locations: GraphQLErrorLocation.listFromSource(fieldSpan?.start),
            path: fieldPath,
          );
        }
        futureResponseValue = withExtensions<FutureOr<Object?>>(
          (n, e) => e.executeField(n, objectCtx, _objectField, alias),
          () {
            return executeField<Object?, Object?>(
              fields,
              objectCtx,
              _objectField,
            );
          },
        );
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

  /// Returns the serialized value of type [objectField] for the object [ctx]
  /// by [coerceArgumentValues], executing the resolver [resolveFieldValue]
  /// and serializing the result [completeValue]
  Future<T?> executeField<T, P>(
    List<FieldNode> fields,
    ObjectExecutionCtx<P> ctx,
    GraphQLObjectField<T, Object?, P> objectField,
  ) async {
    T? _returnError(GraphQLException err) {
      if (objectField.type.isNullable) {
        // TODO: add only one error?
        ctx.executionCtx.errors.add(err.errors.first);
        return null;
      } else {
        throw err;
      }
    }

    final field = fields.first;
    final fieldName = field.name.value;
    final pathItem = field.alias?.value ?? fieldName;
    final fieldSpan = field.span ?? field.alias?.span ?? field.name.span;
    final fieldPath = [...ctx.path, pathItem];

    final Map<String, dynamic> argumentValues;
    try {
      argumentValues = coerceArgumentValues(
        ctx.executionCtx.schema.serdeCtx,
        objectField,
        field,
        ctx.executionCtx.variableValues,
      );
    } catch (e, s) {
      return _returnError(
        GraphQLException.fromException(e, s, fieldPath, span: fieldSpan),
      );
    }

    final fieldCtx = Ctx<P>(
      args: argumentValues,
      objectCtx: ctx,
      field: objectField,
      pathItem: pathItem,
      lookahead: possibleSelectionsCallback(
        ctx.executionCtx.schema,
        objectField.type,
        ctx.groupedFieldSet[pathItem]!,
        ctx.executionCtx.document,
        ctx.executionCtx.variableValues,
      ),
    );
    try {
      final resolvedValue = await resolveFieldValue<T, P>(fieldCtx);
      return await completeValue(
        ctx,
        fieldName,
        objectField.type,
        fields,
        resolvedValue,
        pathItem: pathItem,
        reqCtx: fieldCtx,
      ) as T;
    } catch (e, s) {
      final err = mapException(
        ThrownError(
          error: e,
          stackTrace: s,
          path: fieldPath,
          span: fieldSpan,
          objectCtx: ctx,
          ctx: fieldCtx,
          type: objectField.type,
          location: ThrownErrorLocation.executeField,
        ),
      );
      return _returnError(err);
    }
  }

  Map<String, dynamic> coerceArgumentValues(
    SerdeCtx serdeCtx,
    GraphQLObjectField desiredField,
    FieldNode field,
    Map<String, dynamic> variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final argumentValues = field.arguments;
    final fieldName = field.name.value;
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
        } else if (argumentType.isNonNullable) {
          throw GraphQLException.fromMessage(
            'Missing value for argument "$argumentName" of type $argumentType'
            ' for field "$fieldName".',
          );
        }
      } else {
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
                  : 'Missing variable "$variableName" for argument'
                      ' "$argumentName" of type $argumentType'
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
            final errors = <GraphQLError>[
              GraphQLError(
                'Type coercion error for argument "$argumentName"'
                ' ($argumentType) of field "$fieldName". Got value $value.',
                locations: locations,
              )
            ];

            for (final error in validation.errors) {
              errors.add(
                GraphQLError(
                  error,
                  locations: locations,
                ),
              );
            }

            throw GraphQLException(errors);
          } else {
            // Nullability change was validation.value!
            final Object? serialized = validation.value;
            coercedValue = argumentDefinition.type.deserialize(
              serdeCtx,
              serialized,
            );
          }
        }
        coercedValues[argumentName] = coercedValue;
      }
    }

    return coercedValues;
  }

  Future<T?> resolveFieldValue<T, P>(Ctx<P> fieldCtx) async {
    final objectValue = fieldCtx.object;
    final field = fieldCtx.field;
    final fieldName = fieldCtx.field.name;

    return withExtensions(
      (next, p1) => p1.resolveField(next, fieldCtx),
      () async {
        if (objectValue is SubscriptionEvent) {
          if (field.resolve != null) {
            return await field.resolve!(objectValue, fieldCtx) as T?;
          }
          return objectValue.value as T?;
        } else if (field.resolve != null) {
          return await field.resolve!(objectValue, fieldCtx) as T?;
        } else if (objectValue is Map && objectValue.containsKey(fieldName)) {
          final Object? value = objectValue[fieldName];
          // TODO: support functions with more params?
          return await _extractResult(value) as T?;
        } else {
          final serialized = fieldCtx.objectCtx.serializedObject();
          if (serialized != null && serialized.containsKey(fieldName)) {
            final value = serialized[fieldName];
            return await _extractResult(value) as T?;
          }
          if (defaultFieldResolver != null) {
            final value = await defaultFieldResolver!(
              objectValue,
              fieldCtx,
            );
            return value as T?;
          }

          return null;
        }
      },
    );
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
  /// given the Object context [ctx]
  Future<Object?> completeValue(
    ObjectExecutionCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    List<SelectionNode> fields,
    Object? _result, {
    required Object pathItem,
    required Ctx reqCtx,
  }) async {
    final Object? result = await _extractResult(_result);
    return withExtensions(
        (next, e) => e.completeValue(next, ctx, fieldName, fieldType, result),
        () async {
      if (fieldType.isNullable && result == null) {
        return null;
      }
      final path = [...ctx.path, pathItem];
      Future<Object?> _completeScalar(GraphQLType fieldType) async {
        Object? _result = result;
        if (fieldType.generic.isValueOfType(_result)) {
          _result = fieldType.serialize(_result);
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
      }

      Future<Object?> _completeObjectOrUnion(GraphQLType fieldType) async {
        GraphQLObjectType objectType;

        if (fieldType is GraphQLObjectType && !fieldType.isInterface) {
          objectType = fieldType;
        } else {
          // if (validate && fieldType is GraphQLObjectType) {
          //   final selected = fields.map((e) => e.name.value).toSet();
          //   final delta = selected
          //       .difference(fieldType.fields.map((e) => e.name).toSet());
          //   if (delta.isNotEmpty) {
          //     throw GraphQLError(
          //       'Selected unknown fields $delta in interface $fieldType.',
          //       locations: [
          //         ...delta.map((e) {
          //           final _field = fields.firstWhere((f) => f.name.value == e);
          //           final span = (_field.span ??
          //               _field.alias?.span ??
          //               _field.name.span)!;
          //           return GraphQLErrorLocation.fromSourceLocation(span.start);
          //         })
          //       ],
          //       path: path,
          //     );
          //   }
          // }
          objectType = resolveAbstractType(ctx, fieldName, fieldType, result!);
        }

        Object _result = result!;
        if (fieldType is GraphQLUnionType) {
          _result = fieldType.extractInner(_result);
        }

        if (validate &&
            _result is! Map<String, dynamic> &&
            !objectType.generic.isValueOfType(_result)) {
          throw GraphQLException.fromMessage(
            'Expected value of type "$objectType" for'
            ' field "${ctx.objectType}.$fieldName", but got $_result.',
            path: path,
          );
        }

        final subSelectionSet = mergeSelectionSets(fields);
        return executeSelectionSet(
            ctx.executionCtx, subSelectionSet, objectType, _result,
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
            reqCtx: reqCtx,
          );

          if (completedResult == null) {
            throw GraphQLException.fromMessage(
              'Null value provided for non-nullable'
              ' field "${ctx.objectType}.$fieldName".',
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

          final listCtx = ObjectExecutionCtx<Object?>(
            executionCtx: ctx.executionCtx,
            pathItem: pathItem,
            // TODO: objectType, objectValue, groupedFieldSet do not apply to lists
            objectType: ctx.objectType,
            objectValue: ctx.objectValue,
            groupedFieldSet: ctx.groupedFieldSet,
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
                    reqCtx: reqCtx,
                  );
                } catch (error, s) {
                  final field = fields.first;
                  final fieldSpan = field is FieldNode
                      ? field.span ?? field.alias?.span ?? field.name.span
                      : field.span;
                  final err = mapException(ThrownError(
                    error: error,
                    stackTrace: s,
                    path: [...path, _i],
                    span: fieldSpan,
                    objectCtx: listCtx,
                    type: innerType,
                    location: ThrownErrorLocation.completeListItem,
                    ctx: reqCtx,
                  ));
                  if (innerType.isNullable) {
                    ctx.executionCtx.errors.add(err.errors.first);
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

  GraphQLException mapException(ThrownError error) {
    return withExtensions(
      (next, p1) => p1.mapException(next, error),
      () {
        return GraphQLException.fromException(
          error.error,
          error.stackTrace,
          error.path,
          span: error.span,
        );
      },
    );
  }

  GraphQLObjectType resolveAbstractType(
    ObjectExecutionCtx ctx,
    String fieldName,
    GraphQLType type,
    Object result,
  ) {
    final List<GraphQLObjectType> possibleTypes;
    final String? resolvedTypeName;

    if (type is GraphQLObjectType) {
      if (type.isInterface) {
        possibleTypes = type.possibleTypes;
        resolvedTypeName = type.resolveType?.call(result, type, ctx);
      } else {
        return type;
      }
    } else if (type is GraphQLUnionType) {
      possibleTypes = type.possibleTypes;
      resolvedTypeName = type.resolveType?.call(result, type, ctx);
    } else {
      throw ArgumentError(
        'abstract type should be an Object or Union. Received $type.',
      );
    }
    if (resolvedTypeName != null) {
      return possibleTypes.firstWhere((t) => t.name == resolvedTypeName);
    }

    final errors = <GraphQLError>[];

    /// Try to match with the objects' [isType] methods
    final matchingIsOfTypes = possibleTypes.where((t) {
      final isTypeOf = t.isTypeOf;
      return isTypeOf != null && isTypeOf.call(result, t, ctx);
    });
    // If there is only one match, return it,
    if (matchingIsOfTypes.length == 1) {
      return matchingIsOfTypes.first;
    }

    // Try to match match by the "__typename" property
    if (result is Map && result['__typename'] is String) {
      final _typename = result['__typename'] as String;
      final t = possibleTypes.firstWhereOrNull((t) => t.name == _typename);
      if (t != null) {
        return t;
      }
    }

    // Try to match with the type's generic
    final matchingTypes =
        possibleTypes.where((t) => t.generic.isValueOfType(result));
    // If there is only one match, return it,
    if (matchingTypes.length == 1) {
      return matchingTypes.first;
    }

    // Try to match with the type's generic with runtimeType
    final matchingTypesRuntime =
        possibleTypes.where((t) => t.generic.type == result.runtimeType);
    // If there is only one match, return it,
    if (matchingTypesRuntime.length == 1) {
      return matchingTypesRuntime.first;
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
          (m) => GraphQLError(m),
        ));
      } on GraphQLException catch (e) {
        errors.addAll(e.errors);
      }
    }

    errors.insert(
      0,
      GraphQLError(
        'Cannot convert value $result to type $type.',
      ),
    );

    // TODO: check if there is only one type matching
    // throw GraphQLException(errors);
    throw GraphQLException(errors);
  }
}

/// Wrapper around a value from a GraphQL Subscription Stream.
///
/// This type would be received in the resolve callback of a
/// GraphQL subscription field.
class SubscriptionEvent {
  final Object? value;

  const SubscriptionEvent._(this.value);
}

/// The execution location where this exception was thrown
enum ThrownErrorLocation {
  subscribe,
  executeField,
  completeListItem,
}

/// An error throw during the processing of a GraphQL request
class ThrownError {
  /// The source error
  final Object error;

  /// The source stack trace
  final StackTrace stackTrace;

  /// The path of execution
  final List<Object> path;

  /// The span in the query document associated with the error
  final FileSpan? span;

  /// The execution location
  final ThrownErrorLocation location;

  /// The object context
  final ObjectExecutionCtx<Object?> objectCtx;

  /// The field's resolve context
  final Ctx<Object?> ctx;

  /// The type associated with the resolved field
  /// for [ThrownErrorLocation.executeField] or [ThrownErrorLocation.subscribe]
  /// and the inner type for [ThrownErrorLocation.completeListItem]
  final GraphQLType type;

  const ThrownError({
    required this.error,
    required this.stackTrace,
    required this.path,
    required this.span,
    required this.location,
    required this.type,
    required this.objectCtx,
    required this.ctx,
  });
}

class InvalidOperationType implements Exception {
  final RequestCtx ctx;
  final DocumentNode document;
  final OperationDefinitionNode operation;
  final List<OperationType> validOperationTypes;

  const InvalidOperationType(
    this.ctx,
    this.document,
    this.operation,
    this.validOperationTypes,
  );

  @override
  String toString() {
    return 'InvalidOperationType('
        '${operation.name == null ? '' : 'operationName: ${operation.name!.value},'}'
        ' operationType: ${operation.type},'
        ' validOperationTypes: $validOperationTypes)';
  }
}
