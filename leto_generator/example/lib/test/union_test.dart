import 'package:leto/leto.dart';
import 'package:leto_generator_example/decimal.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:test/test.dart';

void main() {
  test(
    'freezed unions generator',
    () async {
      for (final subs in unionsASchemaString) {
        expect(graphqlApiSchema.schemaStr, contains(subs));
      }

      final scope = ScopedMap();

      final unionValues = <UnionA>[
        UnionA.a1(one: 2),
        UnionA.a2(dec: Decimal.parse('23')),
        UnionA.a3(one: null),
        UnionA.a3(one: [1, 2]),
        UnionA.a4(one: [1, 2]),
      ];
      final executor = GraphQL(
        graphqlApiSchema,
        globalVariables: scope,
      );
      for (final item in unionValues) {
        unionARef.get(scope).value = item;
        final result = await executor.parseAndExecute(
          '''
          {getUnionA {
            __typename
            ... on UnionA1 {
              one1: one
            }
            ... on UnionA2 {
              dec
            }
            ... on UnionA3 {
              one3: one
            }
            ... on UnionA4 {
              one4: oneRenamed
            }
          }}
          ''',
        );

        final json = item.toJson();

        final runtimeType = json.remove('runtimeType') as String;
        if (runtimeType != 'a2') {
          json['one${runtimeType.substring(1)}'] = json.remove('one');
        }
        expect(result.data, {
          'getUnionA': <String, Object?>{
            ...json,
            '__typename': 'Union${runtimeType.toUpperCase()}'
          }
        });
      }
    },
  );

  test('no freezed union', () {
    for (final subs in unionNoFreezedSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(subs));
    }
  });
}
