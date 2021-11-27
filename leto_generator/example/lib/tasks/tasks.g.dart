// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final getTasksGraphQLField =
    taskGraphQLType.nonNull().list().nonNull().field<Object?>(
  'getTasks',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getTasks(ctx);
  },
);

final addTaskGraphQLField = graphQLBoolean.nonNull().field<Object?>(
  'addTask',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return addTask(ctx, (args["task"] as Task));
  },
  inputs: [taskGraphQLType.nonNull().coerceToInputObject().inputField('task')],
);

final onAddTaskGraphQLField = taskGraphQLType.nonNull().field<Object?>(
  'onAddTask',
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onAddTask(ctx);
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<WithId>? _withIdGraphQLType;

/// Auto-generated from [WithId].
GraphQLObjectType<WithId> get withIdGraphQLType {
  final __name = 'WithId';
  if (_withIdGraphQLType != null)
    return _withIdGraphQLType! as GraphQLObjectType<WithId>;

  final __withIdGraphQLType =
      objectType<WithId>(__name, isInterface: true, interfaces: []);

  _withIdGraphQLType = __withIdGraphQLType;
  __withIdGraphQLType.fields.addAll(
    [graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)],
  );

  return __withIdGraphQLType;
}

GraphQLObjectType<Named>? _namedGraphQLType;

/// Auto-generated from [Named].
GraphQLObjectType<Named> get namedGraphQLType {
  final __name = 'Named';
  if (_namedGraphQLType != null)
    return _namedGraphQLType! as GraphQLObjectType<Named>;

  final __namedGraphQLType = objectType<Named>(__name,
      isInterface: true, interfaces: [withIdGraphQLType]);

  _namedGraphQLType = __namedGraphQLType;
  __namedGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)
    ],
  );

  return __namedGraphQLType;
}

GraphQLObjectType<WithCreated>? _withCreatedGraphQLType;

/// Auto-generated from [WithCreated].
GraphQLObjectType<WithCreated> get withCreatedGraphQLType {
  final __name = 'WithCreated';
  if (_withCreatedGraphQLType != null)
    return _withCreatedGraphQLType! as GraphQLObjectType<WithCreated>;

  final __withCreatedGraphQLType =
      objectType<WithCreated>(__name, isInterface: true, interfaces: []);

  _withCreatedGraphQLType = __withCreatedGraphQLType;
  __withCreatedGraphQLType.fields.addAll(
    [
      graphQLTimestamp.nonNull().field('createdTimestamp',
          resolve: (obj, ctx) => obj.createdTimestamp)
    ],
  );

  return __withCreatedGraphQLType;
}

final taskSerializer = SerializerValue<Task>(
  key: "Task",
  fromJson: (ctx, json) => Task.fromJson(json), // _$TaskFromJson,
  // toJson: (m) => _$TaskToJson(m as Task),
);

GraphQLObjectType<Task>? _taskGraphQLType;

/// Auto-generated from [Task].
GraphQLObjectType<Task> get taskGraphQLType {
  final __name = 'Task';
  if (_taskGraphQLType != null)
    return _taskGraphQLType! as GraphQLObjectType<Task>;

  final __taskGraphQLType = objectType<Task>(__name,
      isInterface: false,
      interfaces: [namedGraphQLType, withCreatedGraphQLType]);

  _taskGraphQLType = __taskGraphQLType;
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
      userGraphQLType
          .nonNull()
          .list()
          .nonNull()
          .field('assignedTo', resolve: (obj, ctx) => obj.assignedTo)
    ],
  );

  return __taskGraphQLType;
}

final userSerializer = SerializerValue<User>(
  key: "User",
  fromJson: (ctx, json) => User.fromJson(json), // _$UserFromJson,
  // toJson: (m) => _$UserToJson(m as User),
);

GraphQLObjectType<User>? _userGraphQLType;

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType {
  final __name = 'User';
  if (_userGraphQLType != null)
    return _userGraphQLType! as GraphQLObjectType<User>;

  final __userGraphQLType = objectType<User>(__name,
      isInterface: false, interfaces: [namedGraphQLType]);

  _userGraphQLType = __userGraphQLType;
  __userGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name)
    ],
  );

  return __userGraphQLType;
}

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
