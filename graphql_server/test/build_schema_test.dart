import 'package:graphql_server/graphql_server.dart';
import 'package:test/test.dart';

void main() {
  test('build schema', () async {
    final schema = buildSchema('''
type DataType {
  sync: String
  syncNonNull: String!
  promise: String
  promiseNonNull: String!
  syncNest: DataType
  syncNonNullNest: DataType!
  promiseNest: DataType
  promiseNonNullNest: DataType!
}

schema {
  query: DataType
}
''');

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
      initialValue: rootValue,
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
