import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';

typedef LogFunction = void Function(GraphQLLog);

class GraphQLLog {
  final String Function() _message;
  String get message => _message();

  final ResolveCtx? ctx;
  final GraphQLResult? result;
  final bool isSubscriptionEvent;
  List<GraphQLError>? get graphQLErrors => result?.errors ?? ctx?.errors;

  final Object? error;
  final StackTrace? stackTrace;

  const GraphQLLog(
    this._message, {
    this.isSubscriptionEvent = false,
    required this.result,
    required this.ctx,
    this.error,
    this.stackTrace,
  });
}

class LoggingExtension extends GraphQLExtension {
  LoggingExtension(this.logFunction);

  @override
  String get mapKey => 'shelfGraphQLChatLogging';

  final LogFunction logFunction;

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) async {
    try {
      final result = await next();
      logFunction(
        GraphQLLog(
          () => '${_ctxStr(globals)}extensions $extensions result $result',
          result: result,
          ctx: GraphQL.getResolveCtx(globals),
        ),
      );
      return result;
    } catch (e, s) {
      logFunction(
        GraphQLLog(
          () => '${_ctxStr(globals)}extensions $extensions error $e $s',
          result: null,
          ctx: GraphQL.getResolveCtx(globals),
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
    final globals = ctx.globals;
    try {
      final result = await next();
      logFunction(
        GraphQLLog(
          () => 'subscription_event ${_ctxStr(globals)}'
              'extensions ${ctx.extensions} result $result',
          isSubscriptionEvent: true,
          result: result,
          ctx: ctx,
        ),
      );
      return result;
    } catch (e, s) {
      logFunction(
        GraphQLLog(
          () => 'subscription_event ${_ctxStr(globals)}'
              'extensions ${ctx.extensions} error $e $s',
          isSubscriptionEvent: true,
          result: null,
          ctx: ctx,
          error: e,
          stackTrace: s,
        ),
      );
      rethrow;
    }
  }

  String _ctxStr(GlobalsHolder globals) {
    final ctx = GraphQL.getResolveCtx(globals.globals);
    String _ctxStr = '';
    if (ctx != null) {
      final name = ctx.operation.name?.value ?? '';
      final type = ctx.operation.type.toString().split('.').last;
      _ctxStr = '$name $type ';
    }
    return _ctxStr;
  }
}
