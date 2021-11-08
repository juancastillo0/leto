import 'dart:async';
import 'dart:convert' show json;

import 'package:clock/clock.dart';
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';

typedef LogFunction = void Function(GraphQLLog);

class GraphQLLog {
  final ResolveBaseCtx baseCtx;
  final ResolveCtx? ctx;
  final GraphQLResult? result;
  final bool isSubscriptionEvent;
  final DateTime startTime;
  final Duration duration;

  List<GraphQLError>? get graphQLErrors => result?.errors ?? ctx?.errors;
  String? get operationName =>
      ctx?.operation.name?.value ?? baseCtx.operationName;

  final Object? error;
  final StackTrace? stackTrace;

  const GraphQLLog({
    this.isSubscriptionEvent = false,
    required this.startTime,
    required this.duration,
    required this.result,
    required this.ctx,
    required this.baseCtx,
    this.error,
    this.stackTrace,
  });

  Map<String, Object?> toJson({bool withVariables = false}) {
    final type = ctx?.operation.type.toString().split('.').last ?? 'unknown';
    return {
      'time': startTime.toIso8601String(),
      'dur': duration.inMilliseconds,
      if (operationName != null) 'operation': operationName,
      'type': isSubscriptionEvent ? 'subscription_event' : type,
      if (error != null)
        'error': () {
          try {
            // ignore: avoid_dynamic_calls
            return (error as dynamic).toJson();
          } catch (_) {
            return error.toString();
          }
        }(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
      'result': () {
        if (result == null) return null;
        final jsonResult = result!.toJson();
        if (jsonResult['data'] is Stream) {
          jsonResult['data'] = 'Stream<GraphQLResult>';
        }
        return jsonResult;
      }(),
      if (baseCtx.extensions != null) 'extensions': baseCtx.extensions,
      if (withVariables) 'variables': baseCtx.rawVariableValues,
      'query': baseCtx.query,
    };
  }

  String separatedLog({
    bool withVariables = false,
    String separator = '\t',
    bool stringifyValues = true,
    bool withKeys = true,
  }) =>
      toJson(withVariables: withVariables).entries.map((e) {
        final value = stringifyValues
            ? e.value is Map
                ? json.encode(e.value)
                : e.value
            : e.value;
        return withKeys ? '${e.key}=$value' : value;
      }).join(separator);

  String toJsonString({bool withVariables = false}) =>
      json.encode(toJson(withVariables: withVariables));

  @override
  String toString() {
    return json.encode(this);
  }
}

class LoggingExtension extends GraphQLExtension {
  LoggingExtension(
    this.logFunction, {
    this.onResolverError,
  });

  @override
  String get mapKey => 'letoLogger';

  final LogFunction logFunction;
  final void Function(ThrownError)? onResolverError;

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ResolveBaseCtx ctx,
  ) async {
    final startTime = clock.now();
    final watch = clock.stopwatch()..start();
    try {
      final result = await next();
      logFunction(
        GraphQLLog(
          startTime: startTime,
          duration: watch.elapsed,
          result: result,
          ctx: GraphQL.getResolveCtx(ctx),
          baseCtx: ctx,
        ),
      );
      return result;
    } catch (e, s) {
      logFunction(
        GraphQLLog(
          startTime: startTime,
          duration: watch.elapsed,
          result: null,
          ctx: GraphQL.getResolveCtx(ctx),
          baseCtx: ctx,
          error: e,
          stackTrace: s,
        ),
      );
      rethrow;
    }
  }

  @override
  FutureOr<GraphQLResult> executeSubscriptionEvent(
    FutureOr<GraphQLResult> Function() next,
    ResolveCtx ctx,
    ScopedMap parentGlobals,
  ) async {
    final startTime = clock.now();
    final watch = clock.stopwatch()..start();
    try {
      final result = await next();
      logFunction(
        GraphQLLog(
          startTime: startTime,
          duration: watch.elapsed,
          isSubscriptionEvent: true,
          result: result,
          ctx: ctx,
          baseCtx: ctx.baseCtx,
        ),
      );
      return result;
    } catch (e, s) {
      logFunction(
        GraphQLLog(
          startTime: startTime,
          duration: watch.elapsed,
          isSubscriptionEvent: true,
          result: null,
          ctx: ctx,
          baseCtx: ctx.baseCtx,
          error: e,
          stackTrace: s,
        ),
      );
      rethrow;
    }
  }

  @override
  GraphQLException mapException(
    GraphQLException Function() next,
    ThrownError error,
  ) {
    onResolverError?.call(error);
    return next();
  }
}
