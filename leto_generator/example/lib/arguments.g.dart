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
        doubleInput: (args["doubleInput"] as double),
        doubleInputNull: (args["doubleInputNull"] as double?),
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
    graphQLString.nonNull().coerceToInputObject().inputField(
          "str",
          defaultValue: 'def',
        ),
    graphQLInt.nonNull().coerceToInputObject().inputField(
          "intInput",
          defaultValue: 2,
        ),
    graphQLFloat.nonNull().coerceToInputObject().inputField(
          "doubleInput",
          defaultValue: 3,
        ),
    graphQLFloat.coerceToInputObject().inputField(
          "doubleInputNull",
          defaultValue: 4.2,
        ),
    graphQLBoolean.nonNull().coerceToInputObject().inputField(
          "boolean",
          defaultValue: true,
        ),
    graphQLString.nonNull().list().nonNull().coerceToInputObject().inputField(
      "listStr",
      defaultValue: const ['dw', 'dd2'],
    ),
    decimalGraphQLType.list().coerceToInputObject().inputField(
          "listDecimalNull",
          defaultValue: _defaultListDecimalNull(),
        ),
    graphQLUri.nonNull().list().nonNull().coerceToInputObject().inputField(
      "listUri",
      defaultValue: [Uri.parse('http://localhost:8060/')],
    ),
    graphQLDate.nonNull().coerceToInputObject().inputField(
          "date",
          defaultValue: DateTime.parse("2021-03-24"),
        ),
    inputGenGraphQLType<int>(graphQLInt.nonNull()).inputField(
      "gen",
      defaultValue: InputGen(name: 'gen', generic: 2),
    ),
    enumValueGraphQLType.nonNull().coerceToInputObject().inputField(
          "enumValue",
          defaultValue: EnumValue.v1,
        ),
    graphQLInt.nonNull().coerceToInputObject().inputField(
          "enumCustom",
          defaultValue: 3,
        ),
    graphQLInt.nonNull().list().nonNull().coerceToInputObject().inputField(
      "enumCustomList",
      defaultValue: const [2],
    ),
    Json.graphQLType.nonNull().coerceToInputObject().inputField(
          "json",
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
