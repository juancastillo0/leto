import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf/src/server_utils/graphql_request.dart';
import 'package:test/test.dart';

import 'common.dart';

Future<void> main() async {
  final _server = await testServer(ServerConfig(
    extensionList: [
      GraphQLPersistedQueries(
        returnHashInResponse: true,
      )
    ],
  ));
  final url = _server.url;

  test('file upload', () async {
    final operations = const GraphQLRequest(
        query: 'mutation addFile(\$fileVar: Upload!) { '
            ' addFile (file: \$fileVar){'
            ' ... on FileUpload{filename mimeType sizeInBytes }'
            ' } } ',
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

  test('file upload bad requests', () async {
    final values = <String, Map<String, Object>>{
      'Missing "operations" field.': {},
      '"operations" field should have at least one operation.': {
        'operations': jsonEncode(<String>[])
      },
      '"operations" field must decode to a JSON object.': {
        'operations': jsonEncode(<String>['d'])
      },
      '"operations.query" field must be a String.': {
        'operations': jsonEncode([
          {'query': 2}
        ])
      },
      '"operations.operationName" field must be a String?.': {
        'operations': jsonEncode({'query': '', 'operationName': 2})
      },
      '"operations.variables" field must be a Map.': {
        'operations': jsonEncode({'query': '', 'variables': true})
      },
      '"operations.extensions" field must be a Map.': {
        'operations': jsonEncode({
          'query': '',
          'extensions': ['true'],
          'variables': <String, Object?>{},
        })
      },
      '"map" field must decode to a JSON object.': {
        'operations': jsonEncode({
          'query': '',
          'variables': <String, Object?>{},
        }),
        'map': jsonEncode(<String>['d']),
      },
      '"map" contained key "kk", but no uploaded file '
          'has that name.': {
        'operations': jsonEncode({
          'query': '',
          'variables': <String, Object?>{},
        }),
        'map': jsonEncode(<String, String>{'kk': ''}),
      },
      'The value for "kk" in the "map"'
          ' field was not a JSON array.': {
        'operations': jsonEncode({
          'query': '',
          'variables': <String, Object?>{},
        }),
        'map': jsonEncode(<String, String>{'kk': ''}),
        'files': [
          http.MultipartFile.fromBytes(
            'kk',
            utf8.encode('testString in file'),
            filename: 'filename1.txt',
          )
        ],
      },
      'Object "wrongVariables" is not a JSON object, but the '
          '"map" field contained a mapping to wrongVariables.v.': {
        'operations': jsonEncode({
          'query': '',
          'variables': <String, Object?>{'v': null},
        }),
        'map': jsonEncode(<String, List<String>>{
          'kk': ['wrongVariables.v']
        }),
        'files': [
          http.MultipartFile.fromBytes(
            'kk',
            utf8.encode('testString in file'),
            filename: 'filename1.txt',
          )
        ],
      },
      'Object "variables.v" is not a JSON array, but the '
          '"map" field contained a mapping to variables.v.wrongName.': {
        'operations': jsonEncode({
          'query': '',
          'variables': <String, Object?>{
            'v': [null]
          },
        }),
        'map': jsonEncode(<String, List<String>>{
          'kk': ['variables.v.wrongName']
        }),
        'files': [
          http.MultipartFile.fromBytes(
            'kk',
            utf8.encode('testString in file'),
            filename: 'filename1.txt',
          )
        ],
      },
    };

    await Future.wait(values.entries.map((e) async {
      final files = e.value.remove('files') as List<http.MultipartFile>? ?? [];
      if (!e.value.containsKey('map')) {
        e.value['map'] = '{}';
      }

      final request = http.MultipartRequest('POST', url)
        ..fields['map'] = e.value['map']! as String
        ..files.addAll(files);

      final operations = e.value['operations'];
      if (operations is String) {
        request.fields['operations'] = operations;
      }

      final response = await request.send();
      expect(response.statusCode, 400);
      expect(await response.stream.bytesToString(), e.key);
    }));
  });
}
