import 'dart:async';
import 'package:leto/src/graphql_result.dart';

import 'remote_client.dart';
import 'transport.dart';

/// Error codes sent when closing the websocket channel in graphql-transport-ws
///
/// https://developer.mozilla.org/en-US/docs/Web/API/CloseEvent/code
/// https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
class ErrorReason {
  static const invalidMessage = 4400;
  static const unauthorized = 4401;
  static const duplicateSubscriptionId = 4409;
  static const tooManyInitialisations = 4429;
  static const initialisationTimeout = 4408;
  static const normalClosure = 1000;
  static const internalError = 1011;
}

/// A GraphQL Web Socket Server implementation supporting
/// graphql-transport-ws and graphql-ws (apollo) subprotocols.
///
/// https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
/// https://github.com/apollographql/subscriptions-transport-ws/blob/master/PROTOCOL.md
abstract class Server {
  static const supportedProtocols = ['graphql-transport-ws', 'graphql-ws'];

  bool get isTransportWsProtocol => client.protocol == 'graphql-transport-ws';

  final RemoteClient client;
  final Duration? keepAliveInterval;
  final Duration? connectionInitWaitTimeout;
  late final Timer? _connectionInitTimer;
  final Completer _done = Completer<void>();
  late final StreamSubscription<OperationMessage> _sub;

  final Set<StreamSubscription<Object?>> _allSubs = {};
  final Map<String, StreamSubscription<Object?>?> currentOperationIds = {};

  bool _init = false;
  bool _receivedInit = false;
  Timer? _timer;

  Future<void> get done => _done.future;

  Future<void> _onDone() async {
    if (!_done.isCompleted) {
      _done.complete();
    }
    _connectionInitTimer?.cancel();
    _timer?.cancel();
    await Future.wait(_allSubs.map((e) => e.cancel()));
  }

  Future<void> _connectionInitTimeout() {
    return client.closeWithReason(
      ErrorReason.initialisationTimeout,
      'Connection initialisation timeout',
    );
  }

