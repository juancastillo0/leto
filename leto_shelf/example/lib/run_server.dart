import 'dart:io';

import 'package:graphql_schema/utilities.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'schema/api_schema.dart' show makeApiSchema, pathRelativeToScript;
import 'schema/files/files.controller.dart';

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

class ServerConfig {
  final ScopedMap? globalVariables;
  final List<GraphQLExtension>? extensionList;

  const ServerConfig({
    this.globalVariables,
    this.extensionList,
  });
}

Handler serverHandler({ServerConfig? config}) {
  final app = Router();
  app.get('/echo', _echoHandler);

  setUpGraphQL(app, config: config);

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

void setUpGraphQL(Router app, {ServerConfig? config}) {
  final globalVariables = config?.globalVariables;
  final filesController = FilesController();

  app.get(
    '/files/<filepath|.*>',
    staticFilesWithController(filesController),
  );
  final schema = makeApiSchema(filesController);
  final graphQL = GraphQL(
    schema,
    introspect: true,
    extensions: config?.extensionList ??
        [GraphQLTracingExtension(), GraphQLPersistedQueries()],
  );

  const port = 8060;
  const httpPath = '/graphql';
  const wsPath = '/graphql-subscription';

  app.all(httpPath, graphqlHttp(graphQL, globalVariables: globalVariables));
  app.get(wsPath, graphqlWebSocket(graphQL, globalVariables: globalVariables));

  setUpGraphQLSchemaDefinition(app, schema);
  setUpGraphQLUi(
    app,
    url: 'http://localhost:$port$httpPath',
    subscriptionUrl: 'ws://localhost:$port$wsPath',
  );
}

void setUpGraphQLSchemaDefinition(
  Router app,
  GraphQLSchema schema, {
  bool downloadSchemaOnOpen = true,
  String schemaFilename = 'api_schema.graphql',
}) {
  final schemaFileText = printSchema(schema);

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
}

void setUpGraphQLUi(
  Router app, {
  required String url,
  required String subscriptionUrl,
}) {
  app.get(
    '/playground',
    playgroundHandler(
      config: PlaygroundConfig(
        endpoint: url,
        subscriptionEndpoint: subscriptionUrl,
      ),
    ),
  );
  app.get(
    '/graphiql',
    graphiqlHandler(
      fetcher: GraphiqlFetcher(
        url: url,
        subscriptionUrl: subscriptionUrl,
      ),
    ),
  );
  app.get(
    '/altair',
    altairHandler(
      config: AltairConfig(
        endpointURL: url,
        subscriptionsEndpoint: subscriptionUrl,
      ),
    ),
  );
}

Handler staticFilesWithController(FilesController filesController) {
  final handler = createStaticHandler(
    pathRelativeToScript(['/']),
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
