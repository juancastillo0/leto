[![Pub](https://img.shields.io/pub/v/leto.svg)](https://pub.dartlang.org/packages/leto)

# Leto

Base package for implementing GraphQL servers executors. The main entrypoint is the `GraphQL.parseAndExecute` method which parses a GraphQL document and executes it with the configured `GraphQLSchema` from `package:leto_schema`.

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

## Table of Contents
- [Leto](#leto)
  - [Ad-hoc Usage](#ad-hoc-usage)
  - [Table of Contents](#table-of-contents)
- [GraphQL Executor](#graphql-executor)
    - [`GraphQLConfig`](#graphqlconfig)
  - [`GraphQL.parseAndExecute`](#graphqlparseandexecute)
    - [GraphQL Request Arguments](#graphql-request-arguments)
    - [`ScopedOverride` List](#scopedoverride-list)
    - [`InvalidOperationType`](#invalidoperationtype)
  - [Introspection](#introspection)
  - [Extensions](#extensions)
- [DataLoader](#dataloader)
- [Subscriptions and WebSockets](#subscriptions-and-websockets)
  - [WebSocket implementation](#websocket-implementation)

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

The main entry point. The implementation follows closely the [execution section in the specification](https://spec.graphql.org/draft/#sec-Execution),
most of the method and variable names are taken from there.



Exceptions may be thrown by extensions

### GraphQL Request Arguments

The main GraphQL request arguments are the following:

| Name           | Type                  | Description                                                                                  | Example                                                                               |
| -------------- | --------------------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| query          | String                | The GraphQL query                                                                            | "mutation createUser ($name: String!) { createUser(name: $name) { name createdAt } }" |
| operationName  | String?               | The operation to execute within the query                                                    | "createUser"                                                                          |
| variableValues | Map<String, Object?>? | The variables specified in the query that should be used as parameter                        | {"name": "Example Name"}                                                              |
| extensions     | Map<String, Object?>? | The extensions passed in the GraphQL request                                                 | {"persistedQuery": {"version": 1, "sha256Hash": "dpiw2ndabo389hd9bs"}}                |
| rootValue      | Object?               | A value passed as parent to the root resolvers. If null, the global `ScopedMap` will be used | {"arg1":"value"}                                                                      |

### `ScopedOverride` List

You can provide `ScopedOverride`s which will only apply to this request. It it is a Subscription, then the overrides will apply to all events in the subscription. If you want to override a `ScopedRef` for all requests in a executor you can pass a `ScopedMap` to the argument `GraphQL.globalVariables` in the executor's constructor.

### `InvalidOperationType`

The execution may throw an `InvalidOperationType` if the `validOperationTypes` argument is passed and the operation in the document is not one of the valid operations. Useful to prevent HTTP safe methods (like GET) from being used for mutations (this is already handled in `package:leto_shelf`).

## Introspection

Introspection of a GraphQL schema allows clients to query the schema itself,
and get information about the response the server expects. The `GraphQL`
class handles this automatically, so you don't have to write any code for it.

However, you can call the `reflectSchema` method to manually reflect a schema:
https://pub.dartlang.org/documentation/leto/latest/introspection/reflectSchema.html


## Extensions

You can read more about extensions in the [main README](../README.md#extensions). The main API with all the methods that
can be overridden is found in [this file](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/extension.dart).

<!-- include{extension-api} -->
```dart
  /// The key identifying this extension, used as the key for
  /// the extensions map in GraphQLError or GraphQLResult.
  /// Should be unique.
  String get mapKey;

  /// The entry point for each request, this is the first method
  /// executed in a [GraphQLExtension] for each request
  ///
  /// Subscriptions execute this once and then execute
  /// [executeSubscriptionEvent] for every
  /// [GraphQLResult.subscriptionStream] event
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    RequestCtx ctx,
  ) =>
      next();

  /// Parser or retrieves the GraphQL [DocumentNode]
  /// from [query] or [extensions]
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    RequestCtx ctx,
  ) =>
      next();

  /// Executes validations given a schema,
  /// and the operation to perform
  GraphQLException? validate(
    GraphQLException? Function() next,
    RequestCtx ctx,
    DocumentNode document,
  ) =>
      next();

  /// Parses argument values and a executes a [field] in [ctx]
  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ObjectExecutionCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) =>
      next();

  /// Resolves a field with [ctx]
  FutureOr<T> resolveField<T>(
    FutureOr<T> Function() next,
    Ctx ctx,
  ) =>
      next();

  /// Called for every [GraphQLResult.subscriptionStream] event
  FutureOr<GraphQLResult> executeSubscriptionEvent(
    FutureOr<GraphQLResult> Function() next,
    ExecutionCtx ctx,
    ScopedMap parentGlobals,
  ) =>
      next();

  /// Maps a resolved value into a serialized value
  FutureOr<Object?> completeValue(
    FutureOr<Object?> Function() next,
    ObjectExecutionCtx ctx,
    String fieldName,
    GraphQLType fieldType,
    Object? result,
  ) =>
      next();

  /// Executes a callback for a [ThrownError] during execution
  ///
  /// Can be used for logging or mapping a resolver exception
  /// into a user friendly error.
  GraphQLException mapException(
    GraphQLException Function() next,
    ThrownError error,
  ) =>
      next();
```
<!-- include-end{extension-api} -->

# DataLoader

The DataLoader implementation is based on [graphql/dataloader](https://github.com/graphql/dataloader), the API and methods are basically the same. For usage examples please review the [main README](../README.md#dataloader-batching).


# Subscriptions and WebSockets

GraphQL queries involving `subscription` operations can return
a `Stream`. Ultimately, the transport for relaying subscription
events to clients is not specified in the GraphQL spec, so it's
up to you. We provide a [WebSocket Server implementation](#websocket-implementation).

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

Your Dart schema's field `subscribe` for `onTodo` should return a `Stream`:

```dart
field(
  'onTodo',
  todoAddedType,
  subscribe: (_, Ctx ctx) {
    return someStreamOfTodos();
  },
);
```

## WebSocket implementation

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