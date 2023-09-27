// ignore_for_file: dead_code

import 'dart:async';
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show HttpServer;

import 'package:http/http.dart' as http;
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' show Router;

part 'quickstart_server.g.dart';

// @example-start{quickstart-main-fn}
Future<void> main() async {
  final server = await runServer();
  final url = Uri.parse('http://${server.address.host}:${server.port}/graphql');
  await testServer(url);
}
// @example-end{quickstart-main-fn}

// @example-start{quickstart-controller-state-definition}
// this annotations is only necessary for code generation
@GraphQLObject()
class Model {
  final String state;
  final DateTime createdAt;

  const Model(this.state, this.createdAt);
}

/// Set up your state.
/// This could be anything such as a database connection.
///
/// Global means that there will only be one instance of [ModelController]
/// for this reference. As opposed to [ScopedRef.local] where there will be
/// one [ModelController] for each request (for saving user information
/// or a [DataLoader], for example).
final stateRef = ScopedRef<ModelController>.global(
  (scope) => ModelController(
    Model('InitialState', DateTime.now()),
  ),
);

class ModelController {
  Model? _value;
  Model? get value => _value;

  final _streamController = StreamController<Model>.broadcast();
  Stream<Model> get stream => _streamController.stream;

  ModelController(this._value);

  void setValue(Model newValue) {
    if (newValue.state == 'InvalidState') {
      // This will appear as an GraphQLError in the response.
      // You can pass more information using custom extensions.
      throw GraphQLError(
        "Can't be in InvalidState.",
        extensions: {'errorCodeExtension': 'INVALID_STATE'},
      );
    }
    _value = newValue;
    _streamController.add(newValue);
  }
}
// @example-end{quickstart-controller-state-definition}

// @example-start{quickstart-schema-string,extension:graphql,start:1,end:-1}
const schemaString = '''
type Query {
  """Get the current state"""
  getState: Model
}

type Model {
  state: String!
  createdAt: Date!
}

"""An ISO-8601 Date."""
scalar Date

type Mutation {
  setState(
    """The new state, can't be 'WrongState'!."""
    newState: String!
  ): Boolean!
}

type Subscription {
  onStateChange: Model!
}
''';
// @example-end{quickstart-schema-string}

// @example-start{quickstart-make-schema}
/// Create a [GraphQLSchema].
/// All of this can be generated automatically using `package:leto_generator`
GraphQLSchema makeGraphQLSchema() {
  // The [Model] GraphQL Object type. It will be used in the schema
  final GraphQLObjectType<Model> modelGraphQLType = objectType<Model>(
    'Model',
    fields: [
      // All the fields that you what to expose
      graphQLString.nonNull().field(
            'state',
            resolve: (Model model, Ctx ctx) => model.state,
          ),
      graphQLDate.nonNull().field(
            'createdAt',
            resolve: (Model model, Ctx ctx) => model.createdAt,
          ),
    ],
  );
  // The executable schema. The `queryType`, `mutationType`
  // and `subscriptionType` are should be GraphQL Object types
  final schema = GraphQLSchema(
    queryType: objectType('Query', fields: [
      // Use the created [modelGraphQLType] as the return type for the
      // "getState" root Query field
      modelGraphQLType.field(
        'getState',
        description: 'Get the current state',
        resolve: (Object? rootValue, Ctx ctx) => stateRef.get(ctx).value,
      ),
    ]),
    mutationType: objectType('Mutation', fields: [
      graphQLBoolean.nonNull().field(
        'setState',
        // set up the input field. could also be done with
        // `graphQLString.nonNull().inputField('newState')`
        inputs: [
          GraphQLFieldInput(
            'newState',
            graphQLString.nonNull(),
            description: "The new state, can't be 'WrongState'!.",
          ),
        ],
        // execute the mutation
        resolve: (Object? rootValue, Ctx ctx) {
          final newState = ctx.args['newState']! as String;
          if (newState == 'WrongState') {
            return false;
          }
          stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
          return true;
        },
      ),
    ]),
    subscriptionType: objectType('Subscription', fields: [
      // The Subscriptions are the same as Queries and Mutations as above,
      // but should use `subscribe` instead of `resolve` and return a `Steam`
      modelGraphQLType.nonNull().field(
            'onStateChange',
            subscribe: (Object? rootValue, Ctx ctx) => stateRef.get(ctx).stream,
          )
    ]),
  );
  assert(schema.schemaStr == schemaString.trim());
  return schema;
}

