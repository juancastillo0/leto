import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';

import 'package:stream_channel/stream_channel.dart';
import 'transport.dart';

class RemoteClient extends StreamChannelMixin<OperationMessage> {
  final StreamChannel<Map<String, Object?>> channel;
  final StreamChannelController<OperationMessage> _ctrl =
      StreamChannelController();

  RemoteClient(StreamChannel<String> channel)
      : this.withoutJson(const _JsonMapTransformer().bind(channel));

  RemoteClient.withoutJson(this.channel) {
    _ctrl.local.stream.map((m) => m.toJson()).forEach(channel.sink.add);
    channel.stream.listen((m) {
      _ctrl.local.sink.add(OperationMessage.fromJson(m));
    });
  }

  @override
  StreamSink<OperationMessage> get sink => _ctrl.foreign.sink;

  @override
  Stream<OperationMessage> get stream => _ctrl.foreign.stream;

  void close() {
    channel.sink.close();
    _ctrl.local.sink.close();
  }
}

class _JsonMapTransformer implements StreamChannelTransformer<Object?, String> {
  const _JsonMapTransformer();

  @override
  StreamChannel<Map<String, Object?>> bind(StreamChannel<String> channel) {
    final stream = channel.stream.map(
      (d) => jsonDecode(d) as Map<String, Object?>,
    );
    final transformer =
        StreamSinkTransformer<Map<String, Object?>, String>.fromHandlers(
      handleData: (data, sink) {
        sink.add(jsonEncode(data));
      },
    );
    final sink = transformer.bind(channel.sink);
    return StreamChannel.withCloseGuarantee(stream, sink);
  }
}
