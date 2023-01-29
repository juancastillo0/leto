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
  fromJson: (ctx, json) => TodoItemInput.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _todoItemInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<TodoItemInput>>((setValue) {
  final __name = 'TodoItemInput';

  final __todoItemInputGraphQLTypeInput =
      inputObjectType<TodoItemInput>(__name);

  setValue(__todoItemInputGraphQLTypeInput);
  __todoItemInputGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('text'),
      todoItemInputNestedGraphQLTypeInput.inputField('nested'),
    ],
  );

  return __todoItemInputGraphQLTypeInput;
});

/// Auto-generated from [TodoItemInput].
GraphQLInputObjectType<TodoItemInput> get todoItemInputGraphQLTypeInput =>
    _todoItemInputGraphQLTypeInput.value;

final todoItemInputNestedSerializer = SerializerValue<TodoItemInputNested>(
  key: "TodoItemInputNested",
  fromJson: (ctx, json) => TodoItemInputNested.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _todoItemInputNestedGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<TodoItemInputNested>>(
        (setValue) {
  final __name = 'TodoItemInputNested';

  final __todoItemInputNestedGraphQLTypeInput =
      inputObjectType<TodoItemInputNested>(__name);

  setValue(__todoItemInputNestedGraphQLTypeInput);
  __todoItemInputNestedGraphQLTypeInput.fields.addAll(
    [decimalGraphQLType.inputField('cost')],
  );

  return __todoItemInputNestedGraphQLTypeInput;
});

/// Auto-generated from [TodoItemInputNested].
GraphQLInputObjectType<TodoItemInputNested>
    get todoItemInputNestedGraphQLTypeInput =>
        _todoItemInputNestedGraphQLTypeInput.value;

final _todoItemGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<TodoItem>>((setValue) {
  final __name = 'TodoItem';

  final __todoItemGraphQLType = objectType<TodoItem>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__todoItemGraphQLType);
  __todoItemGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'text',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.text,
        description: 'A description of the todo item',
      ),
      graphQLBoolean.field(
        'isComplete',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.isComplete,
        description: 'Whether this item is complete.',
      ),
      graphQLDate.nonNull().field(
            'createdAt',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.createdAt,
            deprecationReason: 'Don\'t use this',
          ),
      decimalGraphQLType.field(
        'cost',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.cost,
      ),
    ],
  );

  return __todoItemGraphQLType;
});

/// Auto-generated from [TodoItem].
GraphQLObjectType<TodoItem> get todoItemGraphQLType =>
    _todoItemGraphQLType.value;
