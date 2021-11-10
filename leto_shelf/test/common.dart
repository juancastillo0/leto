import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf_example/run_server.dart'
    show ServerConfig, serverHandler;
import 'package:shelf/shelf_io.dart' as io;
import 'package:test/test.dart';

export 'package:leto_shelf_example/run_server.dart' show ServerConfig;

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

Future<TestGqlServer> testServer(ServerConfig config) async {
  final handler = serverHandler(config: config);
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

Future<Uri> simpleGraphQLHttpServer(
  Pipeline pipeline,
  GraphQLSchema schema, {
  ServerConfig? config,
}) async {
  final graphQL = GraphQL(
    schema,
    introspect: true,
    extensions: config?.extensionList ?? [],
  );

  return simpleHttpServer(
    pipeline
        .addMiddleware(
          jsonParse(),
        )
        .addHandler(
          graphqlHttp(
            graphQL,
            globalVariables: config?.globalVariables,
          ),
        ),
  );
}

Future<Uri> simpleHttpServer(
  Handler handler,
) async {
  final server = await io.serve(
    handler,
    '0.0.0.0',
    0,
  );
  // Enable content compression
  server.autoCompress = true;

  final url = Uri.http(
    '${server.address.host}:${server.port}',
    '/',
  );

  return url;
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
