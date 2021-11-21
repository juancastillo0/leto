import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';

part 'tasks.g.dart';

final tasksRef = RefWithDefault.global(
  (_) => TaskController([
    Task(
      id: '1',
      assignedTo: [User('u1', 'un1')],
      createdTimestamp: DateTime.now(),
      name: 'daw',
      weight: 3,
      image: Uri.parse('http://localhost:8060/path'),
    ),
    Task(
      id: '2',
      assignedTo: [],
      createdTimestamp: DateTime.now().subtract(
        const Duration(
          days: 2,
          minutes: 50,
        ),
      ),
      name: 'daw2',
      weight: 33,
      image: Uri.parse('www.google.com/search?q=leto'),
    ),
  ]),
);

class TaskController {
  final List<Task> tasks;

  TaskController(this.tasks);

  final onAddTask = StreamController<Task>();

  void addTask(Task task) {
    tasks.add(task);
    onAddTask.add(task);
  }
}

const tasksSchemaStr = [
  '''
interface WithId {
  id: ID!
}''',
  '''
interface Named implements WithId {
  name: String!
  id: ID!
}''',
  '''
interface WithCreated {
  createdTimestamp: Timestamp!
}''',
  '''
"""An UNIX timestamp."""
scalar Timestamp''',
  '''
"""
A Uniform Resource Identifier (URI) is a compact sequence of characters that identifies an abstract or physical resource.
"""
scalar Uri @specifiedBy(url: "https://datatracker.ietf.org/doc/html/rfc3986")''',
  '''
type Task implements Named & WithId & WithCreated {
  id: ID!
  name: String!
  description: String
  image: Uri!
  weight: Int!
  extra: Json
  createdTimestamp: Timestamp!
  assignedTo: [User!]!
}''',
  '''
type User implements Named & WithId {
  id: ID!
  name: String!
}''',
];

@GraphQLClass()
abstract class WithId {
  String get id;
}

@GraphQLClass()
abstract class Named implements WithId {
  String get name;
}

@GraphQLClass()
abstract class WithCreated {
  @GraphQLField(type: 'graphQLTimestamp.nonNull()')
  DateTime get createdTimestamp;
}

@GraphQLClass()
@JsonSerializable()
class Task implements Named, WithCreated {
  @override
  final String id;
  @override
  final String name;
  final String? description;
  final Uri image;
  final int weight;
  final Json? extra;
  @override
  @GraphQLField(type: 'graphQLTimestamp.nonNull()')
  final DateTime createdTimestamp;
  final List<User> assignedTo;

  Task({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.weight,
    this.extra,
    required this.createdTimestamp,
    required this.assignedTo,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, Object?> toJson() => _$TaskToJson(this)
    ..['createdTimestamp'] = createdTimestamp.millisecondsSinceEpoch;
}

@GraphQLClass()
@JsonSerializable()
class User implements Named {
  @override
  final String id;
  @override
  final String name;

  User(this.id, this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, Object?> toJson() => _$UserToJson(this);
}

@Query()
List<Task> getTasks(Ctx ctx) {
  return tasksRef.get(ctx).tasks;
}

@Mutation()
bool addTask(Ctx ctx, Task task) {
  tasksRef.get(ctx).addTask(task);
  return true;
}

@Subscription()
Stream<Task> onAddTask(Ctx ctx) {
  return tasksRef.get(ctx).onAddTask.stream;
}
