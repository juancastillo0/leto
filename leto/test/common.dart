// ignore_for_file: prefer_constructors_over_static_methods

import 'package:collection/collection.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

final Matcher throwsAGraphQLException = throwsA(
  predicate((Object? x) => x is GraphQLException, 'is a GraphQL exception'),
);

@immutable
class Todo {
  final String? text;
  final bool? completed;
  final DateTime time;
  final List<User>? users;

  const Todo({
    this.text,
    this.completed,
    required this.time,
    this.users,
  });

  Map<String, Object?> toJson({bool nested = false}) {
    return {
      if (text != null) 'text': text,
      if (completed != null) 'completed': completed,
      if (users != null)
        'users': nested ? users!.map((e) => e.toJson()).toList() : users,
      'time': time.toIso8601String(),
    };
  }

  static Todo fromJson(Map<String, Object?> map) {
    return Todo(
      text: map['text'] as String?,
      completed: map['completed'] as bool?,
      time: DateTime.parse(map['time']! as String),
      users: (map['users'] as List<Object?>?)
          ?.map((e) => User.fromJson(e! as Map<String, Object?>))
          .toList(),
    );
  }

  static final serializer = SerializerValue(
    fromJson: (ctx, json) => fromJson(json),
  );

  Todo copyWith({
    String? text,
    bool? completed,
    DateTime? time,
    List<User>? users,
  }) {
    return Todo(
      text: text ?? this.text,
      completed: completed ?? this.completed,
      time: time ?? this.time,
      users: users ?? this.users,
    );
  }

  @override
  String toString() {
    return 'Todo(text: $text, completed: $completed,'
        ' time: $time, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Todo &&
        other.text == text &&
        other.completed == completed &&
        other.time == time &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return text.hashCode ^ completed.hashCode ^ time.hashCode ^ users.hashCode;
  }
}

@immutable
class User {
  final String name;
  final int? age;

  const User({
    required this.name,
    this.age,
  });

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      if (age != null) 'age': age,
    };
  }

  static User fromJson(Map<String, Object?> map) {
    return User(
      name: map['name']! as String,
      age: map['age'] as int?,
    );
  }

  static final serializer = SerializerValue(
    fromJson: (ctx, json) => fromJson(json),
  );

  @override
  String toString() => 'User(name: $name, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
