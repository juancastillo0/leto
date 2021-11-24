import 'package:decimal/decimal.dart';
import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:test/test.dart';

void main() {
  test('interface generator', () async {
    final scope = ScopedMap.empty();

    for (final subs in unionsSchemaString.split('||')) {
      expect(graphqlApiSchema.schemaStr, contains(subs.trim()));
    }

    final states = [
      interfaceState.get(scope),
      InterfaceState(
        m2: NestedInterfaceImpl2(dec: Decimal.one, name2: 'dd', name: 'ca'),
        m3: NestedInterfaceImpl3(
            dec: Decimal.parse('2'), name3: 'd2d', name: 'ca'),
      ),
      InterfaceState(
        m2: NestedInterfaceImpl2(
            dec: Decimal.parse('-2.22'), name2: 'dd', name: null),
        m3: NestedInterfaceImpl3(dec: Decimal.zero, name3: 'd2d', name: null),
      ),
    ];

    for (final s in states) {
      interfaceState.set(scope, s);
      final m3 = s.m3;
      final m2 = s.m2;

      final result = await GraphQL(
        graphqlApiSchema,
        globalVariables: scope,
      ).parseAndExecute(
        '{ getNestedInterfaceImpl3 { name name3 dec }'
        ' getNestedInterfaceImpl2 { name name2 dec }'
        ' index2: getNestedInterfaceImplByIndex(index: 2) { dec }'
        ' index3: getNestedInterfaceImplByIndex(index: 3) { dec } '
        '}',
      );

      expect(result.data, {
        'getNestedInterfaceImpl3': {
          'name': m3.name,
          'name3': m3.name3,
          'dec': m3.dec.toString(),
        },
        'getNestedInterfaceImpl2': {
          'name': m2.name,
          'name2': m2.name2,
          'dec': m2.dec.toString(),
        },
        'index2': {
          'dec': m2.dec.toString(),
        },
        'index3': {
          'dec': m3.dec.toString(),
        },
      });
    }
  });
}
