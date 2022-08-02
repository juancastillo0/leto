import 'dart:convert';
import 'dart:io';

import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf/src/multipart_shelf.dart' show extractMultiPartData;

Handler graphQLHttp(
  GraphQL graphQL, {
  ScopeOverrides? scopeOverrides,
  Response Function(Request)? onEmptyGet,
  Response Function(Request, Object, StackTrace)? onError,
}) {
  return (request) async {
    final requestVariables = {
      ...makeRequestScopedMap(
        request,
        isFromWebSocket: false,
      ),
      if (scopeOverrides != null) ...scopeOverrides
    };

    try {
      final GraphQLRequest graphQLRequest;
      final List<OperationType> validOperationTypes;
      try {
        if (request.method == 'POST') {
          validOperationTypes = [OperationType.query, OperationType.mutation];
          if (request.mimeType == 'application/graphql') {
            final text = await request.readAsString();
            graphQLRequest = GraphQLRequest(query: text);
          } else if (request.mimeType == 'multipart/form-data') {
            final data = await extractMultiPartData(request);
            final parseQueryResult = GraphQLRequest.fromMultiPartFormData(data);
            if (parseQueryResult.isErr()) {
              return Response(
                HttpStatus.badRequest,
                body: parseQueryResult.unwrapErr(),
              );
            }
            graphQLRequest = parseQueryResult.unwrap();
          } else if (request.mimeType == 'application/json' ||
              request.mimeType == 'application/graphql+json') {
            final payload = await extractJson(request);
            if (payload is Map<String, Object?> && payload['query'] == null) {
              payload['query'] = request.url.queryParameters['query'];
            }
            graphQLRequest = GraphQLRequest.fromJson(payload);
          } else {
            return Response(HttpStatus.badRequest);
          }
        } else if (request.method == 'GET') {
          validOperationTypes = [OperationType.query];
          final queryParams = request.url.queryParameters;
          if (queryParams['query'] is String) {
            // TODO: 3A allow requests without query but with extensions?
            //  such us persisted queries
            graphQLRequest = GraphQLRequest.fromQueryParameters(queryParams);
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

      final results = graphQLRequest.asIterable().map((gqlQuery) async {
        // ignore: unnecessary_await_in_return
        return await graphQL.parseAndExecute(
          gqlQuery.query,
          operationName: gqlQuery.operationName,
          variableValues: gqlQuery.variables,
          globalVariables: requestVariables,
          extensions: gqlQuery.extensions,
          sourceUrl: 'input',
          validOperationTypes: validOperationTypes,
        );
      });
      final resultList = await Future.wait(results);
      final Object? responseBody;
      if (graphQLRequest.isBatched) {
        responseBody = resultList.map((e) => e.toJson()).toList();
      } else {
        responseBody = resultList.first.toJson();
      }

      Response response = extractResponseFromMap(requestVariables);
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
    } on InvalidOperationType catch (e) {
      // HttpStatus.methodNotAllowed = 405
      return Response(HttpStatus.methodNotAllowed, body: e.toString());
    } catch (e, s) {
      return onError?.call(request, e, s) ?? Response.internalServerError();
    }
  };
}
