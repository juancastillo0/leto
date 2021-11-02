import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:test/test.dart';

void main() {
  test('input generator', () {
    for (final subs in inputsSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(subs.trim()));
    }
  });
}
