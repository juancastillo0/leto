import 'package:leto/leto.dart';
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
    expect(result.data, {
      'todos': [
        {'text': 'Clean your room!'}
      ]
    });
  });

  test('mutation', () async {
    final t = DateTime.now();

    final resultmut = await graphql.parseAndExecute(
      'mutation mut1 (\$todoIn: TodoInput) { '
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
    expect(resultmut.data, {
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
