// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final getNameGraphQLField = graphQLString.nonNull().field<Object?>(
  'getName',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getName();
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final todoItemInputSerializer = SerializerValue<TodoItemInput>(
  key: "TodoItemInput",
  fromJson: (ctx, json) =>
      TodoItemInput.fromJson(json), // _$TodoItemInputFromJson,
  // toJson: (m) => _$TodoItemInputToJson(m as TodoItemInput),
);

GraphQLInputObjectType<TodoItemInput>? _todoItemInputGraphQLType;

/// Auto-generated from [TodoItemInput].
GraphQLInputObjectType<TodoItemInput> get todoItemInputGraphQLType {
  final __name = 'TodoItemInput';
  if (_todoItemInputGraphQLType != null)
    return _todoItemInputGraphQLType! as GraphQLInputObjectType<TodoItemInput>;

  final __todoItemInputGraphQLType = inputObjectType<TodoItemInput>(__name);

  _todoItemInputGraphQLType = __todoItemInputGraphQLType;
  __todoItemInputGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('text'),
      todoItemInputNestedGraphQLType.coerceToInputObject().inputField('nested')
    ],
  );

  return __todoItemInputGraphQLType;
}

final todoItemInputNestedSerializer = SerializerValue<TodoItemInputNested>(
  key: "TodoItemInputNested",
  fromJson: (ctx, json) =>
      TodoItemInputNested.fromJson(json), // _$TodoItemInputNestedFromJson,
  // toJson: (m) => _$TodoItemInputNestedToJson(m as TodoItemInputNested),
);

GraphQLInputObjectType<TodoItemInputNested>? _todoItemInputNestedGraphQLType;

/// Auto-generated from [TodoItemInputNested].
GraphQLInputObjectType<TodoItemInputNested> get todoItemInputNestedGraphQLType {
  final __name = 'TodoItemInputNested';
  if (_todoItemInputNestedGraphQLType != null)
    return _todoItemInputNestedGraphQLType!
        as GraphQLInputObjectType<TodoItemInputNested>;

  final __todoItemInputNestedGraphQLType =
      inputObjectType<TodoItemInputNested>(__name);

  _todoItemInputNestedGraphQLType = __todoItemInputNestedGraphQLType;
  __todoItemInputNestedGraphQLType.fields.addAll(
    [decimalGraphQLType.coerceToInputObject().inputField('cost')],
  );

  return __todoItemInputNestedGraphQLType;
}

GraphQLObjectType<TodoItem>? _todoItemGraphQLType;

/// Auto-generated from [TodoItem].
GraphQLObjectType<TodoItem> get todoItemGraphQLType {
  final __name = 'TodoItem';
  if (_todoItemGraphQLType != null)
    return _todoItemGraphQLType! as GraphQLObjectType<TodoItem>;

  final __todoItemGraphQLType =
      objectType<TodoItem>(__name, isInterface: false, interfaces: []);

  _todoItemGraphQLType = __todoItemGraphQLType;
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
}
