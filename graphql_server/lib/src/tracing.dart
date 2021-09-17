// https://github.com/apollographql/apollo-tracing
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';
import 'package:graphql_server/src/extension.dart';

class GraphQLTracingExtension extends GraphQLExtension {
  final ref = GlobalRef('GraphQLTracingExtension');

  @override
  String get mapKey => 'tracing';

  @override
  void start(
    Map<Object, Object?> globals,
    Map<String, Object?>? extensions,
  ) {
    globals[ref] = TracingBuilder(version: 1);
  }

  @override
  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) async {
    final tracing = ctx.globalVariables[ref] as TracingBuilder;

    final endTracing = tracing.execution.start(ResolverTracing(
      path: [...ctx.path, fieldAlias],
      parentType: field.type.realType.toString(),
      fieldName: field.name,
      returnType: field.type.toString(),
    ));
    try {
      return await next();
    } finally {
      endTracing();
    }
  }

  @override
  Object? toJson(Map<Object, Object?> globals) {
    final tracing = globals[ref]! as TracingBuilder;
    return tracing.toJson();
  }
}

// "extensions": {
//     "tracing": {
//       "version": 1,
//       "startTime": <>,
//       "endTime": <>,
//       "duration": <>,
//       "parsing": {
//         "startOffset": <>,
//         "duration": <>,
//       },
//       "validation": {
//         "startOffset": <>,
//         "duration": <>,
//       },
//       "execution": {
//         "resolvers": [
//           {
//             "path": [<>, ...],
//             "parentType": <>,
//             "fieldName": <>,
//             "returnType": <>,
//             "startOffset": <>,
//             "duration": <>,
//           },
//           ...
//         ]
//       }
//     }
// }

class TracingBuilder {
  final int version;
  final DateTime startTime;
  final Stopwatch stopwatch = Stopwatch()..start();

  TracingBuilder({required this.version, DateTime? startTime})
      : startTime = startTime ?? DateTime.now();

  late final parsing = TracingItemBuilder(stopwatch);
  late final validation = TracingItemBuilder(stopwatch);
  late final execution = ExecutionTracingBuilder(stopwatch);

  Tracing build() {
    final endTime = DateTime.now();
    return Tracing(
      version: version,
      startTime: startTime,
      endTime: endTime,
      duration: stopwatch.elapsedMicroseconds,
      parsing: parsing.build(),
      validation: validation.build(),
      execution: execution.build(),
    );
  }

  Map<String, Object?> toJson() {
    final endTime = DateTime.now();
    return {
      'version': version,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': stopwatch.elapsedMicroseconds,
      'parsing': parsing.build().toJson(),
      'validation': validation.build().toJson(),
      'execution': execution.build().toJson(),
    };
  }
}

class TracingItemBuilder {
  final Stopwatch stopwatch;
  int? startOffset;
  int? duration;

  TracingItemBuilder(this.stopwatch);

  void Function() start() {
    assert(startOffset == null);
    startOffset = stopwatch.elapsedMicroseconds;
    return end;
  }

  void end() => duration = stopwatch.elapsedMicroseconds - startOffset!;

  T trace<T>(T Function() func) {
    assert(startOffset == null);
    try {
      startOffset = stopwatch.elapsedMicroseconds;
      final result = func();
      return result;
    } finally {
      duration = stopwatch.elapsedMicroseconds - startOffset!;
    }
  }

  FutureOr<T> traceAsync<T>(FutureOr<T> Function() func) async {
    assert(startOffset == null);
    try {
      startOffset = stopwatch.elapsedMicroseconds;
      final result = await func();
      return result;
    } finally {
      duration = stopwatch.elapsedMicroseconds - startOffset!;
    }
  }

  TracingItem build() {
    return TracingItem(
      startOffset: startOffset!,
      duration: duration!,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'startOffset': startOffset,
      'duration': duration,
    };
  }
}

class Tracing {
  final int version;
  final DateTime startTime;
  final DateTime endTime;

  /// in nanoseconds
  final int duration;
  final TracingItem parsing;
  final TracingItem validation;
  final ExecutionTracing execution;

  Tracing({
    required this.version,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.parsing,
    required this.validation,
    required this.execution,
  });

  Tracing copyWith({
    int? version,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    TracingItem? parsing,
    TracingItem? validation,
    ExecutionTracing? execution,
  }) {
    return Tracing(
      version: version ?? this.version,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      parsing: parsing ?? this.parsing,
      validation: validation ?? this.validation,
      execution: execution ?? this.execution,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'version': version,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': duration,
      'parsing': parsing.toJson(),
      'validation': validation.toJson(),
      'execution': execution.toJson(),
    };
  }

  factory Tracing.fromJson(Map<String, Object?> map) {
    return Tracing(
      version: map['version']! as int,
      startTime: DateTime.parse(map['startTime']! as String),
      endTime: DateTime.parse(map['endTime']! as String),
      duration: map['duration']! as int,
      parsing: TracingItem.fromJson(map['parsing']! as Map<String, Object?>),
      validation:
          TracingItem.fromJson(map['validation']! as Map<String, Object?>),
      execution: ExecutionTracing.fromJson(
        map['execution']! as Map<String, Object?>,
      ),
    );
  }

