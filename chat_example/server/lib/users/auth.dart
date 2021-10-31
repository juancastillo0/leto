import 'dart:convert' show base64;
import 'dart:io';
import 'dart:math' show Random;
import 'dart:typed_data' show Uint8List;

import 'package:argon2/argon2.dart';
import 'package:jose/jose.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/users/user_table.dart';

// ignore: constant_identifier_names
const AUTH_COOKIE_KEY = 'shelf-graphql-chat-auth';
final _webSocketConnCtxRef = ScopeRef<WebSocketConnCtx>('webSocketConnCtxRef');
final _webSocketSessionsRef = RefWithDefault.scoped(
  (h) => <String, Set<GraphQLWebSocketServer>>{},
  name: 'webSocketSessionsRef',
);

final unauthenticatedError = GraphQLError('Unauthenticated');
final unauthorizedError = GraphQLError('Unauthorized');

class WebSocketConnCtx {
  final UserClaims? claims;
  final String? platform;
  final String? appVersion;

  const WebSocketConnCtx({
    this.claims,
    this.platform,
    this.appVersion,
  });

  static WebSocketConnCtx? fromCtx(ReqCtx ctx) => _webSocketConnCtxRef.get(ctx);
}

String? getAuthToken(ReqCtx ctx) {
  return getCookie(ctx.request, AUTH_COOKIE_KEY) ??
      ctx.request.headers[HttpHeaders.authorizationHeader];
}

void setAuthCookie(ReqCtx ctx, String token, int maxAgeSecs) {
  ctx.appendHeader(
    HttpHeaders.setCookieHeader,
    '$AUTH_COOKIE_KEY=$token; HttpOnly; SameSite=Lax; Max-Age=$maxAgeSecs',
  );
}

void closeWebSocketSessionConnections(GlobalsHolder ctx, String sessionId) {
  final connections = _webSocketSessionsRef.get(ctx)[sessionId];
  if (connections != null) {
    for (final conn in connections) {
      // TODO: Unauthorized
      // conn.client.closeWithReason(4401, 'Session ended.');
      conn.client.close();
    }
  }
}

Future<void> setWebSocketAuth(
  Map<String, Object?>? map,
  GlobalsHolder holder,
  GraphQLWebSocketServer server,
) async {
  late final WebSocketConnCtx connCtx;
  if (map == null) {
    connCtx = const WebSocketConnCtx();
  } else {
    final refreshToken = map['refreshToken'];
    UserClaims? claims;
    if (refreshToken is String) {
      claims = await _getUserClaimsFromToken(
        refreshToken,
        isRefreshToken: true,
      );
      if (claims != null) {
        final _connectionsMap = _webSocketSessionsRef.get(holder);
        final set = _connectionsMap.putIfAbsent(
          claims.sessionId,
          () => {},
        );
        set.add(server);

        void _onDone(Object? _) {
          set.remove(server);
          if (set.isEmpty) {
            _connectionsMap.remove(claims!.sessionId);
          }
        }

        // ignore: unawaited_futures
        server.done.then(_onDone).catchError(_onDone);
      }
    }
    connCtx = WebSocketConnCtx(
      claims: claims,
      platform: map[UserSession.platformKey] as String?,
      appVersion: map[UserSession.appversionKey] as String?,
    );
  }
  _webSocketConnCtxRef.setScoped(
    server.globalVariables,
    connCtx,
  );
}

class UserClaims {
  final int userId;
  final String sessionId;

  UserClaims({
    required this.userId,
    required this.sessionId,
  });
}

Future<UserClaims> getUserClaimsUnwrap(
  ReqCtx ctx, {
  bool isRefreshToken = false,
}) async {
  final claims = await getUserClaims(
    ctx,
    isRefreshToken: isRefreshToken,
  );
  if (claims != null) {
    return claims;
  }
  throw unauthenticatedError;
}

