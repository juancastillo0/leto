// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arguments.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<String, Object?, Object?> get testManyDefaultsGraphQLField =>
    _testManyDefaultsGraphQLField.value;
final _testManyDefaultsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<String, Object?, Object?>>(
    (setValue) => setValue(graphQLString.nonNull().field<Object?>(
          'testManyDefaults',
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
                timestamps: (args["timestamps"] as List<DateTime?>),
                json: (args["json"] as Json));
          },
        ))
          ..inputs.addAll([
            graphQLString.nonNull().inputField('str', defaultValue: 'def'),
            graphQLInt.nonNull().inputField('intInput', defaultValue: 2),
            graphQLFloat.nonNull().inputField('doubleInput', defaultValue: 3),
            graphQLFloat.inputField('doubleInputNull', defaultValue: 4.2),
            graphQLBoolean.nonNull().inputField('boolean', defaultValue: true),
            graphQLString
                .nonNull()
                .list()
                .nonNull()
                .inputField('listStr', defaultValue: const ['dw', 'dd2']),
            decimalGraphQLType.list().inputField('listDecimalNull',
                defaultValue: _defaultListDecimalNull()),
            graphQLUri.nonNull().list().nonNull().inputField('listUri',
                defaultValue: [Uri.parse('http://localhost:8060/')]),
            graphQLDate
                .nonNull()
                .inputField('date', defaultValue: DateTime.parse("2021-03-24")),
            inputGenGraphQLTypeInput<int>(graphQLInt.nonNull()).inputField(
                'gen',
                defaultValue: InputGen(name: 'gen', generic: 2)),
            enumValueGraphQLType
                .nonNull()
                .inputField('enumValue', defaultValue: EnumValue.v1),
            enumCustomGraphQLType.inputField('enumCustom', defaultValue: 3),
            enumCustomGraphQLType
                .nonNull()
                .list()
                .nonNull()
                .inputField('enumCustomList', defaultValue: const [2]),
            _timestampsType().inputField('timestamps',
                defaultValue: [DateTime.parse("2021-01-24"), null]),
            Json.graphQLType.nonNull().inputField('json',
                defaultValue: const Json.map({
                  'd': Json.list([Json.number(2)])
                }))
          ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

/// Auto-generated from [EnumValue].
final GraphQLEnumType<EnumValue> enumValueGraphQLType =
    GraphQLEnumType('EnumValue', [
  GraphQLEnumValue('v1', EnumValue.v1),
  GraphQLEnumValue('v2', EnumValue.v2),
  GraphQLEnumValue('v3', EnumValue.v3)
]);
