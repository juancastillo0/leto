import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:test/test.dart';

void main() {
  test('arguments generator test', () async {
    expect(
      graphqlApiSchema.schemaStr,
      contains(
        'testManyDefaults(str: String! = "def", intInput: Int! = 2,'
        ' doubleInput: Float! = 3.0, doubleInputNull: Float = 4.2,'
        ' boolean: Boolean! = true, listStr: [String!]! = ["dw", "dd2"],'
        ' listDecimalNull: [Decimal] = [null, "2"],'
        ' listUri: [Uri!]! = ["http://localhost:8060/"],'
        ' date: Date! = "2021-03-24T00:00:00.000",'
        ' gen: InputGenIntReq = {name: "gen", generic: 2},'
        ' enumValue: EnumValue! = v1, enumCustom: Int! = 3,'
        ' enumCustomList: [Int!]! = [2], json: Json! = {d: [2]}): String!',
      ),
    );
    final result = await GraphQL(graphqlApiSchema).parseAndExecute(
      '{testManyDefaults}',
    );
    expect(result.errors, isEmpty);
    final values = jsonDecode(
      (result.data as Map)['testManyDefaults'] as String,
    );

    expect(
      values,
      {
        'str': 'def',
        'intInput': 2,
        'doubleInput': 3,
        'doubleInputNull': 4.2,
        'boolean': true,
        'listStr': ['dw', 'dd2'],
        'listDecimalNull': [null, '2'],
        'listUri': ['http://localhost:8060/'],
        'date': '2021-03-24T00:00:00.000',
        'gen': {'name': 'gen', 'generic': 2},
        'enumValue': 'v1',
        'enumCustom': 3,
        'enumCustomList': [2],
        'json': {
          'd': [2]
        },
      },
    );
  });
}
