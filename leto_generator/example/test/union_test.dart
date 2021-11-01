import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:test/test.dart';

void main() {
  test(
    'freezed unions',
    () async {
      for (final subs in unionsASchemaString) {
        expect(graphqlApiSchema.schemaStr, contains(subs));
      }
    },
  );
}
