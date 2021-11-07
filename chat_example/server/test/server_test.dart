import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show sha1;
import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sqlite_utils.dart';
import 'package:server/handler.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'queries.dart';
import 'web_socket_link.dart';

class _TestUser {
  final String refreshToken;
  final String accessToken;
  final String name;
  final int chatId;
  final int userId;

  _TestUser({
    required this.refreshToken,
    required this.accessToken,
    required this.name,
    required this.userId,
    required this.chatId,
  });
}

void main() {
  late HttpServer server;
  String host() => 'http://${server.address.host}:${server.port}';
  String subscriptionUrl() =>
      'ws://${server.address.host}:${server.port}/graphql-subscription';

  Uri url() => Uri.parse('${host()}/graphql');

  group('cli server', () {
    late http.Client client;
    // late TestProcess process;

    setUp(() async {
      client = http.Client();
      server = await startServer(
        scope: ScopedMap(
          {chatRoomDatabase: SqliteConnection(sqlite3.openInMemory())},
        ),
        config: GraphQLConfig(
          extensions: [
            GraphQLPersistedQueries(returnHashInResponse: true),
            CacheExtension(cache: LruCacheSimple(50)),
          ],
        ),
      );

      // process = await TestProcess.start(
      //   'fvm',
      //   ['dart', 'run', 'bin/server.dart'],
      //   environment: {'SHELF_PORT': port, 'SQLITE_MEMORY': 'true'},
      // );
      bool err = true;
      while (err) {
        try {
          await client.get(Uri.parse('${host()}/echo'));
          err = false;
        } catch (_) {}
        await Future<Object?>.delayed(const Duration(seconds: 1));
      }
    });

    // tearDown(() {
    //   process.kill();
    // });

    Future<http.Response> send(
      GraphQLRequest request, {
      Map<String, String>? headers,
    }) {
      return client.post(
        url(),
        body: jsonEncode(request.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (headers != null) ...headers,
        },
      );
    }

    Future<_TestUser> _createdUserAndRoom({required String chatName}) async {
      var response = await send(
        const GraphQLRequest(
          query: 'mutation signUp { signUp(name: "aa", password: "aaaaaa")'
              ' { ... on TokenWithUser {accessToken refreshToken'
              ' user { id name } } } }',
        ),
      );
      expect(response.statusCode, 200);
      dynamic body = jsonDecode(response.body);
      expect(body, {
        'data': {
          'signUp': {
            'accessToken': const TypeMatcher<String>(),
            'refreshToken': const TypeMatcher<String>(),
            'user': {
              'id': isA<int>(),
              'name': 'aa',
            }
          }
        }
      });

      // ignore: avoid_dynamic_calls
      final data = body['data']['signUp'] as Map<String, dynamic>;
      final accessToken = data['accessToken'] as String;
      final refreshToken = data['refreshToken'] as String;
      final userId = data['user']['id'] as int;

      response = await send(
        GraphQLRequest(
          query: 'mutation createChatRoom { createChatRoom(name: "$chatName")'
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
        GraphQLRequest(
          query: 'mutation createChatRoom { createChatRoom(name: "$chatName")'
              ' { id name } }',
        ),
        headers: {
          HttpHeaders.authorizationHeader: accessToken,
        },
      );
      expect(response.statusCode, 200);
      body = jsonDecode(response.body);
      expect(body, {
        'data': {
          'createChatRoom': {'name': chatName, 'id': isA<int>()}
        },
      });

      return _TestUser(
        accessToken: accessToken,
        refreshToken: refreshToken,
        name: 'aa',
        userId: userId,
        chatId: (((body as Map)['data'] as Map)['createChatRoom'] as Map)['id']
            as int,
      );
    }

    test('Create user and room', () async {
      const chatName = 'a_chat';
      final user = await _createdUserAndRoom(chatName: chatName);
      final accessToken = user.accessToken;
      var response = await send(
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
      Object? body = jsonDecode(response.body);
      const _payload = {
        'getChatRooms': [
          {
            'name': chatName,
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
        'data': <String, Object?>{},
        'extensions': {
          'cacheResponse': {
            'hash': hash,
          }
        }
      });
    });

    test('send chat messages', () async {
      const chatName = 'a_chat';
      final user = await _createdUserAndRoom(chatName: chatName);

      final link = WebSocketLink(subscriptionUrl(), initialPayload: {
        'refreshToken': user.refreshToken,
      });

      int eventIndex = 0;
      const messagesToSend = ['msg test', 'msg test response'];

      link.requestRaw(subscriptionQuery).listen(
            expectAsync1(
              (event) {
                expect(event.errors, isNull);

                expect(event.data!['onEvent']['userId'], user.userId);

                final message = event.data!['onEvent']['data']['value']
                    ['message'] as Map<String, Object?>;

                expect(
                  message['referencedMessage'],
                  eventIndex == 0 ? isNull : isNotNull,
                );
                expect(message['message'], messagesToSend[eventIndex++]);
              },
              count: 2,
            ),
          );
      await Future<void>.delayed(const Duration(seconds: 2));

      final response = await link.requestRaw(
        messagesQuery,
        operationName: 'sendMessage',
        variables: {'message': messagesToSend[0], 'chatId': user.chatId},
      ).first;

      expect(response.errors, isNull);

      final messageId = response.data!['sendMessage']['id'] as int;

      final response2 = await link.requestRaw(
        messagesQuery,
        operationName: 'sendMessage',
        variables: {
          'message': messagesToSend[1],
          'chatId': user.chatId,
          'referencedMessageId': messageId,
        },
      ).first;

      final messageId2 = response2.data!['sendMessage']['id'] as int;

      final responseMessages = await link.requestRaw(
        messagesQuery,
        operationName: 'getMessages',
        variables: {
          'chatId': user.chatId,
        },
      ).first;

      final messages = responseMessages.data!['getMessage'] as List;
      expect(messages[0]['id'], messageId);
      expect(messages[1]['id'], messageId2);
    });
  });
}
