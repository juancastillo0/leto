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
http://spec.graphql.org/draft/#sec-Type-System

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

# GraphQL Schema

To validate the schema definition following [the specification](https://spec.graphql.org/draft/#sec-Type-System)
you can use `validateSchema(GraphQLSchema)` which return the `List<GraphQLError>` found during validation.

# GraphQL Types

All of the GraphQL scalar types are built in, as well other additional types:

* `graphQLString`
* `graphQLId`
* `graphQLBoolean`
* `graphQLInt`
* `graphQLFloat`

## Additional types

* `graphQLDate`
* `graphQLBigInt`
* `graphQLTimestamp`
* `graphQLUri`

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

### `SerdeCtx`

A Serialization and Deserialization Context (SerdeCtx) allows you to create types from serialized values.
It registers `Serializers` for any type and can be used with generics.


## Validation

GraphQL types can `validate` input data.

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
Support for list types is also included. Use the `listOf` helper for convenience.

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

You can find the implementation for all the rules in the `lib/src/validate/rules` directory.

We also provide a [QueryComplexity](../README.md#query-complexity) validation rule.

`List<GraphQLError> validateDocument()`
`List<GraphQLError> validateSDL()`

## Custom Validations

You can provide custom validations, they are a function that receives a `ValidationCtx` and returns a visitor that reports errors thought the context.

```dart
import 'package:gql/language.dart' as gql; 

// or `SDLValidationCtx context` for documents
gql.Visitor validation(ValidationCtx context) {
  // report errors
  context.reportError(
    GraphQLError(
      'Error message',

    )
  );
}
```

# GraphQLException and GraphQLError



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




