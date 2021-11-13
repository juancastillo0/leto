import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as gql;
import 'package:leto_schema/introspection.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart'
    show computeValue, convertType, getDirectiveValue, isInputType;
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
  final FutureOr<Object?> Function(Object? parent, ReqCtx)?
      defaultFieldResolver;

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

  final Map<Object, Object?>? globalVariables;

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
  final FutureOr<Object?> Function(Object? parent, ReqCtx)?
      defaultFieldResolver;

  /// Variables passed to all executed requests
  final Map<Object, Object?> baseGlobalVariables;

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

  late final GraphQLSchema _schema;

  /// A Dart implementation of a GraphQL server.
  ///
  /// Parses, validates and executes GraphQL requests using the
  /// provided [GraphQLSchema].
  GraphQL(
    GraphQLSchema schema, {
    bool? introspect,
    bool? validate,
    this.defaultFieldResolver,
    this.extensions = const [],
    Map<Object, Object?>? globalVariables,
  })  : baseGlobalVariables = globalVariables ?? const {},
        introspect = introspect ?? true,
        validate = validate ?? true {
    if (this.introspect) {
      _schema = reflectSchema(schema);
    } else {
      _schema = schema;
    }
  }

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

  static final _resolveCtxRef = ScopeRef<ResolveCtx>('ResolveCtx');

  /// Gets the [ResolveCtx] of a request from a [scope].
  /// null when the execution stage hasn't started.
  static ResolveCtx? getResolveCtx(GlobalsHolder scope) =>
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
    ScopedMap? globalVariables,
    List<OperationType> validOperationTypes = OperationType.values,
  }) async {
    final _globalVariables = globalVariables ?? ScopedMap.empty();
    for (final e in baseGlobalVariables.entries) {
      _globalVariables.putScopedIfAbsent(e.key, () => e.value);
    }
    _graphQLExecutorRef.setScoped(_globalVariables, this);

    final preExecuteCtx = ResolveBaseCtx(
      extensions: extensions,
      globals: _globalVariables,
      operationName: operationName,
      query: query,
      rootValue: rootValue ?? _globalVariables,
      rawVariableValues: variableValues,
      schema: _schema,
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
            _schema,
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
    required ResolveBaseCtx ctx,
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
    required ResolveBaseCtx baseCtx,
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
    final ctx = ResolveCtx(
      document: document,
      operation: operation,
      globals: globalVariables,
      variableValues: coercedVariableValues,
      baseCtx: baseCtx,
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
    ResolveCtx ctx,
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
    ResolveCtx ctx,
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
    ResolveCtx baseCtx,
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
    ResolveCtx baseCtx,
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
    final groupedFieldSet = collectFields(baseCtx.document, subscriptionType,
        selectionSet, baseCtx.variableValues);
    if (validate && groupedFieldSet.length != 1) {
      throw GraphQLException.fromMessage(
        'The grouped field set from this query must have exactly one entry.',
        // TODO:
        // selectionSet.selections.elementAt(1).span!,
      );
    }

    final objCtx = ResolveObjectCtx(
      resolveCtx: baseCtx,
      groupedFieldSet: groupedFieldSet,
      objectType: subscriptionType,
      objectValue: rootValue,
      parent: null,
      pathItem: null,
    );
    final fields = groupedFieldSet.entries.first.value;
    final fieldNode = fields.first;
    final argumentValues = coerceArgumentValues(
        schema.serdeCtx, subscriptionType, fieldNode, baseCtx.variableValues);
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
    ResolveCtx streamCtx,
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
        final ctx = ResolveCtx(
          baseCtx: streamCtx.baseCtx,
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
    ResolveObjectCtx ctx,
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

    final reqCtx = ReqCtx<Object?>(
      args: argumentValues,
      field: field,
      parentCtx: ctx,
      pathItem: pathItem,
      lookahead: possibleSelectionsCallback(
        field.type,
        ctx.groupedFieldSet[pathItem]!,
        ctx.resolveCtx.document,
        ctx.variableValues,
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
        throw Exception(
          'Could not resolve subscription field event stream for $fieldName.',
        );
      }
    } catch (e, s) {
      throw mapException(
        ThrownError(
          error: e,
          stackTrace: s,
          path: [pathItem],
          span: fieldNode.span ?? fieldNode.alias?.span ?? fieldNode.name.span,
          objectCtx: reqCtx.parentCtx,
          type: reqCtx.field.type,
          ctx: reqCtx,
          location: ThrownErrorLocation.subscribe,
        ),
      );
    }

    final Stream<Object?> stream;
    if (result is Stream) {
      stream = result;
    } else {
      stream = Stream.fromIterable([result]);
    }

    return stream; // Result.captureStream(stream).map((event) {});
  }

  Future<Map<String, dynamic>> executeSelectionSet(
    ResolveCtx baseCtx,
    SelectionSetNode selectionSet,
    GraphQLObjectType<Object?> objectType,
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
      resolveCtx: baseCtx,
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
        final objectField = objectType.fields.firstWhereOrNull(
          (f) => f.name == fieldName,
        );
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
          (n, e) => e.executeField(n, objectCtx, objectField, alias),
          () {
            return executeField<Object?, Object?>(
              fields,
              objectCtx,
              objectField,
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
    ResolveObjectCtx<P> ctx,
    GraphQLObjectField<T, Object?, P> objectField,
  ) async {
    T? _returnError(GraphQLException err) {
      if (objectField.type.isNullable) {
        // TODO: add only one error?
        ctx.resolveCtx.errors.add(err.errors.first);
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
        ctx.resolveCtx.schema.serdeCtx,
        ctx.objectType,
        field,
        ctx.variableValues,
      );
    } catch (e, s) {
      return _returnError(
        GraphQLException.fromException(e, s, fieldPath, span: fieldSpan),
      );
    }

    final fieldCtx = ReqCtx<P>(
      args: argumentValues,
      parentCtx: ctx,
      field: objectField,
      pathItem: pathItem,
      lookahead: possibleSelectionsCallback(
        objectField.type,
        ctx.groupedFieldSet[pathItem]!,
        ctx.resolveCtx.document,
        ctx.variableValues,
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
    GraphQLObjectType objectType,
    FieldNode field,
    Map<String, dynamic> variableValues,
  ) {
    final coercedValues = <String, dynamic>{};
    final argumentValues = field.arguments;
    final fieldName = field.name.value;
    final desiredField = objectType.fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () => throw GraphQLError(
        '${objectType.name} has no field named "$fieldName".',
        locations: GraphQLErrorLocation.listFromSource(
            (field.span ?? field.name.span)?.start),
      ),
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

  PossibleSelections? Function() possibleSelectionsCallback(
    GraphQLType type,
    List<FieldNode> fields,
    DocumentNode document,
    Map<String, Object?> variableValues,
  ) {
    bool calculated = false;
    PossibleSelections? _value;
    return () {
      if (calculated) return _value;

      final possibleObjects = <GraphQLObjectType>[];

      void _mapperType(GraphQLWrapperType nn) {
        final ofType = nn.ofType;
        if (ofType is GraphQLObjectType) {
          possibleObjects.add(ofType);
        } else if (ofType is GraphQLUnionType) {
          possibleObjects.addAll(ofType.possibleTypes);
        } else if (ofType is GraphQLWrapperType) {
          _mapperType(ofType as GraphQLWrapperType);
        }
      }

      type.whenOrNull(
        object: (obj) {
          possibleObjects.add(obj);
        },
        union: (union) => possibleObjects.addAll(union.possibleTypes),
        nonNullable: _mapperType,
        list: _mapperType,
      );
      if (possibleObjects.isNotEmpty) {
        final selectionSet = mergeSelectionSets(fields);

        _value = PossibleSelections(
          Map.fromEntries(
            possibleObjects.map((obj) {
              final nonAlised = collectFields(
                document,
                obj,
                selectionSet,
                variableValues,
                aliased: false,
              );

              Iterable<MapEntry<String, PossibleSelections? Function()>>
                  _mapEntries(
                Iterable<MapEntry<String, List<FieldNode>>> entries,
              ) {
                return entries.map(
                  (e) {
                    final fieldName = e.value.first.name.value;
                    final field = obj.fields.firstWhereOrNull(
                      (f) => f.name == fieldName,
                    );
                    if (field == null) {
                      // TODO: should we do something else?
                      return null;
                    }
                    return MapEntry(
                      e.key,
                      possibleSelectionsCallback(
                        field.type,
                        e.value,
                        document,
                        variableValues,
                      ),
                    );
                  },
                ).whereType();
              }

              return MapEntry(
                obj.name,
                PossibleSelectionsObject(
                  Map.fromEntries(
                    _mapEntries(nonAlised.entries),
                  ),
                ),
              );
            }),
          ),
          fields,
        );
      }
      calculated = true;
      return _value;
    };
  }

  Future<T?> resolveFieldValue<T, P>(ReqCtx<P> fieldCtx) async {
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
          final serialized = fieldCtx.parentCtx.serializedObject();
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
    ResolveObjectCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    List<SelectionNode> fields,
    Object? _result, {
    required Object pathItem,
    required ReqCtx reqCtx,
  }) async {
    final Object? result = await _extractResult(_result);
    return withExtensions(
        (next, e) => e.completeValue(next, ctx, fieldName, fieldType, result),
        () async {
      if (fieldType.isNullable && result == null) {
        return null;
      }
      final path = [...ctx.path, pathItem];
      Future<Object?> _completeScalar(GraphQLScalarType fieldType) async {
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
            ctx.resolveCtx, subSelectionSet, objectType, _result,
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

          final listCtx = ResolveObjectCtx<Object?>(
            resolveCtx: ctx.resolveCtx,
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
                    ctx.resolveCtx.errors.add(err.errors.first);
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
    ResolveObjectCtx ctx,
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
    bool aliased = true,
  }) {
    final groupedFields = <String, List<FieldNode>>{};
    visitedFragments ??= [];

    for (final selection in selectionSet.selections) {
      final directives = selection.directives;
      if (getDirectiveValue('skip', 'if', directives, variableValues) == true) {
        continue;
      }
      if (getDirectiveValue('include', 'if', directives, variableValues) ==
          false) {
        continue;
      }

      if (selection is FieldNode) {
        final responseKey = aliased
            ? (selection.alias?.value ?? selection.name.value)
            : selection.name.value;
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
            visitedFragments: visitedFragments, aliased: aliased);

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
            visitedFragments: visitedFragments, aliased: aliased);

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
    final type = convertType(typeNode, _schema.typeMap);

    return type.whenMaybe(
      object: (type) {
        if (type.isInterface) {
          return objectType.isImplementationOf(type);
        } else {
          return type.name == objectType.name;
        }
      },
      union: (type) {
        return type.possibleTypes.any((t) => objectType.isImplementationOf(t));
      },
      orElse: (_) => false,
    );
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

extension DirectiveExtension on SelectionNode {
  List<DirectiveNode> get directives {
    final selection = this;
    return selection is FieldNode
        ? selection.directives
        : selection is FragmentSpreadNode
            ? selection.directives
            : (selection as InlineFragmentNode).directives;
  }

  T when<T>({
    required T Function(FieldNode) field,
    required T Function(FragmentSpreadNode) fragmentSpread,
    required T Function(InlineFragmentNode) inlineFragment,
  }) {
    final selection = this;
    if (selection is FieldNode) return field(selection);
    if (selection is FragmentSpreadNode) return fragmentSpread(selection);
    if (selection is InlineFragmentNode) return inlineFragment(selection);
    throw Error();
  }
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
  final ResolveObjectCtx<Object?> objectCtx;

  /// The field's resolve context
  final ReqCtx<Object?> ctx;

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
  final ResolveBaseCtx ctx;
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
    return 'InvalidOperationType(operationName: ${operation.name},'
        ' operationType: ${operation.type},'
        ' validOperationTypes: $validOperationTypes)';
  }
}
