// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<String, Object?, Object?> get getNameGraphQLField =>
    _getNameGraphQLField.value;
final _getNameGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<String, Object?, Object?>>(
        (setValue) => setValue(graphQLString.nonNull().field<Object?>(
              'getName',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getName();
              },
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final todoItemInputSerializer = SerializerValue<TodoItemInput>(
  key: "TodoItemInput",
  fromJson: (ctx, json) =>
      TodoItemInput.fromJson(json), // _$TodoItemInputFromJson,
  // toJson: (m) => _$TodoItemInputToJson(m as TodoItemInput),
);
final _todoItemInputGraphQLType =
    HotReloadableDefinition<GraphQLInputObjectType<TodoItemInput>>((setValue) {
  final __name = 'TodoItemInput';

  final __todoItemInputGraphQLType = inputObjectType<TodoItemInput>(__name);

  setValue(__todoItemInputGraphQLType);
  __todoItemInputGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('text'),
      todoItemInputNestedGraphQLType.coerceToInputObject().inputField('nested')
    ],
  );

  return __todoItemInputGraphQLType;
});

/// Auto-generated from [TodoItemInput].
GraphQLInputObjectType<TodoItemInput> get todoItemInputGraphQLType =>
    _todoItemInputGraphQLType.value;

final todoItemInputNestedSerializer = SerializerValue<TodoItemInputNested>(
  key: "TodoItemInputNested",
  fromJson: (ctx, json) =>
      TodoItemInputNested.fromJson(json), // _$TodoItemInputNestedFromJson,
  // toJson: (m) => _$TodoItemInputNestedToJson(m as TodoItemInputNested),
);
final _todoItemInputNestedGraphQLType =
    HotReloadableDefinition<GraphQLInputObjectType<TodoItemInputNested>>(
        (setValue) {
  final __name = 'TodoItemInputNested';

  final __todoItemInputNestedGraphQLType =
      inputObjectType<TodoItemInputNested>(__name);

  setValue(__todoItemInputNestedGraphQLType);
  __todoItemInputNestedGraphQLType.fields.addAll(
    [decimalGraphQLType.coerceToInputObject().inputField('cost')],
  );

  return __todoItemInputNestedGraphQLType;
});

/// Auto-generated from [TodoItemInputNested].
GraphQLInputObjectType<TodoItemInputNested>
    get todoItemInputNestedGraphQLType => _todoItemInputNestedGraphQLType.value;

final _todoItemGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<TodoItem>>((setValue) {
  final __name = 'TodoItem';

  final __todoItemGraphQLType =
      objectType<TodoItem>(__name, isInterface: false, interfaces: []);

  setValue(__todoItemGraphQLType);
  __todoItemGraphQLType.fields.addAll(
    [
      graphQLString.field('text',
          resolve: (obj, ctx) => obj.text,
          description: 'A description of the todo item'),
      graphQLBoolean.field('isComplete',
          resolve: (obj, ctx) => obj.isComplete,
          description: 'Whether this item is complete.'),
      graphQLDate.nonNull().field('createdAt',
          resolve: (obj, ctx) => obj.createdAt,
          deprecationReason: 'Don\'t use this'),
      decimalGraphQLType.field('cost', resolve: (obj, ctx) => obj.cost)
    ],
  );

  return __todoItemGraphQLType;
});

/// Auto-generated from [TodoItem].
GraphQLObjectType<TodoItem> get todoItemGraphQLType =>
    _todoItemGraphQLType.value;
