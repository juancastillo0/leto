import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto/subscriptions_transport_ws.dart' as stw;
import 'package:leto_shelf/leto_shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// A shelf [Handler] that serves a spec-compliant
/// GraphQL backend over WebSockets.
/// This endpoint only supports WebSockets, and can be used
/// to deliver subscription events as well as queries and mutations.
///
/// [graphQLWebSocket] supports the 'graphql-transport-ws' and
/// 'graphql-ws' (apollo subscriptions-transport-ws) subprotocols,
/// for the sake of compatibility with existing tooling.
///
/// See:
/// * https://the-guild.dev/blog/graphql-over-websockets
/// * https://github.com/apollographql/subscriptions-transport-ws
/// * https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
Handler graphQLWebSocket(
  GraphQL graphQL, {
  Iterable<String>? allowedOrigins,
  Duration? keepAliveInterval,
  Duration? pingInterval,
  Duration? connectionInitWaitTimeout,
  List<ScopedOverride>? scopeOverrides,
  FutureOr<bool> Function(
    Map<String, Object?>? payload,
    GraphQLWebSocketShelfServer server,
  )? validateIncomingConnection,
}) {
  return (request) {
    final handler = webSocketHandler(
      (WebSocketChannel? channel, String? protocol) async {
        final client = stw.RemoteClient(
          channel!.cast<String>(),
          channel.sink.close,
          protocol ?? 'graphql-ws',
        );
        final requestOverrides = makeRequestScopedMap(
          request,
          isFromWebSocket: true,
        );
        final _requestVariables = [
          ...requestOverrides.overrides,
          if (scopeOverrides != null) ...scopeOverrides
        ];
        final server = GraphQLWebSocketShelfServer(
          client,
          graphQL,
          request,
          validateIncomingConnection: validateIncomingConnection,
          scopeOverrides: _requestVariables,
          keepAliveInterval: keepAliveInterval,
          connectionInitWaitTimeout: connectionInitWaitTimeout,
        );
        await server.done;
      },
      protocols: stw.GraphQLWebSocketServer.supportedProtocols,
      allowedOrigins: allowedOrigins,
      pingInterval: pingInterval,
    );
    return handler(request);
  };
}

/// An executor of GraphQL request that uses a Web Socket
/// shelf [request] as its entry point.
class GraphQLWebSocketShelfServer extends stw.GraphQLWebSocketServer {
  final GraphQL graphQL;
  final Request request;
  final List<ScopedOverride> scopeOverrides;
  final FutureOr<bool> Function(
    Map<String, Object?>? payload,
    GraphQLWebSocketShelfServer server,
  )? validateIncomingConnection;

  /// An executor of GraphQL request that uses a Web Socket
  /// shelf [request] as its entry point.
  GraphQLWebSocketShelfServer(
    stw.RemoteClient client,
    this.graphQL,
    this.request, {
    this.validateIncomingConnection,
    required this.scopeOverrides,
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
    return graphQL.parseAndExecute(
      query,
      operationName: operationName,
      variableValues: variables,
      scopeOverrides: scopeOverrides,
      extensions: extensions,
      sourceUrl: 'input',
    );
  }
}
