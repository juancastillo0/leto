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
    globalVariables: ScopedMap({
      testUnionModelsTestKey: _testUnionModels,
    }),
    extensionList: [GraphQLPersistedQueries()],
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

  test('file upload', () async {
    final operations = const GraphQLRequest(
        query: 'mutation addFile(\$fileVar: Upload!) { '
            ' addFile (file: \$fileVar){ filename mimeType sizeInBytes }'
            ' }',
        variables: {
          'fileVar': null,
        }).toJson();

    final fileToUpload = http.MultipartFile.fromBytes(
      'filename1Field',
      utf8.encode('testString in file'),
      filename: 'filename1.txt',
    );
    // TODO:
    // final fileToUpload = http.MultipartFile.fromString(
    //   'filename1Field',
    //   'testString in file',
    //   filename: 'filename1.txt',
    // );

    final request = http.MultipartRequest('POST', url)
      ..fields['operations'] = jsonEncode(operations)
      ..fields['map'] = jsonEncode(<String, Object?>{
        'filename1Field': ['variables.fileVar'],
      })
      ..files.add(fileToUpload)
      ..headers['shelf-test'] = 'true';

    final response = await request.send();
    expect(response.statusCode, 200);

    final bodyStr = await response.stream.bytesToString();
    final body = jsonDecode(bodyStr) as Map<String, Object?>;
    expect(body, {
      'data': {
        'addFile': {
          'filename': fileToUpload.filename,
          'sizeInBytes': fileToUpload.length,
          'mimeType': fileToUpload.contentType.mimeType,
        }
      }
    });
  });

  test('generated union', () async {
    final client = http.Client();

    // TODO: check name alias
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
      name
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
              'name': e.name,
              'cost': e.cost,
              'dates': e.dates?.map((e) => e.toIso8601String()).toList(),
              // 'runtimeType': 'delete',
            },
          );
        }).toList(),
      }
    };
    final sha256Hash = sha256.convert(utf8.encode(_query)).toString();

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

    /// POST without query text batched
    const reqBatched = GraphQLRequest(query: _query);
    final responseBatched = await client.post(
      url,
      body: jsonEncode([req2.toJson(), reqBatched.toJson()]),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
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
  });
}