  @override
  String toString() {
    return 'Tracing(version: $version, startTime: $startTime, '
        'endTime: $endTime, duration: $duration, '
        'parsing: $parsing, validation: $validation, execution: $execution)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tracing &&
        other.version == version &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.duration == duration &&
        other.parsing == parsing &&
        other.validation == validation;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        duration.hashCode ^
        parsing.hashCode ^
        validation.hashCode;
  }
}

abstract class TracingItemI {
  /// in nanoseconds
  int get startOffset;

  /// in nanoseconds
  int get duration;
}

class TracingItem implements TracingItemI {
  @override
  final int startOffset;

  @override
  final int duration;

  TracingItem({
    required this.startOffset,
    required this.duration,
  });

  TracingItem copyWith({
    int? startOffset,
    int? duration,
  }) {
    return TracingItem(
      startOffset: startOffset ?? this.startOffset,
      duration: duration ?? this.duration,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'startOffset': startOffset,
      'duration': duration,
    };
  }

  factory TracingItem.fromJson(Map<String, Object?> map) {
    return TracingItem(
      startOffset: map['startOffset']! as int,
      duration: map['duration']! as int,
    );
  }

  @override
  String toString() =>
      'TracingItem(startOffset: $startOffset, duration: $duration)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TracingItem &&
        other.startOffset == startOffset &&
        other.duration == duration;
  }

  @override
  int get hashCode => startOffset.hashCode ^ duration.hashCode;
}

class ExecutionTracingBuilder {
  final Stopwatch stopwatch;
  final Map<ResolverTracing, TracingItemBuilder> resolvers = {};

  ExecutionTracingBuilder(this.stopwatch);

  TracingItemBuilder tracing(ResolverTracing resolver) {
    return resolvers.putIfAbsent(
      resolver,
      () => TracingItemBuilder(stopwatch),
    );
  }

  void Function() start(ResolverTracing resolver) {
    final tracing = resolvers.putIfAbsent(
      resolver,
      () => TracingItemBuilder(stopwatch),
    );
    return tracing.start();
  }

  ExecutionTracing build() {
    return ExecutionTracing(
      resolvers: resolvers.map(
        (key, value) => MapEntry(key, value.build()),
      ),
    );
  }
}

class ExecutionTracing {
  final Map<ResolverTracing, TracingItem> resolvers;
  ExecutionTracing({
    required this.resolvers,
  });

  ExecutionTracing copyWith({
    Map<ResolverTracing, TracingItem>? resolvers,
  }) {
    return ExecutionTracing(
      resolvers: resolvers ?? this.resolvers,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'resolvers': resolvers.entries.map((x) => x.key.toJson(x.value)).toList(),
    };
  }

  factory ExecutionTracing.fromJson(Map<String, Object?> map) {
    return ExecutionTracing(
        resolvers: Map.fromEntries(
      (map['resolvers'] as List?)!.map(
        (Object? x) => MapEntry(
          ResolverTracing.fromJson(x! as Map<String, Object?>),
          TracingItem.fromJson(map),
        ),
      ),
    ));
  }

  @override
  String toString() => 'ExecutionTracing(resolvers: $resolvers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ExecutionTracing && listEquals(other.resolvers, resolvers);
  }

  @override
  int get hashCode => resolvers.hashCode;
}

class ResolverTracing {
  final List<Object> path;
  final String parentType;
  final String fieldName;
  final String returnType;

  ResolverTracing({
    required this.path,
    required this.parentType,
    required this.fieldName,
    required this.returnType,
  });

  ResolverTracing copyWith({
    List<Object>? path,
    String? parentType,
    String? fieldName,
    String? returnType,
    int? startOffset,
    int? duration,
  }) {
    return ResolverTracing(
      path: path ?? this.path,
      parentType: parentType ?? this.parentType,
      fieldName: fieldName ?? this.fieldName,
      returnType: returnType ?? this.returnType,
    );
  }

  Map<String, Object?> toJson(TracingItemI tracing) {
    return {
      'path': path,
      'parentType': parentType,
      'fieldName': fieldName,
      'returnType': returnType,
      'startOffset': tracing.startOffset,
      'duration': tracing.duration,
    };
  }

  factory ResolverTracing.fromJson(Map<String, Object?> map) {
    return ResolverTracing(
      path: map['path']! as List<Object>,
      parentType: map['parentType']! as String,
      fieldName: map['fieldName']! as String,
      returnType: map['returnType']! as String,
    );
  }

  @override
  String toString() {
    return 'ResolverTracing(path: $path, parentType: $parentType, fieldName: '
        '$fieldName, returnType: $returnType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ResolverTracing &&
        listEquals(other.path, path) &&
        other.parentType == parentType &&
        other.fieldName == fieldName &&
        other.returnType == returnType;
  }

  @override
  int get hashCode {
    return path.hashCode ^
        parentType.hashCode ^
        fieldName.hashCode ^
        returnType.hashCode;
  }
}
