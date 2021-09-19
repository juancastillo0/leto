// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/books.controller.dart';
import 'package:sqlite3/sqlite3.dart';

part 'chat_table.g.dart';
part 'chat_table.freezed.dart';

// class DbCtx {
//   static Future<DbCtx> create() {
//      final x = ;

//   }
// }

bool migrate(Database db, String tableName, List<String> queries) {
  if (queries.isEmpty) {
    return true;
  }
  db.execute('''
    CREATE TABLE IF NOT EXISTS migration (
      code TEXT NOT NULL,
      query TEXT NOT NULL,
      createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
      PRIMARY KEY (code)
    );
  ''');

  db.execute('BEGIN TRANSACTION;');
  int i = 0;
  String migrationCode = '';
  for (final query in queries) {
    migrationCode = '${tableName}_$i';
    final result = db.select(
      'SELECT query from migration where code = ?;',
      [migrationCode],
    );
    if (result.isEmpty) {
      db.execute(query);
      db.execute(
        'INSERT INTO migration(code, query) VALUES(?, ?);',
        [migrationCode, query],
      );
    } else {
      final row = result.rows.first;
      final savedQuery = row.first! as String;
      if (savedQuery != query) {
        throw Exception('savedQuery $savedQuery != query $query');
      }
    }
    i++;
  }
  db.execute('COMMIT;');
  final result = db.select(
    'SELECT query from migration where code = ?;',
    [migrationCode],
  );
  return result.isNotEmpty;
}

final chatControllerRef = RefWithDefault(
  'ChatController',
  (globals) => ChatController.create(),
);

class ChatController {
  final ChatTable chats;
  final ChatMessageTable messages;

  ChatController({
    required this.chats,
    required this.messages,
  });

  static Future<ChatController> create() async {
    final chats = ChatTable();
    await chats.setup();
    final messages = ChatMessageTable();
    await messages.setup();

    return ChatController(chats: chats, messages: messages);
  }
}

class ChatTable {
  final Database db;

  ChatTable() : db = sqlite3.open('chat_room.sqlite');

  ChatRoom? insert(String name) {
    db.execute('INSERT INTO chat(name) VALUES (?)', [name]);

    final result = db.select(
      'SELECT * FROM chat WHERE id = ?',
      [db.lastInsertRowId],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatRoom.fromJson(result.first);
  }

  Future<void> setup() async {
    const tableName = 'chat';
    final migrated = migrate(
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
      ],
    );
    print('migrated $tableName $migrated');
  }
}

class ChatMessageTable {
  final Database db;

  final controller = StreamController<ChatMessage>.broadcast();

  ChatMessageTable() : db = sqlite3.open('chat_room.sqlite') {
    controller.stream.listen((event) {
      print(event);
    });
  }

  Future<List<ChatMessage>> getAll({int? chatId}) async {
    final result = db.select(
      '''
SELECT id, chatId, message, createdAt
FROM message ${chatId == null ? '' : 'WHERE chatId = ?'};
''',
      [if (chatId != null) chatId],
    );
    final values = result.map((e) => ChatMessage.fromJson(e)).toList();
    return values;
  }

  ChatMessage? insert(int chatId, String message) {
    db.execute('''
INSERT INTO message(chatId, message) VALUES (?, ?)
''', [chatId, message]);

    final result = db.select(
      'SELECT * FROM message WHERE id = ?',
      [db.lastInsertRowId],
    );
    if (result.isEmpty) {
      return null;
    }
    final messageModel = ChatMessage.fromJson(result.first);
    controller.add(messageModel);
    return messageModel;
  }

  Future<void> setup() async {
    const tableName = 'message';
    final migrated = migrate(
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
      ],
    );
    print('migrated $tableName $migrated');
  }
}

@GraphQLClass()
@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required int id,
    required String name,
    required DateTime createdAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, Object?> json) =>
      _$ChatRoomFromJson(json);
}

@GraphQLClass()
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int chatId,
    required String message,
    required DateTime createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);
}

@Mutation()
Future<ChatMessage?> sendMessage(
  ReqCtx<Object> ctx,
  int chatId,
  String message,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.insert(chatId, message);
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
  return controller.messages.controller.stream
      .where((event) => event.chatId == chatId)
      .asyncMap((event) => controller.messages.getAll(chatId: chatId));
}

@Mutation()
Future<ChatRoom?> createChatRoom(
  ReqCtx<Object> ctx,
  String name,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.insert(name);
}
