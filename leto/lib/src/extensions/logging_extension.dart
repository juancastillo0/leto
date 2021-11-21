import 'dart:async';
import 'dart:convert' show json;

import 'package:clock/clock.dart';
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';

/// A callback for logging a [GraphQLLog] from a request execution
typedef LogFunction = void Function(GraphQLLog);

/// A log with information about the execution of GraphQL requests
/// or subscription events
class GraphQLLog {
  /// The base request context
  final RequestCtx baseCtx;

  /// The main execution context for the execution, null if there
  /// was an error before execution
  final ExecutionCtx? ctx;

  /// The [GraphQLResult] for the execution, null if there
  /// was an error before execution
  final GraphQLResult? result;

  /// Whether the log is from a subscription event
  final bool isSubscriptionEvent;

  /// The start time of execution
  final DateTime startTime;

  /// The duration of execution
  final Duration duration;

  /// The [GraphQLError]s found during execution, null if there
  /// was an error before execution
  List<GraphQLError>? get graphQLErrors => result?.errors ?? ctx?.errors;

  /// The operation name of the request, null if there
  /// was an error before execution
  String? get operationName =>
      ctx?.operation.name?.value ?? baseCtx.operationName;

  /// The source error
  ///
  /// Almost always null. Most of the times, if there were any errors,
  /// they will be in [graphQLErrors].
  /// More information in [GraphQL.parseAndExecute].
  final Object? error;

  /// The [StackTrace] for [error]
  final StackTrace? stackTrace;

  /// A log with information about the execution of GraphQL requests
  /// or subscription events
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

  /// Returns the log as a Json Map
  ///
  /// Uses `toJson` for the error or `toString` if not available
  /// If [withVariables] is true, it will also return the
  /// input variables within the Map
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

  /// A String with the log information separated by [separator]
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

  /// A Json String with the log information.
  /// More info in [toJson]
  String toJsonString({bool withVariables = false}) =>
      json.encode(toJson(withVariables: withVariables));

  @override
  String toString() {
    return json.encode(this);
  }
}

/// Extension that logs all requests and subscription events
class LoggingExtension extends GraphQLExtension {
  /// Extension that logs all requests and subscription events
  LoggingExtension(
    this.logFunction, {
    this.onResolverError,
  });

  @override
  String get mapKey => 'letoLogger';

  /// Called for each request or subscription event
  final LogFunction logFunction;

  /// Optional callback for logging errors thrown in resolvers
  final void Function(ThrownError)? onResolverError;

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    RequestCtx ctx,
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
    ExecutionCtx ctx,
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
          baseCtx: ctx.requestCtx,
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
          baseCtx: ctx.requestCtx,
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
