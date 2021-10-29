// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<String, Object, Object> getNameGraphQLField = field(
  'getName',
  graphQLString.nonNull() as GraphQLType<String, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getName();
  },
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final todoItemInputSerializer = SerializerValue<TodoItemInput>(
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

  final __todoItemInputGraphQLType =
      inputObjectType<TodoItemInput>('TodoItemInput');

  _todoItemInputGraphQLType = __todoItemInputGraphQLType;
  __todoItemInputGraphQLType.fields.addAll(
    [
      inputField('text', graphQLString.nonNull().coerceToInputObject()),
      inputField('nested', todoItemInputNestedGraphQLType.coerceToInputObject())
    ],
  );

  return __todoItemInputGraphQLType;
}

final todoItemInputSSerializer = SerializerValue<TodoItemInputS>(
  fromJson: (ctx, json) =>
      TodoItemInputS.fromJson(json), // _$TodoItemInputSFromJson,
  // toJson: (m) => _$TodoItemInputSToJson(m as TodoItemInputS),
);

GraphQLInputObjectType<TodoItemInputS>? _todoItemInputSGraphQLType;

/// Auto-generated from [TodoItemInputS].
GraphQLInputObjectType<TodoItemInputS> get todoItemInputSGraphQLType {
  final __name = 'TodoItemInputS';
  if (_todoItemInputSGraphQLType != null)
    return _todoItemInputSGraphQLType!
        as GraphQLInputObjectType<TodoItemInputS>;

  final __todoItemInputSGraphQLType =
      inputObjectType<TodoItemInputS>('TodoItemInputS');

  _todoItemInputSGraphQLType = __todoItemInputSGraphQLType;
  __todoItemInputSGraphQLType.fields.addAll(
    [
      inputField('text', graphQLString.nonNull().coerceToInputObject()),
      inputField('nested', todoItemInputNestedGraphQLType.coerceToInputObject())
    ],
  );

  return __todoItemInputSGraphQLType;
}

final todoItemInputNestedSerializer = SerializerValue<TodoItemInputNested>(
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
      inputObjectType<TodoItemInputNested>('TodoItemInputNested');

  _todoItemInputNestedGraphQLType = __todoItemInputNestedGraphQLType;
  __todoItemInputNestedGraphQLType.fields.addAll(
    [inputField('cost', decimalGraphQLType.coerceToInputObject())],
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
      objectType<TodoItem>('TodoItem', isInterface: false, interfaces: []);

  _todoItemGraphQLType = __todoItemGraphQLType;
  __todoItemGraphQLType.fields.addAll(
    [
      field('text', graphQLString,
          resolve: (obj, ctx) => obj.text,
          description: 'A description of the todo item'),
      field('isComplete', graphQLBoolean,
          resolve: (obj, ctx) => obj.isComplete,
          description: 'Whether this item is complete.'),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          deprecationReason: 'Don\'t use this'),
      field('cost', decimalGraphQLType, resolve: (obj, ctx) => obj.cost)
    ],
  );

  return __todoItemGraphQLType;
}
