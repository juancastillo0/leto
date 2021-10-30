import 'dart:async';

import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';

export 'package:gql/ast.dart' show DocumentNode;

export 'cache_extension.dart';
export 'persisted_queries.dart';
export 'tracing.dart';

/// Extensions implement additional functionalities to the
/// server's parsing, validation and execution.
///
/// For example, extensions for tracing [GraphQLTracingExtension],
/// logging, error handling or caching [GraphQLPersistedQueries],
/// [CacheExtension].
abstract class GraphQLExtension {
  /// The key identifying this extension, used as the key for
  /// the extensions map in GraphQLError or GraphQLResult.
  /// Should be unique.
  String get mapKey;

  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) =>
      next();

  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) =>
      next();

  GraphQLException? validate(
    GraphQLException? Function() next,
    GraphQLSchema schema,
    DocumentNode document,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) =>
      next();

  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) =>
      next();

  FutureOr<GraphQLResult> executeSubscriptionEvent(
    FutureOr<GraphQLResult> Function() next,
    ResolveCtx ctx,
    ScopedMap parentGlobals,
  ) =>
      next();

  FutureOr<Object?> completeValue(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    Object? result,
  ) =>
      next();
}
