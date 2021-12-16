// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/chat_room/user_rooms_api.dart';
import 'package:server/events/events_api.dart';
import 'package:server/messages/messages_api.dart';
import 'package:server/users/auth.dart';

part 'chat_api.freezed.dart';
part 'chat_api.g.dart';

@GraphQLClass()
@freezed
class ChatEvent with _$ChatEvent implements DBEventDataKeyed {
  const ChatEvent._();
  const factory ChatEvent.created({
    required ChatRoom chat,
    required int ownerId,
  }) = ChatCreatedEvent;

  const factory ChatEvent.deleted({
    required int chatId,
  }) = ChatDeletedEvent;

  factory ChatEvent.fromJson(Map<String, Object?> map) =>
      _$ChatEventFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey {
    return map(
      created: (e) => MapEntry(EventType.chatCreated, '$chatId'),
      deleted: (e) => MapEntry(EventType.chatDeleted, '$chatId'),
    );
  }

  int get chatId {
    return map(
      created: (e) => e.chat.id,
      deleted: (e) => e.chatId,
    );
  }
}

@immutable
class DeepEqualMap<K, V> {
  final Map<K, V> map;

  const DeepEqualMap(this.map);

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is DeepEqualMap &&
            const DeepCollectionEquality().equals(map, other.map);
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(map);
}

@GraphQLClass()
@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required int id,
    required String name,
    required DateTime createdAt,
    @GraphQLField(omit: true) List<ChatMessage>? messagesCache,
    @GraphQLField(omit: true) List<ChatRoomUser>? usersCache,
  }) = _ChatRoom;
  const ChatRoom._();

  factory ChatRoom.fromJson(Map<String, Object?> json) =>
      _$ChatRoomFromJson(json);

  @GraphQLField(omit: true)
  static List<ChatRoom> listFromJson(
    Iterable<Map<String?, Map<String, Object?>>> json,
    Map<String, List<String>> pk,
  ) {
    final Map<int, Map<String, Map<DeepEqualMap, Map<String, Object?>>>> _c =
        {};

    for (final item in json) {
      late final int chatId;
      final Map<String, List<MapEntry<String, Object?>>> map = {};
      for (final entryTable in item.entries) {
        if (entryTable.key == null) {
          continue;
        }
        for (final entry in entryTable.value.entries) {
          map
              .putIfAbsent(entryTable.key!, () => [])
              .add(MapEntry(entry.key, entry.value));

          if (entryTable.key == 'chat' && entry.key == 'id') {
            chatId = entry.value! as int;
          }
        }
      }
      final chatMap = _c.putIfAbsent(chatId, () => {});

      for (final entry in map.entries) {
        final list = chatMap.putIfAbsent(entry.key, () => {});
        final tablePks = entry.key == 'chat' ? ['id'] : pk[entry.key]!;
        final key = DeepEqualMap(
          Map.fromEntries(entry.value.where((c) => tablePks.contains(c.key))),
        );
        if (key.map.values.any((v) => v != null)) {
          list.putIfAbsent(key, () => Map.fromEntries(entry.value));
        }
      }
    }
    return _c.values.map((v) {
      final json = {
        ...(v['chat']!).values.first,
        'messagesCache': v['message']?.values.toList(),
        'usersCache': v['chatRoomUser']?.values.toList(),
      };
      return _$ChatRoomFromJson(json);
    }).toList();
  }

  Future<List<ChatMessage>> messages(Ctx ctx) async {
    if (messagesCache != null) {
      return messagesCache!;
    }
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.getAll(chatId: id);
  }

  Future<List<ChatRoomUser>> users(Ctx ctx) async {
    if (usersCache != null) {
      return usersCache!;
    }
    final users = await userChatsRef.get(ctx).getForChat(id);
    return users!;
  }
}

@Mutation()
Future<ChatRoom?> createChatRoom(
  Ctx ctx,
  String name,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.insert(name, claims);
}

@Mutation()
Future<bool> deleteChatRoom(
  Ctx ctx,
  int id,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.delete(chatId: id, user: claims);
}

@Query()
Future<List<ChatRoom>> getChatRooms(
  Ctx ctx,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  final possibleSelections = ctx.lookahead()!.forObject;

  final withMessages = possibleSelections.contains('messages');
  final withUsers = possibleSelections.contains('users');

  return controller.chats.getAll(
    userId: claims.userId,
    withMessages: withMessages,
    withUsers: withUsers,
  );
}
