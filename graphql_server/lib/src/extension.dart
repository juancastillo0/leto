import 'dart:async';

import 'package:gql/ast.dart' show DocumentNode;
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';

export 'persisted_queries.dart';
export 'tracing.dart';

abstract class GraphQLExtension {
  String get mapKey;

  void start(
    Map<Object, Object?> globals,
    Map<String, Object?>? extensions,
  ) {}

  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
    Map<Object, Object?> globals,
    Map<String, Object?>? extensions,
  ) =>
      next();

  GraphQLException? validate(
    GraphQLException? Function() next,
    GraphQLSchema schema,
    DocumentNode document,
    Map<Object, Object?> globals,
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

  FutureOr<Object?> completeValue(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    Object? result,
  ) =>
      next();

  Object? toJson(Map<Object, Object?> globals) {}
}
