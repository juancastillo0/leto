import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

void main() {
  test('tasks generator tests', () async {
    for (final str in tasksSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(str));
    }
    final scope = ScopedMap.empty();
    final tasks = tasksRef.get(scope);

    final result = await GraphQL(graphqlApiSchema).parseAndExecute(
      '''
     { getTasks {
        id
        name
        createdTimestamp
        description
        image
        weight
        extra
        assignedTo {
          id
          name
        } } }
     ''',
      globalVariables: scope,
    );

    expect(
      result.toJson(),
      {
        'data': <String, Object?>{
          'getTasks': jsonDecode(jsonEncode(tasks.tasks)),
        },
      },
    );
  });
}
