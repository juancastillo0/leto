import 'package:chat_example/api/api_utils.dart';
import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/room.data.gql.dart';
import 'package:chat_example/api/room.req.gql.dart';
import 'package:chat_example/api/room.var.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createChatRoomHandler = UpdateCacheObj<GcreateRoomData, GcreateRoomVars>(
  'createChatRoomHandler',
  (
    proxy,
    response,
  ) {
    final data = response.data?.createChatRoom;
    if (data == null) {
      return;
    }
    final reviews = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();

    proxy.writeQuery(
      GgetRoomsReq(),
      reviews.rebuild(
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
