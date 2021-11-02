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

      final scope = ScopedMap.empty();

      final unionValues = <UnionA>[
        UnionA.a1(one: 2),
        UnionA.a2(dec: Decimal.parse('23')),
        UnionA.a3(one: null),
        UnionA.a3(one: [1, 2]),
        UnionA.a4(one: [1, 2]),
      ];

      for (final item in unionValues) {
        unionARef.setScoped(scope, item);
        final result = await GraphQL(graphqlApiSchema).parseAndExecute(
          '''
          {getUnionA {
            ... on UnionA1 {
              __typename
              one
            }
            ... on UnionA2 {
              __typename
              dec
            }
            ... on UnionA3 {
              __typename
              one
            }
            ... on UnionA4 {
              __typename
              oneRenamed
            }
          }}
          ''',
          globalVariables: scope,
        );

        final json = item.toJson();

        final runtimeType = json.remove('runtimeType') as String;
        if (runtimeType == 'a4') {
          json['oneRenamed'] = json.remove('one');
        }
        expect(result.data, {
          'getUnionA': {
            ...json,
            '__typename': 'Union${runtimeType.toUpperCase()}'
          }
        });
      }
    },
  );
}
