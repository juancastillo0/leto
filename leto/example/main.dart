import 'package:leto_schema/leto_schema.dart';
import 'package:leto/leto.dart';
import 'package:test/test.dart';

void main() {
  test('single element', () async {
    final todoType = objectType<Todo>('todo', fields: [
      field(
        'text',
        graphQLString,
        resolve: (obj, args) => obj.text,
      ),
      field(
        'completed',
        graphQLBoolean,
        resolve: (obj, args) => obj.completed,
      ),
    ]);

    final schema = GraphQLSchema(
      queryType: objectType('api', fields: [
        field(
          'todos',
          listOf(todoType),
          resolve: (_, __) => [
            Todo(
              text: 'Clean your room!',
              completed: false,
              time: DateTime.now(),
            )
          ],
        ),
      ]),
    );

    final graphql = GraphQL(schema);
    final result = await graphql.parseAndExecute('{ todos { text } }');

    print(result);
    expect(result, {
      'todos': [
        {'text': 'Clean your room!'}
      ]
    });
  });
}

class Todo {
  final String? text;
  final bool? completed;
  final DateTime time;
  final List<Todo>? inner;

  Todo({
    this.text,
    this.completed,
    required this.time,
    this.inner,
  });

  Map<String, Object?> toJson() {
    return {
      'text': text,
      'completed': completed,
      'inner': inner?.map((e) => e.toJson()).toList(),
      'time': time.toIso8601String(),
    };
  }

  factory Todo.fromJson(Map<String, Object?> map) {
    return Todo(
      text: map['text'] as String?,
      completed: map['completed'] as bool?,
      time: DateTime.parse(map['time']! as String),
      inner: (map['inner'] as List<Object?>?)
          ?.map((e) => Todo.fromJson(e! as Map<String, Object?>))
          .toList(),
    );
  }

  static final serializer = SerializerValue(
    fromJson: (ctx, json) => Todo.fromJson(json),
  );
}
