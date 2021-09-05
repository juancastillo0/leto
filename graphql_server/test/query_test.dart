import 'package:graphql_server/graphql_server.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'todos_schema.dart';

void main() {
  late GraphQL graphql;

  setUp(() {
    final schema = todosSchema();
    graphql = GraphQL(schema);
  });

  test('single element', () async {
    final result = await graphql.parseAndExecute('{ todos { text } }');

    print(result);
    expect(result, {
      'todos': [
        {'text': 'Clean your room!'}
      ]
    });
  });

  test('mutation', () async {
    final t = DateTime.now();

    final resultmut = await graphql.parseAndExecute(
      'mutation mut1 (\$todoIn: Todo) { '
      '  completeTodo(todoIn: \$todoIn) { text, time, completed, users {name}} '
      '}',
      variableValues: {
        'todoIn': Todo(
          text: 'Clean your room! mut',
          completed: false,
          time: t,
          users: const [User(name: 'Jus')],
        ).toJson(nested: true),
      },
    );

    print(resultmut);
    expect(resultmut, {
      'completeTodo': {
        'text': 'Clean your room! mut',
        'completed': true,
        'time': t.toIso8601String(),
        'users': [
          {'name': 'Jus'}
        ]
      }
    });
  });
}
