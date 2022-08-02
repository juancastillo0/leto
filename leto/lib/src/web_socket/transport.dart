/// A basic message in the Apollo WebSocket and
/// graphql-transport-ws subprotocols.
class OperationMessage {
  static const String gqlConnectionInit = 'connection_init',
      gqlConnectionAck = 'connection_ack',
      gqlError = 'error',
      gqlComplete = 'complete',

      /// https://github.com/apollographql/subscriptions-transport-ws/blob/master/PROTOCOL.md
      gqlConnectionKeepAlive = 'ka',
      gqlConnectionError = 'connection_error',
      gqlStart = 'start',
      gqlStop = 'stop',
      gqlConnectionTerminate = 'connection_terminate',
      gqlData = 'data',

      /// https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
      ping = 'ping',
      pong = 'pong',
      subscribe = 'subscribe',
      next = 'next';

  final dynamic payload;
  final String? id;
  final String type;

  const OperationMessage(this.type, {this.payload, this.id});

  factory OperationMessage.fromJson(Map map) {
    final Object? type = map['type'];
    Object? payload = map['payload'];
    Object? id = map['id'];

    if (type == null) {
      throw ArgumentError.notNull('type');
    } else if (type is! String) {
      throw ArgumentError.value(type, 'type', 'must be a string');
    } else if (id is num) {
      id = id.toString();
    } else if (id != null && id is! String) {
      throw ArgumentError.value(id, 'id', 'must be a string or number');
    }

    // TODO: 1I This is technically a violation of the spec.
    // https://github.com/apollographql/subscriptions-transport-ws/issues/551
    if (map.containsKey('query') ||
        map.containsKey('operationName') ||
        map.containsKey('variables')) payload = Map<Object?, Object?>.from(map);
    return OperationMessage(type, id: id as String?, payload: payload);
  }

  Map<String, Object?> toJson() {
    return {
      'type': type,
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload
    };
  }
}
