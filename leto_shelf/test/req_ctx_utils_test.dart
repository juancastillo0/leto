import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  test('request and response utils', () async {
    late Uri url;

    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          graphQLString.field(
            'fieldName',
            resolve: (_, ctx) {
              final _req = extractRequest(ctx);
              expect(
                {
                  'method': _req.method,
                  'mimeType': _req.mimeType,
                  'header-in': _req.headers['header-in'],
                  'url': _req.requestedUri.toString(),
                },
                {
                  'method': 'POST',
                  'mimeType': 'application/json',
                  'header-in': 'header-in-value1',
                  'url': url.toString(),
                },
              );

              Response response = extractResponse(ctx);
              expect(response.statusCode, 200);
              expect(response.isEmpty, true);

              ctx.updateResponse(
                (p0) => response.change(
                  headers: {'custom-header': 'value'},
                ),
              );

              ctx.changeHeader('custom-header', 'value2');
              ctx.appendHeader('custom-header', 'value3');
              response = extractResponse(ctx);
              expect(
                response.headersAll['custom-header'],
                ['value2', 'value3'],
              );

              return '';
            },
          ),
          graphQLString.field(
            'fieldName2',
            resolve: (_, ctx) {
              final _req = ctx.request;
              expect(
                {
                  'method': _req.method,
                  'mimeType': _req.mimeType,
                  'header-in': _req.headers['header-in'],
                  'url': _req.requestedUri.toString(),
                },
                {
                  'method': 'GET',
                  'mimeType': null,
                  'header-in': 'header-in-value2',
                  'url': url.replace(queryParameters: <String, String>{
                    'query': '{ fieldName2 }'
                  }).toString(),
                },
              );

              Response response = ctx.response;
              expect(response.statusCode, 200);
              expect(response.isEmpty, true);

              ctx.updateResponse((p0) => Response(201));
              ctx.appendHeader('custom-header', 'value1');
              response = extractResponse(ctx);
              expect(
                response.headersAll['custom-header'],
                ['value1'],
              );
              expect(response.statusCode, 201);

              return '';
            },
          ),
        ],
      ),
    );

    url = await simpleGraphQLHttpServer(
      const Pipeline().addMiddleware((innerHandler) {
        return (req) {
          return innerHandler(req);
        };
      }),
      schema,
    );

    final client = http.Client();

    GraphQLResponse r = await send(
      client,
      url,
      const GraphQLRequest(query: '{ fieldName }'),
      headers: {
        'header-in': 'header-in-value1',
      },
    );

    expect(r.statusCode, 200);
    expect(r.body, {
      'data': {'fieldName': ''}
    });
    expect(r.response.headers['custom-header'], 'value2, value3');

    r = await send(
      client,
      url,
      const GraphQLRequest(query: '{ fieldName2 }'),
      headers: {
        'header-in': 'header-in-value2',
      },
      useGET: true,
    );

    expect(r.body, null);
    expect(r.response.headers['custom-header'], 'value1');
    expect(r.response.statusCode, 201);
    expect(r.response.body, '');
  });
}

Future<GraphQLResponse> send(
  http.Client client,
  Uri url,
  GraphQLRequest request, {
  bool useGET = false,
  Map<String, String>? headers,
}) async {
  final http.Response response;

  if (useGET) {
    response = await client.get(
      url.replace(queryParameters: request.toQueryParameters()),
      headers: {
        if (headers != null) ...headers,
      },
    );
  } else {
    response = await client.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (headers != null) ...headers,
      },
    );
  }
  final body = response.statusCode == 200
      ? jsonDecode(response.body) as Map<String, Object?>?
      : null;
  return GraphQLResponse(response, body);
}

class GraphQLResponse {
  final http.Response response;
  final Map<String, Object?>? body;

  GraphQLResponse(this.response, this.body);
  int get statusCode => response.statusCode;
}
