import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql/src/multipart_shelf.dart'
    show extractMultiPartData;
import 'package:shelf_graphql/src/server_utils/graphql_request.dart'
    show GraphQLRequest;

Handler graphqlHttp(
  GraphQL graphQL, {
  ScopedMap? globalVariables,
  Response Function(Request)? onEmptyGet,
  Response Function(Request, Object, StackTrace)? onError,
}) {
  return (request) async {
    final _nested = <Object, Object?>{requestCtxKey: request};
    final _globalVariables = globalVariables != null
        ? globalVariables.child(_nested)
        : ScopedMap(_nested);

    try {
      final GraphQLRequest gqlQuery;
      try {
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
          final queryParams = request.url.queryParameters;
          if (queryParams['query'] is String) {
            // TODO: allow requests without query but with extensions, such us
            // persisted queries
            gqlQuery = GraphQLRequest.fromQueryParameters(queryParams);
          } else {
            return onEmptyGet?.call(request) ?? Response(HttpStatus.badRequest);
          }
        } else {
          return Response.notFound('');
        }
      } catch (e) {
        if (e is Response) return e;
        return Response(HttpStatus.badRequest, body: e.toString());
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

      Response response =
          _globalVariables[responseCtxKey] as Response? ?? Response.ok(null);
      if (response.statusCode != 200 || !response.isEmpty) {
        return response;
      }
      // ignore: join_return_with_assignment
      response = response.change(
        body: jsonEncode(responseBody),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      return response;
    } on Response catch (e) {
      return e;
    } catch (e, s) {
      extractLog(request)?.call('$e $s');
      return onError?.call(request, e, s) ?? Response.internalServerError();
    }
  };
}
