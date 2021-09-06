import 'dart:convert';
import 'dart:io';

import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_graphql/src/middlewares.dart';
import 'package:shelf_graphql/src/multipart_shelf.dart';
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';

const requestCtxKey = '__request';

extension ReqCtxShelf on ReqCtx {
  Request get request => extractRequest(this);
}

Request extractRequest(ReqCtx ctx) {
  return ctx.globals[requestCtxKey]! as Request;
}

Handler graphqlHttp(GraphQL graphQL) {
  return (request) async {
    final globalVariables = <String, Object?>{
      requestCtxKey: request,
    };

    try {
      final GraphqlRequest gqlQuery;
      if (request.method == 'POST') {
        if (request.mimeType == 'application/graphql') {
          final text = await request.readAsString();
          gqlQuery = GraphqlRequest(query: text);
        } else if (request.mimeType == 'multipart/form-data') {
          final data = await extractMultiPartData(request);
          final parseQueryResult = GraphqlRequest.fromMultiPartFormData(data);
          if (parseQueryResult.isErr()) {
            return Response(
              HttpStatus.badRequest,
              body: parseQueryResult.unwrapErr(),
            );
          }
          gqlQuery = parseQueryResult.unwrap();
        } else if (request.mimeType == 'application/json') {
          final payload = extractJson(request)! as Map<String, Object?>;
          if (payload['query'] == null) {
            payload['query'] = request.url.queryParameters['query'];
          }
          gqlQuery = GraphqlRequest.fromJson(payload);
        } else {
          return Response(HttpStatus.badRequest);
        }
      } else if (request.method == 'GET') {
        gqlQuery = GraphqlRequest.fromQueryParameters(
          request.url.queryParameters,
        );
      } else {
        return Response.notFound('');
      }

      Map<String, Object?> responseBody;
      try {
        final data = await graphQL.parseAndExecute(
          gqlQuery.query,
          operationName: gqlQuery.operationName,
          variableValues: gqlQuery.variables,
          globalVariables: globalVariables,
          extensions: gqlQuery.extensions,
          sourceUrl: 'input',
        );
        responseBody = {'data': data};
      } on GraphQLException catch (e) {
        responseBody = e.toJson();
      }
      final headers = ReqCtx.headersFromGlobals(globalVariables);
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


// import 'package:gql/ast.dart' as ast;
// import 'package:gql/language.dart' as lang;
// import 'package:gql/operation.dart' as gql_operation;
// import 'package:gql/schema.dart' as gql_schema;

// class GqlResolver {
//   final String name;
//   final Map<String, GqlField> fields;

//   const GqlResolver(this.name, this.fields);
// }

// class GqlField {}

// class GqlType {}

// final schemaDefinition = lang.parseString('''
// schema {
//   query: StarWarsQuery
// }

// interface Character {
//   id: String
//   name: String
// }

// type Droid implements Character {
//   id: String
//   name: String
//   primaryFunction: String
// }

// type StarWarsQuery {
//   droids: [Droid!]
// }
// ''');

// final queryDefinition = lang.parseString('''
// query AllDroids {
//   droids {
//     ...droidName
//     primaryFunction
//   }
// }
// ''');

// final fragmentDefinitions = [
//   lang.parseString('''
//   fragment droidName on Droid {
//     name
//   }
//   '''),
// ];

// final schema = gql_schema.GraphQLSchema.fromNode(schemaDefinition);

// final document = gql_operation.ExecutableDocument(
//   queryDefinition,
//   schema.getType,
//   // necessary for dereferencing schema definitions
//   fragmentDefinitions,
// );
