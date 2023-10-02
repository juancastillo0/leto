import 'dart:convert';

import 'package:crypto/crypto.dart' show sha256;
import 'package:http/http.dart' as http;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/events/events_api.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'queries.dart';
import 'web_socket_link.dart';

void main() {
  late TestServer ts;

  setUp(() async {
    ts = await setUpTestServer();
  });

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

    final request = http.MultipartRequest('POST', ts.url())
      ..fields['operations'] = jsonEncode(operations)
      ..fields['map'] = jsonEncode(<String, Object?>{
        'filename1Field': ['variables.file'],
      })
      ..files.add(file)
      ..headers['authorization'] = accessToken;

    return request.send();
  }

  test('send chat messages', () async {
    const chatName = 'a_chat';
    final user = await ts.createdUserAndRoom(
      chatName: chatName,
      userName: 'aa',
      userPassword: 'aaaaaa',
    );
    late final int otherUserId;

    final link = WebSocketLink(
      ts.subscriptionUrl(),
      initialPayload: {
        'refreshToken': user.refreshToken,
      },
    );

    int eventIndex = 0;
    final messagesToSend = [
      'msg test',
      'msg test response',
      '', // not a message, peer added to chat room
      'Go to this link: ${ts.host()}/graphql-schema-interactive',
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

    final linksMetadata = responseLinksMetadata.data!['getMessageLinksMetadata']
        as Map<String, Object?>;
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

    final userB = await ts.createdUserAndRoom(
      chatName: 'b_chat',
      userName: 'bb',
      userPassword: 'bbbbbb',
      anonymous: true,
    );
    otherUserId = userB.userId;
    final roomQueriesHash = sha256.convert(utf8.encode(roomQueries)).toString();
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
    final responseUnauth = await ts.send(
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
    expect(responseAddUser.errors ?? [], isEmpty);

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
    expect(fileResponse.statusCode, 200);

    await ts.singOut(userB.accessToken, userB.userId);
  });
}
