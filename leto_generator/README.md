# leto_generator <!-- omit in toc -->
[![Pub](https://img.shields.io/pub/v/leto_generator.svg)](https://pub.dartlang.org/packages/leto_generator)
[![build status](https://travis-ci.org/angel-dart/graphql.svg)](https://travis-ci.org/angel-dart/graphql)

Generates `package:leto_schema`'s `GraphQLSchema`s from annotated Dart classes and functions. This is a code-first generator which will generate different GraphQL elements based on annotations in Dart code.

# Table of contents <!-- omit in toc -->

- [Examples](#examples)
- [Annotations (Decorators)](#annotations-decorators)
  - [Outputs](#outputs)
    - [GraphQLClass](#graphqlclass)
    - [GraphQLField](#graphqlfield)
      - [Interfaces](#interfaces)
    - [GraphQLUnion](#graphqlunion)
  - [Inputs](#inputs)
    - [GraphQLInput](#graphqlinput)
    - [GraphQLArg](#graphqlarg)
    - [Resolver Inputs](#resolver-inputs)
  - [Other](#other)
    - [GraphQLDocumentation](#graphqldocumentation)
    - [GraphQLEnum](#graphqlenum)
    - [Generics](#generics)
- [Dart Type to GraphQLType coercion](#dart-type-to-graphqltype-coercion)
  - [Default type mappings](#default-type-mappings)
  - [Provided type annotations](#provided-type-annotations)
  - [Class.graphQLType static getter](#classgraphqltype-static-getter)
  - [customTypes in build.yaml](#customtypes-in-buildyaml)
  - [@GraphQLDocumentation(type: Function, typeName: String)](#graphqldocumentationtype-function-typename-string)
- [Resolvers](#resolvers)
  - [TODO: 2G BeforeResolver](#todo-2g-beforeresolver)
  - [Function Resolvers](#function-resolvers)
  - [Class Resolvers](#class-resolvers)
- [Global Configuration (build.yaml)](#global-configuration-buildyaml)
  - [Fields](#fields)
    - [Name for ID GraphQLType (default: "id")](#name-for-id-graphqltype-default-id)
    - [nullableFields (default: false)](#nullablefields-default-false)
    - [omitFields (default: false)](#omitfields-default-false)
    - [omitPrivateFields (default: true)](#omitprivatefields-default-true)
  - [Resolvers](#resolvers-1)
    - [instantiateCode (default: null)](#instantiatecode-default-null)
    - [customTypes](#customtypes)
      - [Example](#example)
    - [graphQLApiSchemaFile](#graphqlapischemafile)

## Usage
Usage is very simple. You just need `@GraphQLClass()` annotation
on any class you want to generate an object type for.

Individual fields can have a `@GraphQLDocumentation()` annotation, to provide information
like descriptions, deprecation reasons, etc.

```yaml
dependencies:
  leto_schema:
dependencies:
  leto_generator:
  build_runner:
```

Run the code generator:

```
dart pub run build_runner watch --delete-conflicting-outputs
```

# Examples

Multiple examples with tests can be found in the [examples](https://github.com/juancastillo0/leto/tree/main/leto_generator/example) folder.

# Annotations (Decorators)

All annotations with documentation and the supported configuration parameters can be found in  `package:leto_schema`'s [decorators file](https://github.com/juancastillo0/leto/blob/main/leto_schema/lib/src/decorators.dart).

## Outputs

Annotations for GraphQL Output Types

### GraphQLClass

Generate `GraphQLObjectType`s and Interfaces with this annotation. The constructor provides a couple of parameters to configure the generated fields. 

### GraphQLField

Configures the generation of a `GraphQLObjectField` in a `GraphQLObjectType`.

In this example, the `omitFields` parameter is used to omit all fields by default from the generation. Also an usage of the `interfaces` parameter is shown, a better approach for specifying interfaces is shown in the [Interfaces section](#interfaces).

<!-- include{generator-object-class} -->
```dart
final customInterface = objectType<Object>(
  'ClassConfig2Interface',
  fields: [
    graphQLString.nonNull().field('value'),
  ],
  isInterface: true,
);

@GraphQLClass(omitFields: true, interfaces: ['customInterface'])
class ClassConfig2 {
  @GraphQLField()
  final String value;
  @GraphQLField(nullable: true)
  final String valueOverridden;
  final String notFound;
  @GraphQLField(name: 'renamedValue2')
  final String value2;

  const ClassConfig2({
    required this.value,
    required this.valueOverridden,
    required this.notFound,
    required this.value2,
  });
}
```
<!-- include-end{generator-object-class} -->

Fields annotated with `@GraphQLField()` will appear in the type definition, but `notFound` will not since `omitFields: true` and `notFound` is not annotated with `@GraphQLField()`. The type implements the interface specified in the annotation.

<!-- include{generator-class-graphql} -->
```graphql
type ClassConfig2 implements ClassConfig2Interface {
  value: String!
  valueOverridden: String
  renamedValue2: String!
}
```
<!-- include-end{generator-class-graphql} -->

The following class uses the `nullableFields` parameter to override the default nullability type inference. When true, all fields will be nullable by default.

<!-- include{generator-object-class-renamed} -->
```dart
@GraphQLClass(nullableFields: true, name: 'RenamedClassConfig')
class ClassConfig {
  @GraphQLDocumentation(deprecationReason: 'value deprecated')
  @GraphQLField()
  final String value;
  final String valueOverridden;
  final String? valueNull;
  @GraphQLField(nullable: true)
  final String value2;

  ClassConfig({
    required this.value2,
    required this.value,
    required this.valueOverridden,
    this.valueNull,
  });
}
```
<!-- include-end{generator-object-class-renamed} -->

The previous Dart code will generate a GraphQL Object Type with the following definition:

<!-- include{generator-class-renamed-graphql} -->
```graphql
type RenamedClassConfig {
  value: String! @deprecated(reason: "value deprecated")
  valueOverridden: String
  valueNull: String
  value2: String
}
```
<!-- include-end{generator-class-renamed-graphql} -->

#### Interfaces

You may use abstract classes to specify that a given class annotated with `@GraphQLClass()` should generate a GraphQLInterface. Implemented classes that generate GraphQLInterfaces will appear as an interface of a the generated Object or Interface.

The following annotated Dart classes show the behavior.

<!-- include{generator-interfaces} -->
```dart
@GraphQLClass()
abstract class NestedInterface {
  Decimal get dec;
}

@GraphQLClass()
abstract class NamedInterface {
  String? get name;
}

@GraphQLClass()
class NestedInterfaceImpl implements NestedInterface {
  @override
  final Decimal dec;

  final String? name;

  NestedInterfaceImpl(this.name, this.dec);
}

@GraphQLClass()
class NestedInterfaceImpl2 implements NestedInterfaceImpl {
  @override
  final Decimal dec;

  @override
  final String? name;
  final String name2;

  NestedInterfaceImpl2({
    required this.dec,
    required this.name,
    required this.name2,
  });
}

@GraphQLClass()
class NestedInterfaceImpl3 extends NestedInterfaceImpl
    implements NamedInterface {
  final String name3;

  NestedInterfaceImpl3({
    required Decimal dec,
    required String? name,
    required this.name3,
  }) : super(name, dec);
}
```
<!-- include-end{generator-interfaces} -->

Will generate the following GraphQL definitions:

<!-- include{generator-interfaces-graphql} -->
```graphql
interface NestedInterface {
  dec: Decimal!
}

interface NamedInterface {
  name: String
}

type NestedInterfaceImpl implements NestedInterface {
  dec: Decimal!
  name: String
}

type NestedInterfaceImpl2 implements NestedInterface {
  dec: Decimal!
  name: String
  name2: String!
}

type NestedInterfaceImpl3 implements NamedInterface & NestedInterface {
  name3: String!
  dec: Decimal!
  name: String
}
```
<!-- include-end{generator-interfaces-graphql} -->

### GraphQLUnion

[Unions](https://github.com/juancastillo0/leto#unions) allow you to specify that a given value can be one of multiple possible objects. For code generation we use [freezed](https://github.com/rrousselGit/freezed)-like unions where factory constructors specify the different properties for the different objects. Other annotations such as `@GraphQLField()`, `@GraphQLDocumentation()` and freezed's `@Default` will also work as shown in the example.

<!-- include{generator-unions-freezed} -->
```dart
@GraphQLClass()
@freezed
class UnionA with _$UnionA {
  const factory UnionA.a1({
    // five with default
    @Default(5) int one,
  }) = _UnionA1;

  const factory UnionA.a2({
    @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
    @Deprecated('custom deprecated msg')
        Decimal? dec,
  }) = _UnionA2;

  const factory UnionA.a3({
    @GraphQLDocumentation(description: 'description for one') List<int>? one,
  }) = UnionA3;

  const factory UnionA.a4({
    @GraphQLField(name: 'oneRenamed') required List<int> one,
  }) = _UnionA4;

  factory UnionA.fromJson(Map<String, Object?> json) => _$UnionAFromJson(json);
}
```
<!-- include-end{generator-unions-freezed} -->


<!-- include{generator-unions-freezed-graphql} -->
```graphql
union UnionA = UnionA1 | UnionA2 | UnionA3 | UnionA4

type UnionA1 {
  """five with default"""
  one: Int!
}

type UnionA2 {
  dec: Decimal @deprecated(reason: "custom deprecated msg")
}

type UnionA3 {
  """description for one"""
  one: [Int!]
}

type UnionA4 {
  oneRenamed: [Int!]!
}
```
<!-- include-end{generator-unions-freezed-graphql} -->

If you don't use `package:freezed`, your can still generate unions with the same Dart definition, but actually defining the constructors for each possible object in the union:

<!-- include{unions-example-generator} -->
```dart
GraphQLAttachments unionNoFreezedAttachments() => const [ElementComplexity(50)];

@AttachFn(unionNoFreezedAttachments)
@GraphQLDocumentation(
  description: '''
Description from annotation.

Union generated from raw Dart classes''',
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

Which generates code for the following GraphQL definitions:

<!-- include{unions-example-generator-graphql} -->
```graphql
"""
Description from annotation.

Union generated from raw Dart classes
"""
union UnionNoFreezedRenamed @cost(complexity: 50) = UnionNoFreezedA | UnionNoFreezedB

type UnionNoFreezedA {
  value: String!
}

type UnionNoFreezedB {
  value: Int!
}
```
<!-- include-end{unions-example-generator-graphql} -->

## Inputs

Annotations for GraphQL Input Types

### GraphQLInput

Specifies that a given class should generate a [`GraphQLInputObject`](https://github.com/juancastillo0/leto#inputs-and-input-objects). All classes annotated with `@GraphQLInput()` should provide a `fromJson` factory or static method as shown in the following examples. You can use packages such us `json_serializable` to generate the serialization code.

### GraphQLArg

This annotation allows you to specify a default value for Input types in the schema. The type with a default value should support de-serializing the provided default value or should be able to be serialized with a `toJson` method. This will also work for arguments in resolvers as shown in the [Resolver Inputs](#resolver-inputs) section.


<!-- include{generator-input-object} -->
```dart
@GraphQLInput(name: 'InputMNRenamed')
class InputMN {
  final String name;
  final InputM? parent;
  final Json json;
  final List<Json> jsonListArgDef;
  final List<List<InputM>?>? parentNullDef;

  static List<List<InputM>?> parentNullDefDefault() => [
        null,
        [
          const InputM(
            name: 'defaultName',
            nested: [],
            nestedNullItem: [],
            ints: [0, 0],
            doubles: [0, 0.1],
          )
        ]
      ];

  const InputMN({
    required this.name,
    this.parent,
    this.json = const JsonList([JsonNumber(1)]),
    @GraphQLArg(defaultCode: 'const [JsonMap({})]')
        required this.jsonListArgDef,
    @GraphQLArg(defaultFunc: parentNullDefDefault) this.parentNullDef,
  });

  factory InputMN.fromJson(Map<String, Object?> json) {
    return InputMN(
      name: json['name']! as String,
      parent: json['parent'] != null
          ? InputM.fromJson(json['parent']! as Map<String, Object?>)
          : null,
      json: Json.fromJson(json['json']),
      jsonListArgDef: List.of(
        (json['jsonListArgDef'] as List).map(
          (Object? e) => Json.fromJson(e),
        ),
      ),
      parentNullDef: json['parentNullDef'] != null
          ? List.of(
              (json['parentNullDef']! as List<Object?>).map(
                (e) => e == null
                    ? null
                    : List.of(
                        (e as List<Object?>).map(
                          (e) => InputM.fromJson(e as Map<String, Object?>),
                        ),
                      ),
              ),
            )
          : null,
    );
  }

  Map<String, Object?> toJson() => {
        'name': name,
        'parent': parent,
        'json': json,
        'jsonListArgDef': jsonListArgDef,
        if (parentNullDef != null) 'parentNullDef': parentNullDef,
      };
}
```
<!-- include-end{generator-input-object} -->

Generic input types are supported. However the api may change in the future. Your `fromJson` method should have generic argument factories as parameters, functions that return the generic instance from a serialized value. You can use the `@JsonSerializable(genericArgumentFactories: true)` if using `json_serializable` as shown in the example.

<!-- include{generator-input-object-generic} -->
```dart
@GraphQLInput()
@JsonSerializable(genericArgumentFactories: true)
class InputGen<T> {
  final String name;
  final T generic;

  const InputGen({
    required this.name,
    required this.generic,
  });

  factory InputGen.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$InputGenFromJson(json, fromJsonT);

  Map<String, Object?> toJson() => {'name': name, 'generic': generic};
}
```
<!-- include-end{generator-input-object-generic} -->

### Resolver Inputs

// TODO: 1G `@FromCtx()` Type.fromCtx;

Authentication (admin|role);

For resolvers, you just specify the type that you want as input and the input GraphQL type will be included in the generated field definition.  You can use the `@GraphQLArg()` annotation to specify a default value or specify the default value directly in the dart code if it can be a `const` Dart definition.

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

Enums work as expected using the `@GraphQLEnum()` annotation. The `valuesCase` parameter can be used to specify the case of the generated GraphQL enum definition. Some example of simple enums:

<!-- include{generator-enum-example} -->
```dart
/// comments for docs
@GraphQLEnum(name: 'SimpleEnumRenamed')
enum SimpleEnum {
  @AttachFn(simpleVariantAttachments)
  simpleVariantOne,

  SIMPLE_VARIANT_TWO,
}

GraphQLAttachments simpleVariantAttachments() => const [CustomAttachment()];

@GraphQLEnum(valuesCase: EnumNameCase.snake_case)
enum SnakeCaseEnum {
  @GraphQLDocumentation(description: 'description from annotation')
  @Deprecated('custom deprecated')
  variantOne,

  /// Documentation for variant two
  variantTwo,
}
```
<!-- include-end{generator-enum-example} -->

The `SimpleEnum` Dart enum will generate the following GraphQL definition:

<!-- include{generator-enum-example-graphql} -->
```graphql
enum ClassEnum @cost(complexity: 2) {
  VARIANT_ONE

  """The second variant docs"""
  VARIANT_TWO
  errorRenamed
}
```
<!-- include-end{generator-enum-example-graphql} -->

And the `SnakeCaseEnum` Dart enum will generate the following GraphQL definition:

<!-- include{generator-enum-example-case-graphql} -->
```graphql
enum SnakeCaseEnum {
  """description from annotation"""
  variant_one @deprecated(reason: "custom deprecated")

  """Documentation for variant two"""
  variant_two
}
```
<!-- include-end{generator-enum-example-case-graphql} -->

You can also provide a custom enum class, you will need to annotate each static variant with the `@GraphQLEnumVariant()` decorator and have a `Class.values` static getter. All variants should be of the same type as the Enum class. An example of this is shown in the following code snippet.

<!-- include{generator-class-enum-example} -->
```dart
GraphQLAttachments classEnumAttachments() => const [ElementComplexity(2)];

@AttachFn(classEnumAttachments)
@GraphQLEnum(valuesCase: EnumNameCase.CONSTANT_CASE)
@immutable
class ClassEnum {
  final int code;
  final bool isError;

  const ClassEnum._(this.code, this.isError);

  @GraphQLEnumVariant()
  static const variantOne = ClassEnum._(100, false);

  /// The second variant docs
  @GraphQLEnumVariant()
  static const variantTwo = ClassEnum._(201, false);
  @GraphQLEnumVariant(name: 'errorRenamed')
  @AttachFn(variantErrorAttachments)
  static const variantErrorThree = ClassEnum._(300, true);

  static GraphQLAttachments variantErrorAttachments() =>
      const [CustomAttachment()];

  static const List<ClassEnum> values = [
    variantOne,
    variantTwo,
    variantErrorThree,
  ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassEnum && other.code == code && other.isError == isError;
  }

  @override
  int get hashCode => code.hashCode ^ isError.hashCode;
}
```
<!-- include-end{generator-class-enum-example} -->

### Generics

// TODO: 1G Generics docs

# Dart Type to GraphQLType coercion

Dart types specified as fields of classes or input parameters in resolvers will be coerced into `GraphQLType`s using the following rules.

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

A Class annotated with `@GraphQLClass()` will generate fields for all its methods. Resolver inputs were discussed in the [inputs section](#resolver-inputs).

## TODO: 2G BeforeResolver


## Function Resolvers

You can use the `@Query()`, `@Mutation()` and `@Subscription()` annotation to specify that a given method or function is a field in the given root object type (Query, Mutation or Subscription root objects).All function annotated with `@Subscription()` should return a `Stream` of values.

These annotations have the following parameters:

- name (default: the name of the method)

This will be the name of the GraphQL field.

- genericTypeName (default: null)

When the return type is a generic type, you can override the GraphQL type name with a custom String. Most generic types provide a default name composed from the type parameters (using `GraphQLType.printableName`, for example), so this parameter is usually not required.

- TODO: 1G nullable return type

## Class Resolvers

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

#### Example

To support the `Decimal` type from https://github.com/a14n/dart-decimal you can use the following code:

<!-- include{custom-scalar-decimal} -->
```dart
import 'package:decimal/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

export 'package:decimal/decimal.dart';

final decimalGraphQLType = GraphQLScalarTypeValue<Decimal, String>(
  name: 'Decimal',
  deserialize: (_, serialized) => decimalFromJson(serialized)!,
  serialize: (value) => decimalToJson(value)!,
  validate: (key, input) => (input is num || input is String) &&
          Decimal.tryParse(input.toString()) != null
      ? ValidationResult.ok(input.toString())
      : ValidationResult.failure(
          ['Expected $key to be a number or a numeric String.'],
        ),
  description: 'A number that allows computation without losing precision.',
  specifiedByURL: null,
);

Decimal? decimalFromJson(Object? value) =>
    value == null ? null : Decimal.parse(value as String);

String? decimalToJson(Decimal? value) => value?.toString();
```
<!-- include-end{custom-scalar-decimal} -->

And specify the following config in the [build.yaml](https://github.com/dart-lang/build/blob/master/docs/faq.md) file.

```yaml
target:
  default:
    builders:
      leto_generator:
        options:
          customTypes:
            - name: "Decimal"
            import: "package:<your_package_name>/<path_to_implementation>.dart"
            getter: "decimalGraphQLType"
```

### graphQLApiSchemaFile