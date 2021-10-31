import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/event.data.gql.dart';
import 'package:chat_example/api/event.req.gql.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:ferry/ferry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiEventStoreProvider = Provider((ref) {
  ref.watch(userIdProvider);

  return ApiEventStore(ref.read, ref.onDispose);
});

class ApiEventStore {
  final T Function<T>(ProviderBase<T>) _read;
  final Function(Function()) onDispose;

  ApiEventStore(this._read, this.onDispose) {
    final sub = _read(userEvents.stream).listen((resp) {
      final _event = resp.data?.onEvent;
      if (_event == null) {
        return;
      }
      final event = GgetEventsData_getEvents_values.fromJson(_event.toJson())!;

      _updateList((u) => u.insert(0, event));
    });
    onDispose(() {
      sub.cancel();
    });
  }

  final events =
      StateProvider<BuiltList<GgetEventsData_getEvents_values>?>((ref) => null);
  final isLoading = StateProvider<bool>((ref) => false);
  bool canFetchMore = true;

  String? cursor;

  void getApiEvents() {
    final _isLoading = _read(this.isLoading);
    if (_isLoading.state || !canFetchMore) {
      return;
    }
    final req = GgetEventsReq(
      (b) => b
        ..executeOnListen = false
        ..vars.cursor = cursor
        ..vars.delta = -7,
    );
    _read(clientProvider).request(req).listen((event) {
      if (event.dataSource == DataSource.Link) {
        _isLoading.state = false;
      }
      if (event.data != null) {
        final events = event.data!.getEvents;
        cursor = events.pageInfo.endCursor;
        canFetchMore = events.pageInfo.hasPreviousPage;

        _updateList((u) => u.addAll(events.values));
      }
    });
    _isLoading.state = true;
    _read(clientProvider).requestController.add(req);
  }

  void _updateList(
    void Function(ListBuilder<GgetEventsData_getEvents_values>) update,
  ) {
    _read(this.events).state =
        (_read(this.events).state ?? BuiltList()).rebuild((u) {
      update(u);
      final ids = <int>{};
      u.removeWhere((p0) {
        final remove = ids.contains(p0.id);
        ids.add(p0.id);
        return remove;
      });
    });
  }
}
