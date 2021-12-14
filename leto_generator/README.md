# leto_generator
[![Pub](https://img.shields.io/pub/v/leto_generator.svg)](https://pub.dartlang.org/packages/leto_generator)
[![build status](https://travis-ci.org/angel-dart/graphql.svg)](https://travis-ci.org/angel-dart/graphql)

Generates `package:leto_schema` schemas for
annotated class.

Replaces `convertDartType` from `package:leto`.

## Usage
Usage is very simple. You just need a `@graphQLClass` or `@GraphQLClass()` annotation
on any class you want to generate an object type for.

Individual fields can have a `@GraphQLDocumentation()` annotation, to provide information
like descriptions, deprecation reasons, etc.

```dart
@graphQLClass
class Todo {
  String text;

  @GraphQLDocumentation(description: 'Whether this item is complete.')
  bool isComplete;
}

void main() {
  print(todoGraphQLType.fields.map((f) => f.name));
}
```

The following is generated (as of April 18th, 2019):

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

/// Auto-generated from [Todo].
final GraphQLObjectType todoGraphQLType = objectType('Todo',
    isInterface: false,
    interfaces: [],
    fields: [
      field('text', graphQLString),
      field('isComplete', graphQLBoolean)
    ]);
```

# Examples

Multiple examples with tests can be found in the [examples](https://github.com/juancastillo0/leto/tree/main/leto_generator/example) folder.

# Annotations (Decorators)

## TODO: BeforeResolver


## Outputs

### GraphQLClass

### GraphQLField
### GraphQLUnion

## Inputs

### GraphQLInput
### GraphQLArg

<!-- include{code-generation-arguments} -->
```dart
List<Decimal?> _defaultListDecimalNull() => [null, Decimal.parse('2')];

GraphQLType<dynamic, dynamic> _timestampsType() =>
    graphQLTimestamp.list().nonNull();

@GraphQLEnum()
enum EnumValue { v1, v2, v3 }

final enumCustomGraphQLType = enumType<int>(
  'EnumCustom',
  {
    'TWO': 2,
    'THREE': 3,
  },
);

const testManyDefaultsGraphQLStr =
    'testManyDefaults(str: String! = "def", intInput: Int! = 2,'
    ' doubleInput: Float! = 3.0, doubleInputNull: Float = 4.2,'
    ' boolean: Boolean! = true, listStr: [String!]! = ["dw", "dd2"],'
    ' listDecimalNull: [Decimal] = [null, "2"],'
    ' listUri: [Uri!]! = ["http://localhost:8060/"],'
    ' date: Date! = "2021-03-24T00:00:00.000",'
    ' gen: InputGenIntReq = {name: "gen", generic: 2},'
    ' enumValue: EnumValue! = v1, enumCustom: EnumCustom = THREE,'
    ' enumCustomList: [EnumCustom!]! = [TWO],'
    ' timestamps: [Timestamp]! = [1611446400000, null],'
    ' json: Json! = {d: [2]}): String!';

@Query()
String testManyDefaults({
  String str = 'def',
  int intInput = 2,
  double doubleInput = 3,
  double? doubleInputNull = 4.2,
  bool boolean = true,
  List<String> listStr = const ['dw', 'dd2'],
  @GraphQLArg(defaultFunc: _defaultListDecimalNull)
      List<Decimal?>? listDecimalNull,
  @GraphQLArg(defaultCode: "[Uri.parse('http://localhost:8060/')]")
      required List<Uri> listUri,
  @GraphQLArg(defaultCode: 'DateTime.parse("2021-03-24")')
      required DateTime date,
  @GraphQLArg(defaultCode: "InputGen(name: 'gen', generic: 2)")
      InputGen<int>? gen,
  EnumValue enumValue = EnumValue.v1,
  @GraphQLDocumentation(typeName: 'enumCustomGraphQLType')
      int enumCustom = 3,
  @GraphQLDocumentation(
    typeName: 'enumCustomGraphQLType.nonNull().list().nonNull()',
  )
      List<int> enumCustomList = const [2],
  @GraphQLArg(defaultCode: '[DateTime.parse("2021-01-24"), null]')
  @GraphQLDocumentation(type: _timestampsType)
      required List<DateTime?> timestamps,
  Json json = const Json.map({
    'd': Json.list([Json.number(2)])
  }),
}) {
```
<!-- include-end{code-generation-arguments} -->

## Other
### GraphQLDocumentation

Dart comments for all elements will be taken as the description in the generated GraphQLType or Field. Also, Dart's `@Deprecated()` annotation can be used for setting the `deprecationReason` for fields, input fields, arguments and enum values. Another way, which will override the previous two, is by using the `@GraphQLDocumentation()` with the `description` and `deprecationReason` params.

The GraphQLType of a field, input field, argument or class can be configured using the `type` or `typeName` params. More information in the [GraphQLDocumentation type parameters section](#graphqldocumentationtype-function-typename-string).

### GraphQLEnum







# Dart Type to GraphQLType coercion



## Default type mappings

| Dart Type                                        | GraphQL Type           |
| ------------------------------------------------ | ---------------------- |
| `String`                                         | String                 |
| `int`                                            | Int                    |
| `double`/`num`                                   | Float                  |
| `bool`                                           | Boolean                |
| `String`/`int` (with `id` as name, configurable) | ID                     |
| `List<T>`                                        | [T]                    |
| `DateTime`                                       | Date (custom scalar)   |
| `Uri`                                            | Uri (custom scalar)    |
| `BigInt`                                         | BigInt (custom scalar) |

By default, a non-nullable Dart `String` (or any type) represents a GraphQL `String!` and a nullable Dart `String?` represents a GraphQL `String`, however that can be [configured](#nullablefields-default-false) for each field, class or for the whole project.

## Provided type annotations

Using the provided [type annotations](#annotations-decorators), a GraphQLType will be created for the given class or enum. You can use any type with a type annotation as part of another type or in the definition of a resolver function.

## Class.graphQLType static getter

If you have control over the class definition, you can provide a static `graphQLType` getter in the class. This will be used as the GraphQL type in other parts of code generation. 

Typically used for scalar types that you control (not from another package) or for generic types that need more customization (usage of `GraphQLUnionType.extractInner` for example).

Some examples of this are the `Json`, `PageInfo` and `Result<T, E>` provided types.

## customTypes in build.yaml

Another way of mapping a Dart type to a `GraphQLType` instance is by using the "customTypes" `build.yaml` global config option explained in the [customTypes](#customtypes) section. This will override (take precedence over) all other type mappings.

Useful for types that you don't control like the `Decimal` type from https://github.com/a14n/dart-decimal or `IsoDuration` from https://github.com/mzdm/iso_duration_parser.

## @GraphQLDocumentation(type: Function, typeName: String)

If you want to customize a single field or argument with a GraphQLType different from the one inferred by the library, you can provide a static function (`GraphQLType Function()`) which returns the expected type in the `type` parameter of `@GraphQLDocumentation(type: )`. For the same purpose, we provide a `typeName` String value, which should be the getter (in Dart code) of the expected `GraphQLType`. The code generation will throw an exception if you provide both at the same time.

# Resolvers

A Class annotated with `@GraphQLClass()` will generate fields for all its methods.

### Resolver Inputs

// TODO: `@FromCtx()` Type.fromCtx;

Authentication (admin|role);

### Function Resolvers

You can use the `@Query()`, `@Mutation()` and `@Subscription()` annotation to specify that a given method or function is a field in the given root object type (Query, Mutation or Subscription root objects).All function annotated with `@Subscription()` should return a `Stream` of values.

These annotations have the following parameters:

- name (default: the name of the method)

This will be the name of the GraphQL field.

- genericTypeName (default: null)

When the return type is a generic type, you can override the GraphQL type name with a custom String. Most generic types provide a default name composed from the type parameters (using `GraphQLType.printableName`, for example), so this parameter is usually not required.

- TODO: nullable return type

### Class Resolvers

With `@ClassResolver()` you can specify that a set of fields will be resolved by executing the methods of the decorated class. This allows you to group the fields into a separate class which give you a couple of nice features. Since in Dart all classes specify an "interface" this could be useful if you want to unit test the interface or implement the class resolver's API in other contexts. This also allows you to easily access common dependencies shared between the fields in the resolver class. Instead of using `final dependencyName = dependencyRef.get(ctx);` in each field's resolver method body, you could create a field or getter within the class.

In order for Leto to have an instance of the resolver you need to provide a way of creating or getting the class resolver before executing any of the methods. We provide two main tool for that:

- Resolver.ref

A static variable that implements `BaseRef<FutureOr<Resolver?>>`. For example, a `RefWithDefault` or `ScopedRef`. This will use the `Ctx` of the field's resolver to access an instance of the class resolver with `final FutureOr<Resolver> instance = Resolver.ref.get(ctx)!;` and then call the method `instance.fieldName(...arguments)` where `fieldName` is the name of the method.

- instantiateCode

Available in: `build.yaml`, `ClassResolver`.

If you want to use a custom dependency injection library or method, you can provide an "instantiateCode" String which will be used as a getter to the class resolver instance. You can use the `Ctx` of the field in the provided code with the `ctx` variable and the resolver Dart class name with "{{name}}" as a template variable within the String. The value should be cast to a `FutureOr<Resolver>` type if necessary. A variable of type `Resolver` or `Future<Resolver>` is fine, no need to explicitly add the `as FutureOr<Resolver>` suffix.

```dart
final resolversTypeMap = <Type, Object Function(Ctx)>{
  Resolver: (Ctx ctx) => Resolver(),
};

const diByMapType = ClassResolver(
  instantiateCode: 'resolversTypeMap[{{name}}]!(ctx) as {{name}}',
);

@diByMapType
class Resolver {
  @Query()
  String getName() => '';
}
```

In the example above we first instantiate the annotation and then apply it to the class, this would allow you to reuse the `diByMapType` annotation in multiple classes if you want to use the same dependency injection method for all of them.

- fieldName

Nested objects in resolvers.


# Global Configuration (build.yaml)

## Fields

### Name for ID GraphQLType (default: "id")


### nullableFields (default: false)

Available in: `build.yaml`, `GraphQLClass`, `GraphQLField`.

When `true`, this will make all fields nullable by default. If you want to make a field non-nullable, you will need to configure it in the class' `GraphQLClass` annotation, which applies to all the class' fields, or in the field's `GraphQLField` annotation.

### omitFields (default: false)

Available in: `build.yaml`, `GraphQLClass`, `GraphQLField`.

When `true`, this will omit all fields from being generated by default. If you want to generate a specific field, you will need to configure it in the class' `GraphQLClass` annotation, which applies to all the class' fields, or in the field's `GraphQLField` annotation.
### omitPrivateFields (default: true)

Available in: `build.yaml`, `GraphQLClass`.

When `true`, this will omit all fields that start with a underscore "_".

Following the GraphQL spec, fields that start with double underscore "__" are not allowed, they will be always be omitted.

## Resolvers


### instantiateCode (default: null)

Available in: `build.yaml`, `ClassResolver`.

### customTypes

This will allow you to specify a custom mapping from given Dart type to a `GraphQLType`. The mapping is done with Dart type `name` provided as a field in the `build.yaml` configuration. This will override all other mapping discussed in [coercing types section](#dart-type-to-graphqltype-coercion). It is a list of objects with the following properties: 

- String name;

The name of the Dart type, if the name matches a Dart type's name during code generation, the `getter` (next configuration) will be used as it's `GraphQLType`.

- String getter;

The getter is the name of the Dart getter or property of returns the `GraphQLType`. It should be located in the file pointed by the `import` property.

- String import;

The file path where the `GraphQLType`'s `getter` can be found.



### graphQLApiSchemaFile