// @example-end{quickstart-make-schema}
// @example-start{quickstart-setup-graphql-server}
Future<HttpServer> runServer({int? serverPort, ScopedMap? globals}) async {
  // you can override state with ScopedMap.setGlobal/setScoped
  final ScopedMap scopedMap = globals ?? ScopedMap();
  if (globals == null) {
    // if it wasn't overridden it should be the default
    assert(stateRef.get(scopedMap).value?.state == 'InitialState');
  }
  // Instantiate the GraphQLSchema
  final schema = makeGraphQLSchema();
  // Instantiate the GraphQL executor, you can pass extensions and
  // decide whether you want to introspect the schema
  // and validate the requests
  final letoGraphQL = GraphQL(
    schema,
    extensions: [],
    introspect: true,
    globalVariables: scopedMap,
  );

  final port =
      serverPort ?? const int.fromEnvironment('PORT', defaultValue: 8080);
  const graphqlPath = 'graphql';
  const graphqlSubscriptionPath = 'graphql-subscription';
  final endpoint = 'http://localhost:$port/$graphqlPath';
  final subscriptionEndpoint = 'ws://localhost:$port/$graphqlSubscriptionPath';

  // Setup server endpoints
  final app = Router();
  // GraphQL HTTP handler
  app.all(
    '/$graphqlPath',
    graphQLHttp(letoGraphQL),
  );
  // GraphQL WebSocket handler
  app.all(
    '/$graphqlSubscriptionPath',
    graphQLWebSocket(
      letoGraphQL,
      pingInterval: const Duration(seconds: 10),
      validateIncomingConnection: (
        Map<String, Object?>? initialPayload,
        GraphQLWebSocketShelfServer wsServer,
      ) {
        if (initialPayload != null) {
          // you can authenticated an user with the initialPayload:
          // final token = initialPayload['token']! as String;
          // ...
        }
        return true;
      },
    ),
  );
// @example-end{quickstart-setup-graphql-server}
// @example-start{quickstart-setup-graphql-server-utilities}
  // GraphQL schema and endpoint explorer web UI.
  // Available UI handlers: playgroundHandler, graphiqlHandler and altairHandler
  app.get(
    '/playground',
    playgroundHandler(
      config: PlaygroundConfig(
        endpoint: endpoint,
        subscriptionEndpoint: subscriptionEndpoint,
      ),
    ),
  );
  // Simple endpoint to download the GraphQLSchema as a SDL file.
  // $ curl http://localhost:8080/graphql-schema > schema.graphql
  const downloadSchemaOnOpen = true;
  const schemaFilename = 'schema.graphql';
  app.get('/graphql-schema', (Request request) {
    return Response.ok(
      schema.schemaStr,
      headers: {
        'content-type': 'text/plain',
        'content-disposition': downloadSchemaOnOpen
            ? 'attachment; filename="$schemaFilename"'
            : 'inline',
      },
    );
  });
// @example-end{quickstart-setup-graphql-server-utilities}
// @example-start{quickstart-start-server}
  // Set up other shelf handlers such as static files

  // Start the server
  final server = await shelf_io.serve(
    const Pipeline()
        // Configure middlewares
        .addMiddleware(customLog(log: (msg) {
          // TODO: 2A detect an introspection query.
          //  Add more structured logs and headers
          if (!msg.contains('IntrospectionQuery')) {
            print(msg);
          }
        }))
        .addMiddleware(cors())
        .addMiddleware(etag())
        .addMiddleware(jsonParse())
        // Add Router handler
        .addHandler(app),
    '0.0.0.0',
    port,
  );
  print(
    'GraphQL Endpoint at $endpoint\n'
    'GraphQL Subscriptions at $subscriptionEndpoint\n'
    'GraphQL Playground UI at http://localhost:$port/playground',
  );

  return server;
}
// @example-end{quickstart-start-server}

// @example-start{quickstart-test-server}
/// For a complete GraphQL client you probably want to use
/// Ferry (https://github.com/gql-dart/ferry)
/// Artemis (https://github.com/comigor/artemis)
/// or raw GQL Links (https://github.com/gql-dart/gql/tree/master/links)
Future<void> testServer(Uri url) async {
  final before = DateTime.now();
  const newState = 'NewState';
  // POST request which sets the state
  final response = await http.post(
    url,
    body: jsonEncode({
      'query':
          r'mutation setState ($state: String!) { setState(newState: $state) }',
      'variables': {'state': newState}
    }),
    headers: {'content-type': 'application/json'},
  );
  assert(response.statusCode == 200);
  final body = jsonDecode(response.body) as Map<String, Object?>;
  final data = body['data']! as Map<String, Object?>;
  assert(data['setState'] == true);

  // Also works with GET
  final responseGet = await http.get(url.replace(
    queryParameters: <String, String>{
      'query': '{ getState { state createdAt } }'
    },
  ));
  assert(responseGet.statusCode == 200);
  final bodyGet = jsonDecode(responseGet.body) as Map<String, Object?>;
  final dataGet = bodyGet['data']! as Map<String, dynamic>;
  assert(dataGet['getState']['state'] == newState);
  final createdAt = DateTime.parse(dataGet['getState']['createdAt'] as String);
  assert(createdAt.isAfter(before));
  assert(createdAt.isBefore(DateTime.now()));

  // To test subscriptions you can open the playground web UI at /playground
  // or programmatically using https://github.com/gql-dart/gql/tree/master/links/gql_websocket_link,
  // an example can be found in test/mutation_and_subscription_test.dart
}
// @example-end{quickstart-test-server}

// @example-start{quickstart-make-schema-code-gen}
/// Code Generation
/// Using leto_generator, [makeGraphQLSchema] could be generated
/// with the following annotated functions and the [GraphQLObject]
/// annotation over [Model]

/// Get the current state
@Query()
Model? getState(Ctx ctx) {
  return stateRef.get(ctx).value;
}

@Mutation()
bool setState(
  Ctx ctx,
  // The new state, can't be 'WrongState'!.
  String newState,
) {
  if (newState == 'WrongState') {
    return false;
  }

  stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
  return true;
}

@Subscription()
Stream<Model> onStateChange(Ctx ctx) {
  return stateRef.get(ctx).stream;
}
// @example-end{quickstart-make-schema-code-gen}
