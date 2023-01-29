import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chat_example/api/api_utils.dart';
import 'package:chat_example/api/client.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:ferry/typed_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/__generated__/room.data.gql.dart';
import '../api/__generated__/room.req.gql.dart';
import '../api/__generated__/room.var.gql.dart';
import '../api/__generated__/user.data.gql.dart';

final createChatRoomHandler = UpdateCacheObj<GcreateRoomData, GcreateRoomVars>(
  'createChatRoomHandler',
  (proxy, response) {
    final data = response.data?.createChatRoom;
    if (data == null) {
      return;
    }
    final rooms = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();

    proxy.writeQuery(
      GgetRoomsReq(),
      rooms.rebuild(
        (b) => b
          ..getChatRooms.add(
            GgetRoomsData_getChatRooms.fromJson(
              data.toJson(),
            )!,
          ),
      ),
    );
  },
);

final roomsProvider = StateNotifierProvider<
    RequestState<GgetRoomsData, GgetRoomsVars>,
    Stream<OperationResponse<GgetRoomsData, GgetRoomsVars>>>((ref) {
  // final client = ref.read(clientProvider);
  return RequestState(ref.read, GgetRoomsReq());
});

final roomsStreamProvider = StreamProvider((ref) {
  final client = ref.read(clientProvider);
  final _req = GgetRoomsReq((b) => b..executeOnListen = false);
  final stream = client.request(_req);
  client.requestController.add(_req);
  return stream;
});

final createRoomProvider = Provider((ref) {
  final client = ref.read(clientProvider);
  return (String name) => client.request(
        GcreateRoomReq(
          (b) => b
            ..vars.name = name
            ..updateCacheHandlerKey = createChatRoomHandler.name,
        ),
      );
});

final deleteChatRoomHandler = UpdateCacheObj<GdeleteRoomData, GdeleteRoomVars>(
  'deleteChatRoomHandler',
  (proxy, response) {
    final data = response.data?.deleteChatRoom;
    if (data != true) {
      return;
    }
    final rooms = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();

    proxy.writeQuery(
      GgetRoomsReq(),
      rooms.rebuild(
        (b) => b
          ..getChatRooms.removeWhere(
            (r) => r.id == response.operationRequest.vars.id,
          ),
      ),
    );
  },
);

final addChatRoomUserHandler =
    UpdateCacheObj<GaddChatRoomUserData, GaddChatRoomUserVars>(
  'addChatRoomUserHandler',
  (proxy, response) {
    final data = response.data?.addChatRoomUser;
    if (data == null) {
      return;
    }

    _updateRoomUsers(
      proxy,
      data.chatId,
      (p0) => p0.add(
        GgetRoomsData_getChatRooms_users.fromJson(data.toJson())!,
      ),
    );
  },
);

final deleteChatRoomUserHandler =
    UpdateCacheObj<GdeleteChatRoomUserData, GdeleteChatRoomUserVars>(
  'deleteChatRoomUserHandler',
  (proxy, response) {
    final data = response.data?.deleteChatRoomUser;
    if (data != true) {
      return;
    }
    final vars = response.operationRequest.vars;
    if (false) {
      // TODO: leave group
      final rooms = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();

      proxy.writeQuery(
        GgetRoomsReq(),
        rooms.rebuild(
          (b) => b
            ..getChatRooms.removeWhere(
              (r) => r.id == vars.chatId,
            ),
        ),
      );
    } else {
      _updateRoomUsers(
        proxy,
        vars.chatId,
        (p0) => p0.removeWhere(
          (u) => u.userId == vars.userId,
        ),
      );
    }
  },
);

void _updateRoomUsers(
  CacheProxy proxy,
  int chatId,
  void Function(ListBuilder<GgetRoomsData_getChatRooms_users> users) update,
) {
  final rooms = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();
  proxy.writeQuery(
    GgetRoomsReq(),
    rooms.rebuild(
      (b) => b
        ..getChatRooms.map(
          (p0) {
            if (p0.id != chatId) {
              return p0;
            }
            return p0.rebuild((p0) => p0.users.update(update));
          },
        ),
    ),
  );
}

final roomStoreProvider = Provider((ref) => RoomStore(ref.read));

class RoomStore {
  final T Function<T>(ProviderListenable<T> provider) _read;

  RoomStore(this._read);

  void deleteRoom(int id) async {
    final req = GdeleteRoomReq(
      (b) =>
          ((b..executeOnListen = false)..updateCacheHandlerKey = deleteChatRoomHandler.name)
            ..vars.id = id,
    );
    final fut = _read(clientProvider).request(req).first;
    _read(clientProvider).requestController.add(req);
    final result = await fut;
    if (result.hasErrors) {}
    if (result.data?.deleteChatRoom == true) {
      onRoomDeleted(id);
    }
  }

  void onRoomDeleted(int id) {
    final _selected = _read(selectedChatId.notifier);
    if (_selected.state == id) {
      _selected.state = null;
    }
  }

  final searchedUsers =
      StateProvider.autoDispose<MapEntry<String, List<GAUser>>?>((ref) => null);
  final loadingSearch = StateProvider.autoDispose<bool>((ref) => false);

  String lastSearchName = '';
  Timer? searchTimer;
  void searchUser(String name) {
    if (name.isEmpty) {
      return;
    }
    _read(loadingSearch.notifier).state = true;
    lastSearchName = name;
    searchTimer ??= Timer(const Duration(seconds: 2), () async {
      final _searchName = lastSearchName;
      final req = GsearchUserReq(
        (b) => (b..executeOnListen = false).vars..name = _searchName,
      );
      final result = _read(clientProvider).request(req).firstWhere((element) {
        if (element.hasErrors) {
        } else if (element.data != null) {
          final users = element.data!.searchUser;
          _read(searchedUsers.notifier).state = MapEntry(_searchName, users.toList());
        }
        return element.dataSource == DataSource.Link;
      });
      _read(clientProvider).requestController.add(req);
      await result;
      searchTimer = null;
      if (_searchName != lastSearchName) {
        searchUser(lastSearchName);
      } else {
        _read(loadingSearch.notifier).state = false;
      }
    });
  }

  void addChatRoomUser({
    required int chatId,
    required int userId,
  }) async {
    final req = GaddChatRoomUserReq(
      (b) {
        b.executeOnListen = false;
        b.vars
          ..chatId = chatId
          ..userId = userId;
        b.updateCacheHandlerKey = addChatRoomUserHandler.name;
      },
    );
    final fut = _read(clientProvider).request(req).first;
    _read(clientProvider).requestController.add(req);
    final result = await fut;
    if (result.hasErrors) {}
    if (result.data?.addChatRoomUser != null) {}
  }

  void deleteChatRoomUser({
    required int chatId,
    required int userId,
  }) async {
    final req = GdeleteChatRoomUserReq(
      (b) {
        b..executeOnListen = false;
        b.vars
          ..chatId = chatId
          ..userId = userId;
        b.updateCacheHandlerKey = deleteChatRoomUserHandler.name;
      },
    );
    final fut = _read(clientProvider).request(req).first;
    _read(clientProvider).requestController.add(req);
    final result = await fut;
    if (result.hasErrors) {}
    if (result.data?.deleteChatRoomUser == true) {
      if (_read(authStoreProv)?.user.id == userId) {
        // TODO: leave group
      }
    }
  }
}
