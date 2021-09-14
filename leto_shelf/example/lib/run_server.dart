import 'dart:io';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'schema/api_schema.dart' show makeApiSchema, relativeToScriptPath;
import 'schema/files.controller.dart';

void main() {
  runServer();
}

Future<void> runServer() async {
  await shelfRun(
    serverHandler,
    defaultBindPort: 8060,
    defaultBindAddress: '0.0.0.0',
    defaultEnableHotReload: true,
  );
}

Handler serverHandler({Map<String, Object?>? globalVariables}) {
  final app = Router();
  app.get('/echo', _echoHandler);

  setUpGraphQL(app, globalVariables: globalVariables);

  final _logMiddleware = customLog(log: (msg) {
    if (!msg.contains('IntrospectionQuery')) {
      print(msg);
    }
  });

  return const Pipeline()
      .addMiddleware(_logMiddleware)
      .addMiddleware(cors())
      .addMiddleware(etag())
      .addMiddleware(jsonParse())
      .addHandler(app);
}

void setUpGraphQL(Router app, {Map<Object, Object?>? globalVariables}) {
  final filesController = FilesController();

  app.get(
    '/files/<filepath|.*>',
    staticFilesWithController(filesController),
  );
  final schema = makeApiSchema(filesController);
  final graphQL = GraphQL(
    schema,
    introspect: true,
    globalVariables: globalVariables,
  );

  const port = 8060;
  const httpPath = '/graphql';
  const wsPath = '/graphql-subscription';

  app.all(httpPath, graphqlHttp(graphQL, globalVariables: globalVariables));
  app.get(wsPath, graphqlWebSocket(graphQL, globalVariables: globalVariables));

  final schemaFileText = printSchema(schema);
  const downloadSchemaOnOpen = true;
  const schemaFilename = 'api-schema.graphql';

  app.get('/graphql-schema', (Request request) {
    return Response.ok(
      schemaFileText,
      headers: {
        HttpHeaders.contentTypeHeader: 'text/plain',
        'content-disposition': downloadSchemaOnOpen
            ? 'attachment; filename="$schemaFilename"'
            : 'inline',
      },
    );
  });

  String printTypeReference(GraphQLType type) => type.whenMaybe(
        list: (type) => '[${printTypeReference(type.ofType)}]',
        nonNullable: (type) => '${printTypeReference(type.ofType)}!',
        orElse: (_) => '<a href="#$type">$type</a>',
      );

  // TODO: there are probably better options
  final schemaWithTypeTags = printSchema(
    schema,
    printer: SchemaPrinter(
      printTypeName: (type) => '<span id="$type">$type</span>',
      printTypeReference: printTypeReference,
    ),
  );

  final schemaFileHtml = '''
<html>
<head>
<style>
  .disable-select {-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none;}
</style>
</head>
<body style="display: flex;flex-direction: column;padding: 0 6px 16px;">
  <a href="/graphql-schema" class="disable-select" style="padding:12px;">DOWNLOAD</a>
  <pre>$schemaWithTypeTags</pre>
</body>
</html>''';

  app.get('/graphql-schema-interactive', (Request request) {
    return Response.ok(
      schemaFileHtml,
      headers: {HttpHeaders.contentTypeHeader: 'text/html'},
    );
  });

  app.get(
    '/playground',
    playgroundHandler(
      config: const PlaygroundConfig(
        endpoint: 'http://localhost:$port$httpPath',
        subscriptionEndpoint: 'ws://localhost:$port$wsPath',
      ),
    ),
  );
  app.get(
    '/graphiql',
    graphiqlHandler(
      fetcher: const GraphiqlFetcher(
        url: 'http://localhost:$port$httpPath',
        subscriptionUrl: 'ws://localhost:$port$wsPath',
      ),
    ),
  );
  app.get(
    '/altair',
    altairHandler(
      config: const AltairConfig(
        endpointURL: 'http://localhost:$port$httpPath',
        subscriptionsEndpoint: 'ws://localhost:$port$wsPath',
      ),
    ),
  );
}

Handler staticFilesWithController(FilesController filesController) {
  final handler = createStaticHandler(
    relativeToScriptPath(['/']),
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  return (request) {
    final etag = request.headers[HttpHeaders.ifNoneMatchHeader];
    final filepath = request.routeParameter('filepath');
    if (etag != null && filepath is String) {
      final decodedFilePath = Uri.decodeComponent(filepath);
      final file = filesController.allFiles[decodedFilePath];
      if (file != null && etag == '"${file.sha1Hash}"') {
        return Response.notModified();
      }
    }
    return handler(request);
  };
}

Response _echoHandler(Request request) {
  return Response.ok(DateTime.now().toString());
}
