# Leto GraphQL

A GraphQL server implementation written in Dart.

Inspired by graphql-js, async-graphql and type-graphql. First version of the codebase was forked from angel-graphql. Many tests and utilities (Dataloader, printSchema) were ported from graphql-js.

# Quickstart

This provides a simple introduction to leto, you can explore more in the following sections of this readme or looking at the tests and examples for each package. A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto_graphql/chat_example

### Add dependencies to your pubspec.yaml

```yaml
dependencies:
  leto: <latest>
  leto_shelf: <latest>
  shelf: <latest>
  shelf_router: <latest>
  # not nessary for the server, just for testing it
  http: <latest>
```

### Create a `GraphQLSchema`

```dart

class Model {
    final String stringField;
    final int intField;
    final List<Model>? optionalNested;

    const Model({
        required this.stringField,
        required this.intField,
        required this.optionalNested,
    });
}


final modelGraphqlType = objectType<Model>(
    'Model',
    fields: [
        graphQLString.nonNull().field('stringField',resolve: (ReqCtx ctx, Model m)
        => m.intField,),
        field('intField', graphqlInt, resolve: (ReqCtx ctx, Model m)
        => m.intField,
        )
    ],
);

final apiSchema = GraphQLSchema(
    queryType: objectType(
        fields [
modelGraphqlType.field('getModel', resolve: (ReqCtx ctx, Object rootValue) => const Model(stringField: 'sField', ))
        ]
    )
)
```

Or with code generation

```dart
import 'package:leto_shelf/leto_shelf.dart';
part 'main.g.dart';

/// Get the current state
@Query()
String? getState(ReqCtx ctx) {
  return stateRef.get(ctx);
}

@Mutation()
bool setState(
  ReqCtx ctx,
  // The new state, can't be 'WrongState'!.
  String newState,
) {
  if (newState == 'WrongState') {
    return false;
  }
  stateRef.set(ctx, newState);
  return true;
}

```

which generates the same `modelGraphqlType` in `model.g.dart` and `apiSchema` in 'lib/graphql_api.schema.dart' (TODO: configurable).

### Start the server

### Test the server

/graphql-schema
/playground

# Examples

## Fullstack Dart Chat:

A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto_graphql/chat_example.

- Sqlite3 and Posgres database integrations
- Subscriptions
- Authentication/Authorization
- Sessions
- Tests
- File uploads
- Client/Server GraphQL extensions integration
- Docker

### Chat functionalities

- Send/receive/delete messages in realtime
  - File uploads
  - Link metadata
  - Reply to other messages
