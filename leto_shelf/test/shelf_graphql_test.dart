import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show sha256;
import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf/src/server_utils/graphql_request.dart';
import 'package:leto_shelf_example/schema/generator_test.dart';
import 'package:test/test.dart';

import 'common.dart';

Future<void> main() async {
  final _testUnionModels = [
    null,
    const EventUnion.add(
      name: 'da',
      models: [
        null,
        TestModel(name: 'da test', description: 'dda'),
      ],
    ),
    EventUnion.delete(
      name: 'da',
      cost: 24,
      dates: [DateTime(2021, 2, 4)],
    ),
  ];

  final _server = await testServer(ServerConfig(
    globalVariables: ScopedMap(
      overrides: [
        testUnionModelsTestKey.override((_) => _testUnionModels),
      ],
    ),
    extensionList: [
      GraphQLPersistedQueries(
        returnHashInResponse: false,
      )
    ],
  ));
  final url = _server.url;

  test('query ui html', () async {
    final client = http.Client();

    Future<void> _validateResponse(http.Response response) async {
      expect(response.statusCode, 200);
      expect(response.headers[HttpHeaders.contentTypeHeader], 'text/html');
      await checkEtag(client, response);
    }

    await Future.wait(
      ['/altair', '/playground', '/graphiql'].map(
        (e) => client.get(url.replace(path: e)).then(_validateResponse),
      ),
    );
  });

  const _query = '''
query unions {
  testUnionModels(positions: [null, 1]) {
    ... on EventUnionAdd {
      name
      description
      models {
        name
        description
      }
    }
    ... on EventUnionDelete {
      nameDelete: name
      cost
      dates
    }
  }
}
''';

  final expectedBody = {
    'data': {
      'testUnionModels': _testUnionModels.map((e) {
        if (e == null) {
          return null;
        }
        return e.map(
          add: (e) => {
            'name': e.name,
            'description': e.description,
            // 'runtimeType': 'add',
            'models': e.models
                .map((e) => e == null
                    ? null
                    : {
                        'name': e.name,
                        'description': e.description,
                      })
                .toList()
          },
          delete: (e) => {
            'nameDelete': e.name,
            'cost': e.cost,
            'dates': e.dates?.map((e) => e.toIso8601String()).toList(),
            // 'runtimeType': 'delete',
          },
        );
      }).toList(),
    }
  };
  final sha256Hash = sha256.convert(utf8.encode(_query)).toString();

  test('generated union success', () async {
    final client = http.Client();

    /// GET without query text (using persistedQueryExtension)
    /// returns error since
    final reqErr = GraphQLRequest(
      query: '',
      operationName: 'unions',
      extensions: persistedQueryExtension(sha256Hash),
    );
    final responseErr = await client.get(
      url.replace(queryParameters: reqErr.toQueryParameters()),
    );
    expect(responseErr.statusCode, 200);
    expect(jsonDecode(responseErr.body), {
      'errors': [
        {'message': GraphQLPersistedQueries.PERSISTED_QUERY_NOT_FOUND}
      ]
    });

    /// GET with query text (using persistedQueryExtension)
    final req = GraphQLRequest(
      query: _query,
      operationName: 'unions',
      extensions: persistedQueryExtension(sha256Hash),
    );
    final response = await client.get(
      url.replace(queryParameters: req.toQueryParameters()),
    );
    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), expectedBody);

    /// POST without query text (using persistedQueryExtension)
    final req2 = GraphQLRequest(
      query: '',
      operationName: 'unions',
      extensions: persistedQueryExtension(sha256Hash),
    );
    final response2 = await client.post(
      url,
      body: jsonEncode(req2.toJson()),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(response2.statusCode, 200);
    expect(jsonDecode(response2.body), expectedBody);

    /// POST without query text batched with graphql+json
    const reqBatched = GraphQLRequest(query: _query);
    final responseBatched = await client.post(
      url,
      body: jsonEncode([req2.toJson(), reqBatched.toJson()]),
      headers: {HttpHeaders.contentTypeHeader: 'application/graphql+json'},
    );
    expect(responseBatched.statusCode, 200);
    expect(jsonDecode(responseBatched.body), [expectedBody, expectedBody]);

    /// POST without query text batched
    final responseBatchedSingle = await client.post(
      url,
      body: jsonEncode([req2.toJson()]),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(responseBatchedSingle.statusCode, 200);
    expect(jsonDecode(responseBatchedSingle.body), [expectedBody]);

    /// POST with application/graphql
    final responseApplicationGraphQL = await client.post(
      url,
      body: _query,
      headers: {HttpHeaders.contentTypeHeader: 'application/graphql'},
    );
    expect(responseApplicationGraphQL.statusCode, 200);
    expect(jsonDecode(responseApplicationGraphQL.body), expectedBody);

    /// POST with query in queryParameters
    final responsePostQueryParams = await client.post(
      url.replace(queryParameters: <String, String>{'query': _query}),
      body: jsonEncode({'extensions': persistedQueryExtension(sha256Hash)}),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(responsePostQueryParams.statusCode, 200);
    expect(jsonDecode(responsePostQueryParams.body), expectedBody);
  });

  test('http errors', () async {
    final client = http.Client();

    // no query POST
    http.Response response = await client.post(
      url,
      body: jsonEncode({'extensions': persistedQueryExtension(sha256Hash)}),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(response.statusCode, 400);

    // extensions is not a map
    response = await client.post(
      url,
      body: jsonEncode({'query': _query, 'extensions': <String>[]}),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(response.statusCode, 400);

    // no query GET
    response = await client.get(url);
    expect(response.statusCode, 400);

    // Mutation in GET
    response = await client.get(url.replace(
      queryParameters: <String, String>{
        'query': 'mutation addTestModel { addTestModel { name } }'
      },
    ));
    expect(response.statusCode, 405);

    // Mutation in GET with operationName
    response = await client.get(url.replace(
      queryParameters: <String, String>{
        'query': '$_query mutation addTestModel { addTestModel { name } }',
        'operationName': 'addTestModel',
      },
    ));
    expect(response.statusCode, 405);

    // PUT
    response = await client.put(url);
    expect(response.statusCode, 404);
    // DELETE
    response = await client.delete(url);
    expect(response.statusCode, 404);
    // HEAD
    response = await client.head(url);
    expect(response.statusCode, 404);
  });
}
