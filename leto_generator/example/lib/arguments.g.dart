// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arguments.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<String, Object, Object> testManyDefaultsGraphQLField =
    field(
  'testManyDefaults',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testManyDefaults(
        str: (args["str"] as String),
        intInput: (args["intInput"] as int),
        boolean: (args["boolean"] as bool),
        listStr: (args["listStr"] as List<String>),
        listDecimalNull: (args["listDecimalNull"] as List<Decimal?>?),
        listUri: (args["listUri"] as List<Uri>),
        date: (args["date"] as DateTime),
        gen: (args["gen"] as InputGen<int>?),
        enumValue: (args["enumValue"] as EnumValue),
        enumCustom: (args["enumCustom"] as int),
        enumCustomList: (args["enumCustomList"] as List<int>),
        json: (args["json"] as Json));
  },
  inputs: [
    GraphQLFieldInput(
      "str",
      graphQLString.nonNull().coerceToInputObject(),
      defaultValue: 'def',
    ),
    GraphQLFieldInput(
      "intInput",
      graphQLInt.nonNull().coerceToInputObject(),
      defaultValue: 2,
    ),
    GraphQLFieldInput(
      "boolean",
      graphQLBoolean.nonNull().coerceToInputObject(),
      defaultValue: true,
    ),
    GraphQLFieldInput(
      "listStr",
      graphQLString.nonNull().list().nonNull().coerceToInputObject(),
      defaultValue: const ['dw', 'dd2'],
    ),
    GraphQLFieldInput(
      "listDecimalNull",
      decimalGraphQLType.list().coerceToInputObject(),
      defaultValue: _defaultListDecimalNull(),
    ),
    GraphQLFieldInput(
      "listUri",
      graphQLUri.nonNull().list().nonNull().coerceToInputObject(),
      defaultValue: [Uri.parse('http://localhost:8060/')],
    ),
    GraphQLFieldInput(
      "date",
      graphQLDate.nonNull().coerceToInputObject(),
      defaultValue: DateTime.parse("2021-03-24"),
    ),
    GraphQLFieldInput(
      "gen",
      inputGenGraphQLType<int>(graphQLInt.nonNull()),
      defaultValue: InputGen(name: 'gen', generic: 2),
    ),
    GraphQLFieldInput(
      "enumValue",
      enumValueGraphQLType.nonNull().coerceToInputObject(),
      defaultValue: EnumValue.v1,
    ),
    GraphQLFieldInput(
      "enumCustom",
      graphQLInt.nonNull().coerceToInputObject(),
      defaultValue: 3,
    ),
    GraphQLFieldInput(
      "enumCustomList",
      graphQLInt.nonNull().list().nonNull().coerceToInputObject(),
      defaultValue: const [2],
    ),
    GraphQLFieldInput(
      "json",
      Json.graphQLType.nonNull().coerceToInputObject(),
      defaultValue: const Json.map({
        'd': Json.list([Json.number(2)])
      }),
    )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

/// Auto-generated from [EnumValue].
final GraphQLEnumType<EnumValue> enumValueGraphQLType = enumType('EnumValue',
    const {'v1': EnumValue.v1, 'v2': EnumValue.v2, 'v3': EnumValue.v3});
