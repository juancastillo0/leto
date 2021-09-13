import 'dart:async';

import 'package:graphql_schema/graphql_schema.dart';
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
/// `graphQLWS` uses the Apollo WebSocket protocol, for the sake
/// of compatibility with existing tooling.
///
/// See:
/// * https://github.com/apollographql/subscriptions-transport-ws
Handler graphqlWebSocket(
  GraphQL graphQL, {
  Duration? keepAliveInterval,
  Map<String, Object?>? globalVariables,
}) {
  return (request) {
    final handler = webSocketHandler(
      (WebSocketChannel channel) async {
        final client = stw.RemoteClient(channel.cast<String>());
        final server = _GraphQLWSServer(
            client, graphQL, request, keepAliveInterval, globalVariables);
        await server.done;
      },
      protocols: ['graphql-ws'],
    );
    return handler(request);
  };
}

class _GraphQLWSServer extends stw.Server {
  final GraphQL graphQL;
  final Request request;
  final Map<String, Object?>? globalVariables;

  _GraphQLWSServer(
    stw.RemoteClient client,
    this.graphQL,
    this.request,
    Duration? keepAliveInterval,
    this.globalVariables,
  ) : super(client, keepAliveInterval: keepAliveInterval);

  @override
  bool onConnect(stw.RemoteClient client, [Map? connectionParams]) => true;

  @override
  Future<stw.GraphQLResult> onOperation(
    String? id,
    String query, [
    Map<String, Object?>? variables,
    String? operationName,
  ]) async {
    try {
      final _globalVariables = <String, Object?>{
        requestCtxKey: request,
        if (globalVariables != null) ...globalVariables!
      };
      final data = await graphQL.parseAndExecute(
        query,
        operationName: operationName,
        variableValues: variables,
        globalVariables: _globalVariables,
        // TODO: extensions? headers? auth?
        sourceUrl: 'input',
      );
      return stw.GraphQLResult(data);
    } on GraphQLException catch (e) {
      return stw.GraphQLResult(null, errors: e.errors);
    }
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
