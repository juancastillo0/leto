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
  Duration? connectionInitWaitTimeout,
  Map<Object, Object?>? globalVariables,
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
    );
    return handler(request);
  };
}

class GraphQLWebSocketServer extends stw.Server {
  final GraphQL graphQL;
  final Request request;
  final Map<Object, Object?>? globalVariables;
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
    final _globalVariables = <Object, Object?>{
      requestCtxKey: request,
      if (globalVariables != null) ...globalVariables!
    };
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

// if (req.protocolVersion != '1.1') {
//   return Response(
//     HttpStatus.badRequest,
//     body: 'The `graphQLWS` endpoint only accepts HTTP/1.1 requests.',
//   );
// }
// if (!req.canHijack) {
//   throw ArgumentError('webSocketHandler may only be used with a server '
//       'that supports request hijacking.');
// }
// req.hijack((p0) async {
//   if (WebSocketTransformer.isUpgradeRequest(req.rawRequest)) {
//     await res.detach();
//     var socket = await WebSocketTransformer.upgrade(
//       req.rawRequest,
//       protocolSelector: (protocols) {
//         if (protocols.contains('graphql-ws')) {
//           return 'graphql-ws';
//         } else {
//           return Response(
//             HttpStatus.badRequest,
//             body: 'Only the "graphql-ws" protocol is allowed.',
//           );
//         }
//       },
//     );

//     final channel = IOWebSocketChannel(socket);
//     final client = stw.RemoteClient(channel.cast<String>());
//     final server =
//         _GraphQLWSServer(client, graphQL, req, keepAliveInterval);
//     await server.done;
//   } else {
//     return Response(
//       HttpStatus.badRequest,
//       body: 'The `graphQLWS` endpoint only accepts WebSockets.',
//     );
//   }
// });
