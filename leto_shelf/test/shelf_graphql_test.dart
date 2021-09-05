import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';
import 'package:test/test.dart';

import '../example/main.dart' show serverHandler;

Future<void> main() async {
  final handler = serverHandler();
  final server = await io.serve(
    handler,
    '0.0.0.0',
    0,
  );
  // Enable content compression
  server.autoCompress = true;

  final url = Uri.http(
    '${server.address.host}:${server.port}',
    '/graphql',
  );

  test('query ui html', () async {
    final client = http.Client();

    Future<void> _validateResponse(http.Response response) async {
      expect(response.statusCode, 200);
      expect(response.headers[HttpHeaders.contentTypeHeader], 'text/html');

      final etag = response.headers[HttpHeaders.etagHeader];
      expect(etag, isNotNull);

      final responseCached = await client.get(
        response.request!.url,
        headers: {HttpHeaders.ifNoneMatchHeader: etag!},
      );

      expect(responseCached.statusCode, 304);
    }

    await Future.wait(
      ['/altair', '/playground', '/graphiql'].map(
        (e) => client.get(url.replace(path: e)).then(_validateResponse),
      ),
    );
  });
}