  /// Creates the server logic for receiving and responding messages
  /// through the [client]. The [client.protocol] should be in
  /// the [supportedProtocols] and that will determine the logic executed.
  Server(
    this.client, {
    this.keepAliveInterval,
    this.connectionInitWaitTimeout,
  }) {
    done.onError((Object e, StackTrace s) async {
      if (isTransportWsProtocol) {
        await client.closeWithReason(
          e is FormatException
              ? ErrorReason.invalidMessage
              : ErrorReason.internalError,
          e.toString(),
        );
      }
      return _onDone();
    });
    _connectionInitTimer = connectionInitWaitTimeout == null
        ? null
        : Timer(connectionInitWaitTimeout!, _connectionInitTimeout);

    _sub = client.stream.listen(
      (msg) async {
        if (msg.type == OperationMessage.gqlConnectionInit) {
          _connectionInitTimer?.cancel();
          if (_receivedInit && isTransportWsProtocol) {
            return client.closeWithReason(
              ErrorReason.tooManyInitialisations,
              'Too many initialisation requests',
            );
          }
          _receivedInit = true;

          try {
            Map<String, Object?>? connectionParams;
            if (msg.payload is Map) {
              connectionParams = (msg.payload as Map?)?.cast();
            } else if (msg.payload != null) {
              throw FormatException(
                  '${msg.type} payload must be a map (object).');
            }

            final connect = await onConnect(client, connectionParams);
            if (!connect) throw false;
            _init = true;
            client.sink.add(
              const OperationMessage(OperationMessage.gqlConnectionAck),
            );

            if (keepAliveInterval != null) {
              final _keepAliveMsg = OperationMessage(
                isTransportWsProtocol
                    ? OperationMessage.pong
                    : OperationMessage.gqlConnectionKeepAlive,
              );
              client.sink.add(_keepAliveMsg);
              _timer ??= Timer.periodic(keepAliveInterval!, (timer) {
                client.sink.add(_keepAliveMsg);
              });
            }
          } catch (e) {
            final _unauthorized = e == false;
            final String message =
                _unauthorized ? 'The connection was rejected.' : e.toString();

            if (isTransportWsProtocol) {
              return client.closeWithReason(
                _unauthorized
                    ? ErrorReason.unauthorized
                    : e is FormatException
                        ? ErrorReason.invalidMessage
                        : ErrorReason.internalError,
                message,
              );
            } else {
              client.sink.add(
                OperationMessage(
                  OperationMessage.gqlConnectionError,
                  payload: {'message': message},
                ),
              );
            }
          }
        } else if (msg.type == OperationMessage.ping) {
          client.sink.add(const OperationMessage(OperationMessage.pong));
        } else if (_init) {
          if (msg.type == OperationMessage.subscribe ||
              msg.type == OperationMessage.gqlStart) {
            if (msg.id == null) {
              throw FormatException('${msg.type} id is required.');
            }
            if (isTransportWsProtocol &&
                currentOperationIds.containsKey(msg.id)) {
              return client.closeWithReason(
                ErrorReason.duplicateSubscriptionId,
                'Subscriber for ${msg.id} already exists',
              );
            }
            currentOperationIds[msg.id!] = null;
            if (msg.payload == null) {
              throw FormatException('${msg.type} payload is required.');
            } else if (msg.payload is! Map) {
              throw FormatException(
                  '${msg.type} payload must be a map (object).');
            }
            final payload = msg.payload as Map;
            final Object? query = payload['query'];
            final Object? variables = payload['variables'];
            final Object? operationName = payload['operationName'];
            final Object? extensions = payload['extensions'];
            if (query is! String) {
              throw FormatException(
                  '${msg.type} payload must contain a string named "query".');
            }
            if (variables is! Map?) {
              throw FormatException('${msg.type} payload\'s "variables" field'
                  ' must be a map (object).');
            }
            if (operationName is! String?) {
              throw FormatException(
                  '${msg.type} payload\'s "operationName" field'
                  ' must be a string.');
            }
            if (extensions is! Map?) {
              throw FormatException('${msg.type} payload\'s "extensions" field'
                  ' must be a map (object).');
            }
            final result = await onOperation(
              msg.id,
              query,
              variables?.cast<String, dynamic>(),
              operationName,
              extensions?.cast<String, dynamic>(),
            );
            if (!result.didExecute) {
              client.sink.add(OperationMessage(
                OperationMessage.gqlError,
                id: msg.id,
                payload: result.errors,
              ));
              if (isTransportWsProtocol) {
                currentOperationIds.remove(msg.id);
                return;
              }
            } else {
              await _sendData(msg.id!, result);
            }
            // Don't send complete if the client completed the subscription
            if (!isTransportWsProtocol ||
                currentOperationIds.containsKey(msg.id)) {
              client.sink.add(
                  OperationMessage(OperationMessage.gqlComplete, id: msg.id));
            }
            currentOperationIds.remove(msg.id);
          } else if (msg.type == OperationMessage.gqlComplete ||
              msg.type == OperationMessage.gqlStop) {
            if (msg.id == null) {
              throw FormatException('${msg.type} id is required.');
            }
            final subs = currentOperationIds.remove(msg.id);
            if (subs != null) {
              await subs.cancel();
            }
          } else if (msg.type == OperationMessage.gqlConnectionTerminate) {
            await _sub.cancel();
            await _onDone();
          }
        } else if (msg.type == OperationMessage.subscribe) {
          return client.closeWithReason(
            ErrorReason.unauthorized,
            'Unauthorized',
          );
        }
      },
      onError: _done.completeError,
      onDone: _onDone,
      cancelOnError: true,
    );
  }

  Future<void> _sendData(String id, GraphQLResult result) async {
    final msgType = isTransportWsProtocol
        ? OperationMessage.next
        : OperationMessage.gqlData;

    final subscriptionStream = result.subscriptionStream;
    if (subscriptionStream != null) {
      final sub = subscriptionStream.listen((GraphQLResult event) {
        if (_done.isCompleted) {
          return;
        }
        client.sink.add(OperationMessage(
          msgType,
          id: id,
          payload: event.toJson(),
        ));
      });
      _allSubs.add(sub);
      await sub.asFuture<Object?>();
      _allSubs.remove(sub);
    } else {
      client.sink.add(OperationMessage(
        msgType,
        id: id,
        payload: result.toJson(),
      ));
    }
  }

  FutureOr<bool> onConnect(
    RemoteClient client, [
    Map<String, Object?>? connectionParams,
  ]);

  FutureOr<GraphQLResult> onOperation(
    String? id,
    String query, [
    Map<String, dynamic>? variables,
    String? operationName,
    Map<String, Object?>? extensions,
  ]);
}
