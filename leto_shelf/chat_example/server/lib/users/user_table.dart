import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:argon2/argon2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/sql_utils.dart';
import 'package:server/users/auth.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:uuid/uuid.dart';
import 'package:valida/validate/validate_annotations.dart';

part 'user_table.g.dart';

final userTableRef = RefWithDefault.global(
  'UserTable',
  (scope) => UserTable(
    chatRoomDatabase.get(scope),
  ),
);

final userSessionRef = RefWithDefault.global(
  'UserSessionTable',
  (scope) => UserSessionTable(
    chatRoomDatabase.get(scope),
  ),
);

final userDataloaderRef = RefWithDefault.global(
  'UserChatsTable',
  (scope) {
    final table = userTableRef.get(scope);
    return DataLoader<int, User?, int>(
      (ids) => table.getByIds(ids),
    );
  },
);

class UserTable {
  final TableConnection conn;

  UserTable(this.conn);

  Future<void> setup() async {
    const tableName = 'user';
    final migrated = await migrate(
      conn,
      tableName,
      [
        '''
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  name TEXT NULL,
  passwordHash TEXT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<User?> insert({String? name, String? passwordHash}) async {
    final result = await conn.query(
      'insert into user(name, passwordHash, createdAt)'
      ' values (?, ?, CURRENT_TIMESTAMP)',
      [
        name,
        passwordHash,
      ],
    );
    if (result.insertId == null) {
      return null;
    }
    return get(result.insertId!);
  }

  Future<User?> update(
    int id, {
    required String name,
    required String passwordHash,
  }) async {
    final result = await conn.query(
      'update user set name = ?, passwordHash = ? where id = ?;',
      [
        name,
        passwordHash,
        id,
      ],
    );
    if ((result.affectedRows ?? 0) == 0) {
      return null;
    }
    return get(id);
  }

  Future<User?> get(int id) async {
    final result = await conn.query(
      'select * from user where id = ?',
      [id],
    );
    return result.isEmpty ? null : User.fromJson(result.first);
  }

  Future<List<User?>> getByIds(List<int> ids) async {
    final result = await conn.query(
      'select * from user where id IN (${ids.map((e) => '?').join(',')})',
      ids,
    );
    final allUsers = Map.fromEntries(result.map((e) {
      final u = User.fromJson(e);
      return MapEntry(u.id, u);
    }));
    return ids.map((e) => allUsers[e]).toList();
  }

  Future<User?> getByName(String name) async {
    final result = await conn.query(
      'select * from user where name = ?',
      [name],
    );
    return result.isEmpty ? null : User.fromJson(result.first);
  }
}

class UserSessionTable {
  final TableConnection conn;

  UserSessionTable(this.conn);

  Future<void> setup() async {
    const tableName = 'userSession';
    final migrated = await migrate(
      conn,
      tableName,
      [
        '''
CREATE TABLE $tableName (
  id TEXT NOT NULL,
  userId INTEGER NOT NULL,
  isActive BOOL NOT NULL DEFAULT true,
  platform TEXT NULL,
  userAgent TEXT NULL,
  appVersion TEXT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id),
  FOREIGN KEY (userId) REFERENCES user (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<UserSession?> insert(UserSession session) async {
    await conn.query(
      'insert into userSession(id, userId, isActive, platform,'
      ' userAgent, appVersion, createdAt)'
      ' values (?, ?, ?, ?, ?, ?, ?)',
      [
        session.id,
        session.userId,
        session.isActive,
        session.platform,
        session.userAgent,
        session.appVersion,
        session.createdAt.toIso8601String(),
      ],
    );
    return session;
  }

  Future<UserSession?> get(String id) async {
    final result = await conn.query(
      'select * from userSession where id = ?',
      [id],
    );
    return result.isEmpty ? null : UserSession.fromJson(result.first);
  }

  Future<List<UserSession>> getForUser(int userId) async {
    final result = await conn.query(
      'select * from userSession where userId = ?',
      [userId],
    );
    return result.map((e) => UserSession.fromJson(e)).toList();
  }

  Future<bool> deactivate(String id) async {
    final result = await conn.query(
      'update userSession set isActive = false where id = ?',
      [id],
    );
    return (result.affectedRows ?? 0) >= 1;
  }
}

@GraphQLClass()
@JsonSerializable()
class UserSession {
  final String id;
  final int userId;
  final String? userAgent;
  final String? platform;
  final String? appVersion;
  final bool isActive;
  final DateTime createdAt;

  UserSession({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.createdAt,
    this.userAgent,
    this.platform,
    this.appVersion,
  });

  factory UserSession.create(int userId, Request request) {
    final uuid = base64Encode(const Uuid().v4obj().toBytes());
    return UserSession(
      isActive: true,
      createdAt: DateTime.now(),
      id: uuid,
      userId: userId,
      platform: request.headers['sgqlc-platform'],
      userAgent: request.headers[HttpHeaders.userAgentHeader],
      appVersion: request.headers['sgqlc-appversion'],
    );
  }

  Map<String, Object?> toJson() => _$UserSessionToJson(this);
  factory UserSession.fromJson(Map<String, Object?> json) =>
      _$UserSessionFromJson(json);
}

@GraphQLClass()
@JsonSerializable()
class User {
  final int id;
  @GraphQLField(omit: true)
  final String? passwordHash;
  final String? name;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.passwordHash,
  });

  Future<List<UserSession>> sessions(ReqCtx ctx) {
    return userSessionRef.get(ctx).getForUser(id);
  }

  Map<String, Object?> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@GraphQLClass()
@JsonSerializable()
class TokenWithUser {
  final String accessToken;
  final String refreshToken;
  final int expiresInSecs;
  final User user;

  TokenWithUser({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.expiresInSecs,
  });

  Map<String, Object?> toJson() => _$TokenWithUserToJson(this);
  factory TokenWithUser.fromJson(Map<String, Object?> json) =>
      _$TokenWithUserFromJson(json);
}

@Mutation()
Future<String?> refreshAuthToken(
  ReqCtx ctx,
) async {
  final claims = await getUserClaims(ctx, isRefreshToken: true);
  if (claims == null) {
    return null;
  }
  return setAuthToken(
    ctx,
    claims,
  );
}

Uint8List getRandomBytes([int length = 16]) {
  final _random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (i) => _random.nextInt(256)),
  );
}

String hashFromPassword(String password, {Argon2Parameters? params}) {
  // // use Salt(List<int> bytes) for a salt from an Integer list
  // final s = Salt.newSalt();
  // // Hash with pre-set params (iterations: 32, memory: 256, parallelism: 2,
  // // length: 32, type: Argon2Type.i, version: Argon2Version.V13)
  // final result = await argon2.hashPasswordString(password, salt: s);
  // final stringEncoded = result.encodedString;

  final _params = params ??
      Argon2Parameters(
        Argon2Parameters.ARGON2_id,
        getRandomBytes(),
        version: Argon2Parameters.ARGON2_VERSION_13,
        iterations: 3,
        memoryPowerOf2: 16,
        lanes: 2,
      );
  final argon2 = Argon2BytesGenerator();
  argon2.init(_params);

  final passwordBytes = _params.converter.convert(password);
  final result = Uint8List(32);
  argon2.generateBytes(passwordBytes, result, 0, result.length);
  // final hash = result.toHexString();
  final encoded =
      '\$argon2${['d', 'i', 'id'][_params.type]}\$v=${_params.version}'
      '\$m=${_params.memory},t=${_params.iterations},p=${_params.lanes}'
      '\$${base64Encode(_params.salt).replaceAll('=', '')}'
      '\$${base64Encode(result).replaceAll('=', '')}';
  print(encoded);
  return encoded;
}

bool verifyHashFromPassword(String password, String realHash) {
  // use Salt(List<int> bytes) for a salt from an Integer list
  // final s = Salt.newSalt();
  // Hash with pre-set params (iterations: 32, memory: 256, parallelism: 2,
  // length: 32, type: Argon2Type.i, version: Argon2Version.V13)
  // final result = await argon2.hashPasswordString(password, salt: s);
  // final stringEncoded = result.encodedString;
  try {
    final split = realHash.split('\$');
    final version = int.parse(split[2]);
    final compluteParams =
        split[3].split(',').map((v) => int.parse(v.substring(2))).toList();
    final saltStrUnpadded = split[4];
    final salt =
        base64Decode('$saltStrUnpadded${'=' * (saltStrUnpadded.length % 4)}');

    final parameters = Argon2Parameters(
      const {'d': 0, 'i': 1, 'id': 2}[split[1].substring(6)]!,
      salt,
      version: version,
      memory: compluteParams[0],
      iterations: compluteParams[1],
      lanes: compluteParams[2],
    );
    final hash = hashFromPassword(password, params: parameters);

    return hash == realHash;
  } catch (e) {
    print(e);
    return false;
  }
}

@GraphQLClass()
enum SignUpError {
  nameTaken,
  alreadySignedUp,
  unknown,
}

@Mutation()
Future<Result<TokenWithUser, ErrC<SignUpError>>> signUp(
  ReqCtx ctx,
  @ValidateString(minLength: 2) String name,
  @ValidateString(minLength: 6) String password,
) async {
  final userClaims = await getUserClaims(ctx);
  final User? user;
  final userWithName = await userTableRef.get(ctx).getByName(name);
  if (userWithName != null) {
    final verified = userWithName.passwordHash != null &&
        verifyHashFromPassword(password, userWithName.passwordHash!);
    if (!verified) {
      return Err(ErrC(SignUpError.nameTaken));
    }
    if (userClaims != null) {
      await deactivateSession(ctx, userClaims.sessionId);
    }
    user = userWithName;
  } else {
    User? currentUser;
    if (userClaims != null) {
      currentUser = await userTableRef.get(ctx).get(userClaims.userId);
      if (currentUser!.name != null) {
        return Err(ErrC(SignUpError.alreadySignedUp));
      }
      await deactivateSession(ctx, userClaims.sessionId);
    }

    final passwordHash = hashFromPassword(password);

    if (currentUser != null) {
      user = await userTableRef.get(ctx).update(
            currentUser.id,
            name: name,
            passwordHash: passwordHash,
          );
    } else {
      user = await userTableRef.get(ctx).insert(
            name: name,
            passwordHash: passwordHash,
          );
    }
  }
  if (user == null) {
    return Err(ErrC(SignUpError.unknown));
  }
  return signInUser(ctx, user).then((value) => Ok(value));
}

GraphQLType<Result<T, T2>, Map<String, Object?>>
    resultGraphQlType<T extends Object, T2 extends Object>(
  GraphQLType<T, Object> _t1,
  GraphQLType<T2, Object> _t2, {
  String? name,
}) {
  final t1 = (_t1 is GraphQLNonNullType
      ? (_t1 as GraphQLNonNullType).ofType
      : _t1) as GraphQLObjectType;
  final t2 = (_t2 is GraphQLNonNullType
      ? (_t2 as GraphQLNonNullType).ofType
      : _t2) as GraphQLObjectType;
  return GraphQLUnionType(
    name ?? 'Result${t1.name}${t2.name}',
    [t1, t2],
    description: '${t1.name} when the operation was successful or'
        ' ${t2.name} when an error was encountered.',
    extractInner: (result) => result.when(ok: (ok) => ok, err: (err) => err),
    resolveType: (result, union, ctx) => result is Err ? t2.name : t1.name,
  );
}

@GraphQLClass()
@JsonSerializable(genericArgumentFactories: true)
class ErrC<T> {
  final String? message;
  final T value;

