import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'schema/api_schema.dart' show makeApiSchema;

Future<void> main() async {
  await shelfRun(
    serverHandler,
    defaultBindPort: 8060,
    defaultBindAddress: '0.0.0.0',
    defaultEnableHotReload: true,
  );
}

Handler serverHandler() {
  final app = Router();
  app.get('/echo', _echoHandler);

  setUpGraphQL(app);

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

void setUpGraphQL(Router app) {
  final graphQL = GraphQL(
    makeApiSchema(),
    introspect: true,
  );

  const port = 8060;
  const httpPath = '/graphql';
  const wsPath = '/graphql-subscription';

  app.all(httpPath, graphqlHttp(graphQL));
  app.get(wsPath, graphqlWebSocket(graphQL));

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

Response _echoHandler(Request request) {
  return Response.ok(DateTime.now().toString());
}
