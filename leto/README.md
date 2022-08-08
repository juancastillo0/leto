[![Pub](https://img.shields.io/pub/v/leto.svg)](https://pub.dartlang.org/packages/leto)

# leto

Base package for implementing GraphQL servers executors. The main entrypoint is the `GraphQL.parseAndExecute` method which parses a GraphQL document and executes it with the configured `GraphQLSchema` from `package:leto_schema` .

`package:leto` does not require any specific framework, and thus can be used in any Dart project.

## Ad-hoc Usage

The actual querying functionality is handled by the
`GraphQL` class, which takes a schema (from `package:leto_schema`).
In most cases, you'll want to call `parseAndExecute`
on some string of GraphQL text. It returns a `GraphQLResult` with either a
`Map<String, dynamic>` or a `Stream<GraphQLResult>` for subscriptions:

```dart
try {
    final GraphQLResult result = await graphQL.parseAndExecute(responseText);
    final data = result.data;
    if (data is Stream<GraphQLResult>) {
        // Handle a subscription somehow...
    } else if (data is Map<String, Object?>) {
        response.send({'data': data});
    } else {
        // Handle errors
        final bool didExecute = result.didExecute;
        final List<GraphQLError> errors = result.errors;
    }
} catch (e) {
    // Not usually necessary, only when a specify extension throws.
    response.send(e.toJson());
}
```

Consult the API reference for more:
https://pub.dev/documentation/leto/latest/leto/GraphQL/parseAndExecute.html

If you're looking for functionality like `graphQLHttp` in `graphql-js`, that is not included in this package, because
it is typically specific to the framework/platform you are using. The `graphQLHttp` implementation in [`package:leto_shelf`](../leto_shelf) is a good example.

# GraphQL Executor

The executor can be configured with the following parameters:

<!-- include{graphql-executor-properties} -->
```dart
  /// Extensions implement additional functionalities to the
  /// server's parsing, validation and execution.
  /// For example, extensions for tracing [GraphQLTracingExtension],
  /// logging, error handling or caching [GraphQLPersistedQueries]
  final List<GraphQLExtension> extensions;

  /// An optional callback that can be used to resolve fields
  /// from objects that are not [Map]s, when the related field has no resolver.
  final FutureOr<Object?> Function(Object? parent, Ctx)? defaultFieldResolver;

  /// Variables passed to all executed requests
  final ScopedMap baseGlobalVariables;

  /// If validate is false, a parsed document is executed without
  /// being validated with the provided schema
  final bool validate;

  /// Whether to introspect the [GraphQLSchema]
  ///
  /// This will change the Query type of the [schema] by adding
  /// introspection fields, useful for client code generators or other
  /// tools like UI explorers.
  final bool introspect;

  /// The schema used for executing GraphQL requests
  final GraphQLSchema schema;

  /// Custom validation rules performed to a request's document
  /// before the execution phase
  final List<ValidationRule> customValidationRules;

```
<!-- include-end{graphql-executor-properties} -->


### `GraphQLConfig`

You can also use the `GraphQLConfig` class and the `GraphQL.fromConfig` constructor for creating an executor from a configuration class.

## `GraphQL.parseAndExecute`

The main entry point. Exceptions may be thrown by extensions

### GraphQL Request Arguments

String query
String? operationName
Map<String, Object?>? variableValues
Map<String, Object?>? extensions
Object? rootValue

### `ScopedOverride` List

List<ScopedOverride\>? scopeOverrides

### `InvalidOperationType`

The execution may throw an `InvalidOperationType` if the validOperationTypes argument is passed and the operation in the document is not one of the valid operations. Useful for HTTP safe methods (like GET) used for mutations (this is already handled in `package:leto_shelf`).

## Introspection

Introspection of a GraphQL schema allows clients to query the schema itself,
and get information about the response the server expects. The `GraphQL`
class handles this automatically, so you don't have to write any code for it.

However, you can call the `reflectSchema` method to manually reflect a schema:
https://pub.dartlang.org/documentation/leto/latest/introspection/reflectSchema.html


## Extensions

You can read more about extensions in the [main README](../README.md#extensions). The main API with all the methods that can be overridden is found in [this file](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/extension.dart).

# DataLoader

The DataLoader implementation is based on [graphql/dataloader](https://github.com/graphql/dataloader), the API and methods are basically the same. For usage examples please review the [main README](../README.md#dataloader-batching).


# Subscriptions and Web Socket

GraphQL queries involving `subscription` operations can return
a `Stream`. Ultimately, the transport for relaying subscription
events to clients is not specified in the GraphQL spec, so it's
up to you.

Note that in a schema like this:

```graphql
type TodoSubscription {
    onTodo: TodoAdded!
}

type TodoAdded {
    id: ID!
    text: String!
    isComplete: Bool
}
```

Your Dart schema's resolver for `onTodo` should be
a `Map` *containing an `onTodo` key*:

```dart
field(
  'onTodo',
  todoAddedType,
  resolve: (_, __) {
    return someStreamOfTodos()
            .map((todo) => {'onTodo': todo});
  },
);
```

## Web Socket implementation

For the purposes of reusing existing tooling (i.e. JS clients, etc.),
`package:leto` rolls with an implementation of Apollo's `graphql-ws` spec.
The implementation also supports the `graphql-transport-ws` subprotocol.

**NOTE: At this point, Apollo's spec is extremely out-of-sync with the protocol their client actually expects.**
**See the following issue to track this:**
**https://github.com/apollographql/subscriptions-transport-ws/issues/551**

The implementation is built on `package:stream_channel`, and 
therefore can be used on any two-way transport, whether it is
WebSockets, TCP sockets, Isolates, or otherwise.

Users of this package are expected to extend the `Server`
abstract class. `Server` will handle the transport and communication,
but again, ultimately, emitting subscription events is up to your
implementation.

Here's a snippet from `graphQLWebSocket` in `package:leto_shelf`.
It runs within the context of one single request:

```dart
final channel = IOWebSocketChannel(socket);
final client = stw.RemoteClient(channel.cast<String>());
final server =
    GraphQLWebSocketShelfSServer(client, graphQL, req, res, keepAliveInterval);
await server.done;
```

See `graphQLWebSocket` in `package:leto_shelf` for a good example:
https://github.com/juancastillo0/leto/tree/main/leto_shelf/lib/src/graphql_ws.dart