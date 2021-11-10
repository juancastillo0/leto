import 'dart:io';

import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  final ioClient = HttpClient();

  /// package:http does not allow multiple headers
  /// https://github.com/dart-lang/http/issues/24
  Future<HttpClientResponse> _sendIo(
    String method,
    Uri url, {
    Map<String, List<String>>? headers,
  }) async {
    final _req = await ioClient.openUrl(method, url);
    if (headers != null) {
      headers.forEach((name, value) {
        _req.headers.set(name, value);
        _req.headers.noFolding(name);
      });
    }
    return _req.close();
  }

  Map<String, Object> _filterCorsHeaders(
    HttpHeaders header,
  ) {
    final result = <String, Object>{};

    header.forEach((name, values) {
      if (const [
        CorsHeaders.allowCredentials,
        CorsHeaders.allowOrigin,
        CorsHeaders.maxAge,
        CorsHeaders.allowHeaders,
        CorsHeaders.exposeHeaders,
        CorsHeaders.allowMethods,
      ].contains(name)) {
        final split = values.expand((e) => e.split(', ')).toList();
        result[name] = split.length == 1 ? split.first : split;
      }
    });
    return result;
  }

  test('authorized cors', () async {
    final url = await simpleHttpServer(
      const Pipeline()
          .addMiddleware(cors(allowCredentials: true))
          .addHandler((request) async {
        return Response.ok('body');
      }),
    );

    final _requestHeaders = ['custom-header', 'custom-header-2'];
    HttpClientResponse response = await _sendIo('OPTIONS', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 204);

    // Default values
    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowCredentials: 'true',
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.maxAge: '${30 * 60}',
      CorsHeaders.allowHeaders: _requestHeaders,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
      CorsHeaders.allowMethods: [
        'GET',
        'HEAD',
        'PUT',
        'PATCH',
        'POST',
        'DELETE',
        'OPTIONS',
      ],
    });

    response = await _sendIo('GET', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 200);

    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowCredentials: 'true',
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
    });
  });

  test('unauthorized cors', () async {
    final url = await simpleHttpServer(
      const Pipeline()
          .addMiddleware(cors(allowCredentials: false))
          .addHandler((request) async {
        return Response.ok('body');
      }),
    );

    final _requestHeaders = ['custom-header', 'custom-header-2'];
    HttpClientResponse response = await _sendIo('OPTIONS', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 204);
    expect(response.headers[CorsHeaders.allowCredentials], isNull);

    // Default values
    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.maxAge: '${30 * 60}',
      CorsHeaders.allowHeaders: _requestHeaders,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
      CorsHeaders.allowMethods: [
        'GET',
        'HEAD',
        'PUT',
        'PATCH',
        'POST',
        'DELETE',
        'OPTIONS',
      ],
    });

    response = await _sendIo('GET', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 200);
    expect(response.headers[CorsHeaders.allowCredentials], isNull);

    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
    });
  });

  test('origin cors', () async {
    // ignore: prefer_function_declarations_over_variables
    bool Function(String) _matcher =
        (String origin) => 'other-origin' != origin;

    final url = await simpleHttpServer(
      const Pipeline()
          .addMiddleware(cors(
        allowOrigin: (v) => _matcher(v),
      ))
          .addHandler((request) async {
        return Response.ok('body');
      }),
    );

    final _requestHeaders = ['custom-header', 'custom-header-2'];
    HttpClientResponse response = await _sendIo('OPTIONS', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': ['other-origin'],
    });

    expect(response.statusCode, 200);
    expect(_filterCorsHeaders(response.headers), <String, List<String>>{});

    response = await _sendIo('OPTIONS', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 204);

    // Default values
    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowCredentials: 'true',
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.maxAge: '${30 * 60}',
      CorsHeaders.allowHeaders: _requestHeaders,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
      CorsHeaders.allowMethods: [
        'GET',
        'HEAD',
        'PUT',
        'PATCH',
        'POST',
        'DELETE',
        'OPTIONS',
      ],
    });

    response = await _sendIo('GET', url, headers: {
      CorsHeaders.requestHeaders: _requestHeaders,
      'origin': [url.origin],
    });
    expect(response.statusCode, 200);

    expect(_filterCorsHeaders(response.headers), {
      CorsHeaders.allowCredentials: 'true',
      CorsHeaders.allowOrigin: url.origin,
      CorsHeaders.exposeHeaders: [
        HttpHeaders.etagHeader,
        HttpHeaders.contentLengthHeader,
        HttpHeaders.contentEncodingHeader,
        HttpHeaders.dateHeader,
      ],
    });
  });
}
