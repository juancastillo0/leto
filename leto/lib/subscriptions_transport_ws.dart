/// An implementation of Apollo's `subscriptions-transport-ws` and
/// `graphql-transport-ws` Web Socket subprotocols in Dart.
///
/// See:
/// https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
/// https://github.com/apollographql/subscriptions-transport-ws/blob/master/PROTOCOL.md
library leto.subscriptions_transport_ws;

export 'src/web_socket/remote_client.dart';
export 'src/web_socket/server.dart';
export 'src/web_socket/transport.dart';
