import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show sha1;
import 'package:http/http.dart' as http;
import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  group('cli server', () {
    late TestServer ts;

    setUp(() async {
      ts = await setUpTestServer();
    });

    test('Create user and room', () async {
      const chatName = 'a_chat';
      TestUser user;
      List? errors;
      try {
        user = await ts.createdUserAndRoom(
          chatName: chatName,
          userName: 'aa',
          userPassword: 'aaaaa',
        );
      } on List catch (e) {
        errors = e;
        user = await ts.createdUserAndRoom(
          chatName: chatName,
          userName: 'aa',
          userPassword: 'aaaaaA',
        );
      }
      expect(errors, [
        {
          'message': 'Input validation error',
          'path': ['signUp'],
          'locations': [
            {'line': 0, 'column': 38}
          ],
          'extensions': {
            'validaErrors': {
              'password': [
                {
                  'property': 'password',
                  'errorCode': 'ValidaLength.minLength',
                  'message': 'Should have a minimum length of 6',
                  'validationParam': 6
                }
              ]
            }
          }
        }
      ]);

      final accessToken = user.accessToken;
      var response = await ts.send(
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

      response = await ts.send(
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

      await ts.singOut(user.accessToken, user.userId);
    });

    test('user auth', () async {
      final userToken = await ts.signInAnonymous();

      http.Response response = await ts.send(
        const GraphQLRequest(query: 'mutation { refreshAuthToken } '),
        headers: {
          'authorization': userToken.refreshToken,
        },
      );
      Map<String, Object?> data =
          jsonDecode(response.body) as Map<String, Object?>;
      expect(data, {
        'data': {'refreshAuthToken': isA<String>()}
      });
      final authToken = (data['data'] as Map)['refreshAuthToken'] as String;

      // does not work with accessToken
      response = await ts.send(
        const GraphQLRequest(query: 'mutation { refreshAuthToken } '),
        headers: {
          'authorization': userToken.accessToken,
        },
      );
      expect(jsonDecode(response.body), {
        'data': {'refreshAuthToken': null}
      });

      await ts.singOut(authToken, userToken.user.id);

      // not available when already signed out
      response = await ts.send(
        const GraphQLRequest(query: 'mutation { refreshAuthToken } '),
        headers: {
          'authorization': userToken.refreshToken,
        },
      );
      expect(jsonDecode(response.body), {
        'data': {'refreshAuthToken': null}
      });

      const userName = 'daw';
      const userPassword = 'dawdawaw';
      final user2Token = await ts.signUp(
        userName: userName,
        userPassword: userPassword,
        signIn: false,
      );

      await ts.singOut(user2Token.accessToken, user2Token.user.id);

      // wrong name
      response = await ts.send(
        GraphQLRequest(
          query: 'mutation signIn { signIn(name: "wrongName",'
              ' password: "$userPassword")'
              ' ${tokenWithUserSelection(signUp: false)} }',
        ),
      );
      data = ((jsonDecode(response.body) as Map)['data'] as Map)['signIn']
          as Map<String, Object?>;

      expect(data, {'message': null, 'value': 'wrong'});

      // wrong password
      response = await ts.send(
        GraphQLRequest(
          query: 'mutation signIn { signIn(name: "$userName",'
              ' password: "wrongPassword")'
              ' ${tokenWithUserSelection(signUp: false)} }',
        ),
      );
      data = ((jsonDecode(response.body) as Map)['data'] as Map)['signIn']
          as Map<String, Object?>;

      expect(data, {'message': null, 'value': 'wrong'});

      // sign up with same name different password
      response = await ts.send(
        GraphQLRequest(
          query: 'mutation signUp { signUp(name: "$userName",'
              ' password: "otherPassword")'
              ' ${tokenWithUserSelection(signUp: true)} }',
        ),
      );
      data = ((jsonDecode(response.body) as Map)['data'] as Map)['signUp']
          as Map<String, Object?>;

      expect(data, {'message': null, 'value': 'nameTaken'});

      // TODO: T1 sign up speed up test. Specially password hashing
      final signUpTokens = await ts.signUp(
        userName: userName,
        userPassword: userPassword,
        signIn: false,
      );
      expect(signUpTokens.user.id, user2Token.user.id);

      await ts.singOut(signUpTokens.accessToken, signUpTokens.user.id);

      // sign in
      final signInTokens = await ts.signUp(
        userName: userName,
        userPassword: userPassword,
        signIn: true,
      );
      expect(signInTokens.user.id, user2Token.user.id);

      await ts.singOut(signInTokens.accessToken, signInTokens.user.id);
    });
  });
}
