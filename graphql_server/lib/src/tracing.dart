import 'dart:async';

import 'package:collection/collection.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_server/graphql_server.dart';
import 'package:meta/meta.dart';

/// Apollo Tracing is a GraphQL extension for performance tracing.
///
/// More information: https://github.com/apollographql/apollo-tracing
class GraphQLTracingExtension extends GraphQLExtension {
  GraphQLTracingExtension({
    this.onExecute,
    this.returnInResponse = true,
  });

  /// Allows you to access the tracing information for each
  /// request and subscription event.
  ///
  /// Useful for logging the trace directly instead of returning
  /// it in the response extensions.
  final void Function(TracingBuilder)? onExecute;

  /// Whether the trace information should be retuned in the
  /// response extensions.
  ///
  /// If false, you probably want to pass an [onExecute] callback.
  final bool returnInResponse;

  final ref = GlobalRef('GraphQLTracingExtension');

  @override
  String get mapKey => 'tracing';

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) async {
    final tracing = TracingBuilder(version: 1);
    globals.setScoped(ref, tracing);

    final result = await next();

    tracing.end();
    onExecute?.call(tracing);
    if (returnInResponse) {
      return result.copyWithExtension(mapKey, tracing.toJson());
    }
    return result;
  }

  @override
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) {
    final tracing = globals[ref]! as TracingBuilder;
    final endParsing = tracing.parsing.start();
    final document = next();
    endParsing();
    return document;
  }

  @override
  GraphQLException? validate(
    GraphQLException? Function() next,
    GraphQLSchema schema,
    DocumentNode document,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) {
    final tracing = globals[ref]! as TracingBuilder;
    final endValidation = tracing.validation.start();
    final exception = next();
    endValidation();
    return exception;
  }

  @override
  FutureOr<Object?> executeField(
    FutureOr<Object?> Function() next,
    ResolveObjectCtx ctx,
    GraphQLObjectField field,
    String fieldAlias,
  ) async {
    final tracing = ctx.globalVariables[ref]! as TracingBuilder;

    final endTracing = tracing.execution.start(ResolverTracing(
      path: [...ctx.path, fieldAlias],
      parentType: ctx.objectType.toString(),
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
  FutureOr<GraphQLResult> executeSubscriptionEvent(
    FutureOr<GraphQLResult> Function() next,
    ResolveCtx ctx,
    ScopedMap parentGlobals,
  ) async {
    return executeRequest(
      next,
      ctx.globalVariables,
      ctx.extensions,
    );
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
  DateTime? endTime;
  int? duration;
  final Stopwatch stopwatch = Stopwatch()..start();

  TracingBuilder({required this.version, DateTime? startTime})
      : startTime = startTime ?? DateTime.now();

  late final parsing = TracingItemBuilder(stopwatch);
  late final validation = TracingItemBuilder(stopwatch);
  late final execution = ExecutionTracingBuilder(stopwatch);

  void end() {
    endTime ??= DateTime.now();
    duration ??= stopwatch.elapsedMicroseconds;
  }

  Tracing build() {
    end();
    return Tracing(
      version: version,
      startTime: startTime,
      endTime: endTime!,
      duration: duration!,
      parsing: parsing.build(),
      validation: validation.build(),
      execution: execution.build(),
    );
  }

  Map<String, Object?> toJson() {
    end();
    return {
      'version': version,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime!.toIso8601String(),
      'duration': duration!,
      'parsing': parsing.toJson(),
      'validation': validation.toJson(),
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

  Map<String, Object?>? toJson() {
    if (startOffset == null) {
      return null;
    }
    if (duration == null) {
      end();
    }
    return {
      'startOffset': startOffset,
      'duration': duration,
    };
  }
}

@immutable
class Tracing {
  final int version;
  final DateTime startTime;
  final DateTime endTime;

  /// in nanoseconds
  final int duration;
  final TracingItem parsing;
  final TracingItem validation;
  final ExecutionTracing execution;

  const Tracing({
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

@immutable
class TracingItem implements TracingItemI {
  @override
  final int startOffset;

  @override
  final int duration;

  const TracingItem({
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

@immutable
class ExecutionTracing {
  final Map<ResolverTracing, TracingItem> resolvers;
  const ExecutionTracing({
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
          TracingItem.fromJson(x as Map<String, Object?>),
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
  int get hashCode => const DeepCollectionEquality().hash(resolvers);
}

@immutable
class ResolverTracing {
  final List<Object> path;
  final String parentType;
  final String fieldName;
  final String returnType;

  const ResolverTracing({
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
      path: (map['path']! as List).cast(),
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
    return const DeepCollectionEquality().hash(path) ^
        parentType.hashCode ^
        fieldName.hashCode ^
        returnType.hashCode;
  }
}
