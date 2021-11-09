import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf/src/server_utils/graphql_request.dart';
import 'package:test/test.dart';

import 'common.dart';

Future<void> main() async {
  final _server = await testServer(ServerConfig(
    extensionList: [GraphQLPersistedQueries()],
  ));
  final url = _server.url;

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
}