- Client cache through [Ferry](https://github.com/gql-dart/ferry) and [Hive]()
- Create chat rooms, add/remove users and share authorized invite links
- View complete usage history with events for the most important mutations
- View all user sessions

## Server example:

A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto_graphql/chat_example

# Documentation

The following sections introduce most of the concepts and small examples for building GraphQL executable schemas and servers with Leto. Please, if there is something that may be missing from the documentation or you have any question you can make an issue, that would help us a lot.

# GraphQL Schema Types

## Scalars

## Objects

```dart
final type = objectType(
    'ObjectTypeName',
    fields: [],
);
```

- With code generation

```dart


@GraphQLClass()
@JsonSerializable()
class Model {
    final String stringField;
    final int intField;
    final List<Model>? optionalModels;

    const Model({
        required this.stringField,
        required this.intField,
        required this.optionalModels,
    });


}

@Query
Future<Model> getModel(ReqCtx ctx) {

}
```

This would generate graphql_api.schema.dart

```dart

```

## Input Objects

## Unions

Per the GraphQL spec, Unions can't be (or part of) Input types and their possible types can only be GraphQLObjectType.

# Advanced types

## Custom scalars

extend GraphQLScalarType

## Generics

```dart

GraphQLObjectType<ErrC<T?>> errCGraphQlType<T extends Object>(
  GraphQLType<T, Object> tGraphQlType, {
      String? name,
  }
) {
  return objectType(
      name ?? 'ErrC${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}',
      isInterface: false,
      interfaces: [],
      description: null,
    fields: [
      field('message', graphQLString,
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('value', tGraphQlType,
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );
}

class ErrC<T> {
  final String? message;
  final T value;

  const ErrC(this.value, [this.message]);
}

```

- With code generation (derialization with Generic Input types is not yet supported ISSUE // TODO:)

```dart
import 'package:leto/leto.dart';
part 'errc.g.dart';

@GraphQLClass()
class ErrC<T> {
  final String? message;
  final T value;

  const ErrC(this.value, [this.message]);
}

```

Which generates:

```dart

Map<String, GraphQLObjectType<ErrC>> _errCGraphQlType = {};

/// Auto-generated from [ErrC].
GraphQLObjectType<ErrC<T>> errCGraphQlType<T extends Object>(
  GraphQLType<T, Object> tGraphQlType,
) {
  final __name =
      'ErrC${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}';
  if (_errCGraphQlType[__name] != null)
    return _errCGraphQlType[__name]! as GraphQLObjectType<ErrC<T>>;

  final __errCGraphQlType = objectType<ErrC<T>>(
      'ErrC${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}',
      isInterface: false,
      interfaces: [],
      description: null);
  _errCGraphQlType[__name] = __errCGraphQlType;
  __errCGraphQlType.fields.addAll(
    [
      field('message', graphQLString,
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('value', tGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __errCGraphQlType;
}

```

# Subscriptions

`GraphQLObjectField` contains a subscribe function `Stream<T> Function(ReqCtx<P> ctx, P parent)`

```dart

final apiSchema = GraphQLSchema(
    queryType: objectType('Query'),
    subscriptionType: objectType(
        'Subcription',
        fields: [
            graphQLInt.nonNull().fields(
                'secondsSinceSubcription',
                subscribe: (ReqCtx ctx, Object rootValue) {
                    return Stream.periodic(const Duration(seconds: 1), (secs) {
                        return secs;
                    });
                }
            ),
        ]
    ),
);

Future<void> main() async {
    final GraphQLResult result = await GraphQL(apiSchema).parseAndExecute(
        'subscription { secondsSinceSubcription }',
    );

    assert(result.isSubscription);
    final Stream<GraphQLResult> stream = result.subscriptionStream;
    stream.listen((event) {
        final data = event.data as Map<String, Object?>;
        assert(data['secondsSinceSubcription'] is int);

        print(data['secondsSinceSubcription']);
    });
}

```

## Examples

For a complete subscription example with events from a database please see the [chat_example](https://github.com/juancastillo0/leto_graphql/chat_example) in particular the // TODO:

# Web server integrations

## Shelf (https://github.com/juancastillo0/leto_graphql/leto_shelf)

- [HTTP](https://graphql.org/learn/serving-over-http/)/1.1 POST, GET
- [Mutipart requests](https://github.com/jaydenseric/graphql-multipart-request-spec) for file Upload.
- Subscriptions through WebSockets. Supporting [graphql-ws](https://github.com/apollographql/subscriptions-transport-ws/blob/master/PROTOCOL.md) and [graphql-transport-ws](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md) subprotocols
- Batched queries
- TODO: HTTP/2
- TODO: [Server-Sent Events](https://the-guild.dev/blog/graphql-over-sse)

# Solving the N+1 problem

## Lookahead

```dart
@GraphQLClass()
class Model {
    final String id;
    final String name;
    final NestedModel nested;

    const Model(this.id, this.name, this.nested);
}

@GraphQLClass()
class NestedModel {
    final String id;
    final String name;

    const NestedModel(this.id, this.name);
}

final modelRepo = RefWithDefault.global(
    'ModelRepo',
    (GlobalsHolder scope) => ModelRepo();
);

class ModelRepo {
    List<Model> getModels({bool withNested = false}) {
        //
        throw Unimplemented();
    }
}

@Query()
FutureOr<List<Model>> getModels(ReqCtx ctx) {
    final PossibleSelections lookahead = ctx.lookahead();
    assert(!lookahead.isUnion);
    final PossibleSelectionsObject lookaheadObj = lookahead.asObject;
    final withNested = lookaheadObj.contains('nested');

    final ModelRepo repo = modelRepo.get(ctx);
    return repo.getModels(withNested: withNested);
}

```

With this implementaton and given the following queries:

```graphql
query getModelsWithNested {
  getModels {
    id
    name
    nested {
      id
      name
    }
  }
}

query getModelsBase {
  getModels {
    id
    name
  }
}
```

`ModelRepo.getModels` will receive `true` in the `withNested` param for the `getModelsWithNested` query since `lookaheadObj.contains('nested')` will be `true` and the `withNested` param will be `false` for the `getModelsBase` query since the "nested" field was not selected.

## Dataloader

An easier to implement but probably less performant way of solving the N+1 problem is by using a `Dataloader`.

```dart


```

# Extensions

Extensions implement additional funcionalities to the server's parsing, validation and execution. For example, extensions for tracing [GraphQLTracingExtension], logging, error handling or caching [GraphQLPersistedQueries].

## Persisted Queries

Save network bandwith by storing GraphQL documents on the server and not requiring the Client to send the full document String on each request.

More information: https://www.apollographql.com/docs/apollo-server/performance/apq/

## Appolo Tracing

## Response Cache

Client GQL Link implementation in:
// TODO:

- Hash: Similar to HTTP If-None-Match and Etag headers. Computes a hash of the payload (sha1 by default) and returns it to the Client when requested. If the Client makes a request with a hash (computed locally or saved from a previous server response), the extension compares the hash and only returns the full body when the hash do not match. If the hash match, the client already has the last version of the payload.

- MaxAge: If passed a `Cache` object, it will save the responses and compare the saved date with the current date, if the maxAge para is greater than the difference it returns the cached value.

- UpdatedAt: Similar to HTTP If-Modified-Since and Last-Modified headers.

// TODO: retrive hash, updatedAt and maxAge in resolvers.

## Custom Extensions

To create a custom extension you can extends `GraphQLExtension` and override multiple functions which are executed throught a request's parsing, validation and execution.

To save state scoped to a single request you can use the `ScopedMap.setScoped(key, value)` and retrieve the state in a different method with `final value = ScopedMap.get(key);`

The Persisted Queries and Response Cache extensions are implemented in this way.

# Utilities

- [`buildSchema`](https://github.com/juancastillo0/leto_graphql/leto_shelf)

Create a `GraphQLSchema` from a GraphQL Schema Definition String.

- `printSchema`

Trasform a `GraphQLSchema` into a GraphQL Schema Definition String.

- `mergeSchema`

Merge multiple `GraphQLSchema`. The output `GraphQLSchema` contains all the query, mutations and subscription fields from the input schemas. Nested objects are also merged.
