// ignore_for_file: lines_longer_than_80_chars

import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/event.data.gql.dart';
import 'package:chat_example/api/event.req.gql.dart';
import 'package:chat_example/api/event.var.gql.dart';
import 'package:chat_example/api/messages.data.gql.dart';
import 'package:chat_example/api/messages.req.gql.dart';
import 'package:chat_example/api/messages.var.gql.dart';
import 'package:chat_example/api/room.data.gql.dart';
import 'package:chat_example/api/room.req.gql.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:ferry/ferry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'messages_store.freezed.dart';

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

final userEvents =
    StreamProvider<OperationResponse<GonEventData, GonEventVars>>(
  (ref) {
    ref.watch(userIdProvider);
    return ref.read(clientProvider).request(GonEventReq());
  },
);

final messageStoreProvider = Provider(
  (ref) {
    ref.watch(userIdProvider);
    return MessagesStore(ref.read);
  },
);

class MessagesStore {
  MessagesStore(this._read) {
    _read(userMessagesEvents.stream).listen((event) {
      event.when(
        sent: (sent) {
          final req = GgetMessagesReq(
            (b) => b..vars.chatId = sent.message.chatId,
          );
          final data = client.cache.readQuery(req) ?? GgetMessagesData();
          client.cache.writeQuery(
            req,
            data.rebuild(
              (p0) {
                p0.getMessage.add(
                  GgetMessagesData_getMessage.fromJson(
                    sent.message.toJson(),
                  )!,
                );
                p0.getMessage.sort((a, b) => a.id - b.id);
              },
            ),
          );
        },
        deleted: (deleted) {},
        updated: (updated) {},
      );
    });
  }

  Client get client => _read(clientProvider);
  T Function<T>(ProviderBase<T> provider) _read;

  void sendMessage(String message, int chatId) {
    final user = _read(authStoreProv).user!;
    final optimisticResponse = (GsendMessageData_sendMessageBuilder()
      ..chatId = chatId
      ..message = message
      ..userId = user.id
      ..createdAt.value = DateTime.now().toIso8601String()
      ..id = -1);

    client
        .request(
          GsendMessageReq(
            (b) => b
              ..vars.chatId = chatId
              ..vars.message = message
              ..updateResult
              ..optimisticResponse.sendMessage = optimisticResponse,
          ),
        )
        .listen((event) {});
  }
}

final userMessagesEvents = StreamProvider<ChatMessageEvent>(
  (ref) {
    return ref
        .read(userEvents.stream)
        .map<ChatMessageEvent?>((event) {
          final data = event.data?.onEvent.data;
          if (data is GonEventData_onEvent_data__asChatMessageDBEventData) {
            final value = data.value;
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent) {
              return ChatMessageEvent.sent(value);
            }
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent) {
              return ChatMessageEvent.deleted(value);
            }
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent) {
              return ChatMessageEvent.updated(value);
            }
          }
          return null;
        })
        .where((event) => event != null)
        .cast();
  },
);

@freezed
class ChatMessageEvent with _$ChatMessageEvent {
  const factory ChatMessageEvent.sent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value) = ChatMessageSentEvent;
  const factory ChatMessageEvent.deleted(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value) = ChatMessageDeletedEvent;
  const factory ChatMessageEvent.updated(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value) = ChatMessageUpdatedEvent;
}
