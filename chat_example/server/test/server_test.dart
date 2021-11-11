import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show sha1, sha256;
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sqlite_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/file_system.dart';
import 'package:server/handler.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_table.dart';
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

    late MemoryFileSystem fs;
    late ScopedMap scope;
    late TableConnection dbConn;

    setUp(() async {
      fs = MemoryFileSystem();
      scope = ScopedMap.empty();
      dbConn = SqliteConnection(sqlite3.openInMemory());
      chatRoomDatabase.set(scope, dbConn);
      fileSystemRef.set(scope, fs);

      client = http.Client();
      server = await startServer(
        scope: scope,
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
        if (err) {
          await Future<Object?>.delayed(const Duration(seconds: 1));
        }
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

    Future<http.StreamedResponse> sendFile({
      required int chatId,
      required http.MultipartFile file,
      required String accessToken,
      required String? message,
    }) async {
      final operations = GraphQLRequest(
        query: messagesQuery,
        variables: {
          'file': null,
          'chatId': chatId,
          'message': message,
        },
        operationName: 'sendFileMessage',
      );

      final request = http.MultipartRequest('POST', url())
        ..fields['operations'] = jsonEncode(operations)
        ..fields['map'] = jsonEncode(<String, Object?>{
          'filename1Field': ['variables.file'],
        })
        ..files.add(file)
        ..headers['authorization'] = accessToken;

      return request.send();
    }

    Future<void> singOut(String accessToken, int userId) async {
      // TODO: use clock
      final before = DateTime.now();
      final claims = (await getUserClaimsFromToken(accessToken))!;
      expect(claims.userId, userId);

      final response = await send(
        const GraphQLRequest(
          query: 'mutation signOut { signOut }',
        ),
        headers: {
          'authorization': accessToken,
        },
      );
      expect(response.statusCode, 200);
      expect(jsonDecode(response.body), {
        'data': {'signOut': null}
      });
      final queryResult = await dbConn.query(
        'select * from userSession where id = ?',
        [claims.sessionId],
      );

      expect(queryResult, isNotEmpty);
      final row = queryResult.first;

      expect(row['isActive'], 0);
      final endedAt = DateTime.parse(row['endedAt'] as String);
      expect(endedAt.difference(before).inSeconds, greaterThan(-1));
    }

    Future<TokenWithUser> _validateTokenWithUser(
      Map<String, Object?> data, {
      DateTime? createdAtBefore,
      String? name,
    }) async {
      expect(data, {
        'accessToken': isA<String>(),
        'refreshToken': isA<String>(),
        'expiresInSecs': isA<int>(),
        'user': {
          'id': isA<int>(),
          'name': name ?? isNull,
          'createdAt': predicate(
            (c) {
              final v = DateTime.parse(c! as String);
              if (createdAtBefore != null) {
                v.isAfter(createdAtBefore);
              }
              return true;
            },
          ),
        }
      });
      final values = TokenWithUser.fromJson(data);
      UserClaims? claims = await getUserClaimsFromToken(
        values.accessToken,
        isRefreshToken: false,
      );
      expect(claims?.userId, values.user.id);
      claims = await getUserClaimsFromToken(
        values.refreshToken,
        isRefreshToken: true,
      );
      expect(claims?.userId, values.user.id);
      return values;
    }

    Future<TokenWithUser> signInAnonymous() async {
      final before = DateTime.now().subtract(const Duration(seconds: 1));
      final response = await send(
        const GraphQLRequest(
          query: 'mutation signIn { signIn'
              ' { ... on TokenWithUser { accessToken refreshToken'
              ' expiresInSecs user { id name createdAt } } } }',
        ),
      );

      final data =
          jsonDecode(response.body)['data']['signIn'] as Map<String, dynamic>;

      expect(data, {
        'accessToken': isA<String>(),
        'refreshToken': isA<String>(),
        'expiresInSecs': isA<int>(),
        'user': {
          'id': isA<int>(),
          'name': isNull,
          'createdAt': predicate(
            (c) => DateTime.parse(c! as String).isAfter(before),
          ),
        }
      });
      final values = TokenWithUser.fromJson(data);
      UserClaims? claims = await getUserClaimsFromToken(
        values.accessToken,
        isRefreshToken: false,
      );
      expect(claims?.userId, values.user.id);
      claims = await getUserClaimsFromToken(
        values.refreshToken,
        isRefreshToken: true,
      );
      expect(claims?.userId, values.user.id);
      return _validateTokenWithUser(data, createdAtBefore: before);
    }

    Future<TokenWithUser> _signUp({
      String? accessToken,
      required String userName,
      required String userPassword,
      bool signIn = false,
    }) async {
      final _field = signIn ? 'signIn' : 'signUp';
      final response = await send(
        GraphQLRequest(
          query:
              'mutation $_field { $_field(name: "$userName", password: "$userPassword")'
              ' { ... on TokenWithUser {accessToken refreshToken'
              ' expiresInSecs user { id name createdAt } } } }',
        ),
        headers: {
          if (accessToken != null) 'authorization': accessToken,
        },
      );
      expect(response.statusCode, 200);
      final body = jsonDecode(response.body) as Map;
      // ignore: avoid_dynamic_calls
      return _validateTokenWithUser(
        body['data']['signUp'] as Map<String, dynamic>,
        name: userName,
      );
    }

    Future<_TestUser> _createdUserAndRoom({
      required String chatName,
      required String userName,
      required String userPassword,
      bool anonymous = false,
    }) async {
      String? _accessToken;
      if (anonymous) {
        final tokenWithUser = await signInAnonymous();
        _accessToken = tokenWithUser.accessToken;
      }
      final userTokens = await _signUp(
        accessToken: _accessToken,
        userName: userName,
        userPassword: userPassword,
      );

      var response = await send(
        GraphQLRequest(
          query: 'mutation createChatRoom { createChatRoom(name: "$chatName")'
              ' { name, createdAt } }',
        ),
      );
      expect(response.statusCode, 200);
      Object? body = jsonDecode(response.body);
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
          HttpHeaders.authorizationHeader: userTokens.accessToken,
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
        accessToken: userTokens.accessToken,
        refreshToken: userTokens.refreshToken,
        name: userName,
        userId: userTokens.user.id,
        chatId: (((body as Map)['data'] as Map)['createChatRoom'] as Map)['id']
            as int,
      );
    }

    test('Create user and room', () async {
      const chatName = 'a_chat';
      final user = await _createdUserAndRoom(
        chatName: chatName,
        userName: 'aa',
        userPassword: 'aaaaa',
      );
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

      await singOut(user.accessToken, user.userId);
    });

    test('send chat messages', () async {
      const chatName = 'a_chat';
      final user = await _createdUserAndRoom(
        chatName: chatName,
        userName: 'aa',
        userPassword: 'aaaaa',
      );
      late final int otherUserId;

      final link = WebSocketLink(
        subscriptionUrl(),
        initialPayload: {
          'refreshToken': user.refreshToken,
        },
      );

      int eventIndex = 0;
      final messagesToSend = [
        'msg test',
        'msg test response',
        '', // not a message, peer added to chat room
        'Go to this link: ${host()}/graphql-schema-interactive',
      ];
      int _previousEventId = -1;

      link.requestRaw(subscriptionQuery).listen(
            expectAsync1(
              (event) {
                expect(event.errors, isNull);

                final payload = event.data!['onEvent'] as Map<String, dynamic>;
                // expect(payload['userId'], user.userId);
                expect(payload, {
                  'id': greaterThan(_previousEventId),
                  'type': isA<String>(),
                  'userId': eventIndex == 3 ? otherUserId : user.userId,
                  'sessionId': isA<String>(),
                  'createdAt': predicate((v) {
                    DateTime.parse(v! as String);
                    return true;
                  }),
                  'data': isA<Map<String, Object?>>(),
                });
                _previousEventId = payload['id'] as int;
                final type = eventTypeGraphQLType.deserialize(
                  SerdeCtx(),
                  payload['type'] as String,
                );

                final data = payload['data'] as Map<String, dynamic>;

                if (eventIndex == 2) {
                  expect(type, EventType.userChatAdded);
                  expect(data['__typename'], 'UserChatDBEventData');
                } else {
                  expect(type, EventType.messageSent);
                  expect(data['__typename'], 'ChatMessageDBEventData');
                  final message =
                      data['value']['message'] as Map<String, Object?>;

                  expect(
                    message['referencedMessage'],
                    eventIndex != 1 ? isNull : isNotNull,
                  );
                  expect(message['message'], messagesToSend[eventIndex]);
                }
                eventIndex++;
              },
              count: 4,
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

      final responseLinksMetadata = await link.requestRaw(
        messagesQuery,
        operationName: 'getMessageLinksMetadata',
        variables: {
          'message': messagesToSend[3],
        },
      ).first;

      final linksMetadata = responseLinksMetadata
          .data!['getMessageLinksMetadata'] as Map<String, Object?>;
      expect(linksMetadata['hasLinks'], true);
      final links = linksMetadata['links']! as List;
      expect(links.length, 1);
      expect(links.first, {
        'title': 'Leto Chat',
        'description':
            'A chat server application implemented with Leto Dart GraphQL',
        'image':
            'https://raw.githubusercontent.com/juancastillo0/leto/main/img/leto-logo-white.png',
        'url': 'https://github.com/juancastillo0/leto/',
      });

      final userB = await _createdUserAndRoom(
        chatName: 'b_chat',
        userName: 'bb',
        userPassword: 'bbbbb',
        anonymous: true,
      );
      otherUserId = userB.userId;
      final roomQueriesHash =
          sha256.convert(utf8.encode(roomQueries)).toString();
      final addRoomUserRequest = GraphQLRequest(
        query: roomQueries,
        operationName: 'addChatRoomUser',
        variables: {
          'chatId': user.chatId,
          'userId': userB.userId,
        },
        extensions: {
          'persistedQuery': {
            'version': 1,
            'sha256Hash': roomQueriesHash,
          }
        },
      );
      final responseUnauth = await send(
        addRoomUserRequest,
        headers: {'authorization': 'wrong-token'},
      );
      expect(responseUnauth.statusCode, 200);
      expect(jsonDecode(responseUnauth.body), {
        'extensions': {
          'persistedQuery': {'sha256Hash': roomQueriesHash}
        },
        'data': {'addChatRoomUser': null},
        'errors': [
          {
            // TODO: Invalid argument (serialization): Not a valid `JsonWebSignature` or `JsonWebEncryption`: "wrong-token"
            'message': isA<String>(),
            'path': ['addChatRoomUser'],
            'locations': isA<List>(),
          }
        ]
      });

      final responseAddUser = await link
          .requestRaw(
            addRoomUserRequest.query,
            operationName: addRoomUserRequest.operationName,
            variables: addRoomUserRequest.variables!,
            // TODO: hash mismatch link parses and prints the document
            // extensions: addRoomUserRequest.extensions,
          )
          .first;

      final fileToUpload = http.MultipartFile.fromBytes(
        'filename1Field',
        utf8.encode('testString in file'),
        filename: 'filename1.txt',
      );

      final fileResponse = await sendFile(
        chatId: user.chatId,
        file: fileToUpload,
        accessToken: userB.accessToken,
        message: messagesToSend[3],
      );

      await singOut(userB.accessToken, userB.userId);
    });

    test('user auth', () async {
      final userToken = await signInAnonymous();

      await singOut(userToken.accessToken, userToken.user.id);
    });
  });
}
