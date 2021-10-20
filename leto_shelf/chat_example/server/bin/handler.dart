import 'dart:convert';
import 'dart:io';

import 'package:server/api_schema.dart' show makeApiSchema;
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart' show userChatsRef;
import 'package:server/users/auth.dart' show setWebSocketAuth;
import 'package:server/users/user_table.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

Future<Handler> serverHandler({GraphQLConfig? config}) async {
  final app = Router();
  app.get('/echo', _echoHandler);

  await setUpGraphQL(app, config: config);

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

Future<void> setUpGraphQL(Router app, {GraphQLConfig? config}) async {
  final globalVariables = ScopedMap.empty();

  app.get(
    '/files/<filepath|.*>',
    staticFilesWithController(),
  );
  final schema = makeApiSchema();

  const bool kReleaseMode = bool.fromEnvironment(
    'dart.vm.product',
    defaultValue: false,
  );
  if (!kReleaseMode &&
      schema.queryType!.fields.every((f) => f.name != 'testSqlRawQuery')) {
    schema.queryType!.fields.add(
      graphQLString.field(
        'testSqlRawQuery',
        inputs: [
          GraphQLFieldInput('query', graphQLString.nonNull()),
          GraphQLFieldInput('params', listOf(graphQLString)),
        ],
        resolve: (_, ctx) async {
          final query = ctx.args['query']! as String;
          final params = ctx.args['params'] as List<String?>?;
          final result = await chatRoomDatabase.get(ctx).query(query, params);
          if (result.affectedRows != null) {
            return jsonEncode({
              'affectedRows': result.affectedRows,
              'insertId': result.insertId
            });
          }
          return jsonEncode(
            result
                .map(
                  (e) => e
                      .toTableColumnMap()
                      .map((key, value) => MapEntry(key ?? '', value)),
                )
                .toList(),
          );
        },
      ),
    );
  }
  final graphQL = GraphQL(
    schema,
    introspect: true,
    extensionList: config?.extensionList ??
        [
          if (Platform.environment['TRACING'] == 'true')
            GraphQLTracingExtension(),
          GraphQLPersistedQueries(),
          CacheExtension(cache: LruCacheSimple(50)),
        ],
  );
  await userTableRef.get(globalVariables).setup();
  await userSessionRef.get(globalVariables).setup();
  await userChatsRef.get(globalVariables).setup();

  const port = 8060;
  const httpPath = '/graphql';
  const wsPath = '/graphql-subscription';

  app.all(
    httpPath,
    graphqlHttp(
      graphQL,
      globalVariables: globalVariables,
    ),
  );
  app.get(
    wsPath,
    graphqlWebSocket(
      graphQL,
      globalVariables: globalVariables,
      validateIncomingConnection: (map) {
        if (map != null) {
          setWebSocketAuth(map, globalVariables);
        }
        return true;
      },
    ),
  );

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

Handler staticFilesWithController() {
  final handler = createStaticHandler(
    pathRelativeToScript(['/']),
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  return (request) {
    // final etag = request.headers[HttpHeaders.ifNoneMatchHeader];
    // final filepath = request.routeParameter('filepath');
    // if (etag != null && filepath is String) {
    //   final decodedFilePath = Uri.decodeComponent(filepath);
    //   final file = filesController.allFiles[decodedFilePath];
    //   if (file != null && etag == '"${file.sha1Hash}"') {
    //     return Response.notModified();
    //   }
    // }
    return handler(request);
  };
}

Response _echoHandler(Request request) {
  return Response.ok(DateTime.now().toString());
}

String pathRelativeToScript(List<String> pathSegments) {
  return [
    '/',
    ...Platform.script.pathSegments
        .take(Platform.script.pathSegments.length - 1),
    ...pathSegments
  ].join(Platform.pathSeparator);
}