  ErrC(this.value, [this.message]);

  factory ErrC.fromJson(
    Map<String, Object?> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ErrCFromJson(json, fromJsonT);
}

@GraphQLClass()
enum SignInError { wrong, unknown, alreadySignedIn }

@Mutation()
Future<Result<TokenWithUser, ErrC<SignInError>>> signIn(
  ReqCtx ctx,
  String? name,
  String? password,
) async {
  final User? user;
  if (name != null && password != null) {
    user = await userTableRef.get(ctx).getByName(name);
    if (user == null) {
      return Err(ErrC(SignInError.wrong));
    }
    // Verify password (returns true/false), uses default type (Argon2Type.i)
    final verified = verifyHashFromPassword(password, user.passwordHash!);
    if (!verified) {
      return Err(ErrC(SignInError.wrong));
    }
    final userClaims = await getUserClaims(ctx);
    if (userClaims != null) {
      await deactivateSession(ctx, userClaims.sessionId);
      // final currentUser = await userTableRef.get(ctx).get(userClaims.userId);
      // return currentUser == null ? Err(SignInError.unknown) : Ok(currentUser);
      // return Err(ErrC(SignInError.alreadySignedIn));
    }
  } else if (name != null || password != null) {
    return Err(ErrC(SignInError.wrong));
  } else {
    final userClaims = await getUserClaims(ctx);
    if (userClaims != null) {
      return Err(ErrC(SignInError.alreadySignedIn));
      // await deactivateSession(ctx, userClaims.sessionId);
      // user = await userTableRef.get(ctx).get(userClaims.userId);
    } else {
      // anonymous sign in
      user = await userTableRef.get(ctx).insert();
    }
  }
  if (user == null) {
    return Err(ErrC(SignInError.unknown));
  }
  final payload = await signInUser(ctx, user);
  return Ok(payload);
}

@Mutation()
Future<String?> signOut(ReqCtx ctx) async {
  final claims = await getUserClaims(ctx);
  if (claims != null) {
    final success = await deactivateSession(ctx, claims.sessionId);
    if (!success) {
      return 'Error in sign out.';
    }
  }

  ctx.appendHeader(
    HttpHeaders.setCookieHeader,
    // delete cookie
    '$AUTH_COOKIE_KEY=""; Max-Age=0',
  );
  return null;
}

Future<bool> deactivateSession(ReqCtx ctx, String sessionId) {
  return userSessionRef.get(ctx).deactivate(sessionId);
}

const refreshDuration = Duration(hours: 1);

String setAuthToken(
  ReqCtx ctx,
  UserClaims claims,
) {
  final accessToken = createAuthToken(
    sessionId: claims.sessionId,
    userId: claims.userId,
    duration: refreshDuration,
    isRefresh: false,
  );
  setAuthCookie(
    ctx,
    accessToken,
    refreshDuration.inSeconds,
  );
  return accessToken;
}

Future<TokenWithUser> signInUser(ReqCtx ctx, User user) async {
  final session = UserSession.create(user.id, ctx.request);
  await userSessionRef.get(ctx).insert(session);

  final refreshToken = createAuthToken(
    sessionId: session.id,
    userId: user.id,
    duration: const Duration(days: 10),
    isRefresh: true,
  );

  final accessToken = setAuthToken(
    ctx,
    UserClaims(
      userId: user.id,
      sessionId: session.id,
    ),
  );
  return TokenWithUser(
    refreshToken: refreshToken,
    expiresInSecs: refreshDuration.inSeconds,
    accessToken: accessToken,
    user: user,
  );
}

String? getCookie(Request request, String name) {
  final cookies = request.headersAll[HttpHeaders.cookieHeader];
  final cookie = cookies?.expand((element) {
    final cookiesList = element.split('; ');
    return cookiesList.map((e) {
      final kv = e.split('=');
      return MapEntry(kv[0], kv[1]);
    });
  }).firstWhereOrNull((element) => element.key == name);
  return cookie?.value;
}
