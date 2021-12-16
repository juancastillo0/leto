// ignore_for_file: leading_newlines_in_multiline_strings, constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:query_builder/database/models/connection_models.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/events/events_api.dart';
import 'package:server/messages/messages_api.dart';
import 'package:server/messages/metadata.dart';
import 'package:server/users/auth.dart';

class ChatMessageTable {
  final TableConnection db;

  final controller = StreamController<ChatMessage>.broadcast();

  ChatMessageTable(this.db) {
    controller.stream.listen((event) {
      print(event);
    });
  }

  Future<List<ChatMessage>> getAll({int? chatId}) async {
    final result = await db.query(
      '''
SELECT * FROM message ${chatId == null ? '' : 'WHERE chatId = ?'};
''',
      [if (chatId != null) chatId],
    );
    final values = result.map((e) => ChatMessage.fromJson(e)).toList();
    return values;
  }

  Future<ChatMessage?> get(int id) async {
    final result = await db.query(
      '''SELECT * FROM message WHERE id = ?;''',
      [id],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatMessage.fromJson(result.first);
  }

  Future<ChatMessage?> getByPath(String path) async {
    final result = await db.query(
      '''SELECT * FROM message WHERE fileUrl = ?;''',
      [path],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatMessage.fromJson(result.first);
  }

  Future<void> validateInsert({
    required int userId,
    required int chatId,
    required int? referencedMessageId,
  }) {
    return db.transaction((db) async {
      final chatUser = await UserChatsTable(db).get(
        userId: userId,
        chatId: chatId,
      );
      if (chatUser == null) {
        throw unauthorizedError;
      }
      if (referencedMessageId != null) {
        final referencedMessage =
            await ChatMessageTable(db).get(referencedMessageId);
        if (referencedMessage == null) {
          throw Exception(
            'Chat message with id $referencedMessageId not found.',
          );
        } else if (referencedMessage.chatId != chatId) {
          throw Exception('Can only reference messages within the same chat.');
        }
      }
    });
  }

  Future<ChatMessage?> insert(
    int chatId,
    String message, {
    String? fileUrl,
    required UserClaims user,
    int? referencedMessageId,
    required MessageMetadata metadata,
  }) async {
    ChatMessage? messageModel;
    await db.transaction((db) async {
      await ChatMessageTable(db).validateInsert(
        userId: user.userId,
        chatId: chatId,
        referencedMessageId: referencedMessageId,
      );
      final createdAt = DateTime.now();
      final messageType = fileUrl == null ? MessageType.TEXT : MessageType.FILE;
      final metadataJson = jsonEncode(metadata.toJson());
      final insertResult = await db.query(
        '''
        INSERT INTO 
        message(chatId, message, referencedMessageId, 
          userId, fileUrl, type, createdAt, metadataJson)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)''',
        [
          chatId,
          message,
          referencedMessageId,
          user.userId,
          fileUrl,
          messageType.toString().split('.').last,
          createdAt.toIso8601String(),
          metadataJson,
        ],
      );
      final _messageModel = ChatMessage(
        chatId: chatId,
        createdAt: createdAt,
        id: insertResult.insertId!,
        userId: user.userId,
        type: messageType,
        fileUrl: fileUrl,
        metadataJson: metadataJson,
        message: message,
        referencedMessageId: referencedMessageId,
      );
      await EventTable(db).insert(
        DBEventData.message(ChatMessageEvent.sent(message: _messageModel)),
        user,
      );

      messageModel = _messageModel;
    });
    // TODO:
    // } on SqliteException catch (e) {
    //   if (e.extendedResultCode == 787) {
    //     throw Exception('Chat room with id $chatId not found.');
    //   }
    //   return null;
    // } finally {
    //   if (messageModel == null) {
    //     db.execute('ROLLBACK;');
    //   }
    // }
    if (messageModel != null) {
      controller.add(messageModel!);
    }
    return messageModel;
  }

  Future<void> setup() async {
    const tableName = 'message';
    final migrated = await migrate(
      db,
      tableName,
      [
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  message TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id),
  FOREIGN KEY (chatId) REFERENCES chat (id)
);''',

        /// Change DEFAULT CURRENT_DATE -> DEFAULT CURRENT_TIMESTAMP
        'ALTER TABLE $tableName RENAME TO tmp_$tableName;',
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  message TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (chatId) REFERENCES chat (id)
);''',
        '''\
INSERT INTO $tableName(id, chatId, message, createdAt) 
SELECT id, chatId, message, createdAt
FROM tmp_$tableName;''',
        'DROP TABLE tmp_$tableName;',

        /// Add referencedMessageId column
        '''
ALTER TABLE $tableName ADD referencedMessageId INT NULL
REFERENCES $tableName (id);''',

        /// Add userId column and add ON DELETE CASCADE FOR chat
        '''DROP TABLE $tableName;''',
        '''
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  userId INTEGER NOT NULL,
  message TEXT NOT NULL,
  referencedMessageId INT NULL REFERENCES $tableName (id),
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (userId) REFERENCES user (id),
  FOREIGN KEY (chatId) REFERENCES chat (id) ON DELETE CASCADE
);''',

        /// Add type, fileUrl, metadataJson, isDeleted columns,
        '''DROP TABLE $tableName;''',
        '''
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  userId INTEGER NOT NULL,
  message TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('TEXT', 'FILE')),
  fileUrl TEXT NULL CHECK (type = 'FILE' AND fileUrl is not null OR type = 'TEXT' AND fileUrl is null),
  isDeleted BOOL NOT NULL DEFAULT 0,
  metadataJson ${db.database == SqlDatabase.sqlite ? 'TEXT' : 'JSONB'} NULL,
  referencedMessageId INT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (referencedMessageId) REFERENCES $tableName (id),
  FOREIGN KEY (userId) REFERENCES user (id),
  FOREIGN KEY (chatId) REFERENCES chat (id) ON DELETE CASCADE
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }
}
