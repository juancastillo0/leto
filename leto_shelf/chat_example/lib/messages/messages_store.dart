import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/messages.data.gql.dart';
import 'package:chat_example/api/messages.req.gql.dart';
import 'package:chat_example/api/messages.var.gql.dart';
import 'package:chat_example/api/room.data.gql.dart';
import 'package:chat_example/api/room.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedChatId = StateProvider<int?>((ref) => null);

final selectedChat = StreamProvider<GFullChatRoomData?>(
  (ref) {
    final chatId = ref.watch(selectedChatId).state;
    if (chatId == null) {
      return const Stream.empty();
    }
    return ref.read(clientProvider).cache.watchFragment(
          GFullChatRoomReq(
            (b) => b..idFields = <String, Object?>{'id': chatId},
          ),
        );
  },
);

final selectedChatMessages =
    StreamProvider<OperationResponse<GgetMessagesData, GgetMessagesVars>>(
  (ref) {
    final chat = ref.watch(selectedChat);
    if (chat.asData == null || chat.value == null) {
      return const Stream.empty();
    }

    return ref.read(clientProvider).request(
          // TODO:
          // ..requestId = 'getMessages'
          GgetMessagesReq((b) => b..vars.chatId = chat.value!.id),
        );
  },
);
