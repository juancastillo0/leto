import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/users/auth.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:uuid/uuid.dart';
import 'package:valida/validate/validate_annotations.dart';

part 'user_table.g.dart';
part 'user_table.freezed.dart';

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

final userDataLoaderRef = RefWithDefault.global(
  'UserDataLoader',
  (scope) {
    final table = userTableRef.get(scope);
    return DataLoader<int, User?, int>(
      (ids) => table.getByIds(ids),
    );
  },
);

@GraphQLClass()
@freezed
class UserEvent with _$UserEvent implements DBEventDataKeyed {
  const UserEvent._();
  const factory UserEvent.created({
    required User user,
  }) = UserCreatedEvent;

  const factory UserEvent.signedUp({
    required UserSession session,
  }) = UserSignedUpEvent;

  const factory UserEvent.signedIn({
    required UserSession session,
  }) = UserSignedInEvent;

  const factory UserEvent.signedOut({
    required int userId,
    required String sessionId,
  }) = UserSignedOutEvent;

  factory UserEvent.fromJson(Map<String, Object?> map) =>
      _$UserEventFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey {
    return map(
      created: (e) => MapEntry(EventType.userCreated, '${e.user.id}'),
      signedUp: (e) => MapEntry(
        EventType.userSessionSignedUp,
        '${e.session.userId}/${e.session.id}',
      ),
      signedIn: (e) => MapEntry(
        EventType.userSessionSignedIn,
        '${e.session.userId}/${e.session.id}',
      ),
      signedOut: (e) => MapEntry(
        EventType.userSessionSignedOut,
        '${e.userId}/${e.sessionId}',
      ),
    );
  }

  int get userId => map(
        created: (e) => e.user.id,
        signedUp: (e) => e.session.userId,
        signedIn: (e) => e.session.userId,
        signedOut: (e) => e.userId,
      );
}

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

  Future<User> insert({String? name, String? passwordHash}) async {
    return conn.transaction((conn) async {
      final createdAt = DateTime.now();
      final result = await conn.query(
        'insert into user(name, passwordHash, createdAt)'
        ' values (?, ?, ?)',
        [
          name,
          passwordHash,
          createdAt,
        ],
      );
      final user = User(
        id: result.insertId!,
        name: name,
        createdAt: createdAt,
        passwordHash: passwordHash,
      );
      // await EventTable(conn).insert(
      //   DBEventData.user(UserEvent.created(user: user)),
      //   // TODO:
      //   UserClaims(sessionId: '', userId: user.id),
      // );
      return user;
    });
  }

  Future<User?> update(
    int id, {
    required String name,
    required String passwordHash,
  }) async {
    // TODO: EventTable
    return conn.transaction((conn) async {
      final result = await conn.query(
        'update user set name = ?, passwordHash = ? where id = ?;',
        [name, passwordHash, id],
      );
      final updated = (result.affectedRows ?? 0) > 0;
      if (!updated) {
        return null;
      }
      return get(id);
    });
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

  Future<List<User>> searchByName(String name) async {
    final _escaped = name.replaceAllMapped(
      RegExp('[%_]'),
      (match) => '\\${match.input.substring(match.start, match.end)}',
    );
    final result = await conn.query(
      "select * from user where name LIKE ? ESCAPE '\\';",
      ['%$_escaped%'],
    );
    return result.map((e) => User.fromJson(e)).toList();
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
  endedAt TIMESTAMP NULL,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

  Future<bool> deactivate(UserClaims claims) async {
    return conn.transaction((conn) async {
      final result = await conn.query(
        'update userSession set isActive = false'
        ' and endedAt = CURRENT_TIMESTAMP where id = ?',
        [claims.sessionId],
      );
      final deactivated = (result.affectedRows ?? 0) >= 1;
      if (deactivated) {
        await EventTable(conn).insert(
          DBEventData.user(
            UserEvent.signedOut(
              userId: claims.userId,
              sessionId: claims.sessionId,
            ),
          ),
          claims,
        );
      }
      return deactivated;
    });
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
  final DateTime? endedAt;

  UserSession({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.createdAt,
    this.userAgent,
    this.platform,
    this.appVersion,
    this.endedAt,
  });

  factory UserSession.create(int userId, Request request) {
    final uuid = base64UrlEncode(const Uuid().v4obj().toBytes());
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
  factory UserSession.fromJson(Map<String, Object?> json) {
    final isActive = json['isActive'];
    return _$UserSessionFromJson(<String, Object?>{
      ...json,
      'isActive': isActive is int ? isActive != 0 : isActive! as bool
    });
  }
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

  Future<List<UserSession>> sessions(ReqCtx ctx) async {
    final claims = await getUserClaimsUnwrap(ctx);
    if (claims.userId != id) {
      throw unauthorizedError;
    }
    return userSessionRef.get(ctx).getForUser(id);
  }

  Map<String, Object?> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@Query()
Future<List<User>> searchUser(ReqCtx ctx, String name) {
  return userTableRef.get(ctx).searchByName(name);
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

@Query()
Future<User?> getUser(ReqCtx ctx) async {
  final claims = await getUserClaimsUnwrap(ctx);
  return userTableRef.get(ctx).get(claims.userId);
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
        verifyPasswordFromHash(password, userWithName.passwordHash!);
    if (!verified) {
      return Err(ErrC(SignUpError.nameTaken));
    }
    if (userClaims != null) {
      await deactivateSession(ctx, userClaims);
    }
    user = userWithName;
  } else {
    User? currentUser;
    if (userClaims != null) {
      currentUser = await userTableRef.get(ctx).get(userClaims.userId);
      if (currentUser!.name != null) {
        return Err(ErrC(SignUpError.alreadySignedUp));
      }
      await deactivateSession(ctx, userClaims);
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
    final verified = verifyPasswordFromHash(password, user.passwordHash!);
    if (!verified) {
      return Err(ErrC(SignInError.wrong));
    }
    final userClaims = await getUserClaims(ctx);
    if (userClaims != null) {
      await deactivateSession(ctx, userClaims);
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
    final success = await deactivateSession(ctx, claims);
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

Future<bool> deactivateSession(ReqCtx ctx, UserClaims claims) {
  return userSessionRef.get(ctx).deactivate(claims);
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
