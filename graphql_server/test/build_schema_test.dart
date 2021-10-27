import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';
import 'package:test/test.dart';

void main() {
  test('build schema', () async {
    const schemaStr = '''
schema {
  query: DataType
}

type DataType {
  sync: String
  syncNonNull: String!
  promise: String
  promiseNonNull: String!
  syncNest: DataType
  syncNonNullNest: DataType!
  promiseNest: DataType
  promiseNonNullNest: DataType!
}''';
    final schema = buildSchema(schemaStr);

    expect(printSchema(schema), schemaStr);

    expect(schema.queryType!.name, 'DataType');
    expect(schema.queryType!.fields.length, 8);

    final rootValue = <String, Object?>{'sync': 'bd'};
    rootValue['syncNest'] = () => rootValue;

    const document = '''
query {
  sync
  syncNest {
    syncNonNull
  }
}
''';

    final result = await GraphQL(schema).parseAndExecute(
      document,
      rootValue: rootValue,
    );
    expect(result.toJson(), {
      'data': {'sync': 'bd', 'syncNest': null},
      'errors': [
        {
          'message': isNotEmpty,
          'locations': [
            {'line': 3, 'column': 4}
          ],
          'path': ['syncNest', 'syncNonNull'],
        }
      ]
    });
  });
}
