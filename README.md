![Logo](img/leto-logo-white.svg)

<div style="text-align: center">
<hr>
<a href="https://pub.dartlang.org/packages/leto">
  <img src="https://img.shields.io/pub/v/leto.svg" alt="Pub package">
</a>

<a href="https://codecov.io/gh/juancastillo0/leto">
  <img src="https://codecov.io/gh/juancastillo0/leto/branch/main/graph/badge.svg?token=QJLQSCIJ42" alt="Code coverage"/>
</a>

<a href="https://github.com/juancastillo0/leto/actions/workflows/test.yaml">
  <img src="https://img.shields.io/github/checks-status/juancastillo0/leto/main" alt="CI checks"/>
</a>

<a href="https://github.com/juancastillo0/leto/actions/workflows/test.yaml">
  <img src="https://github.com/juancastillo0/leto/actions/workflows/test.yaml/badge.svg"  alt="CI tests"/>
</a>

<a href="https://pub.dev/packages/lint">
  <img src="https://img.shields.io/badge/style-lint-4BC0F5.svg" alt="Lint" />
</a>

<a href="https://github.com/juancastillo0/leto/blob/main/LICENSE">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="Leto is released under the MIT license." />
</a>

<a href="#contributing">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs welcome" />
</a>

</div>

# Leto - GraphQL Server <!-- omit in toc -->

