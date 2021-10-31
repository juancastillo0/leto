import 'package:graphql_schema/graphql_schema.dart';

import 'common.dart';

GraphQLSchema todosSchema() {
  final userType = objectType<User>('User', fields: [
    field(
      'name',
      graphQLString.nonNull(),
    ),
    field(
      'age',
      graphQLInt,
    ),
  ]);

  final todoType = objectType<Todo>('Todo', fields: [
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
    graphQLDate.nonNull().field('time'),
    field(
      'users',
      listOf(userType),
    ),
  ]);

  final serdeCtx = SerdeCtx();

  serdeCtx.addAll([
    Todo.serializer,
    User.serializer,
  ]);

  final schema = GraphQLSchema(
    serdeCtx: serdeCtx,
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
    mutationType: objectType(
      'Mutation',
      fields: [
        field(
          'completeTodo',
          todoType,
          inputs: [
            GraphQLFieldInput(
              'todoIn',
              todoType.coerceToInputObject(),
            ),
          ],
          resolve: (obj, ctx) {
            final todo = ctx.args['todoIn'] as Todo;
            return todo.copyWith(
              completed: true,
            );
          },
        ),
      ],
    ),
  );

  return schema;
}
