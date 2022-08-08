[![Pub](https://img.shields.io/pub/v/leto_schema.svg)](https://pub.dartlang.org/packages/leto_schema)

# leto_schema

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
* `Date` - ISO-8601 Date string, deserializes to a Dart `DateTime` object

Of course, for a full description of GraphQL's type system, see the official
specification:
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
      field('text', graphQLString.nonNullable()),
      field('created_at', graphQLDate),
    ],
  ),
);
```

All GraphQL types are generic, in order to leverage Dart's strong typing support.

# GraphQL Types

All of the GraphQL scalar types are built in, as well as a `Date` type:
* `graphQLString`
* `graphQLId`
* `graphQLBoolean`
* `graphQLInt`
* `graphQLFloat`
* `graphQLDate`


## Helpers and Extensions

Most of them can be found in 

* `objectType` - Create a `GraphQLObjectType` with fields
* `field` - Create a `GraphQLField` with a type/argument/resolver
* `listOf` - Create a `GraphQLListType` with the provided `innerType`
* `inputObjectType` - Creates a `GraphQLInputObjectType`
* `inputField` - Creates a field for a `GraphQLInputObjectType`

## Serialization and `SerdeCtx`

GraphQL types can `serialize` and `deserialize` input data.
The exact implementation of this depends on the type.

```dart
final iso8601String = graphQLDate.serialize(new DateTime.now());
final date = graphQLDate.deserialize(iso8601String);
print(date.millisecondsSinceEpoch);
```

## Validation

GraphQL types can `validate` input data.

```dart
final validation = myType.validate('@root', {...});

if (validation.successful) {
  doSomething(validation.value);
} else {
  print(validation.errors);
}
```

## Non-Nullable Types
You can easily make a type non-nullable by calling its `nonNullable` method.

## List Types
Support for list types is also included. Use the `listType` helper for convenience.

```dart
/// A non-nullable list of non-nullable integers
listOf(graphQLInt.nonNullable()).nonNullable();
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
final GraphQLObjectType queryType = objectType('AnimeQuery', fields: [
  field('characters',
    listOf(characterType.nonNullable()),
    inputs: [
      new GraphQLFieldInput('title', graphQLString.nonNullable())
    ]
  ),
]);

final GraphQLObjectType characterType = objectType('Character', fields: [
  field('name', graphQLString),
  field('age', graphQLInt),
]);
```

In the majority of cases where you use GraphQL, you will be delegate the
actual fetching of data to a database object, or some asynchronous resolver
function.

`package:leto_schema` includes this functionality in the `resolve` property,
which is passed the parent object and a `ReqCtx` with a `Map<String, dynamic>` of input arguments.

A hypothetical example of the above might be:

```dart
final field = field(
  'characters',
  graphQLString,
  resolve: (_, args) async {
    return await myDatabase.findCharacters(args['title']);
  },
);
```

# Schema and Document Validation Rules


# Utilities

## look_ahead

## req_ctx

