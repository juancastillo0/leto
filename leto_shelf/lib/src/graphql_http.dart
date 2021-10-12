import 'dart:convert';
import 'dart:io';

import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_graphql/src/middlewares.dart';
import 'package:shelf_graphql/src/multipart_shelf.dart';
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';

final requestCtxKey = GlobalRef('__request');

extension ReqCtxShelf on ReqCtx {
  Request get request => extractRequest(this);
}

Request extractRequest(ReqCtx ctx) {
  return ctx.globals[requestCtxKey]! as Request;
}

Handler graphqlHttp(GraphQL graphQL, {ScopedMap? globalVariables}) {
  return (request) async {
    final _nested = <Object, Object?>{requestCtxKey: request};
    final _globalVariables = globalVariables != null
        ? globalVariables.child(_nested)
        : ScopedMap(_nested);

    try {
      final GraphQLRequest gqlQuery;
      if (request.method == 'POST') {
        if (request.mimeType == 'application/graphql') {
          final text = await request.readAsString();
          gqlQuery = GraphQLRequest(query: text);
        } else if (request.mimeType == 'multipart/form-data') {
          final data = await extractMultiPartData(request);
          final parseQueryResult = GraphQLRequest.fromMultiPartFormData(data);
          if (parseQueryResult.isErr()) {
            return Response(
              HttpStatus.badRequest,
              body: parseQueryResult.unwrapErr(),
            );
          }
          gqlQuery = parseQueryResult.unwrap();
        } else if (request.mimeType == 'application/json') {
          final payload = extractJson(request);
          if (payload is Map<String, Object?> && payload['query'] == null) {
            payload['query'] = request.url.queryParameters['query'];
          }
          gqlQuery = GraphQLRequest.fromJson(payload);
        } else {
          return Response(HttpStatus.badRequest);
        }
      } else if (request.method == 'GET') {
        gqlQuery = GraphQLRequest.fromQueryParameters(
          request.url.queryParameters,
        );
      } else {
        return Response.notFound('');
      }

      final results = gqlQuery.asIterable().map((gqlQuery) async {
        // ignore: unnecessary_await_in_return
        return await graphQL.parseAndExecute(
          gqlQuery.query,
          operationName: gqlQuery.operationName,
          variableValues: gqlQuery.variables,
          globalVariables: _globalVariables,
          extensions: gqlQuery.extensions,
          sourceUrl: 'input',
        );
      });
      final resultList = await Future.wait(results);
      final Object? responseBody;
      if (gqlQuery.isBatched) {
        responseBody = resultList.map((e) => e.toJson()).toList();
      } else {
        responseBody = resultList.first.toJson();
      }

      final headers = ReqCtx.headersFromGlobals(_globalVariables);
      final response = Response.ok(jsonEncode(responseBody), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (headers != null) ...headers,
      });
      return response;
    } on Response catch (e) {
      return e;
    } catch (e, s) {
      extractLog(request)?.call('$e $s');
      return Response.internalServerError();
    }
  };
}
