import 'dart:convert';
import 'dart:io';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart' show printSchema, SchemaPrinter;
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/api_schema.dart' show makeApiSchema;
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart' show userChatsRef;
import 'package:server/events/database_event.dart';
import 'package:server/graphql/logging_extension.dart';
import 'package:server/users/auth.dart'
    show closeWebSocketSessionConnections, setWebSocketAuth;
import 'package:server/users/user_table.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

Future<HttpServer> startServer({
  ScopedMap? scope,
  GraphQLConfig? config,
}) async {
  final handle = await serverHandler(config: config, scope: scope);
  final server = await shelf_io.serve(handle, '0.0.0.0', 0);
  return server;
}

Future<Handler> serverHandler({ScopedMap? scope, GraphQLConfig? config}) async {
  final app = Router();
  app.get('/echo', _echoHandler);

  await setUpGraphQL(app, config: config, scope: scope);

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

Future<void> setUpGraphQL(
  Router app, {
  ScopedMap? scope,
  GraphQLConfig? config,
}) async {
  final globalVariables = scope ?? ScopedMap.empty();

  app.get(
    '/files/<filepath|.*>',
    staticFilesHandler(globalVariables),
  );
  final schema = makeApiSchema();

  const bool kReleaseMode = bool.fromEnvironment(
    'dart.vm.product',
    defaultValue: false,
  );
  if (!kReleaseMode) {
    schema.queryType!.fields.removeWhere((f) => f.name == 'testSqlRawQuery');
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
    extensions: config?.extensions ??
        [
          if (const bool.fromEnvironment('TRACING')) GraphQLTracingExtension(),
          GraphQLPersistedQueries(returnHashInResponse: true),
          CacheExtension(cache: LruCacheSimple(50)),
          LoggingExtension((log) {
            final message = log.message;
            if (!message.startsWith('IntrospectionQuery')) {
              print(message);
            }
          }),
        ],
  );
  await userTableRef.get(globalVariables).setup();
  await userSessionRef.get(globalVariables).setup();
  final chatController = await chatControllerRef.get(globalVariables);
  await userChatsRef.get(globalVariables).setup();
  chatController.events.controller.stream.listen((events) {
    for (final event in events) {
      if (event.type == EventType.userSessionSignedOut) {
        closeWebSocketSessionConnections(globalVariables, event.sessionId);
      }
    }
  });

  const port = 8060;
  const httpPath = '/graphql';
  const wsPath = '/graphql-subscription';

  app.all(
    httpPath,
    graphqlHttp(
      graphQL,
      globalVariables: globalVariables,
      onEmptyGet: (_) {
        return Response.ok(schema.schemaStr);
      },
    ),
  );
  app.get(
    wsPath,
    graphqlWebSocket(
      graphQL,
      globalVariables: globalVariables,
      validateIncomingConnection: (map, server) async {
        await setWebSocketAuth(map, globalVariables, server);

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

Handler staticFilesHandler(GlobalsHolder globals) {
  final handler = createStaticHandler(
    pathRelativeToScript(['/']),
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  return (request) async {
    final etag = request.headers[HttpHeaders.ifNoneMatchHeader];
    String? fileHash;
    final filepath = request.params['filepath']!;
    if (filepath.startsWith('chats/')) {
      final chatController = await chatControllerRef.get(globals);

      final dbbPath = request.url.pathSegments.join('/');
      // TODO: Authorization
      final message = await chatController.messages.getByPath('/$dbbPath');
      if (message == null) {
        return Response.notFound(null);
      }
      final fileMetadata = message.metadata()?.fileMetadata;
      if (fileMetadata != null) {
        fileHash = '"${fileMetadata.sha1Hash}"';
        if (fileHash == etag) {
          return Response.notModified();
        }
      }
    }
    final response = await handler(request);
    return fileHash != null ? setEtag(response, fileHash) : response;
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