A complete implementation of the official
[GraphQL specification](https://graphql.github.io/graphql-spec/June2018/)
in the Dart programming language.

Inspired by [graphql-js](https://github.com/graphql/graphql-js), [async-graphql](https://github.com/async-graphql/async-graphql) and [type-graphql](https://github.com/MichalLytek/type-graphql). First version of the codebase was forked from [angel-graphql](https://github.com/angel-dart-archive/graphql). Many tests and utilities ([DataLoader](https://github.com/graphql/dataloader), [printSchema](https://github.com/graphql/graphql-js/blob/10c1c3d6cd8e165501fb1471b5babfabd1be1eb1/src/utilities/printSchema.ts)) were ported from graphql-js.

## Table of Contents <!-- omit in toc -->
- [Quickstart](#quickstart)
    - [Install](#install)
    - [Create a `GraphQLSchema`](#create-a-graphqlschema)
    - [Start the server](#start-the-server)
    - [Test the server](#test-the-server)
- [Examples](#examples)
  - [Code Generator example](#code-generator-example)
  - [Fullstack Dart Chat](#fullstack-dart-chat)
    - [Chat functionalities](#chat-functionalities)
  - [Server example](#server-example)
- [Packages](#packages)
- [Web integrations](#web-integrations)
  - [Server integrations](#server-integrations)
    - [Shelf](#shelf)
  - [Web UI Explorers](#web-ui-explorers)
    - [GraphiQL](#graphiql)
    - [Playground](#playground)
    - [Altair](#altair)
  - [Clients](#clients)
- [Documentation](#documentation)
- [GraphQL Schema Types](#graphql-schema-types)
  - [Scalars](#scalars)
  - [Enums](#enums)
  - [Objects](#objects)
    - [Interfaces](#interfaces)
  - [Inputs and Input Objects](#inputs-and-input-objects)
    - [InputObject.fromJson](#inputobjectfromjson)
  - [Unions](#unions)
    - [Freezed Unions](#freezed-unions)
  - [Wrapping Types](#wrapping-types)
  - [Non-Nullable](#non-nullable)
  - [Lists](#lists)
  - [Abstract Types](#abstract-types)
    - [resolveType](#resolvetype)
    - [Generics](#generics)
    - [isTypeOf](#istypeof)
    - [\_\_typename](#__typename)
    - [Serialize and validate](#serialize-and-validate)
  - [Advanced Types](#advanced-types)
    - [Provided Types](#provided-types)
    - [Cyclic Types](#cyclic-types)
    - [Custom Scalars](#custom-scalars)
    - [Generic Types](#generic-types)
- [Resolvers](#resolvers)
  - [Request Contexts](#request-contexts)
    - [Ctx](#ctx)
    - [ObjectExecutionCtx](#objectexecutionctx)
    - [ExecutionCtx](#executionctx)
    - [RequestCtx](#requestctx)
  - [Queries and Mutations](#queries-and-mutations)
  - [Subscriptions](#subscriptions)
    - [Examples](#examples-1)
- [Validation](#validation)
  - [Schema Validation](#schema-validation)
  - [Document Validation](#document-validation)
  - [Input Validation](#input-validation)
  - [Query Complexity](#query-complexity)
  - [Skip validation with Persisted Queries](#skip-validation-with-persisted-queries)
- [Miscellaneous](#miscellaneous)
  - [`GraphQLResult`](#graphqlresult)
  - [`ScopedMap`](#scopedmap)
  - [Error Handling](#error-handling)
    - [Result types](#result-types)
  - [Hot Reload and Cycles](#hot-reload-and-cycles)
- [Solving the N+1 problem](#solving-the-n1-problem)
  - [LookAhead (Eager loading)](#lookahead-eager-loading)
  - [DataLoader (Batching)](#dataloader-batching)
  - [Combining LookAhead with DataLoader](#combining-lookahead-with-dataloader)
- [Extensions](#extensions)
  - [Persisted Queries](#persisted-queries)
  - [Apollo Tracing](#apollo-tracing)
  - [Response Cache](#response-cache)
  - [Logging Extension](#logging-extension)
  - [Map Error Extension](#map-error-extension)
  - [Custom Extensions](#custom-extensions)
- [Directives](#directives)
- [Attachments](#attachments)
- [Utilities](#utilities)
    - [`buildSchema`](#buildschema)
    - [`printSchema`](#printschema)
    - [`extendSchema`](#extendschema)
    - [`introspectionQuery`](#introspectionquery)
    - [`mergeSchemas`](#mergeschemas)
    - [`schemaFromJson`](#schemafromjson)
- [Contributing](#contributing)

# Quickstart

This provides a simple introduction to Leto, you can explore more in the following sections of this README or by looking at the tests, documentation and examples for each package. A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto/tree/main/chat_example

### Install

Add dependencies to your pubspec.yaml

```yaml
dependencies:
  leto_schema: ^0.0.1
  leto: ^0.0.1
  leto_shelf: ^0.0.1
  shelf: ^1.0.0
  shelf_router: ^1.0.0
  # Not nessary for the server, just for testing it
  http: ^1.0.0

dev_dependencies:
  # Only if you use code generation
  leto_generator: ^0.0.1
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
       graphQLString.nonNull().field('stringField',resolve: (Ctx ctx, Model m)
        => m.intField,),
        field('intField', graphqlInt, resolve: (Ctx ctx, Model m)
        => m.intField,
        )
    ],
);

final apiSchema = GraphQLSchema(
    queryType: objectType(
        fields [
modelGraphqlType.field('getModel', resolve: (Ctx ctx, Object rootValue) => const Model(stringField: 'sField', ))
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
String? getState(Ctx ctx) {
  return stateRef.get(ctx);
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

Beside the tests from each package, you can find some usage example in the following directories:


## Code Generator example

An example with multiple ways of creating a GraphQLSchema with different types and resolvers from code generation can be found in https://github.com/juancastillo0/leto/tree/main/leto_generator/example.


## Fullstack Dart Chat

A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto/tree/main/chat_example. The server is in the [server](https://github.com/juancastillo0/leto/tree/main/chat_example/server) folder.

- Sqlite3 and Postgres database integrations
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
- Client cache through [Ferry](https://github.com/gql-dart/ferry) and [Hive](https://github.com/hivedb/hive)
- Create chat rooms, add/remove users and share authorized invite links
- View complete usage history with events for the most important mutations
- View all user sessions

## Server example

A Leto/Shelf server example with multiple models, code generation, some utilities and tests can be found in https://github.com/juancastillo0/leto/tree/main/leto_shelf/example

# Packages

This repository is a monorepo with the following packages

| Pub                                                                  | Source                                                    | Description                                                                                |
| -------------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| [![version][package:leto:version]][package:leto]                     | [`package:leto`][package:leto:source]                     | GraphQL server (executor) implementation, GraphQL extensions and DataLoader                |
| [![version][package:leto_schema:version]][package:leto_schema]       | [`package:leto_schema`][package:leto_schema:source]       | Define GraphQL executable schemas, validate GraphQL documents and multiple utilities       |
| [![version][package:leto_generator:version]][package:leto_generator] | [`package:leto_generator`][package:leto_generator:source] | Generate GraphQL schemas, types and fields from Dart code annotations                      |
| [![version][package:leto_shelf:version]][package:leto_shelf]         | [`package:leto_shelf`][package:leto_shelf:source]         | GraphQL web server bindings and utilities for  [shelf](https://github.com/dart-lang/shelf) |
| [![version][package:leto_links:version]][package:leto_links]         | [`package:leto_links`][package:leto_links:source]         | Client gql links, support for GraphQL extensions defined in package:leto                   |

# Web integrations

## Server integrations

### [Shelf](https://github.com/juancastillo0/leto/tree/main/leto_shelf)

Using the [shelf](https://github.com/dart-lang/shelf) package.

- [HTTP](https://graphql.org/learn/serving-over-http/) POST and GET
- [Mutipart requests](https://github.com/jaydenseric/graphql-multipart-request-spec) for file Upload.
- Subscriptions through WebSockets. Supporting [graphql-ws](https://github.com/apollographql/subscriptions-transport-ws/blob/master/PROTOCOL.md) and [graphql-transport-ws](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md) subprotocols
- Batched queries
- TODO: HTTP/2 example
- TODO: [Server-Sent Events](https://the-guild.dev/blog/graphql-over-sse)

## Web UI Explorers

These web pages will allow you to explore your GraphQL Schema, view all the types and fields, read each element's documentation, and execute requests against a GraphQL server. 

Usually exposed as static HTML in your deployed server. Each has multiple configurations for determining the default tabs, queries and variables, the GraphQL HTTP and WebSocket (subscription) endpoints, the UI's theme and more.

All of the static HTML files and configurations can be found in the [graphql_ui folder](https://github.com/juancastillo0/leto/tree/main/leto_shelf/lib/src/graphql_ui).

### GraphiQL

[Documentation](https://github.com/graphql/graphiql/tree/main/packages/graphiql#readme). Use `graphiqlHandler`. The classic GraphQL explorer
### Playground

[Documentation](https://github.com/graphql/graphql-playground). Use `playgroundHandler`. Support for multiple tabs, subscriptions.
### Altair

[Documentation](https://github.com/altair-graphql/altair). Use `altairHandler`. Support for file Upload, multiple tabs, subscriptions, plugins.


## Clients

For a complete GraphQL client you probably want to use:

- Ferry (https://github.com/gql-dart/ferry)
- Artemis (https://github.com/comigor/artemis)
- or raw gql Links (https://github.com/gql-dart/gql/tree/master/links)
  
  gql Links are used by Ferry and Artemis, both of which provide additional functionalities over raw gql Links like serialization and deserialization, code generation, type safety, normalized caching and more.

# Documentation

The following sections introduce most of the concepts and small examples for building GraphQL executable schemas and servers with Leto. Please, if there is something that may be missing from the documentation or you have any question you can make an issue, that would help us a lot.

# GraphQL Schema Types

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Schema)

The GraphQL schema type systems provides 

## Scalars

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Scalars)

Standard `GraphQLScalarType`s: String, Int, Float, Boolean and ID types are already implemented and provided by Leto.

Other scalar types are also provided:

- Json: a raw JSON value with no type schema. Could be a Map<String, Json>, List<Json>, num, String, bool or null.
- Uri: Dart's Uri class, serialized using `Uri.toString` and deserialized with `Uri.parse`
- Date: Uses the `DateTime` Dart class. Serialized as an [ISO-8601](https://en.wikipedia.org/wiki/ISO_8601) String and de-serialized with `DateTime.parse`.
- Timestamp: same as Date, but serialized as an UNIX timestamp.
- Time: // TODO:
- Duration: // TODO:
- Upload: a file upload. The [multipart request spec](https://github.com/jaydenseric/graphql-multipart-request-spec)

To provide your own or support types from other packages you can use [Custom Scalars](#custom-scalars).

## Enums

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Enums)

Enums are text values which are restricted to a set of predefined variants. Their behavior is similar to scalars and they don't have a nested fields.

They require a unique name and a set of entries mapping their string representation to the Dart value obtained after parsing.

```graphql
"""The error reason on a failed sign up attempt"""
enum SignUpError {
    usernameTooShort,
    usernameNotFound,
    wrongPassword,
    passwordTooSimple,
}
```

```dart
import 'package:leto/leto.dart';

final signUpErrorGraphQLType = enumTypeFromStrings(
'SignUpError', [
    'usernameTooShort',
    'usernameNotFound',
    'wrongPassword',
    'passwordTooSimple',
  ],
  description: 'The error reason on a failed sign up attempt',
);


// Or with code generation

/// The error reason on a failed sign up attempt
@GraphQLClass()
enum SignUpError {
    usernameTooShort,
    usernameNotFound,
    wrongPassword,
    passwordTooSimple,
}

```
## Objects

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Objects)

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
Future<Model> getModel(Ctx ctx) {

}
```

This would generate graphql_api.schema.dart

```dart

```


### Interfaces

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Interfaces)

- inheritFrom

The `inheritFrom` function in `GraphQLObjectType` receives an Interface and assigns it's argument as  
a super type, now the Object will implement the Interface passed as parameter.

## Inputs and Input Objects

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Input-Objects)

Scalars and Enums can be passed as input to resolvers. Wrapper types such as List and NonNull types of Scalars and Enums, also can be passed, however for more complex Objects with nested fields you will need to use `GraphQLInputObjectType`. Similar `GraphQLObjectType`, a `GraphQLInputObjectType` can have fields.

// TODO: customDeserialize with SerdeCtx deserializers

```dart
final inputModel = GraphQLInputObjectType(
    'ModelInput',
    description: '',
    inputs: [

    ],
);
```

Field inputs (or Arguments) can be used in multiple places:

- `GraphQLObjectType.fields.inputs`: Inputs in field resolvers

- `GraphQLInputObjectType.fields`: Fields in Input Objects

- `GraphQLDirective.inputs`: Inputs in directives

Not all types can be input types, in particular, object types and union types can't be input types nor part of a `GraphQLInputObjectType`.

```dart
static bool isInputType(GraphQLType type) {
  return type.when(
    enum_: (type) => true,
    scalar: (type) => true,
    input: (type) => true,
    object: (type) => false,
    union: (type) => false,
    list: (type) => isInputType(type.ofType),
    nonNullable: (type) => isInputType(type.ofType),
  );
}
```

### Example <!-- omit in toc -->

```graphql
input ComplexInput {
    value: String!
}

# The fields:
(
    """The amount"""
    @deprecated
    amount: Int = 2
    names: [String!]
    complex: ComplexInput!
)
```

```dart

@GraphQLInput()
class ComplexInput {
    const ComplexInput({required this.value});
    /// The value
    final String value;

    factory ComplexInput.fromJson(Map<String, Object?> json) =>
        ComplexInput(
            value: json['value']! as String,
        );
}

final fields = [
    GraphQLFieldInput(
        'amount',
        graphQLInt,
        defaultValue: 2,
        description: 'The amount',
        // an empty String will use the default deprecation reason
        deprecationReason: '',
    ),
    GraphQLFieldInput(
        'names',
        listOf(graphQLString.nonNull()),
    ),
    GraphQLFieldInput(
        'complex',
        compleInputGraphQLInputType.nonNull(),
    ),
];

// can be used in:
// - `GraphQLObjectType.fields.inputs`
// - `GraphQLInputObjectType.fields`
// - 'GraphQLDirective.inputs'

final object = GraphQLObjectType(
    'ObjectName',
    fields: [
        stringGraphQLType.field(
            'someField',
            inputs: fields,
            resolve: (_, Ctx ctx) {
                final Map<String, Object?> args = ctx.args;
                assert(args.containKey('complex'));
                assert(args['names'] is List<String>?);
                assert(args['amount'] is int?);
                return '';
            }
        )
    ]
);

final objectInput = GraphQLInputObjectType(
    'InputObjectName',
    fields: fields,
    // ...
);

final directive = GraphQLDirective(
    name: 'DirectiveName',
    inputs: fields,
    // ...
);
```

### InputObject.fromJson

For code generation, each class annotated as `GraphQLInput` should have a factory constructor or static method name `fromJson` in its class definition. This will be used as the method for deserializing instances of this class.

## Unions

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Unions)

Similar to enums, Unions are restricted to a set of predefined variants, however the possible types are always the more complex `GraphQLObjectType`.

Per the GraphQL spec, Unions can't be (or be part of) Input types and their possible types is a non empty collection of unique `GraphQLObjectType`.

To have the following GraphQL type definitions:

```graphql
union ModelEvent = ModelAdded | ModelRemoved

type ModelRemoved {
  "The removed model id"
  modelId: ID!
}

type ModelAdded {
  model: Model!
}

type Model {
  id: ID!
}
```

You could provide this definitions:

```dart
import 'package:leto_schema/leto_schema.dart';

final model = objectType(
    'Model',
    fields: [
        graphQLIdType.nonNull().field('id'),
    ],
);
final modelAddedGraphQLType = objectType(
    'ModelAdded',
    fields: [model.nonNull().field('model')],
);
final modelRemovedGraphQLType = objectType(
    'ModelRemoved',
    fields: [graphQLIdType.nonNull().field('modelId')],
);

final union = GraphQLUnionType(
    // name
    'ModelEvent',
    // possibleTypes
    [
       modelAddedGraphQLType,
       modelRemovedGraphQLType,
    ],
);
```

- `extractInner`

When the members of the union type are not

### Freezed Unions

With code generation, Unions with [freezed](https://github.com/rrousselGit/freezed) also work without trouble.

```dart
import 'package:leto_schema/leto_schema.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@GraphQLClass()
class Model {
  final String id;

  const Model(this.id);
}

@GraphQLClass()
@freezed
class ModelEvent with _$ModelEvent {
  const factory ModelEvent.added(Model model) = ModelAdded;
  const factory ModelEvent.removed(
    @GraphQLDocumentation(type: 'graphQLIdType', description: 'The removed model id')
    String modelId,
    // you can also provide a private class
  ) = _ModelRemoved;
}
```

<!-- include{unions-example-generator} -->
```dart
GraphQLAttachments unionNoFreezedAttachments() => const [ElementComplexity(50)];

@AttachFn(unionNoFreezedAttachments)
@GraphQLDocumentation(
  description: '''
Description from annotation.

Union generated from raw Dart classes
''',
)
@GraphQLUnion(name: 'UnionNoFreezedRenamed')
class UnionNoFreezed {
  const factory UnionNoFreezed.a(String value) = UnionNoFreezedA.named;
  const factory UnionNoFreezed.b(int value) = UnionNoFreezedB;
}

@GraphQLClass()
class UnionNoFreezedA implements UnionNoFreezed {
  final String value;

  const UnionNoFreezedA.named(this.value);
}

@GraphQLClass()
class UnionNoFreezedB implements UnionNoFreezed {
  final int value;

  const UnionNoFreezedB(this.value);
}

@Query()
List<UnionNoFreezed> getUnionNoFrezzed() {
  return const [UnionNoFreezed.a('value'), UnionNoFreezed.b(12)];
}
```
<!-- include-end{unions-example-generator} -->

## Wrapping Types

Wrapping types allow you to represent a collection of values. This values can be of any `GraphQLType` and List types can be Output or Input Types if the Wrapped type is an Output or Input type. 

## Non-Nullable

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Non-Null)

`GraphQLNonNullType` allows you to represent a non-nullable or required value. By default, all GraphQL Types are nullable or optional, if you want to represent a required input or specify that a given output is always present (non-null), you want to use the `GraphQLNonNullType` wrapping type.

In GraphQL this is represented using the `!` exclamation mark after a given type expression. In Dart you can use the `nonNull()` function present in each `GraphQLType`, which will return a non-nullable `GraphQLNonNullType` with it's inner type, the type from which `nonNull` was called. For example, `graphQLString.nonNull()` will be a `String!` in GraphQL.

## Lists

[GraphQL Specification](http://spec.graphql.org/draft/#sec-List)

`GraphQLListType` allows you to represent a collection of values.

This values can be of any `GraphQLType` and List types can be Output or Input Types if the Wrapped type is an Output or Input type. For example, a List of Union types is an Output type while a List of Strings (scalar types) can be an Output or Input type.

In GraphQL, you can present it like this:

```graphql
type Model {
  listField(listInput: [String]!): [InterfaceModel!]
}

interface InterfaceModel {
  name: String
}
```

Using Dart:

```dart
import 'package:leto_schema/leto_schema.dart';

abstract class InterfaceModel {
  String get name;
}

class Model {
  List<InterfaceModel>? list(List<String?> listInput) {
    throw Unimplemented();
  }
}

final interfaceModel = objectType<InterfaceModel>(
  'InterfaceModel',
  fields: [
    graphQLString.field(
      'name',
      resolve: (InterfaceModel obj, Ctx ctx) => obj.name,
    )
  ],
  isInterface: true,
);

final model = objectType<Model>(
  'Model',
  fields: [
    interfaceModel.nonNull().list().field(
      'listField',
      inputs: [
        listOf(graphQLString).nonNull().inputField('listInput'),
      ],
      resolve: (Model obj, Ctx ctx) => 
        obj.listField(ctx.args['listInput'] as List<String?>) 
    )
  ]
);

```

With code generation, you just annotate the different classes with `@GraphQLClass()` and the fields and models containing Dart Lists will be generated using `GraphQLListType`s.

```dart
import 'package:leto_schema/leto_schema.dart';

@GraphQLClass()
abstract class InterfaceModel {
  String get name;
}

@GraphQLClass()
class Model {
  List<InterfaceModel>? list(List<String?> listInput) {
    throw Unimplemented();
  }
}
```

## Abstract Types

Abstract types like Interfaces and Unions, require type resolution of its variants on execution. For that, we provide a couple of tools explained in the following sections. You can read the code that executes the following logic in package:leto `GraphQL.resolveAbstractType`.

### resolveType

A parameter of Interface and Union types is a function with the signature: `String Function(Object result, T abstractType, ResolveObjectCtx ctx)`. Given a resolved result, the abstract type itself and the ObjectCtx, return the name of the type associated with the result value.

### Generics

We compare the resolved result's Dart type with the possible types generic type parameter, if there is only one match (withing the possible types), that will be the resolved type. This happens very often, specially with code generation or when providing a distinct class for each `GraphQLObjectType`.

This can't be used with Union types which are wrappers over the inner types (like `Result<V, E>` or `Either<L, R>`), since generic type of the possible types (`V` and `E`) will not match the wrapper type (`Result`). For this cases you will need to provide a `resolveType` and `extractInner` callbacks. With freezed-like unions you don't have to do that since the variants extend the union type.

### isTypeOf

If any of the previous fail, you can provide a `isTypeOf` callback for objects, which determine whether a given value is an instance of that `GraphQLObjectType`.

### \_\_typename

If the resolved result is a `Map` and contains a key "\_\_typename", we will use it to resolve the type by comparing it with possible types names. If there is a match, we use the matched type in the next steps of execution.

### Serialize and validate

## Advanced Types

### Provided Types


- PageInfo: Following the [relay connections spec](https://relay.dev/graphql/connections.htm).


### Cyclic Types

Types which use themselves in their definition have to reuse previously created instances. The type's field lists are mutable, which allow you to instantiate the type and then modify the fields of the type. For example, an User with friends:

```dart
class User {
    const User(this.friends);
    final List<User> friends;
}
GraphQLObjectType<User>? _type;
GraphQLObjectType<User> get userGraphQLType {
    if (_type != null) return _type; // return a previous instance
    final type = objectType<User>(
        'User',
        // leave fields empty (or don't pass them)
        fields: [],
    );
    _type = type; // set the cached value
    type.fields.addAll([ // add the fields
        listOf(userGraphQLType.nonNull()).nonNull().field(
            'friends',
            resolve: (obj, _) => obj.friends,
        ),
    ]);
    return type;
}
```

Code generation already does it, so you don't have to worry about it when using it.

### Custom Scalars

You can extend the `GraphQLScalarType` or create an instance directly with `GraphQLScalarTypeValue`. For example, to support the `Decimal` type from https://github.com/a14n/dart-decimal you can use the following code:

```dart
import 'package:decimal/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

final decimalGraphQLType = GraphQLScalarTypeValue<Decimal, String>(
  name: 'Decimal',
  deserialize: (SerdeCtx _, String serialized) => Decimal.parse(serialized),
  serialize: (Decimal value) => value.toString(),
  validate: (String key, Object? input) => (input is num || input is String) &&
          Decimal.tryParse(input.toString()) != null
      ? ValidationResult.ok(input.toString())
      : ValidationResult.failure(
          ['Expected $key to be a number or a numeric String.'],
        ),
  description: 'A number that allows computation without losing precision.',
  specifiedByURL: null,
);

```

For code generation you need to provide `customTypes` in the [build.yaml](https://github.com/dart-lang/build/blob/master/docs/faq.md) file of you project:

```yaml
target:
    default:
        builders:
            leto_generator:
                options:
                    customTypes:
                        - name: "Decimal"
                        import: "package:<your_package_name>/<path_to_implementation>.dart"
                        getter: "fe"

```

### Generic Types

Work in progress

```dart

class ErrC<T> {
  final String? message;
  final T value;

  const ErrC(this.value, [this.message]);
}

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
          resolve: (obj, ctx) => obj.message,),
      field('value', tGraphQlType,
          resolve: (obj, ctx) => obj.value,)
    ],
  );
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

Which generates in 'errc.g.dart':

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

# Resolvers

## Request Contexts
### Ctx

[Source Code](https://github.com/juancastillo0/leto/blob/main/leto_schema/lib/src/req_ctx.dart)

A unique context for each field resolver

- args: the arguments passed as inputs to this field
- object: the parent Object's value, same as the first parameter of `resolve`.
- objectCtx: the parent Object's execution context ([ObjectExecutionCtx](#objectexecutionctx))
- field: The `GraphQLObjectField` being resolved
- path: The path to this field
- executionCtx: The request's execution context ([ExecutionCtx](#executionctx))
- lookahead: A function for retrieving nested selected fields. More in the [LookAhead section](#lookahead-eager-loading)

### ObjectExecutionCtx

### ExecutionCtx

### RequestCtx

## Queries and Mutations

Each field (`GraphQLObjectField`) in an object type (`GraphQLObjectType`) contains a `resolve` parameter this will be used to resolve all fields. The first argument to `resolve` with be the parent object, if this field is in the root Query or Mutation Object, the value will be the the root value passed as an argument to `GraphQL.parseAndExecute` and a `SubscriptionEvent` if this is a subscription field (more in the [subscription](#subscriptions) section). 

To

```graphql
type Query {
  someField: String
}

type CustomMutation {
  updateSomething(arg1: Float): Date
}

"""An ISO-8601 Date."""
scalar Date

type schema {
  query: Query
  mutation: CustomMutation
}

```

In Dart:

```dart

final query = objectType(
  'Query',
  fields: [
    graphQLString.field(
      'someField',
      resolve: (Object? rootObject, Ctx ctx) => 'someFieldOutput',
    ),
  ],
);

final customMutation = objectType(
  'CustomMutation',
  fields: [
    graphQLDate.field(
      'updateSomething',
      inputs: [
        graphQLFloat.inputField('arg1')
      ],
      resolve: (Object? rootObject, Ctx ctx) {
        final arg1 = ctx.args['arg1'] as double?;
        return DateTime.now();
      },
    ),
  ],
);

final schema = GraphQLSchema(
  queryType: query,
  mutation: customMutation,
);

```


When using `package:leto_shelf`, POST requests can be used for Queries or Mutations. However, GET requests can only be used for Queries, if a Mutation operation is sent using a GET request, the server will return 405 (MethodNotAllowed) following the [GraphQL over HTTP specification](https://github.com/graphql/graphql-over-http/blob/main/spec/GraphQLOverHTTP.md).


## Subscriptions

Each field (`GraphQLObjectField`) in an object type (`GraphQLObjectType`) contains a `subscribe` parameter that receives the root value and a `Ctx`, and returns a Stream of values of the field's type `Stream<T> Function(Ctx<P> ctx, P parent)`. The Stream of values will be returned in the `data` field of the `GraphQLResult` returned in execution.

You can only 

If using a WebSocket server, the client should support either `graphql-transport-ws` or `graphql-ws` sub-protocols.

```dart

final apiSchema = GraphQLSchema(
    queryType: objectType('Query'),
    subscriptionType: objectType(
        'Subcription',
        fields: [
            graphQLInt.nonNull().fields(
                'secondsSinceSubcription',
                subscribe: (Ctx ctx, Object rootValue) {
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
    final Stream<GraphQLResult> stream = result.subscriptionStream!;
    stream.listen((event) {
        final data = event.data as Map<String, Object?>;
        assert(data['secondsSinceSubcription'] is int);

        print(data['secondsSinceSubcription']);
    });
}

```

The `resolve` callback in a subscription field will always receive a `SubscriptionEvent` as it's parent.
From that you can access the event value with `SubscriptionEvent.value` which will be the emitted by the Stream returned in the `subscribe` callback. The error handling in each callback is different, if an error is thrown in the `subscribe` callback, the Stream will end with an error. But if you throw an error in the `resolve` callback it will continue sending events, just the event resolved with a thrown Object will have `GraphQLError`s as a result of processing the thrown Object (More information in [Error Handling](#error-handling)).

For usage in a web server you can use any of the [web server integrations](#web-integrations) which support WebSocket subscriptions (For example, [leto_shelf](https://github.com/juancastillo0/leto/tree/main/leto_shelf)).

### Examples

For a complete subscriptions example with events from a database please see the [chat_example](https://github.com/juancastillo0/leto/tree/main/chat_example), in particular the [events](https://github.com/juancastillo0/leto/tree/main/chat_example/server/lib/events) directory.


# Validation

## Schema Validation

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Type-System)

Implements the "Type Validation" sub-sections of the specification's "Type System" section.

Guaranties that the `GraphQLSchema` instance is valid, verifies the Type System validations in the specification. For example, an Object field's type can only be an Output Type or an Union should have at least one possible type and all of them have to be Object types.

This will be executed before stating a GraphQL server. Leto implements all of the Specification's schema validation. The code for all rules can be found in the [validate_schema.dart](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/validate/validate_schema.dart) file in `package:leto_schema`.

## Document Validation

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Validation)

This will be executed before executing any request. Leto implements all of the Specification's document validation. The code for all rules can be found in the [validate](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/validate) folder in `package:leto_schema`.


## Input Validation

daw

## Query Complexity

[Tests](https://github.com/juancastillo0/leto/tree/main/leto_schema/test/validation/query_complexity_test.dart)

This document validation rule allows you to restrict the complexity of a GraphQL request.


The provided `queryComplexityRuleBuilder` returns a `ValidationRule` that reports errors when the `maxComplexity` or `maxDepth` configuration parameters are reached.

- `maxComplexity`

Specifies the maximum complexity for a given operation. The complexity is measured based on the selected fields and should be. If this complexity is surpassed (is greater) a validation error will be reported.

- `maxDepth`

Specifies the maximum depth for a given operation. The depth is defined as the number of objects (including the root operation object) that have to be traversed to arrive to a given field. If this depth is surpassed (is greater) a validation error will be reported.


The complexity for each fieldNode is given by:

`complexity = fieldComplexity + (childrenComplexity + fieldTypeComplexity) * complexityMultiplier`

Where fieldComplexity is the `ElementComplexity` in
`GraphQLObjectField.attachments` or `defaultFieldComplexity`
if there aren't any.

childrenComplexity is:
- scalar or enum (leaf types): 0
- object or interface: sum(objectFieldsComplexities)
- union: max(possibleTypesComplexities)

fieldTypeComplexity will be taken as the `ElementComplexity`
from `GraphQLNamedType.attachments` or 0 if there aren't any.

If the fieldType is a `GraphQLListType`, complexityMultiplier
will be the provided `listComplexityMultiplier`, otherwise 1.

## Skip validation with Persisted Queries

Using the `PersistedQueriesExtensions` you can set the `skipValidation` parameter so that the validation is skipped for already cached (and validated) documents.

# Miscellaneous

## `GraphQLResult`

[GraphQL Specification](http://spec.graphql.org/draft/#sec-Response)

The returned `GraphQLResult` is the output of the execution of a GraphQL request it contains the encountered `GraphQLError`s, the output `extensions` and the `data` payload. The `GraphQLResult.toJson` Map is used by `package:leto_shelf` when constructing an HTTP response's body.

- The `data` is a `Map<String, Object?>?` for Queries and Mutations or a `Stream<GraphQLResult>` for subscriptions. It has the payload returned by the resolvers during execution. Will be null if there was an error in validation or in the execution of a non-nullable root field. If there was an error in validation, the `data` property will not be set in the `GraphQLResult.toJson` Map following the [spec](http://spec.graphql.org/draft/#sec-Response).
  
- The `errors` contain the `GraphQLError`s encountered during validation or execution. If a resolver throws an error, it will appear in this error list. If the field's return type is nullable, a null value will be set as the output for that field. If the type is non-nullable the resolver will continue to throw an exception until a nullable field is reached or the root resolver is reached (in this case the `GraphQLResult.data` property will be null).

- The `extensions` is a  `Map<String, Object?>?` with custom values that you may want to provide to the client. All values should be serializable since they may be returned as part of an HTTP response. Most `GraphQLExtensions` modify this values to provide additional functionalities. The keys for the `extensions` Map should be unique, you may want to prefix them with an identifier such as a package name.

## `ScopedMap`

da

## Error Handling

daw

### Result types

- Result

- ResultU

## Hot Reload and Cycles

Since type and field schema definitions should probably be reused, this may pose a conflict to the beautifully hot reload capabilities of Dart. The cached instances will not change unless you execute the more expensive hot restart, which may also cause you to lose other state when developing.

Because of this, we provide an utility class `HotReloadableDefinition` that handles definition caching, helps with cycles in instantiation and controls the re-instantiation of values. It receives a `create` function that should return a new instance of the value. This value will be cached and reused throughout the schema's construction. To retrieve the current instance you can use the `HotReloadableDefinition.value` getter. 

The provided `create` function receives a `setValue` callback that should be called right after the instance's creation (with the newly constructed instance as argument), this is only necessary if the instance definition may contain cycles.

To re-instantiate all values that use `HotReloadableDefinition` you can execute the static `HotReloadableDefinition.incrementCounter` which will invalidate previously created instances, if you call `HotReloadableDefinition.value` again, a new instance will be created with the, potentially new, hot reloaded code.

When using code generation all schema definitions use the `HotReloadableDefinition` class to create type and field instances, you only need to call the generated `recreateGraphQLApiSchema` function to instantiate the `GraphQLSchema` each time the application hot reloads.

You can use other packages to hot reload the dart virtual machine (vm), for example:

- If using shelf you may want to try https://pub.dev/packages/shelf_hotreload. Most shelf examples in this repository already use this package.
  
- You could also search in https://pub.dev or try https://pub.dev/packages/hotreloader, which is used by `package:shelf_hotreload`.


# Solving the N+1 problem

When fetching nested fields, a specific resolvers could be executed multiple times for each request since the parent object will execute it for all its children. This may pose a problem when the resolver has to do non-trivial work for each execution. For example, retrieving a row from a database. To solve this problem, Leto provides you with two tools: LookAhead and DataLoader.

## LookAhead (Eager loading)

You can mitigate the N+1 problem by fetching all the necessary information from the parent's resolver so that when the nested fields are executed they just return the previously fetch items. This would prevent all SQL queries for nested fields since the parent resolver has all the information about the selected nested fields and can use this to execute a request that fetches the necessary columns or joins.

```dart
@GraphQLClass()
class Model {
    final String id;
    final String name;
    final NestedModel? nested;

    const Model(this.id, this.name, this.nested);
}

@GraphQLClass()
class NestedModel {
    final String id;
    final String name;

    const NestedModel(this.id, this.name);
}

final modelRepo = RefWithDefault.global(
    (GlobalsHolder scope) => ModelRepo();
);

class ModelRepo {
    List<Model> getModels({bool withNested = false}) {
        // request the database
        // if `withNested` = true, join with the `nestedModel` table
        throw Unimplemented();
    }
}

@Query()
FutureOr<List<Model>> getModels(Ctx ctx) {
    final PossibleSelections lookahead = ctx.lookahead();
    assert(!lookahead.isUnion);
    final PossibleSelectionsObject lookaheadObj = lookahead.asObject;
    final withNested = lookaheadObj.contains('nested');

    final ModelRepo repo = modelRepo.get(ctx);
    return repo.getModels(withNested: withNested);
}

```

With this implementation and given the following queries:

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

`ModelRepo.getModels` will receive `true` in the `withNested` param for the `getModelsWithNested` query since `lookaheadObj.contains('nested')` will be `true`. On the other hand, the `withNested` param will be `false` for the `getModelsBase` query since the "nested" field was not selected.

In this way, `ModelRepo.getModels` knows what nested fields it should return. It could add additional joins in a SQL query, for example.

The `PossibleSelections` class has the information about all the nested selected fields when the type of the field is a Composite Type (Object, Interface or Union). When it's an Union, it will provide a map from the type name Object variants to the given variant selections. The @skip and @include directives are already taken into account. You can read more about the `PossibleSelections` class in the [source code](https://github.com/juancastillo0/leto/blob/main/leto_schema/lib/src/req_ctx.dart).

## DataLoader (Batching)

The code in Leto is a port of [graphql/dataloader](https://github.com/graphql/dataloader).

An easier to implement but probably less performant way of solving the N+1 problem is by using a `DataLoader`. It allows you to batch multiple requests and execute the complete batch in a single function call.

```dart

@GraphQLClass()
class Model {
    final String id;
    final String name;
    final int nestedId;

    const Model(this.id, this.name, this.nestedId);

    NestedModel nested(Ctx ctx) {
        return modelNestedRepo.get(ctx).getNestedModel(nestedId);
    }
}

class NestedModelRepo {

  late final dataLoader = DataLoader.unmapped<String, NestedModel>(getNestedModelsFromIds);

  Future<List<NestedModel>> getNestedModel(String id) {
    // Batch the id, eventually `dataLoader` will execute
    // `getNestedModelsFromIds` with a list of batched ids
    return dataLoader.load(id);
  }

  Future<List<NestedModel>> getNestedModelsFromIds(List<String> ids) {
      // Multiple calls to `Model.nested` will be batched and
      // all ids will be passed in the `ids` argument

      // request the database
      final List<NestedModel> models = throw Unimplemented();

      // Make a map from id to model instance
      final Map<String, NestedModel> modelsMap = models.fold(
        {}, (map, model) => map..[model.id] = model
      );
      // Return the models in the same order as the `ids` argument
      return List.of(ids.map((id) => modelsMap[id]!));
  }
}

final modelNestedRepo = RefWithDefault.global(
    (scope) => NestedModelRepo()
);


@Query()
List<Model> getModels(Ctx ctx) {
    return modelRepo.get(ctx).getModels();
}

```

The DataLoader has some options for configuring it. For example you can specify the maximum size of the batch (default: `2^53` or the maximum javascript integer), whether to batch requests or not (default: `true`) and provide a custom batch schedule function, by default it will use `Future.delayed(Duration.zero, executeBatch)`.

You can also configure caching by providing a custom cache implementation, a custom function that maps the key passed to `DataLoader.load` to the cache's key or disabling caching in the DataLoader.

## Combining LookAhead with DataLoader

You can use both, LookAhead and DataLoader at the same time. The keys provided to the `DataLoader.load` function can be anything, so you could send the `PossibleSelection` information, for example.


# Extensions

Extensions implement additional functionalities to the server's parsing, validation and execution. For example, extensions for tracing ([GraphQLTracingExtension](#apollo-tracing)), logging ([GraphQLLoggingExtension](#logging-extension)), error handling or caching ([GraphQLPersistedQueries](#persisted_queries) and [GraphQLCacheExtension](#response_cache)). All extension implementations can be found in the [extensions](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions) folder in `package:leto`.

## Persisted Queries

Save network bandwidth by storing GraphQL documents on the server and not requiring the Client to send the full document String on each request.

More information: https://www.apollographql.com/docs/apollo-server/performance/apq/

[Source code](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/persisted_queries.dart)

## Apollo Tracing

Trace the parsing, validation and execution of your GraphQL server to monitor execution times of all GraphQL requests.

More information: https://github.com/apollographql/apollo-tracing

[Source code](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/tracing.dart)

## Response Cache

Utility for caching responses in your GraphQL server and client.

Client GQL Link implementation in:
// TODO:

- Hash: Similar to HTTP If-None-Match and Etag headers. Computes a hash of the payload (sha1 by default) and returns it to the Client when requested. If the Client makes a request with a hash (computed locally or saved from a previous server response), the extension compares the hash and only returns the full body when the hash do not match. If the hash match, the client already has the last version of the payload.

- MaxAge: If passed a `Cache` object, it will save the responses and compare the saved date with the current date, if the maxAge para is greater than the difference, it returns the cached value without executing the field's resolver.

- UpdatedAt: Similar to HTTP If-Modified-Since and Last-Modified headers.

// TODO: retrive hash, updatedAt and maxAge in resolvers.


[Source code](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/cache_extension.dart)

## Logging Extension

The logging extension allows you monitor requests and responses executed by your server.

Provides some utilities for printing and retrieving information from execution, logging errors and provides a default `GraphQLLog` class that contains aggregated information about the request.

[Source code](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/logging_extension.dart)

## Map Error Extension

Simple extension for mapping an error catched on resolver execution. 

With a function that receives the thrown error and some context as parameter and returns a `GraphQLException?`, this extension will override the error and pass it to the executor, which will eventually return it to the user as an error in the response's `errors` list.

[Source code](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/map_error_extension.dart)

## Custom Extensions

To create a custom extension you can extend [`GraphQLExtension`](https://github.com/juancastillo0/leto/blob/main/leto/lib/src/extensions/extension.dart) and override the necessary functions, all of which are executed throughout a request's parsing, validation and execution.

To save state scoped to a single request you can use the `ScopedMap.setScoped(key, value)` and retrieve the state in a different method with `final value = ScopedMap.get(key);`. Where the `ScopedMap` can be accessed with `ctx.globals`.

All extensions are implemented in this way, so you can look at the source code for some examples.

# Directives

For more information: [GraphQL specification](http://spec.graphql.org/draft/#sec-Type-System.Directives)


[`GraphQLDirective`](https://github.com/juancastillo0/leto/blob/main/leto_schema/lib/src/directive.dart) allows you to provide more information about different elements of your schema and queries.

The default skip, include, deprecated and specifiedBy directives are provided. Fields in the different type system definition classes allow you to include the deprecated reason for fields or enum values, and a url of the specification for scalar types. This information will be printed when using the `printSchema` utility, can be retrieved in Dart through GraphQL extension for modifying the behavior of request execution or, if introspection is enabled, will be exposed by the GraphQL server.

The skip and include directives are supported during document execution following the spec. Right now, custom directives on execution can be obtained by using the parsed `DocumentNode` from package:gql, in the future better support could be implemented.

Provide custom directives supported by your server through the 
`GraphQLSchema.directives` field.

You can retrieve custom directives values in your GraphQL Schema definition when using the `buildSchema` utility, which will parse all directives and leave them accessible through the `astNode` Dart fields in the different GraphQL elements. Setting custom directives values through the GraphQL Schema Dart classes is a work in progress. Right now, you can add `DirectiveNode`s to the element's [attachments](#attachments) if you want to print it with `printSchema`, however the api will probably change. See https://github.com/graphql/graphql-js/issues/1343

# Attachments

This api is experimental.

All GraphQL elements in the schema can have addition custom attachments. This can be used by other libraries or extensions to change the behavior of execution. For example, for supporting custom input validations or configuring the max age for some fields in an extension that caches responses.



# Utilities

Most GraphQL utilities can be found in the [`utilities`](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/utilities) folder in package:leto_schema.

### [`buildSchema`](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/utilities/build_schema.dart)

Create a `GraphQLSchema` from a GraphQL Schema Definition (SDL) document String.

### [`printSchema`](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/utilities/print_schema.dart)

Transform a `GraphQLSchema` into a String in the GraphQL Schema Definition Language (SDL).


### [`extendSchema`](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/utilities/extend_schema.dart)

Experimental. Extend a `GraphQLSchema` with an SDL document. This will return an extended `GraphQLSchema` with the additional types, fields, inputs and directives provided in the document.

### [`introspectionQuery`](https://github.com/juancastillo0/leto/tree/main/leto_schema/lib/src/utilities/introspection_query.dart)

Create an introspection document query for retrieving Schema information from a GraphQL server.

### [`mergeSchemas`](https://github.com/juancastillo0/leto/blob/main/leto_shelf/example/lib/schema/graphql_utils.dart)

Experimental. Merge multiple `GraphQLSchema`. The output `GraphQLSchema` contains all the query, mutations and subscription fields from the input schemas. Nested objects are also merged.


### [`schemaFromJson`](https://github.com/juancastillo0/leto/blob/main/leto_shelf/example/lib/schema/schema_from_json.dart)

Experimental. Build a GraphQLSchema from a JSON value, will add query, mutation, subscription and custom events on top of the provided JSON value. Will try to infer the types from the JSON structure.


# Contributing

Thanks for considering making a contribution! Every issue or question helps!

This package uses [melos](https://github.com/invertase/melos) to manage dependencies. To install it run:

```
pub global activate melos
```

Then, to link the local packages run:

```
melos bootstrap
```

If using fvm, you may need to run:

```
fvm flutter pub global run melos bootstrap
```

[package:leto:source]: ./leto
[package:leto]: https://pub.dartlang.org/packages/leto
[package:leto:version]: https://img.shields.io/pub/v/leto.svg
[package:leto_schema:source]: ./leto_schema
[package:leto_schema]: https://pub.dartlang.org/packages/leto_schema
[package:leto_schema:version]: https://img.shields.io/pub/v/leto_schema.svg
[package:leto_generator:source]: ./leto_generator
[package:leto_generator]: https://pub.dartlang.org/packages/leto_generator
[package:leto_generator:version]: https://img.shields.io/pub/v/leto_generator.svg
[package:leto_shelf:source]: ./leto_shelf
[package:leto_shelf]: https://pub.dartlang.org/packages/leto_shelf
[package:leto_shelf:version]: https://img.shields.io/pub/v/leto_shelf.svg
[package:leto_links:source]: ./leto_links
[package:leto_links]: https://pub.dartlang.org/packages/leto_links
[package:leto_links:version]: https://img.shields.io/pub/v/leto_links.svg