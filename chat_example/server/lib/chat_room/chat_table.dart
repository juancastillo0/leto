// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:query_builder/database/models/connection_models.dart';
import 'package:server/chat_room/chat_api.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/chat_room/user_rooms_api.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/data_utils/sqlite_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/events/events_api.dart';
import 'package:server/messages/messages_table.dart';
import 'package:server/users/auth.dart';
import 'package:sqlite3/sqlite3.dart';

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
