import 'package:chat_example/api/client.dart';
import 'package:ferry/ferry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestState<TData, TVars>
    extends StateNotifier<Stream<OperationResponse<TData, TVars>>> {
  RequestState(this._read, this.request)
      : super(_read(clientProvider).request(request)) {
    _setup();
  }

  OperationResponse<TData, TVars>? lastResponse;
  DateTime? lastResponseTime;

  void _setup() {
    state.map((event) {
      lastResponse = event;
      lastResponseTime = DateTime.now();
    });
  }

  final OperationRequest<TData, TVars> request;
  final T Function<T>(ProviderBase<T> provider) _read;

  void refresh() {
    _read(clientProvider).requestController.add(request);
  }
}

class UpdateCacheObj<TData, TVars> {
  final String name;
  final UpdateCacheHandler<TData, TVars> handler;

  const UpdateCacheObj(this.name, this.handler);
}
