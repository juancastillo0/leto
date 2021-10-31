import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto/subscriptions_transport_ws.dart' as stw;
import 'package:shelf/shelf.dart';
import 'package:leto_shelf/leto_shelf.dart';
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
  FutureOr<bool> Function(
    Map<String, Object?>? payload,
    GraphQLWebSocketServer server,
  )?
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
        final _requestVariables = ScopedMap(
          {requestCtxKey: request},
          globalVariables,
        );
        final server = GraphQLWebSocketServer(
          client,
          graphQL,
          request,
          validateIncomingConnection: validateIncomingConnection,
          globalVariables: _requestVariables,
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
  final ScopedMap globalVariables;
  final FutureOr<bool> Function(
    Map<String, Object?>? payload,
    GraphQLWebSocketServer server,
  )? validateIncomingConnection;

  GraphQLWebSocketServer(
    stw.RemoteClient client,
    this.graphQL,
    this.request, {
    this.validateIncomingConnection,
    required this.globalVariables,
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
      return validateIncomingConnection!(connectionParams, this);
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
    final _globalVariables = globalVariables.child();
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
