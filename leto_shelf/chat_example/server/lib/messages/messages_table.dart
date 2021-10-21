// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/database/models/connection_models.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/users/auth.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

part 'messages_table.g.dart';
part 'messages_table.freezed.dart';

@GraphQLClass()
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int chatId,
    required int userId,
    required String message,
    int? referencedMessageId,
    required DateTime createdAt,
  }) = _ChatMessage;
  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);

  Future<ChatMessage?> referencedMessage(ReqCtx ctx) async {
    if (referencedMessageId == null) {
      return null;
    }
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.get(referencedMessageId!);
  }
}

@GraphQLClass()
@freezed
class ChatMessageEvent with _$ChatMessageEvent implements DBEventDataKeyed {
  const ChatMessageEvent._();
  const factory ChatMessageEvent.sent({
    required ChatMessage message,
  }) = ChatMessageSentEvent;

  const factory ChatMessageEvent.deleted({
    required int chatId,
    required int messageId,
  }) = ChatMessageSeletedEvent;

  const factory ChatMessageEvent.updated({
    required ChatMessage message,
  }) = ChatMessageUpdatedInEvent;

  factory ChatMessageEvent.fromJson(Map<String, Object?> map) =>
      _$ChatMessageEventFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey {
    return map(
      sent: (e) => MapEntry(EventType.messageSent, '$chatId/${e.message.id}'),
      deleted: (e) =>
          MapEntry(EventType.messageDeleted, '$chatId/${e.messageId}'),
      updated: (e) =>
          MapEntry(EventType.messageUpdated, '$chatId/${e.message.id}'),
    );
  }

  int get chatId {
    return map(
      sent: (e) => e.message.chatId,
      deleted: (e) => e.chatId,
      updated: (e) => e.message.chatId,
    );
  }
}

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

  Future<ChatMessage?> insert(
    int chatId,
    String message, {
    required int userId,
    int? referencedMessageId,
  }) async {
    ChatMessage? messageModel;
    await db.transaction((db) async {
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
      final createdAt = DateTime.now();

      final insertResult = await db.query(
        '''
        INSERT INTO 
        message(chatId, message, referencedMessageId, userId, createdAt)
        VALUES (?, ?, ?, ?, ?)''',
        [
          chatId,
          message,
          referencedMessageId,
          userId,
          createdAt.toIso8601String()
        ],
      );
      final _messageModel = ChatMessage(
        chatId: chatId,
        createdAt: createdAt,
        id: insertResult.insertId!,
        userId: userId,
        message: message,
        referencedMessageId: referencedMessageId,
      );
      await EventTable(db).insert(
        DBEventData.message(ChatMessageEvent.sent(message: _messageModel)),
      );

      messageModel = _messageModel;
    });
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
      ],
    );
    print('migrated $tableName $migrated');
  }
}

@Mutation()
Future<ChatMessage?> sendMessage(
  ReqCtx<Object> ctx,
  int chatId,
  String message,
  int? referencedMessageId,
) async {
  final userClaims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.insert(
    chatId,
    message,
    referencedMessageId: referencedMessageId,
    userId: userClaims.userId,
  );
}

@Mutation()
Future<ChatMessage?> sendFileMessage(
  ReqCtx<Object> ctx,
  int chatId,
  UploadedFile file,
  int? referencedMessageId,
) async {
  final userClaims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.insert(
    chatId,
    // TODO:
    'message',
    referencedMessageId: referencedMessageId,
    userId: userClaims.userId,
  );
}

@Query()
Future<List<ChatMessage>> getMessage(
  ReqCtx<Object> ctx,
  int? chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.getAll(chatId: chatId);
}

@Subscription()
Future<Stream<List<ChatMessage>>> onMessageSent(
  ReqCtx<Object> ctx,
  int chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  final chat = await controller.chats.get(chatId);
  if (chat == null) {
    throw GraphQLError('Chat with id $chatId not found.');
  }
  return controller.messages.controller.stream
      .where((event) => event.chatId == chatId)
      .asyncMap((event) => controller.messages.getAll(chatId: chatId));
}
