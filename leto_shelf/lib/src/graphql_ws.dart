import 'dart:async';

import 'package:graphql_server/graphql_server.dart';
import 'package:graphql_server/subscriptions_transport_ws.dart' as stw;
import 'package:shelf/shelf.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// A [RequestHandler] that serves a spec-compliant
/// GraphQL backend, over WebSockets.
/// This endpoint only supports WebSockets, and can be used
/// to deliver subscription events.
///
/// [graphqlWebSocket] supports the 'graphql-transport-ws' and
/// 'graphql-ws' (apollo subscriptions-transport-ws) subprotocols,
/// for the sake of compatibility with existing tooling.
///
/// See:
/// * https://the-guild.dev/blog/graphql-over-websockets
/// * https://github.com/apollographql/subscriptions-transport-ws
/// * https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
Handler graphqlWebSocket(
  GraphQL graphQL, {
  Iterable<String>? allowedOrigins,
  Duration? keepAliveInterval,
  Duration? pingInterval,
  Duration? connectionInitWaitTimeout,
  ScopedMap? globalVariables,
  FutureOr<bool> Function(Map<String, Object?>? payload)?
      validateIncomingConnection,
}) {
  return (request) {
    final handler = webSocketHandler(
      (WebSocketChannel channel) async {
        final client = stw.RemoteClient(
          channel.cast<String>(),
          channel.sink.close,
          channel.protocol ?? 'graphql-ws',
        );
        final server = GraphQLWebSocketServer(
          client,
          graphQL,
          request,
          validateIncomingConnection: validateIncomingConnection,
          globalVariables: globalVariables,
          keepAliveInterval: keepAliveInterval,
          connectionInitWaitTimeout: connectionInitWaitTimeout,
        );
        await server.done;
      },
      protocols: stw.Server.supportedProtocols,
      allowedOrigins: allowedOrigins,
      pingInterval: pingInterval,
    );
    return handler(request);
  };
}

class GraphQLWebSocketServer extends stw.Server {
  final GraphQL graphQL;
  final Request request;
  final ScopedMap? globalVariables;
  final FutureOr<bool> Function(Map<String, Object?>? payload)?
      validateIncomingConnection;

  GraphQLWebSocketServer(
    stw.RemoteClient client,
    this.graphQL,
    this.request, {
    this.validateIncomingConnection,
    this.globalVariables,
    Duration? keepAliveInterval,
    Duration? connectionInitWaitTimeout,
  }) : super(
          client,
          keepAliveInterval: keepAliveInterval,
          connectionInitWaitTimeout: connectionInitWaitTimeout,
        );

  @override
  FutureOr<bool> onConnect(
    stw.RemoteClient client, [
    Map<String, Object?>? connectionParams,
  ]) {
    if (validateIncomingConnection != null) {
      return validateIncomingConnection!(connectionParams);
    }
    return true;
  }

  @override
  Future<GraphQLResult> onOperation(
    String? id,
    String query, [
    Map<String, Object?>? variables,
    String? operationName,
    Map<String, Object?>? extensions,
  ]) async {
    final _nested = <Object, Object?>{requestCtxKey: request};
    final _globalVariables = globalVariables != null
        ? globalVariables!.child(_nested)
        : ScopedMap(_nested);
    return graphQL.parseAndExecute(
      query,
      operationName: operationName,
      variableValues: variables,
      globalVariables: _globalVariables,
      extensions: extensions,
      sourceUrl: 'input',
    );
  }
}
