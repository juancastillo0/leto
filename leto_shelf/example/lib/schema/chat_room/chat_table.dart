// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/chat_room/sql_utils.dart';
import 'package:sqlite3/sqlite3.dart';

part 'chat_table.g.dart';
part 'chat_table.freezed.dart';

final chatRoomDatabase = GlobalRef('ChatRoomDatabase');

final chatControllerRef = RefWithDefault(
  'ChatController',
  (holder) => ChatController.create(
    db: holder.globals[chatRoomDatabase] as Database?,
  ),
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

  static Future<ChatController> create({Database? db}) async {
    final _db = db ?? sqlite3.open('chat_room.sqlite');
    _db.execute('PRAGMA foreign_keys = ON;');

    final events = EventTable(_db);
    await events.setup();
    final chats = ChatTable(_db);
    await chats.setup();
    final messages = ChatMessageTable(_db, events);
    await messages.setup();

    return ChatController(
      chats: chats,
      messages: messages,
      events: events,
    );
  }
}

class ChatTable {
  final Database db;

  ChatTable(this.db);

  ChatRoom? insert(String name) {
    db.execute('INSERT INTO chat(name) VALUES (?)', [name]);

    return get(db.lastInsertRowId);
  }

  ChatRoom? get(int chatId) {
    final result = db.select(
      'SELECT * FROM chat WHERE id = ?;',
      [chatId],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatRoom.fromJson(result.first);
  }

  Future<List<ChatRoom>> getAll() async {
    final result = db.select(
      '''SELECT * FROM chat;''',
    );
    final values = result.map((e) => ChatRoom.fromJson(e)).toList();
    return values;
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
  final EventTable eventsTable;

  final controller = StreamController<ChatMessage>.broadcast();

  ChatMessageTable(this.db, this.eventsTable) {
    controller.stream.listen((event) {
      print(event);
    });
  }

  Future<List<ChatMessage>> getAll({int? chatId}) async {
    final result = db.select(
      '''
SELECT * FROM message ${chatId == null ? '' : 'WHERE chatId = ?'};
''',
      [if (chatId != null) chatId],
    );
    final values = result.map((e) => ChatMessage.fromJson(e)).toList();
    return values;
  }

  Future<ChatMessage?> get(int id) async {
    final result = db.select(
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
    int? referencedMessageId,
  }) async {
    ChatMessage? messageModel;
    db.execute('BEGIN TRANSACTION;');
    try {
      if (referencedMessageId != null) {
        final referencedMessage = await get(referencedMessageId);
        if (referencedMessage == null) {
          throw Exception(
              'Chat message with id $referencedMessageId not found.');
        } else if (referencedMessage.chatId != chatId) {
          throw Exception('Can only reference messages within the same chat.');
        }
      }
      final createdAt = DateTime.now();

      db.execute(
        '''INSERT INTO message(chatId, message, referencedMessageId, createdAt)
              VALUES (?, ?, ?, ?)''',
        [chatId, message, referencedMessageId, createdAt.toIso8601String()],
      );
      final _messageModel = ChatMessage(
        chatId: chatId,
        createdAt: createdAt,
        id: db.lastInsertRowId,
        message: message,
        referencedMessageId: referencedMessageId,
      );
      eventsTable.insert(
        EventType.messageSent,
        jsonEncode(_messageModel.toJson()),
      );

      db.execute('COMMIT;');
      messageModel = _messageModel;
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        throw Exception('Chat room with id $chatId not found.');
      }
      return null;
    } finally {
      if (messageModel == null) {
        db.execute('ROLLBACK;');
      }
    }
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
      ],
    );
    print('migrated $tableName $migrated');
  }
}

@GraphQLClass()
enum EventType { messageSent }

extension SerdeEventType on EventType {
  String toJson() {
    return toString().split('.').last;
  }
}

@JsonSerializable()
@GraphQLClass()
class DBEvent {
  final int id;
  final EventType type;
  final String data;
  final DateTime createdAt;

  const DBEvent({
    required this.id,
    required this.type,
    required this.data,
    required this.createdAt,
  });

