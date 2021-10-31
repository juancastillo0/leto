import 'dart:async';

class StreamCallbacks {
  StreamCallbacks({
    void Function()? onListen,
    void Function()? onCancel,
  })  : _onListen = onListen,
        _onCancel = onCancel;

  final void Function()? _onListen;
  final void Function()? _onCancel;

  bool isListening = false;
  int cancelations = 0;

  final _isListeningController = StreamController<bool>.broadcast();
  Stream<bool> get isListeningStream => _isListeningController.stream;

  void onListen() {
    isListening = true;
    _isListeningController.add(isListening);
    _onListen?.call();
  }

  void onCancel() {
    isListening = false;
    cancelations += 1;
    _isListeningController.add(isListening);
    _onCancel?.call();
  }

  Future<void> dispose() {
    return _isListeningController.close();
  }
}
