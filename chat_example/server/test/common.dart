import 'dart:convert';
import 'dart:io';

import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sqlite_utils.dart';
import 'package:server/file_system.dart';
import 'package:server/handler.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_table.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

String tokenWithUserSelection({required bool signUp}) => '''
{ 
  ... on TokenWithUser { 
    accessToken refreshToken
     expiresInSecs user { 
       id name createdAt }
   }
  ${signUp ? '''
  ... on ErrCSignUpErrorReq {
    message
    value
  }''' : ''}

  ${!signUp ? '''
  ... on ErrCSignInErrorReq {
    message
    value
  }''' : ''}
}''';

Future<TestServer> setUpTestServer() async {
  final fs = MemoryFileSystem();
  final scope = ScopedMap.empty();
  final dbConn = SqliteConnection(sqlite3.openInMemory());
  chatRoomDatabase.set(scope, dbConn);
  fileSystemRef.set(scope, fs);

  final client = http.Client();
  final server = await startServer(
    scope: scope,
    config: GraphQLConfig(
      extensions: [
        GraphQLPersistedQueries(returnHashInResponse: true),
        CacheExtension(cache: LruCacheSimple(50)),
      ],
    ),
  );
  final testServer = TestServer(
    client: client,
    fs: fs,
    scope: scope,
    dbConn: dbConn,
    server: server,
  );

  // process = await TestProcess.start(
  //   'fvm',
  //   ['dart', 'run', 'bin/server.dart'],
  //   environment: {'SHELF_PORT': port, 'SQLITE_MEMORY': 'true'},
  // );
  bool err = true;
  while (err) {
    try {
      await client.get(Uri.parse('${testServer.host()}/echo'));
      err = false;
    } catch (_) {}
    if (err) {
      await Future<Object?>.delayed(const Duration(seconds: 1));
    }
  }

  return testServer;
}

class TestServer {
  final http.Client client;
  // final TestProcess process;

  final MemoryFileSystem fs;
  final ScopedMap scope;
  final TableConnection dbConn;
  final HttpServer server;

  String host() => 'http://${server.address.host}:${server.port}';
  Uri url() => Uri.parse('${host()}/graphql');
  String subscriptionUrl() =>
      'ws://${server.address.host}:${server.port}/graphql-subscription';

  TestServer({
    required this.client,
    required this.fs,
    required this.scope,
    required this.dbConn,
    required this.server,
  });

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
      GraphQLRequest(
        query: 'mutation signIn { signIn'
            ' ${tokenWithUserSelection(signUp: false)}  }',
      ),
    );

    final data =
        jsonDecode(response.body)['data']['signIn'] as Map<String, dynamic>;
    return _validateTokenWithUser(data, createdAtBefore: before);
  }

  Future<TokenWithUser> signUp({
    String? accessToken,
    required String userName,
    required String userPassword,
    bool signIn = false,
  }) async {
    final _field = signIn ? 'signIn' : 'signUp';
    final response = await send(
      GraphQLRequest(
        query:
            'mutation $_field(\$userName: String) { $_field(name: \$userName,'
            ' password: "$userPassword")'
            ' ${tokenWithUserSelection(signUp: !signIn)} }',
        variables: {'userName': userName},
      ),
      headers: {
        if (accessToken != null) 'authorization': accessToken,
      },
    );
    expect(response.statusCode, 200);
    final body = jsonDecode(response.body) as Map;
    // ignore: avoid_dynamic_calls
    return _validateTokenWithUser(
      body['data'][_field] as Map<String, dynamic>,
      name: userName,
    );
  }

  Future<TestUser> createdUserAndRoom({
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
    final userTokens = await signUp(
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

    return TestUser(
      accessToken: userTokens.accessToken,
      refreshToken: userTokens.refreshToken,
      name: userName,
      userId: userTokens.user.id,
      chatId: (((body as Map)['data'] as Map)['createChatRoom'] as Map)['id']
          as int,
    );
  }
}

class TestUser {
  final String refreshToken;
  final String accessToken;
  final String name;
  final int chatId;
  final int userId;

  TestUser({
    required this.refreshToken,
    required this.accessToken,
    required this.name,
    required this.userId,
    required this.chatId,
  });
}
