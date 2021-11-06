import 'dart:convert';

import 'package:leto/types/json.dart';
import 'package:leto_generator_example/decimal.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_schema/leto_schema.dart';

part 'arguments.g.dart';

List<Decimal?> _defaultListDecimalNull() => [null, Decimal.parse('2')];

@GraphQLClass()
enum EnumValue { v1, v2, v3 }

final enumCustomGraphQLType = enumType<int>(
  'EnumCustom',
  {
    'TWO': 2,
    'THREE': 3,
  },
);

@Query()
String testManyDefaults({
  String str = 'def',
  int intInput = 2,
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
  @GraphQLDocumentation(typeName: #enumCustomGraphQLType)
      int enumCustom = 3,
  @GraphQLDocumentation(
    typeName: Symbol('enumCustomGraphQLType.nonNull().list().nonNull()'),
  )
      List<int> enumCustomList = const [2],
  Json json = const Json.map({
    'd': Json.list([Json.number(2)])
  }),
}) {
  return jsonEncode({
    'str': str,
    'intInput': intInput,
    'boolean': boolean,
    'listStr': listStr,
    'listDecimalNull': listDecimalNull?.map((e) => e?.toString()).toList(),
    'listUri': listUri.map((u) => u.toString()).toList(),
    'date': date.toIso8601String(),
    'gen': gen,
    'enumValue': enumValue.toString().split('.').last,
    'enumCustom': enumCustom,
    'enumCustomList': enumCustomList,
    'json': json,
  });
}
