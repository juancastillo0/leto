import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';

abstract class GraphQLExtension {
  String get mapKey;

  void start(
    Map<Object, Object?> globals,
    Map<String, Object?>? extensions,
  ) {}

  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
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
    Object fieldPath,
    GraphQLType fieldType,
    Object? result,
  ) =>
      next();

  Object? toJson(Map<Object, Object?> globals) {}
}
