// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<List<Task>, Object?, Object?> get getTasksGraphQLField =>
    _getTasksGraphQLField.value;
final _getTasksGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<List<Task>, Object?, Object?>>(
        (setValue) =>
            setValue(taskGraphQLType.nonNull().list().nonNull().field<Object?>(
              'getTasks',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getTasks(ctx);
              },
            )));

GraphQLObjectField<bool, Object?, Object?> get addTaskGraphQLField =>
    _addTaskGraphQLField.value;
final _addTaskGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<bool, Object?, Object?>>(
    (setValue) => setValue(graphQLBoolean.nonNull().field<Object?>(
          'addTask',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return addTask(ctx, (args["task"] as Task));
          },
        ))
          ..inputs.addAll([taskGraphQLTypeInput.nonNull().inputField('task')]));

GraphQLObjectField<Task, Object?, Object?> get onAddTaskGraphQLField =>
    _onAddTaskGraphQLField.value;
final _onAddTaskGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<Task, Object?, Object?>>(
        (setValue) => setValue(taskGraphQLType.nonNull().field<Object?>(
              'onAddTask',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                return onAddTask(ctx);
              },
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _withIdGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<WithId>>((setValue) {
  final __name = 'WithId';

  final __withIdGraphQLType =
      objectType<WithId>(__name, isInterface: true, interfaces: []);

  setValue(__withIdGraphQLType);
  __withIdGraphQLType.fields.addAll(
    [graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)],
  );

  return __withIdGraphQLType;
});

/// Auto-generated from [WithId].
GraphQLObjectType<WithId> get withIdGraphQLType => _withIdGraphQLType.value;

final _namedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Named>>((setValue) {
  final __name = 'Named';

  final __namedGraphQLType = objectType<Named>(__name,
      isInterface: true, interfaces: [withIdGraphQLType]);

  setValue(__namedGraphQLType);
  __namedGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)
    ],
  );

  return __namedGraphQLType;
});

/// Auto-generated from [Named].
GraphQLObjectType<Named> get namedGraphQLType => _namedGraphQLType.value;

final _withCreatedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<WithCreated>>((setValue) {
  final __name = 'WithCreated';

  final __withCreatedGraphQLType =
      objectType<WithCreated>(__name, isInterface: true, interfaces: []);

  setValue(__withCreatedGraphQLType);
  __withCreatedGraphQLType.fields.addAll(
    [
      graphQLTimestamp.nonNull().field('createdTimestamp',
          resolve: (obj, ctx) => obj.createdTimestamp)
    ],
  );

  return __withCreatedGraphQLType;
});

/// Auto-generated from [WithCreated].
GraphQLObjectType<WithCreated> get withCreatedGraphQLType =>
    _withCreatedGraphQLType.value;

final taskSerializer = SerializerValue<Task>(
  key: "Task",
  fromJson: (ctx, json) => Task.fromJson(json), // _$TaskFromJson,
  // toJson: (m) => _$TaskToJson(m as Task),
);
final _taskGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Task>>((setValue) {
  final __name = 'Task';

  final __taskGraphQLType = objectType<Task>(__name,
      isInterface: false,
      interfaces: [namedGraphQLType, withCreatedGraphQLType]);

  setValue(__taskGraphQLType);
  __taskGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLString.field('description',
          resolve: (obj, ctx) => obj.description),
      graphQLUri.nonNull().field('image', resolve: (obj, ctx) => obj.image),
      graphQLInt.nonNull().field('weight', resolve: (obj, ctx) => obj.weight),
      Json.graphQLType.field('extra', resolve: (obj, ctx) => obj.extra),
      graphQLTimestamp.nonNull().field('createdTimestamp',
          resolve: (obj, ctx) => obj.createdTimestamp),
      userGraphQLType.nonNull().list().nonNull().field('assignedTo',
          resolve: (obj, ctx) => obj.assignedTo,
          attachments: [
            ...Task.assignedToAttachments(),
          ])
    ],
  );

  return __taskGraphQLType;
});

/// Auto-generated from [Task].
GraphQLObjectType<Task> get taskGraphQLType => _taskGraphQLType.value;
final _taskGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<Task>>((setValue) {
  final __name = 'TaskInput';

  final __taskGraphQLTypeInput = inputObjectType<Task>(__name);

  setValue(__taskGraphQLTypeInput);
  __taskGraphQLTypeInput.fields.addAll(
    [
      graphQLId.nonNull().inputField('id'),
      graphQLString.nonNull().inputField('name'),
      graphQLUri.nonNull().inputField('image'),
      graphQLString.inputField('description'),
      graphQLInt.nonNull().inputField('weight'),
      Json.graphQLType.inputField('extra'),
      graphQLDate.nonNull().inputField('createdTimestamp'),
      userGraphQLTypeInput
          .nonNull()
          .list()
          .nonNull()
          .inputField('assignedTo', attachments: [
        ...Task.assignedToAttachments(),
      ])
    ],
  );

  return __taskGraphQLTypeInput;
});

/// Auto-generated from [Task].
GraphQLInputObjectType<Task> get taskGraphQLTypeInput =>
    _taskGraphQLTypeInput.value;

final userSerializer = SerializerValue<User>(
  key: "User",
  fromJson: (ctx, json) => User.fromJson(json), // _$UserFromJson,
  // toJson: (m) => _$UserToJson(m as User),
);
final _userGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<User>>((setValue) {
  final __name = 'User';

  final __userGraphQLType = objectType<User>(__name,
      isInterface: false, interfaces: [namedGraphQLType]);

  setValue(__userGraphQLType);
  __userGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name)
    ],
  );

  return __userGraphQLType;
});

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType => _userGraphQLType.value;
final _userGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<User>>((setValue) {
  final __name = 'UserInput';

  final __userGraphQLTypeInput = inputObjectType<User>(__name);

  setValue(__userGraphQLTypeInput);
  __userGraphQLTypeInput.fields.addAll(
    [
      graphQLId.nonNull().inputField('id'),
      graphQLString.nonNull().inputField('name')
    ],
  );

  return __userGraphQLTypeInput;
});

/// Auto-generated from [User].
GraphQLInputObjectType<User> get userGraphQLTypeInput =>
    _userGraphQLTypeInput.value;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      name: json['name'] as String,
      image: Uri.parse(json['image'] as String),
      description: json['description'] as String?,
      weight: json['weight'] as int,
      extra:
          json['extra'] == null ? null : Json.fromJson(json['extra'] as Object),
      createdTimestamp: DateTime.parse(json['createdTimestamp'] as String),
      assignedTo: (json['assignedTo'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image.toString(),
      'weight': instance.weight,
      'extra': instance.extra,
      'createdTimestamp': instance.createdTimestamp.toIso8601String(),
      'assignedTo': instance.assignedTo,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
