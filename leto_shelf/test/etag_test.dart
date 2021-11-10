import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' show md5, sha1, sha256;
import 'package:http/http.dart' as http;
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

  test('etag sha1 by default', () async {
    const String body = 'dnwnpoaw';
    final bodyHash = sha1.convert(utf8.encode(body)).toString();

    final url = await simpleHttpServer(
      const Pipeline().addMiddleware(etag()).addHandler((request) {
        return Response.ok(body);
      }),
    );

    final client = http.Client();

    http.Response response = await client.get(url);
    expect(response.statusCode, 200);
    expect(response.headers['etag'], '"$bodyHash"');

    response = await client.get(
      url,
      headers: {'if-none-match': '"$bodyHash"'},
    );
    expect(response.statusCode, 304);
    expect(response.headers['etag'], '"$bodyHash"');
  });

  test('etag custom hasher', () async {
    Future<String> hasher(Stream<List<int>> b, Encoding? e) {
      return md5.bind(b).single.then((value) => '"${value.toString()}"');
    }

    const String body = 'dnwnpoidnaoinoawinoioaw';
    final bodyEtag = await hasher(utf8.encoder.bind(Stream.value(body)), null);
    final sha256BodyHash = sha256.convert(utf8.encode(body)).toString();
    bool shouldSetEtag = false;

    final url = await simpleHttpServer(
      const Pipeline()
          .addMiddleware(etag(hasher: hasher))
          .addHandler((request) async {
        if (shouldSetEtag) {
          return setEtag(Response.ok(body), '"$sha256BodyHash"');
        }
        return Response.ok(body);
      }),
    );

    final client = http.Client();

    http.Response response = await client.get(url);
    expect(response.statusCode, 200);
    expect(response.headers['etag'], bodyEtag);

    response = await client.get(url, headers: {'if-none-match': bodyEtag});
    expect(response.statusCode, 304);
    expect(response.headers['etag'], bodyEtag);

    final _res = await _sendIo('GET', url, headers: {
      'if-none-match': [bodyEtag, 'other']
    });
    expect(_res.statusCode, 304);
    expect(_res.headers['etag'], [bodyEtag]);

    shouldSetEtag = true;

    final _res2 = await _sendIo(
      'GET',
      url,
      headers: {
        'if-none-match': [bodyEtag, '"$sha256BodyHash"']
      },
    );
    expect(_res2.statusCode, 304);
    expect(_res2.headers['etag'], ['"$sha256BodyHash"']);

    response = await client.head(
      url,
      headers: {'if-none-match': '"$sha256BodyHash"'},
    );
    expect(response.statusCode, 304);
    expect(response.headers['etag'], '"$sha256BodyHash"');
  });
}
