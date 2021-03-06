import 'package:leto_generator_example/decimal.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:test/test.dart';

void main() {
  test(
    'schema generator',
    () {
      final built = buildSchema(graphqlApiSchema.schemaStr);
      final round = printSchema(built);

      expect(round, graphqlApiSchema.schemaStr);
    },
  );

  test(
    'schema generator validate',
    () {
      final errors = validateSchema(graphqlApiSchema);
      expect(errors, isEmpty);
      final built = buildSchema(graphqlApiSchema.schemaStr);
      final errorsBuilt = validateSchema(built);
      expect(errorsBuilt, isEmpty);
    },
  );

  test('schema decimal', () {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          decimalGraphQLType.field(
            'decimal',
            inputs: [
              inputField(
                'input',
                decimalGraphQLType,
                defaultValue: Decimal.zero,
              ),
            ],
            resolve: (obj, ctx) {
              return ctx.args['input']! as Decimal;
            },
          ),
        ],
      ),
    );
    final built = buildSchema(schema.schemaStr);

    expect(printSchema(built), schema.schemaStr);
  });
}
