import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show sha1;
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
      if (request.method != 'GET' && request.mimeType == 'application/json') {
        final str = await request.readAsString();
        final updateContext = <String, Object?>{
          extractJsonKey: jsonDecode(str)
        };

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

Response setEtag(Response response, String etag) {
  return response.change(headers: {HttpHeaders.etagHeader: etag});
}

Middleware etag({
  Future<String> Function(Stream<List<int>>, Encoding?)? hasher,
}) {
  return (handler) {
    return (request) async {
      final response = await handler(request);
      if (response.statusCode >= 300) {
        return response;
      }

      final ifNoneMatch = request.headers[HttpHeaders.ifNoneMatchHeader];
      final settedEtag = response.headers[HttpHeaders.etagHeader];
      if (settedEtag != null) {
        // ETag already set
        if (ifNoneMatch == settedEtag) {
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

      if (bodyHash == ifNoneMatch) {
        // computed ETag matches If-None-Match header
        return Response.notModified(
          headers: response.headersAll,
          context: response.context,
        );
      }

      // Return the response with the copied body
      // and the computed ETag header
      return response.change(
        body: Stream.fromIterable(bodyCopy),
        headers: {HttpHeaders.etagHeader: bodyHash},
      );
    };
  };
}
