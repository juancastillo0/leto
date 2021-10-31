import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';
import 'package:crypto/crypto.dart' show sha1;
import 'package:test_process/test_process.dart';

void main() {
  const port = '8060';
  const host = 'http://0.0.0.0:$port';
  final url = Uri.parse('$host/graphql');

  group('cli server', () {
    late http.Client client;
    late TestProcess process;

    setUp(() async {
      client = http.Client();
      process = await TestProcess.start(
        'fvm',
        ['dart', 'run', 'bin/server.dart'],
        environment: {'SHELF_PORT': port, 'SQLITE_MEMORY': 'true'},
      );
      bool err = true;
      while (err) {
        try {
          await client.get(Uri.parse('$host/echo'));
          err = false;
        } catch (_) {}
        await Future<Object?>.delayed(const Duration(seconds: 1));
      }
    });

    tearDown(() {
      process.kill();
    });

    Future<http.Response> send(
      GraphQLRequest request, {
      Map<String, String>? headers,
    }) {
      return client.post(
        url,
        body: jsonEncode(request.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (headers != null) ...headers,
        },
      );
    }

    test('Create user and room', () async {
      var response = await send(
        const GraphQLRequest(
          query: 'mutation signUp { signUp(name: "aa", password: "aaaaaa")'
              ' { ... on TokenWithUser {accessToken} } }',
        ),
      );
      expect(response.statusCode, 200);
      dynamic body = jsonDecode(response.body);
      expect(body, {
        'data': {
          'signUp': {'accessToken': const TypeMatcher<String>()}
        }
      });

      // ignore: avoid_dynamic_calls
      final accessToken = body['data']['signUp']['accessToken'] as String;

      response = await send(
        const GraphQLRequest(
          query: 'mutation createChatRoom { createChatRoom(name: "aachat")'
              ' { name, createdAt } }',
        ),
      );
      expect(response.statusCode, 200);
      body = jsonDecode(response.body);
      expect(body, {
        'data': {'createChatRoom': null},
        'errors': [
          {
            'message': 'Unauthenticated',
            'path': ['createChatRoom'],
            'locations': [
              {'line': 0, 'column': 26}
            ]
          }
        ],
      });

      response = await send(
        const GraphQLRequest(
          query: 'mutation createChatRoom { createChatRoom(name: "aachat")'
              ' { name } }',
        ),
        headers: {
          HttpHeaders.authorizationHeader: accessToken,
        },
      );
      expect(response.statusCode, 200);
      body = jsonDecode(response.body);
      expect(body, {
        'data': {
          'createChatRoom': {'name': 'aachat'}
        },
      });

      response = await send(
        const GraphQLRequest(
          query: 'query getChatRooms { getChatRooms '
              ' { name, users { role user { name } } } }',
          extensions: {
            'cacheResponse': {
              'hash': '',
            }
          },
        ),
        headers: {
          HttpHeaders.authorizationHeader: accessToken,
        },
      );
      expect(response.statusCode, 200);
      body = jsonDecode(response.body);
      const _payload = {
        'getChatRooms': [
          {
            'name': 'aachat',
            'users': [
              {
                'role': 'admin',
                'user': {'name': 'aa'}
              }
            ]
          }
        ]
      };
      final hash = sha1.convert(utf8.encode(jsonEncode(_payload))).toString();
      expect(body, {
        'data': _payload,
        'extensions': {
          'cacheResponse': {
            'hash': hash,
          }
        }
      });

      response = await send(
        GraphQLRequest(
          query: 'query getChatRooms { getChatRooms '
              ' { name, users { role user { name } } } }',
          extensions: {
            'cacheResponse': {
              'hash': hash,
            }
          },
        ),
        headers: {
          HttpHeaders.authorizationHeader: accessToken,
        },
      );
      expect(response.statusCode, 200);
      body = jsonDecode(response.body);
      expect(body, {
        'data': null,
        'extensions': {
          'cacheResponse': {
            'hash': hash,
          }
        }
      });
    });
  });
}
