import 'package:chat_example/api/client.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:ferry/ferry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/__generated__/user.data.gql.dart';
import '../api/__generated__/user.req.gql.dart';

final sessionStoreProvider = Provider((ref) {
  ref.watch(userIdProvider);
  return SessionStore(ref.read);
});

class SessionStore {
  final T Function<T>(ProviderBase<T>) _read;

  SessionStore(this._read);

  final user = StateProvider<GgetUserData_getUser?>((ref) => null);
  final isLoading = StateProvider<bool>((ref) => false);

  void getSessions() {
    final _isLoading = _read(this.isLoading);
    if (_isLoading.state) {
      return;
    }
    final req = GgetUserReq((b) => b.executeOnListen = false);
    _read(clientProvider).request(req).listen((event) {
      if (event.dataSource == DataSource.Link) {
        _isLoading.state = false;
      }
      if (event.data != null) {
        final user = event.data!.getUser;
        if (user == null) {
          return;
        }
        _read(this.user).state = user;
      }
    });
    _isLoading.state = true;
    _read(clientProvider).requestController.add(req);
  }
}
