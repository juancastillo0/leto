// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/database/models/connection_models.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/data_utils/sqlite_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/messages/messages_table.dart';
import 'package:server/users/auth.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:sqlite3/sqlite3.dart';

part 'chat_table.freezed.dart';
part 'chat_table.g.dart';

final chatRoomDatabase = RefWithDefault<TableConnection>.global(
  (scope) => SqliteConnection(
    const bool.fromEnvironment('SQLITE_MEMORY')
        ? sqlite3.openInMemory()
        : sqlite3.open('chat_room.sqlite'),
  ),
  name: 'ChatRoomDatabase',
);

final chatControllerRef = RefWithDefault.global(
  (scope) => ChatController.create(chatRoomDatabase.get(scope)),
  name: 'ChatController',
);

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

class ChatController {
  final ChatTable chats;
  final ChatMessageTable messages;
  final EventTable events;

  ChatController({
    required this.chats,
    required this.messages,
    required this.events,
  });

  static Future<ChatController> create(TableConnection db) async {
    if (db.database == SqlDatabase.sqlite) {
      await db.query('PRAGMA foreign_keys = ON;');
    }

    final events = EventTable(db);
    await events.setup();
    final chats = ChatTable(db);
    await chats.setup();
    final messages = ChatMessageTable(db);
    await messages.setup();

    return ChatController(
      chats: chats,
      messages: messages,
      events: events,
    );
  }
}

class ChatTable {
  final TableConnection db;

  ChatTable(this.db);

  Future<ChatRoom?> insert(String name, UserClaims user) async {
    return db.transaction((db) async {
      final createdAt = DateTime.now();
      final result = await db.query(
        'INSERT INTO chat(name, createdAt) VALUES (?, ?)',
        [name, createdAt],
      );

      final chat = ChatRoom(
        id: result.insertId!,
        createdAt: createdAt,
        name: name,
      );
      await EventTable(db).insert(
        DBEventData.chat(
          ChatEvent.created(
            chat: chat,
            ownerId: user.userId,
          ),
        ),
        user,
      );
      await UserChatsTable(db).insert(
        ChatRoomUser(
          chatId: chat.id,
          userId: user.userId,
          role: ChatRoomUserRole.admin,
          createdAt: DateTime.now(),
        ),
        user,
      );

      return chat;
    });
  }

  Future<bool> delete({
    required int chatId,
    required UserClaims user,
  }) async {
    return db.transaction((db) async {
      final result = await db.query(
        'DELETE FROM chat WHERE id IN (select chat.id from chat INNER JOIN'
        ' chatRoomUser on chatRoomUser.chatId = chat.id'
        ' where chat.id = ? and chatRoomUser.userId = ?'
        " and chatRoomUser.role in ('admin'));",
        [chatId, user.userId],
      );
      final deleted = (result.affectedRows ?? 0) > 0;
      if (deleted) {
        await EventTable(db).insert(
          DBEventData.chat(ChatEvent.deleted(chatId: chatId)),
          user,
        );
      }
      return deleted;
    });
  }

  Future<ChatRoom?> get(int chatId) async {
    final result = await db.query(
      'SELECT * FROM chat WHERE id = ?;',
      [chatId],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatRoom.fromJson(result.first);
  }

  Future<List<ChatRoom>> getAll({
    int? userId,
    bool withUsers = false,
    bool withMessages = false,
  }) async {
    final result = await db.query(
      '''
SELECT chat.*${withUsers ? ', chatRoomUser.*' : ''}${withMessages ? ', message.*' : ''} FROM chat
${withUsers ? 'LEFT JOIN chatRoomUser ON chat.id = chatRoomUser.chatId' : ''}
${withMessages ? 'LEFT JOIN message ON chat.id = message.chatId' : ''}
${userId == null ? '' : '''WHERE EXISTS (
  select chatRoomUser.userId from chatRoomUser 
  where chatRoomUser.chatId = chat.id
  and chatRoomUser.userId = ?
)'''};''',
      [if (userId != null) userId],
    );

    final values =
        ChatRoom.listFromJson(result.map((e) => e.toTableColumnMap()), {
      'chatRoomUser': ['userId', 'chatId'],
      'message': ['id'],
    });
    return values;
  }

  Future<void> setup() async {
    const tableName = 'chat';
    final migrated = await migrate(
      db,
      tableName,
      [
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id)
);''',
// TODO:
//         '''
// ALTER TABLE $tableName ADD COLUMN lastMessageId INT NULL
// ''',
      ],
    );
    print('migrated $tableName $migrated');
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

  Future<List<ChatMessage>> messages(ReqCtx<Object> ctx) async {
    if (messagesCache != null) {
      return messagesCache!;
    }
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.getAll(chatId: id);
  }

  Future<List<ChatRoomUser>> users(ReqCtx<Object> ctx) async {
    if (usersCache != null) {
      return usersCache!;
    }
    final users = await userChatsRef.get(ctx).getForChat(id);
    return users!;
  }
}

@Mutation()
Future<ChatRoom?> createChatRoom(
  ReqCtx<Object> ctx,
  String name,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.insert(name, claims);
}

@Mutation()
Future<bool> deleteChatRoom(
  ReqCtx<Object> ctx,
  int id,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.delete(chatId: id, user: claims);
}

@Query()
Future<List<ChatRoom>> getChatRooms(
  ReqCtx<Object> ctx,
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