Future<UserClaims?> getUserClaims(
  ReqCtx ctx, {
  bool isRefreshToken = false,
}) async {
  final webSocketClaims = WebSocketConnCtx.fromCtx(ctx)?.claims;
  if (webSocketClaims != null) {
    return webSocketClaims;
  }
  final authToken = getAuthToken(ctx);
  if (authToken != null) {
    return _getUserClaimsFromToken(
      authToken,
      isRefreshToken: isRefreshToken,
    );
  }
  return null;
}

Future<UserClaims?> _getUserClaimsFromToken(
  String authToken, {
  bool isRefreshToken = false,
}) async {
  final jwt = await parseJwt(authToken);
  if (jwt.isVerified == true) {
    final userIdStr = jwt.claims.subject ?? '';
    final userId = int.tryParse(userIdStr);
    final sessionId = jwt.claims.getTyped<String?>('sessionId');
    final isRefresh = jwt.claims.getTyped<bool?>('isRefresh');

    if (sessionId != null &&
        userId != null &&
        (isRefreshToken && isRefresh == true ||
            !isRefreshToken && isRefresh == false)) {
      return UserClaims(
        userId: userId,
        sessionId: sessionId,
      );
    }
  }
}

String createAuthToken({
  required int userId,
  required String sessionId,
  required Duration duration,
  required bool isRefresh,
}) {
  final int issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final int expiresAt = issuedAt + duration.inSeconds;

  return _createJwt({
    'exp': expiresAt,
    'iat': issuedAt,
    'iss': 'shelf-graphql-chat',
    'sub': userId.toString(),
    'sessionId': sessionId,
    'isRefresh': isRefresh,
  });
}

// ignore: constant_identifier_names
const _JWT_KEY = <String, String>{
  'kty': 'oct',
  'k': 'AyM1SysPp75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow'
};

final _keyStore = JsonWebKeyStore()..addKey(JsonWebKey.fromJson(_JWT_KEY));

Future<JsonWebToken> parseJwt(String encoded) async {
  final jwt = await JsonWebToken.decodeAndVerify(encoded, _keyStore);

  // validate the claims
  // final violations = jwt.claims.validate(issuer: Uri.parse("alice"));
  // print("violations: $violations");
  return jwt;
}

String _createJwt(Map<String, Object?> claimsMap) {
  final claims = JsonWebTokenClaims.fromJson(claimsMap);

  // create a builder, decoding the JWT in a JWS, so using a
  // JsonWebSignatureBuilder
  final builder = JsonWebSignatureBuilder();

  // set the content
  builder.jsonContent = claims.toJson();

  // add a key to sign, can only add one for JWT
  builder.addRecipient(
    JsonWebKey.fromJson(_JWT_KEY),
    algorithm: 'HS256',
  );

  // build the jws
  final jws = builder.build();

  // output the compact serialization
  return jws.toCompactSerialization();
}

Uint8List getRandomBytes([int length = 16]) {
  final _random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (i) => _random.nextInt(256)),
  );
}

String hashFromPassword(String password, {Argon2Parameters? params}) {
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

  final result = Uint8List(32);
  argon2.generateBytesFromString(password, result, 0, result.length);

  final encoded =
      '\$argon2${['d', 'i', 'id'][_params.type]}\$v=${_params.version}'
      '\$m=${_params.memory},t=${_params.iterations},p=${_params.lanes}'
      '\$${base64.encode(_params.salt).replaceAll('=', '')}'
      '\$${base64.encode(result).replaceAll('=', '')}';
  return encoded;
}

bool verifyPasswordFromHash(String password, String realHash) {
  try {
    final split = realHash.split('\$');
    final version = int.parse(split[2].substring(2));
    final compluteParams =
        split[3].split(',').map((v) => int.parse(v.substring(2))).toList();
    final saltStrUnpadded = split[4];
    final salt =
        base64.decode('$saltStrUnpadded${'=' * (saltStrUnpadded.length % 4)}');

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
  } catch (_) {
    return false;
  }
}
