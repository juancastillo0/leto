import 'package:leto_generator_example/generics_oxidized.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:test/test.dart';

void main() {
  test('generics oxidized generator', () async {
    for (final subs in genericsOxidizedSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(subs));
    }
  });
}
