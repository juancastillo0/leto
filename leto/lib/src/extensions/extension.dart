import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';

export 'package:gql/ast.dart' show DocumentNode;

export 'cache_extension.dart';
export 'logging_extension.dart';
export 'map_error_extension.dart';
export 'persisted_queries.dart';
export 'tracing.dart';

/// Extensions implement additional functionalities to the
/// server's parsing, validation and execution.
///
/// For example, extensions for tracing [GraphQLTracingExtension],
/// logging, error handling or caching [GraphQLPersistedQueries],
/// [CacheExtension].
///
/// If an extension is for logging or tracing (do not affect the execution
/// behavior), it should be the first in the [GraphQL.extensions] list.
abstract class GraphQLExtension {
  /// The key identifying this extension, used as the key for
  /// the extensions map in GraphQLError or GraphQLResult.
  /// Should be unique.
  String get mapKey;

  /// The entry point for each request, this is the first method
  /// executed in a [GraphQLExtension] for each request
  ///
  /// Subscriptions execute this once and then execute
  /// [executeSubscriptionEvent] for every
  /// [GraphQLResult.subscriptionStream] event
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ResolveBaseCtx ctx,
  ) =>
      next();

  /// Parser or retrieves the GraphQL [DocumentNode]
  /// from [query] or [extensions]
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    ResolveBaseCtx ctx,
  ) =>
      next();

  /// Executes validations given a schema,
  /// and the operation to perform
  GraphQLException? validate(
    GraphQLException? Function() next,
    ResolveBaseCtx ctx,
    DocumentNode document,
  ) =>
      next();

  /// Parses argument values and a executes a [field] in [ctx]
  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) =>
      next();

  /// Resolves a field with [ctx]
  FutureOr<T> resolveField<T>(
    FutureOr<T> Function() next,
    ReqCtx ctx,
  ) =>
      next();

  /// Called for every [GraphQLResult.subscriptionStream] event
  FutureOr<GraphQLResult> executeSubscriptionEvent(
    FutureOr<GraphQLResult> Function() next,
    ResolveCtx ctx,
    ScopedMap parentGlobals,
  ) =>
      next();

  /// Maps a resolved value into a serialized value
  FutureOr<Object?> completeValue(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    Object? result,
  ) =>
      next();

  /// Executes a callback for a [ThrownError] during execution
  ///
  /// Can be used for logging or mapping a resolver exception
  /// into a user friendly error.
  GraphQLException mapException(
    GraphQLException Function() next,
    ThrownError error,
  ) =>
      next();
}