  factory DBEvent.fromJson(Map<String, Object?> json) =>
      _$DBEventFromJson(json);
}

class EventTable {
  final Database db;

  EventTable(this.db);

  final subs = <EventType, Set<StreamSubscription>>{};
  Timer? _subsTimer;
  int subsLastEventId = -1;
  late final controller = StreamController<List<DBEvent>>.broadcast(
    onListen: setUpSubscription,
    onCancel: () {
      _subsTimer?.cancel();
    },
  );

  void setUpSubscription() {
    _subsTimer?.cancel();
    if (subs.isEmpty) {
      return;
    }
    _subsTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final _subsLastEventId = subsLastEventId;
      // maybe compare the last id without filtering by type?
      final events = await getAllAfter(_subsLastEventId, types: subs.keys);
      if (events.isNotEmpty && subsLastEventId == _subsLastEventId) {
        subsLastEventId =
            events.map((e) => e.id).reduce((v, e) => v > e ? v : e);
        controller.add(events);
      }
    });
  }

  int insert(EventType type, String data) {
    db.execute(
      'INSERT INTO event(type, data) VALUES (?, ?)',
      [type.toJson(), data],
    );

    return db.lastInsertRowId;
  }

  DBEvent? get(int eventId) {
    final result = db.select(
      'SELECT * FROM event WHERE id = ?;',
      [eventId],
    );
    if (result.isEmpty) {
      return null;
    }
    return DBEvent.fromJson(result.first);
  }

  Future<List<DBEvent>> getAllAfter(
    int id, {
    Iterable<EventType>? types,
  }) async {
    final result = db.select(
      'SELECT * FROM event WHERE id > ?'
      ' ${types == null || types.isEmpty ? '' : 'AND (${types.map((_) => 'type = ?').join(' OR ')})'}'
      ' ORDER BY id;',
      [id, if (types != null) ...types.map((e) => e.toJson())],
    );
    final values = result.map((e) => DBEvent.fromJson(e)).toList();
    return values;
  }

  Future<Stream<DBEvent>> subscribeToChanges(EventType type) async {
    StreamSubscription<DBEvent>? _localSubs;
    late final StreamController<DBEvent> _controller;
    _controller = StreamController(
      onListen: () {
        _localSubs = controller.stream
            .expand((element) => element)
            .where((event) => event.type == type)
            .listen(_controller.add);
        if (subs.containsKey(type)) {
          subs[type]!.add(_localSubs!);
        } else {
          subs[type] = {_localSubs!};
          setUpSubscription();
        }
      },
      onCancel: () async {
        if (_localSubs != null) {
          final typeSubs = subs[type];
          if (typeSubs != null) {
            typeSubs.remove(_localSubs);
            if (typeSubs.isEmpty) {
              subs.remove(type);
              setUpSubscription();
            }
          }
          await _localSubs!.cancel();
        }
      },
    );

    return _controller.stream;
  }

  Future<void> setup() async {
    const tableName = 'event';
    final migrated = migrate(
      db,
      tableName,
      [
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  type TEXT NOT NULL,
  data TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
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
  const ChatRoom._();

  factory ChatRoom.fromJson(Map<String, Object?> json) =>
      _$ChatRoomFromJson(json);

  Future<List<ChatMessage>> messages(ReqCtx<Object> ctx) async {
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.getAll(chatId: id);
  }
}

@GraphQLClass()
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int chatId,
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

@Mutation()
Future<ChatMessage?> sendMessage(
  ReqCtx<Object> ctx,
  int chatId,
  String message,
  int? referencedMessageId,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.insert(
    chatId,
    message,
    referencedMessageId: referencedMessageId,
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
  final chat = controller.chats.get(chatId);
  if (chat == null) {
    throw GraphQLError('Chat with id $chatId not found.');
  }
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

@Query()
Future<List<ChatRoom>> getChatRooms(
  ReqCtx<Object> ctx,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.getAll();
}

@Subscription()
Future<Stream<DBEvent>> onMessageEvent(
  ReqCtx<Object> ctx,
  EventType type,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.events.subscribeToChanges(type);
}
