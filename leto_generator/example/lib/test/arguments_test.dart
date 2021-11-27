import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_generator_example/arguments.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:test/test.dart';

void main() {
  test('arguments generator test', () async {
    expect(
      graphqlApiSchema.schemaStr,
      contains(testManyDefaultsGraphQLStr),
    );
    final result = await GraphQL(graphqlApiSchema).parseAndExecute(
      '{testManyDefaults}',
    );
    expect(result.errors, isEmpty);
    final Object? values = jsonDecode(
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
        'timestamps': [1611446400000, null],
        'json': {
          'd': [2]
        },
      },
    );
  });
  test('arguments generator errors', () async {
    const wrongInputs = <String, String>{
      'str': '2',
      'intInput': '2.1',
      'doubleInput': '"3"',
      'doubleInputNull': '[4.2]',
      'boolean': '"true"',
      'listStr': '["dw", 2]',
      'listDecimalNull': '[null, "sw"]',
      'listUri': '[2]',
      'date': '2',
      'gen': '{name: 2, generic: 2}',
      'enumValue': 'v5',
      'enumCustom': '-3',
      'enumCustomList': '[2.3]',
      'timestamps': '["2.3"]',
    };
    for (final e in wrongInputs.entries) {
      final result = await GraphQL(graphqlApiSchema).parseAndExecute(
        '{ testManyDefaults(${e.key}:${e.value}) }',
      );
      expect(result.errors, isNotEmpty);
      expect(
        result.errors[0].message,
        stringContainsInOrder(
          [
            e.key,
            'testManyDefaults',
          ],
        ),
      );
    }
  });
}
