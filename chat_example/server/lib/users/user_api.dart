import 'dart:io';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:oxidized/oxidized.dart';
import 'package:server/events/events_api.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_table.dart';
import 'package:server/utilities.dart';
import 'package:valida/validate/validate_annotations.dart';

part 'user_api.freezed.dart';
part 'user_api.g.dart';

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

@GraphQLClass()
@JsonSerializable()
class UserSession {
  final String id;
  final int userId;
  final String? userAgent;
  final String? platform;
  final String? appVersion;
  final bool isActive;
  final String? ipAddress;
  final DateTime createdAt;
  final DateTime? endedAt;

  UserSession({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.createdAt,
    this.ipAddress,
    this.userAgent,
    this.platform,
    this.appVersion,
    this.endedAt,
  });

  @GraphQLField(omit: true)
  static const platformKey = 'sgqlc-platform';
  @GraphQLField(omit: true)
  static const appversionKey = 'sgqlc-appversion';
  @GraphQLField(omit: true)
  static const deviceidKey = 'sgqlc-deviceid';

  factory UserSession.create(int userId, Ctx ctx) {
    final request = ctx.request;
    final webSocketConn = WebSocketConnCtx.fromCtx(ctx);
    final uuid = uuidBase64Url();
    final connInfo =
        request.context['shelf.io.connection_info'] as HttpConnectionInfo?;
    final ipAddress = connInfo?.remoteAddress.host;
    return UserSession(
      isActive: true,
      createdAt: DateTime.now(),
      id: uuid,
      userId: userId,
      ipAddress: ipAddress,
      userAgent: request.headers[HttpHeaders.userAgentHeader],
      platform: request.headers[platformKey] ?? webSocketConn?.platform,
      appVersion: request.headers[appversionKey] ?? webSocketConn?.appVersion,
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

  Future<List<UserSession>> sessions(Ctx ctx) async {
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
Future<List<User>> searchUser(Ctx ctx, String name) {
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
Future<User?> getUser(Ctx ctx) async {
  final claims = await getUserClaimsUnwrap(ctx);
  return userTableRef.get(ctx).get(claims.userId);
}

@Mutation()
Future<String?> refreshAuthToken(
  Ctx ctx,
) async {
  final claims = await getUserClaims(ctx, isRefreshToken: true);
  if (claims == null) {
    return null;
  }
  final session = await userSessionRef.get(ctx).get(claims.sessionId);
  if (session == null || !session.isActive) {
    return null;
  }
  return setAuthToken(
    ctx,
    claims,
  );
}

@GraphQLEnum()
enum SignUpError {
  nameTaken,
  alreadySignedUp,
  unknown,
}

@Mutation()
Future<Result<TokenWithUser, ErrC<SignUpError>>> signUp(
  Ctx ctx,
  @ValidaString(minLength: 2) String name,
  @ValidaString(minLength: 6) String password,
) async {
  final userClaims = await getUserClaims(ctx);
  final User? user;
  final userWithName = await userTableRef.get(ctx).getByName(name);
  if (userWithName != null) {
    final verified = userWithName.passwordHash != null &&
        await verifyPasswordFromIsolate(password, userWithName.passwordHash!);
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

    final passwordHash = await hashPasswordFromIsolate(password);

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
    resultGraphQLType<T extends Object, T2 extends Object>(
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

@GraphQLEnum()
enum SignInError { wrong, alreadySignedIn }

@Mutation()
Future<Result<TokenWithUser, ErrC<SignInError>>> signIn(
  Ctx ctx,
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
    final verified =
        await verifyPasswordFromIsolate(password, user.passwordHash!);
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
  final payload = await signInUser(ctx, user);
  return Ok(payload);
}

@Mutation()
Future<String?> signOut(Ctx ctx) async {
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

Future<bool> deactivateSession(Ctx ctx, UserClaims claims) async {
  final success = await userSessionRef.get(ctx).deactivate(claims);
  return success;
}

const refreshDuration = Duration(hours: 1);

String setAuthToken(
  Ctx ctx,
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

Future<TokenWithUser> signInUser(Ctx ctx, User user) async {
  final session = UserSession.create(user.id, ctx);
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
