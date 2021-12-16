import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto/types/page_info.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:server/chat_room/chat_api.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/chat_room/user_rooms_api.dart';
import 'package:server/messages/messages_api.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_api.dart';

part 'events_api.freezed.dart';
part 'events_api.g.dart';

@GraphQLEnum()
enum EventType {
  chatCreated,
  chatDeleted,
  userChatRemoved,
  userChatAdded,
  userCreated,
  userSessionSignedUp,
  userSessionSignedIn,
  userSessionSignedOut,
  messageSent,
  messageDeleted,
  messageUpdated,
}

extension SerdeEventType on EventType {
  String toJson() {
    return toString().split('.').last;
  }
}

abstract class DBEventDataKeyed {
  MapEntry<EventType, String> get eventKey;
}

@GraphQLClass()
@freezed
class DBEventData with _$DBEventData implements DBEventDataKeyed {
  const DBEventData._();
  const factory DBEventData.chat(ChatEvent value) = ChatDBEventData;
  const factory DBEventData.userChat(UserChatEvent value) = UserChatDBEventData;
  const factory DBEventData.user(UserEvent value) = UserDBEventData;
  const factory DBEventData.message(ChatMessageEvent value) =
      ChatMessageDBEventData;

  factory DBEventData.fromJson(Map<String, Object?> map) =>
      _$DBEventDataFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey => when(
        chat: (e) => e.eventKey,
        userChat: (e) => e.eventKey,
        user: (e) => e.eventKey,
        message: (e) => e.eventKey,
      );
}

@GraphQLClass()
@JsonSerializable()
class DBEvent {
  final int id;
  final int userId;
  final String sessionId;
  final EventType type;
  final DBEventData data;
  final DateTime createdAt;

  const DBEvent({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.type,
    required this.data,
    required this.createdAt,
  });

  factory DBEvent.fromJson(Map<String, Object?> json) {
    final data = json['data'];
    if (data is String) {
      return _$DBEventFromJson(<String, Object?>{
        ...json,
        'data': jsonDecode(data),
      });
    }
    return _$DBEventFromJson(json);
  }
}

@Subscription()
Future<Stream<DBEvent>> onEvent(Ctx ctx) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  final stream = await controller.events.subscribeToChanges(claims);

  final chatsCollector = _UserChatsCollector(ctx, userId: claims.userId);

  return stream.asyncMap((event) async {
    await chatsCollector.consume(event);
    return event;
  }).where(
    (event) => event.data.when(
      chat: (event) => chatsCollector.containsChat(event.chatId),
      message: (event) => chatsCollector.containsChat(event.chatId),
      user: (event) => event.userId == claims.userId,
      userChat: (event) => chatsCollector.containsChat(event.chatId),
    ),
  );
}

@Subscription()
Future<Stream<DBEvent>> onMessageEvent(Ctx ctx) async {
  final stream = await onEvent(ctx);

  return stream.where(
    (event) => event.data.maybeWhen(
      message: (_) => true,
      orElse: () => false,
    ),
  );
}

// TODO: T extends Object
@GraphQLClass()
class Paginated<T> {
  final List<T> values;
  final PageInfo pageInfo;

  const Paginated(this.values, this.pageInfo);
}

@Query()
Future<Paginated<DBEvent>> getEvents(
  Ctx ctx,
  String? cursor,
  int delta,
) async {
  final user = await getUserClaimsUnwrap(ctx);
  final numItems = delta.abs();
  final isAscending = delta > 0;
  final eventId = cursor == null ? null : int.tryParse(cursor);

  if (cursor != null && eventId == null) {
    throw 'Invalid cursor $cursor.';
  } else if (numItems > 25) {
    throw "Can't have the amount of items greater than 25.";
  } else if (numItems == 0) {
    throw "Can't have 0 number of elements.";
  }
  final controller = await chatControllerRef.get(ctx);
  final value = await controller.events.getPaginated(
    fromEventId: eventId,
    numEvents: numItems + 1,
    userId: user.userId,
    ascending: isAscending,
  );
  final hasMore = value.length > numItems;
  final selected = hasMore ? value.take(numItems).toList() : value;

  return Paginated(
    selected,
    selected.isEmpty
        ? PageInfo(
            hasNextPage: !isAscending && cursor != null,
            hasPreviousPage: isAscending && cursor != null,
            endCursor: null,
            startCursor: null,
          )
        : PageInfo(
            hasNextPage: isAscending ? hasMore : cursor != null,
            hasPreviousPage: !isAscending ? hasMore : cursor != null,
            startCursor: selected.first.id.toString(),
            endCursor: selected.last.id.toString(),
          ),
  );
}

class _UserChatsCollector {
  Set<int>? chatIds;
  final GlobalsHolder ctx;
  final int userId;

  _UserChatsCollector(
    this.ctx, {
    required this.userId,
  });

  bool containsChat(int chatId) {
    return chatIds!.contains(chatId);
  }

  Future<void> consume(DBEvent event) async {
    if (chatIds == null) {
      final userChats = await userChatsRef.get(ctx).getForUser(userId);
      chatIds = userChats.map((e) => e.chatId).toSet();
    }

    event.data.whenOrNull(
      userChat: (e) {
        e.map(
          added: (added) {
            if (added.chatUser.userId == userId) {
              chatIds!.add(added.chatUser.chatId);
            }
          },
          removed: (removed) {
            if (removed.userId == userId) {
              chatIds!.remove(removed.chatId);
            }
          },
        );
      },
    );
  }
}
