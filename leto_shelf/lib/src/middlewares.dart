import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show Digest, sha1;
import 'package:shelf/shelf.dart';

const extractJsonKey = 'jsonParse.body';
const extractLogKey = 'customLog.log';

bool isJsonRequest(Request request) {
  return request.mimeType == 'application/json';
}

Object? extractJson(Request request) {
  return request.context[extractJsonKey];
}

void Function(String)? extractLog(Request request) {
  return request.context[extractLogKey] as void Function(String)?;
}

Object? extractJsonFromContext(Map<String, Object?> context) {
  return context[extractJsonKey];
}

Middleware jsonParse() {
  return (handler) {
    return (__request) async {
      Request request = __request;
      if (request.mimeType == 'application/json') {
        final str = await request.readAsString();
        final updateContext = {extractJsonKey: jsonDecode(str) as Object};

        request = request.change(context: updateContext);
        final response = await handler(request);
        return response.change(context: updateContext);
      }
      return handler(request);
    };
  };
}

Middleware cors() {
  final _headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Max-Age': (30 * 60).toString(),
  };
  return (handler) {
    return (request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok(null, headers: _headers);
      }
      final response = await handler(request);

      return response.change(headers: _headers);
    };
  };
}

Middleware customLog({void Function(String)? log}) {
  return (handler) {
    return (__request) async {
      final _log = log ?? print;

      final request = __request.change(
        context: {extractLogKey: _log},
      );
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
          '$startTime ${paddedString(durationMs, 5)} ${request.method}'
          ' ${request.mimeType}'
          ' ${request.contentLength} ${response.mimeType}'
          ' ${response.contentLength} ${response.statusCode} /${request.url}'
          ' $payloadStr';
      _log(message);

      return response;
    };
  };
}

String paddedString(
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

Middleware etag({
  StreamTransformer<List<int>, Digest> hasher = sha1,
}) {
  return (handler) {
    return (request) async {
      if (request.method != 'GET' && request.method != 'HEAD') {
        return handler(request);
      }
      final ifNoneMatch = request.headers[HttpHeaders.ifNoneMatchHeader];
      final response = await handler(request);

      // final responseBody = response.read();
      // final data = await responseBody.expand((e) => e).toList();

      // // final digest = responseBody.transform(sha1).single
      // final digest = sha1.convert(data);

      final bodyCopy = <List<int>>[];
      final responseBody = response.read().map((buf) {
        bodyCopy.add(buf);
        return buf;
      });
      final digest = await responseBody.transform(hasher).single;
      final digestHexHeader = '"${digest.toString()}"';

      if (digestHexHeader == ifNoneMatch) {
        return Response.notModified();
      }
      return response.change(
        body: Stream.fromIterable(bodyCopy),
        headers: {HttpHeaders.etagHeader: digestHexHeader},
      );
    };
  };
}
