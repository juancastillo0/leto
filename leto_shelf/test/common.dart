import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_graphql_example/run_server.dart' show serverHandler;
import 'package:test/test.dart';

class TestGqlServer {
  final Uri url;
  final Uri subscriptionsUrl;
  final HttpServer server;

  const TestGqlServer({
    required this.url,
    required this.subscriptionsUrl,
    required this.server,
  });
}

Future<TestGqlServer> testServer(Map<Object, Object?> globalVariables) async {
  final handler = serverHandler(globalVariables: globalVariables);
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
  final subscriptionsUrl = Uri(
    scheme: 'ws',
    host: server.address.host,
    port: server.port,
    path: '/graphql-subscription',
  );
  return TestGqlServer(
    server: server,
    url: url,
    subscriptionsUrl: subscriptionsUrl,
  );
}

Future<void> checkEtag(http.Client client, http.Response response) async {
  final etag = response.headers[HttpHeaders.etagHeader];
  expect(etag, isNotNull);

  final responseCached = await client.get(
    response.request!.url,
    headers: {HttpHeaders.ifNoneMatchHeader: etag!},
  );

  expect(responseCached.statusCode, 304);
}

Map<String, Object?> persistedQueryExtension(String sha256Hash) {
  return {
    'persistedQuery': {'version': 1, 'sha256Hash': sha256Hash}
  };
}
