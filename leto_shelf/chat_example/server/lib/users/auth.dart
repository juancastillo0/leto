import 'dart:io';

import 'package:jose/jose.dart';
import 'package:server/users/user_table.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

// ignore: constant_identifier_names
const AUTH_COOKIE_KEY = 'shelf-graphql-chat-auth';

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

class UserClaims {
  final int userId;
  final String sessionId;

  UserClaims({
    required this.userId,
    required this.sessionId,
  });
}

Future<UserClaims?> getUserClaims(
  ReqCtx ctx, {
  bool isRefreshToken = false,
}) async {
  final authToken = getAuthToken(ctx);
  if (authToken != null) {
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
  return null;
}

String createAuthToken({
  required int userId,
  required String sessionId,
  required Duration duration,
  required bool isRefresh,
}) {
  final issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final expiresAt = issuedAt + duration.inSeconds;

  return createJwt({
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

final keyStore = JsonWebKeyStore()..addKey(JsonWebKey.fromJson(_JWT_KEY));

Future<JsonWebToken> parseJwt(String encoded) async {
  final jwt = await JsonWebToken.decodeAndVerify(encoded, keyStore);

  // validate the claims
  // final violations = jwt.claims.validate(issuer: Uri.parse("alice"));
  // print("violations: $violations");
  return jwt;
}

String createJwt(Map<String, Object?> claimsMap) {
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
