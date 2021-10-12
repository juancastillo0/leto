import 'dart:async';

import 'package:gql/ast.dart' show DocumentNode;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';

export 'persisted_queries.dart';
export 'tracing.dart';

abstract class GraphQLExtension {
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
