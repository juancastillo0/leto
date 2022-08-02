import 'package:leto/leto.dart';
import 'package:leto_generator_example/attachments.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:test/test.dart';

void main() {
  group('attachments', () {
    test('schema String', () {
      for (final str in keyedAttachmentGraphQLStrings) {
        expect(graphqlApiSchema.schemaStr, contains(str));
      }
    });

    test('wrong key attachment', () {
      Object? error;
      try {
        GraphQL(
          GraphQLSchema(
            queryType: objectType(
              'Query',
              fields: [
                field(
                  'getObject',
                  objectType(
                    'ObjectWithKey',
                    extra: const GraphQLTypeDefinitionExtra.attach(
                      // this should be 'key' to work
                      [KeyAttachment('id')],
                    ),
                    fields: [
                      graphQLInt.nonNull().field(
                            'key',
                            resolve: (parent, ctx) => 3,
                          )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } catch (e) {
        error = e;
      }

      expect(error, isA<GraphQLException>());
      final exception = error! as GraphQLException;
      expect(exception.errors.map((e) => e.toJson()), [
        {
          'message': 'KeyAttachment(fields: "id") error for element'
              ' ObjectWithKey. Cannot query field "id" on type "ObjectWithKey".'
        }
      ]);
    });
  });
}
