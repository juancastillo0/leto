import 'dart:convert' show base64;
import 'dart:io';
import 'dart:math' show Random;
import 'dart:typed_data' show Uint8List;

import 'package:argon2/argon2.dart';
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

  final result = Uint8List(32);
  argon2.generateBytesFromString(password, result, 0, result.length);
  // final hash = result.toHexString();
  final encoded =
      '\$argon2${['d', 'i', 'id'][_params.type]}\$v=${_params.version}'
      '\$m=${_params.memory},t=${_params.iterations},p=${_params.lanes}'
      '\$${base64.encode(_params.salt).replaceAll('=', '')}'
      '\$${base64.encode(result).replaceAll('=', '')}';
  print(encoded);
  return encoded;
}

bool verifyPasswordFromHash(String password, String realHash) {
  // use Salt(List<int> bytes) for a salt from an Integer list
  // final s = Salt.newSalt();
  // Hash with pre-set params (iterations: 32, memory: 256, parallelism: 2,
  // length: 32, type: Argon2Type.i, version: Argon2Version.V13)
  // final result = await argon2.hashPasswordString(password, salt: s);
  // final stringEncoded = result.encodedString;
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
  } catch (e) {
    print(e);
    return false;
  }
}
