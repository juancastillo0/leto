[![Pub](https://img.shields.io/pub/v/leto_schema.svg)](https://pub.dartlang.org/packages/leto_schema)

# Leto Schema

An implementation of GraphQL's type system in Dart. Supports any platform where Dart runs.
The decisions made in the design of this library were done to make the experience
as similar to the JavaScript reference implementation as possible, and to also
correctly implement the official specification.

Contains functionality to build *all* GraphQL types:
* `String`
* `Int`
* `Float`
* `Boolean`
* `GraphQLObjectType`
* `GraphQLUnionType`
* `GraphQLEnumType`
* `GraphQLInputObjectType`
* `GraphQLListType`
* `GraphQLNonNullType`

Of course, for a full description of GraphQL's type system, see the official specification:
https://spec.graphql.org/draft/#sec-Type-System

Mostly analogous to `graphql-js`; many names are verbatim:
https://graphql.org/graphql-js/type/

## Usage
It's easy to define a schema with the [helper functions](#helpers-and-extensions):

```dart
final todoSchema = GraphQLSchema(
  query: objectType(
    'Todo',
    fields: [
      field('text', graphQLString.nonNull()),
      field('created_at', graphQLDate),
    ],
  ),
);
```

All GraphQL types are generic, in order to leverage Dart's strong typing support.

## Table of Contents
- [Leto Schema](#leto-schema)
  - [Usage](#usage)
  - [Table of Contents](#table-of-contents)
- [GraphQL Schema](#graphql-schema)
  - [Resolvers](#resolvers)
- [GraphQL Types](#graphql-types)
  - [Scalar types](#scalar-types)
    - [Additional scalar types](#additional-scalar-types)
  - [Composed Types](#composed-types)
  - [Helpers and Extensions](#helpers-and-extensions)
    - [Methods on `GraphQLType`](#methods-on-graphqltype)
  - [Serialization and `SerdeCtx`](#serialization-and-serdectx)
    - [`SerdeCtx`](#serdectx)
  - [Validation](#validation)
  - [Non-Nullable Types](#non-nullable-types)
  - [List Types](#list-types)
    - [Input values and parameters](#input-values-and-parameters)
- [Schema and Document Validation Rules](#schema-and-document-validation-rules)
  - [`validateDocument(GraphQLSchema, gql.DocumentNode)`](#validatedocumentgraphqlschema-gqldocumentnode)
  - [`validateSDL(gql.DocumentNode, GraphQLSchema?)`](#validatesdlgqldocumentnode-graphqlschema)
  - [Custom Validations](#custom-validations)
- [GraphQLException and GraphQLError](#graphqlexception-and-graphqlerror)
- [Ctx and ScopedMap](#ctx-and-scopedmap)
- [LookAhead](#lookahead)
- [Utilities](#utilities)
    - [`buildSchema`](#buildschema)
    - [`printSchema`](#printschema)
    - [`extendSchema`](#extendschema)
    - [`introspectionQuery`](#introspectionquery)
    - [`mergeSchemas`](#mergeschemas)
    - [`schemaFromJson`](#schemafromjson)

# GraphQL Schema

Each `GraphQLSchema` requires a `GraphQLObjectType` as the root query type and optional `GraphQLObjectType`s for the mutation and subscription roots.

You can provide a list of directive definitions (`GraphQLDirectives`) that can be used within the schema or by documents executed by the schema. The directives will be extended if any of the types or fields have a [`ToDirectiveValue`](../README.md#todirectivevalue) attachment.

A `GraphQLSchema` has an optional `description` `String` that can be used as documentation and a [`SerdeCtx`](#serialization-and-serdectx) for deserialization of input types. The `astNode` (`SchemaDefinitionNode`) will be set when the schema is created with [`buildSchema`](#buildschema).

To validate the schema definition, following [the specification](https://spec.graphql.org/draft/#sec-Type-System),
you can use the `validateSchema(GraphQLSchema)` function which returns the `List<GraphQLError>` found during validation.

## Resolvers

Each field in an object type can provide a `resolve` callback to return the value when a GraphQL operation is executed over the schema.

```dart
final nameField = field(
  'name',
  graphQLString,
  resolve: (Object parentObject, Ctx ctx) => 'Example Name',
  // or pass the subscribe parameter if it is a subscription.
  // The return type should be a Stream
)
```

For a more thorough discussion about resolvers please see the resolvers section in the [main Documentation](../README.md#resolvers).

# GraphQL Types

For a more thorough discussion about all the GraphQL types and their usage with Leto, please see the [GraphQL Schema Types Documentation](../README.md#graphql-schema-types).

## Scalar types

All of the GraphQL scalar types (`GraphQLScalarType`) are built in:

* `graphQLString`
* `graphQLId`
* `graphQLBoolean`
* `graphQLInt`
* `graphQLFloat`

As well other additional types, provided for types in Dart's standard library:

### Additional scalar types

* `graphQLDate`
* `graphQLBigInt`
* `graphQLTimestamp`
* `graphQLUri`

## Composed Types

* `GraphQLObjectType`
* `GraphQLUnionType`
* `GraphQLEnumType`
* `GraphQLInputObjectType`
* `GraphQLListType`
* `GraphQLNonNullType`

## Helpers and Extensions

These are helpers to create a GraphQL types within Dart. Most of them can be found in the [/lib/src/gen.dart file](../leto_schema/lib/src/gen.dart).

* `objectType` - Create a `GraphQLObjectType` with fields
* `field` - Create a `GraphQLField` with a type/argument/resolver
* `inputObjectType` - Creates a `GraphQLInputObjectType`
* `inputField` - Creates a field for a `GraphQLInputObjectType`
* `listOf` - Create a `GraphQLListType` with the provided `innerType`

### Methods on `GraphQLType`

* `list` - Create a `GraphQLListType` from the type
* `nonNull` - Create a `GraphQLNonNullType` from the type
* `nullable` - Returns the inner type of `GraphQLNonNullType` or itself it it is nullable
* `field` - Create a `GraphQLField` (extension method)
* `inputField` - Create a field for a `GraphQLInputObjectType` (extension method)

The extensions on `GraphQLType` with the `field` and `inputField` methods are recommended over the
global function to preserve the `GraphQLType`'s generic type information.

## Serialization and `SerdeCtx`

GraphQL types can `serialize` and `deserialize` input data.
The exact implementation of this depends on the type.

```dart
final serdeCtx = SerdeCtx();
final String iso8601String = graphQLDate.serialize(DateTime.now());
final DateTime date = graphQLDate.deserialize(serdeCtx, iso8601String);
print(date.millisecondsSinceEpoch);
```

Values passed through `deserialize` and `serialize` should round-trip.

### `SerdeCtx`

A Serialization and Deserialization Context (SerdeCtx) allows you to create types from serialized values.
It registers `Serializers` for any type that can be used with generics.


## Validation

GraphQL types can `validate` input data. If the validation is successful, the
`GraphQLType.deserialize` method should return an instance of the Dart type.

```dart
final validation = myType.validate('key', {...});

if (validation.successful) {
  doSomething(validation.value);
} else {
  print(validation.errors);
}
```

## Non-Nullable Types
You can easily make a type non-nullable by calling its `nonNull` method.

## List Types
Support for list types is also included. Use the `list` method from `GraphQLType` or the `listOf` helper function for convenience.

```dart
/// A non-nullable list of non-nullable integers
listOf(graphQLInt.nonNull()).nonNull();
```

### Input values and parameters
Take the following GraphQL query:

```graphql
{
   anime {
     characters(title: "Hunter x Hunter") {
        name
        age
     }
   }
}
```

And subsequently, its schema:

```graphql
type AnimeQuery {
  characters($title: String!): [Character!]
}

type Character {
  name: String
  age: Int
}
```

The field `characters` accepts a parameter, `title`. To reproduce this in
`package:leto_schema`, use `GraphQLFieldInput`:

```dart
final GraphQLObjectType queryType = objectType(
  'AnimeQuery',
  fields: [
    field(
      'characters',
      listOf(characterType.nonNull()),
      inputs: [
        GraphQLFieldInput('title', graphQLString.nonNull()),
      ],
    ),
  ],
);

final GraphQLObjectType characterType = objectType(
  'Character',
  fields: [
    field('name', graphQLString),
    field('age', graphQLInt),
  ],
);
```

In the majority of cases where you use GraphQL, you will be delegate the
actual fetching of data to a database object, or some asynchronous resolver
function.

`package:leto_schema` includes this functionality in the `resolve` parameter,
which is a function that receives the parent object and a `Ctx` with a `Map<String, dynamic>`
of input arguments.

A hypothetical example of the above might be:

```dart
final field = field(
  'characters',
  graphQLString,
  resolve: (_, Ctx ctx) async {
    final Stream<String> stream = await myDatabase.findCharacters(ctx.args['title']);
    return stream;
  },
);
```

# Schema and Document Validation Rules

GraphQL schemas and documents can be validated for potential errors, misconfigurations, bad practices or perhaps
restrictions, such as restricting the complexity (how nested and how many fields) of a query.
We perform all the document and schema validations in the [specification](https://spec.graphql.org/draft/#sec-Validation). Most of the code was ported from [graphql-js](https://github.com/graphql/graphql-js).

You can find the implementation for all the rules in the [`lib/src/validate/rules`](../leto_schema/lib/src/validate/rules/) directory.

We also provide a [QueryComplexity](../README.md#query-complexity) validation rule.

You can use two functions to validate GraphQL documents, both return a `List<GraphQLError>`:

## `validateDocument(GraphQLSchema, gql.DocumentNode)`

You can specify multiple validation rules. The default is [`specifiedRules`](../leto_schema/lib/src/validate/validate.dart).

## `validateSDL(gql.DocumentNode, GraphQLSchema?)`

If a `GraphQLSchema` is passed, it is assumed that the document SDL is an extension over the given schema.

You can specify multiple validation rules. The default is `specifiedSDLRules`(../leto_schema/lib/src/validate/validate.dart).

## Custom Validations

You can provide custom validations, they are a function that receives a `ValidationCtx` and returns a visitor that reports errors thought the context.

For example, the following validation rule checks that argument names are unique:

<!-- include{validation-rule-unique-arg-names} -->
```dart
const _uniqueArgumentNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Argument-Names',
  code: 'uniqueArgumentNames',
);

/// Unique argument names
///
/// A GraphQL field or directive is only valid if all supplied arguments are
/// uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Argument-Names
Visitor uniqueArgumentNamesRule(
  SDLValidationCtx context, // ASTValidationContext,
) {
  final visitor = TypedVisitor();

  VisitBehavior? checkArgUniqueness(List<ArgumentNode> argumentNodes) {
    final seenArgs = argumentNodes.groupListsBy((arg) => arg.name.value);

    for (final entry in seenArgs.entries) {
      if (entry.value.length > 1) {
        context.reportError(
          GraphQLError(
            'There can be only one argument named "${entry.key}".',
            locations: List.of(entry.value
                .map((node) => node.name.span!.start)
                .map((e) => GraphQLErrorLocation.fromSourceLocation(e))),
            extensions: _uniqueArgumentNamesSpec.extensions(),
          ),
        );
      }
    }
  }

  visitor.add<FieldNode>((node) => checkArgUniqueness(node.arguments));
  visitor.add<DirectiveNode>((node) => checkArgUniqueness(node.arguments));
  return visitor;
}
```
<!-- include-end{validation-rule-unique-arg-names} -->

# GraphQLException and GraphQLError

A `GraphQLException` is a list of `GraphQLError`s.
You can view the `GraphQLError` definition in the following code section:

<!-- include{graphql-error-definition} -->
```dart
/// An error that may occur during the execution of a GraphQL query.
///
/// This will almost always be passed to a [GraphQLException].
class GraphQLError implements Exception, GraphQLException {
  /// The reason execution was halted, whether it is a syntax error,
  /// or a runtime error, or some other exception.
  final String message;

  /// An optional list of locations within the source text where
  /// this error occurred.
  ///
  /// Smart tools can use this information to show end users exactly
  /// which part of the errant query
  /// triggered an error.
  final List<GraphQLErrorLocation> locations;

  /// List of field names with aliased names or 0‐indexed integers for list
  final List<Object>? path;

  /// The stack trace of the [sourceError]
  final StackTrace? stackTrace;

  /// An optional error Object to pass more information of the
  /// source of the problem for logging or other purposes
  final Object? sourceError;

  /// Extensions return to the client
  ///
  /// This could be used to send more
  /// information about the error, such as a specific error code.
  final Map<String, Object?>? extensions;

  /// An error that may occur during the execution of a GraphQL query.
  ///
  /// This will almost always be passed to a [GraphQLException].
  GraphQLError(
    this.message, {
    this.locations = const [],
    this.path,
    this.extensions,
    StackTrace? stackTrace,
    this.sourceError,
  }) : stackTrace = stackTrace ?? StackTrace.current;
```
<!-- include-end{graphql-error-definition} -->

# Ctx and ScopedMap

You can view a more thorough explanation in the [main README](../README.md#request-contexts).

# LookAhead

You can view an usage example in the [main README](../README.md#lookahead-eager-loading).

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

