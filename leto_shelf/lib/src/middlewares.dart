import 'dart:async';
import 'dart:convert' show Encoding, jsonDecode;
import 'dart:io' show HttpHeaders;

import 'package:crypto/crypto.dart' show sha1;
import 'package:shelf/shelf.dart';

const extractJsonKey = 'jsonParse.body';

FutureOr<Object?> extractJson(Request request) {
  if (request.context.containsKey(extractJsonKey)) {
    return request.context[extractJsonKey];
  }
  if (!const ['GET', 'HEAD', 'OPTIONS'].contains(request.method) &&
      (request.mimeType == 'application/json' ||
          request.mimeType == 'application/graphql+json')) {
    return request.readAsString().then(jsonDecode);
  }
  return null;
}

Object? extractJsonFromContext(Map<String, Object?> context) {
  return context[extractJsonKey];
}

Middleware jsonParse() {
  return (handler) {
    return (__request) async {
      Request request = __request;
      final jsonValue = await extractJson(request);
      final updateContext = <String, Object?>{extractJsonKey: jsonValue};

      request = request.change(context: updateContext);
      final response = await handler(request);
      return response.change(context: updateContext);
    };
  };
}

const List<String> _defaultAllowMethods = [
  'GET',
  'HEAD',
  'PUT',
  'PATCH',
  'POST',
  'DELETE',
  'OPTIONS',
];

class CorsHeaders {
  static const allowCredentials = 'access-control-allow-credentials';
  static const maxAge = 'access-control-max-age';
  static const exposeHeaders = 'access-control-expose-headers';
  static const allowMethods = 'access-control-allow-methods';
  static const requestHeaders = 'access-control-request-headers';
  static const allowOrigin = 'access-control-allow-origin';
  static const allowHeaders = 'access-control-allow-headers';
}

bool _defaultAllowOrigin(String origin) => true;

Middleware cors({
  FutureOr<bool> Function(String) allowOrigin = _defaultAllowOrigin,
  bool allowCredentials = true,
  List<String> exposeHeaders = const [
    HttpHeaders.etagHeader,
    HttpHeaders.contentLengthHeader,
    HttpHeaders.contentEncodingHeader,
    HttpHeaders.dateHeader,
  ],
  // Default: 30 minutes
  int maxAgeSecs = 30 * 60,
  // Default: the headers in the request's Access-Control-Request-Headers header
  List<String>? allowHeaders,
  List<String> allowMethods = _defaultAllowMethods,
  int optionsSuccessStatusCode = 204,
}) {
  final baseHeaders = <String, List<String>>{
    if (allowCredentials) CorsHeaders.allowCredentials: ['true'],
    CorsHeaders.maxAge: [maxAgeSecs.toString()],
    CorsHeaders.exposeHeaders: exposeHeaders,
    CorsHeaders.allowMethods: allowMethods,
  };
  return (handler) {
    return (request) async {
      final origin = request.headers['origin'];
      if (origin == null || !await allowOrigin(origin)) {
        return handler(request);
      }
      final _allowHeaders =
          allowHeaders ?? request.headersAll[CorsHeaders.requestHeaders] ?? [];
      final _headers = {
        ...baseHeaders,
        CorsHeaders.allowOrigin: [origin],
        CorsHeaders.allowHeaders: _allowHeaders
      };
      if (request.method == 'OPTIONS') {
        return Response(optionsSuccessStatusCode, headers: _headers);
      }
      final response = await handler(request);
      return response.change(
        headers: _headers
          ..removeWhere(
            (key, _) => const [
              CorsHeaders.maxAge,
              CorsHeaders.allowMethods,
              CorsHeaders.allowHeaders,
            ].contains(key),
          ),
      );
    };
  };
}

Middleware customLog({void Function(String)? log}) {
  return (handler) {
    return (request) async {
      final _log = log ?? print;
      final startTime = DateTime.now();
      final watch = Stopwatch()..start();
      final response = await handler(request);

      final durationMs = watch.elapsedMilliseconds.toString();
      final payload = extractJsonFromContext(response.context)
          .toString()
          .replaceAll('\n', ' ');
      final payloadStr =
          payload.length > 50 ? '${payload.substring(0, 50)}...' : payload;

      final message =
          '$startTime ${_paddedString(durationMs, 5)} ${request.method}'
          ' ${request.mimeType}'
          ' ${request.contentLength} -> ${response.mimeType}'
          ' ${response.contentLength} ${response.statusCode} /${request.url}'
          ' $payloadStr';
      _log(message);

      return response;
    };
  };
}

String _paddedString(
  String str,
  int minLength, {
  bool rightPadded = false,
}) {
  final padding = Iterable.generate(
    str.length < minLength ? minLength - str.length : 0,
    (_) => ' ',
  ).join();
  return rightPadded ? '$str$padding' : '$padding$str';
}

Response setEtag(Response response, String etag) {
  return response.change(headers: {HttpHeaders.etagHeader: etag});
}

bool _defaultShouldProcessResponse(Request _, Response response) =>
    response.statusCode < 300;

Middleware etag({
  Future<String> Function(Stream<List<int>>, Encoding?)? hasher,
  bool Function(Request, Response) shouldProcessResponse =
      _defaultShouldProcessResponse,
}) {
  return (handler) {
    return (request) async {
      if (!const ['GET', 'HEAD'].contains(request.method)) {
        return handler(request);
      }
      final response = await handler(request);
      if (!shouldProcessResponse(request, response)) {
        return response;
      }

      final ifNoneMatch = request.headersAll[HttpHeaders.ifNoneMatchHeader];
      final alreadySetEtag = response.headers[HttpHeaders.etagHeader];
      if (alreadySetEtag != null) {
        // ETag already set
        if (ifNoneMatch != null && ifNoneMatch.contains(alreadySetEtag)) {
          // set ETag matches If-None-Match header
          return Response.notModified(
            headers: response.headersAll,
            context: response.context,
          );
        }
        return response;
      }

      // Copy the body since `response.read` returns a single
      // subscription stream, which can't be used in the response
      // because we are using it to calculate the ETag hash
      final bodyCopy = <List<int>>[];
      final bodyStream = response.read().map((buf) {
        bodyCopy.add(buf);
        return buf;
      });

      final String bodyHash;
      if (hasher != null) {
        bodyHash = await hasher(bodyStream, response.encoding);
      } else {
        final digest = await bodyStream.transform(sha1).single;
        // sha1 hash in HEX
        bodyHash = '"${digest.toString()}"';
      }

      if (ifNoneMatch != null && ifNoneMatch.contains(bodyHash)) {
        // computed ETag matches If-None-Match header
        return Response.notModified(
          headers: {...response.headersAll, HttpHeaders.etagHeader: bodyHash},
          context: response.context,
        );
      }

      // Return the response with the copied body and the computed ETag header
      return response.change(
        body: Stream.fromIterable(bodyCopy),
        headers: {HttpHeaders.etagHeader: bodyHash},
      );
    };
  };
}
