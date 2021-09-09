import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';
import 'package:shelf_graphql_example/run_server.dart' show serverHandler;
import 'package:test/test.dart';

Future<void> main() async {
  final handler = serverHandler();
  final server = await io.serve(
    handler,
    '0.0.0.0',
    0,
  );
  // Enable content compression
  server.autoCompress = true;

  final url = Uri.http(
    '${server.address.host}:${server.port}',
    '/graphql',
  );

  test('query ui html', () async {
    final client = http.Client();

    Future<void> _validateResponse(http.Response response) async {
      expect(response.statusCode, 200);
      expect(response.headers[HttpHeaders.contentTypeHeader], 'text/html');

      final etag = response.headers[HttpHeaders.etagHeader];
      expect(etag, isNotNull);

      final responseCached = await client.get(
        response.request!.url,
        headers: {HttpHeaders.ifNoneMatchHeader: etag!},
      );

      expect(responseCached.statusCode, 304);
    }

    await Future.wait(
      ['/altair', '/playground', '/graphiql'].map(
        (e) => client.get(url.replace(path: e)).then(_validateResponse),
      ),
    );
  });

  test('file upload', () async {
    final operations = const GraphqlRequest(
        query: 'mutation addFile(\$fileVar: Upload!) { '
            ' addFileCommand (file: \$fileVar){ name mimeType sizeInBytes }'
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
      ..files.add(fileToUpload);

    final response = await request.send();
    expect(response.statusCode, 200);

    final bodyStr = await response.stream.bytesToString();
    final body = jsonDecode(bodyStr) as Map<String, Object?>;
    expect(body, {
      'data': {
        'addFileCommand': {
          'name': fileToUpload.filename,
          'sizeInBytes': fileToUpload.length,
          'mimeType': fileToUpload.contentType.mimeType,
        }
      }
    });
  });
}
