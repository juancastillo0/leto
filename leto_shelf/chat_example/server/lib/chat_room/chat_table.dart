// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/database/models/connection_models.dart';
import 'package:server/chat_room/sql_utils.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/chat_room/sqlite_utils.dart';
import 'package:server/users/auth.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:sqlite3/sqlite3.dart';

part 'chat_table.g.dart';
part 'chat_table.freezed.dart';

final chatRoomDatabase = RefWithDefault<TableConnection>.global(
  'ChatRoomDatabase',
  (scope) => SqliteConnection(
    Platform.environment['SQLITE_MEMORY'] == 'true'
        ? sqlite3.openInMemory()
        : sqlite3.open('chat_room.sqlite'),
  ),
);

final chatControllerRef = RefWithDefault.global(
  'ChatController',
  (scope) => ChatController.create(chatRoomDatabase.get(scope)),
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

  Future<ChatRoom?> insert(String name, int userId) async {
    return db.transaction((db) async {
      final result = await db.query(
        'INSERT INTO chat(name) VALUES (?)',
        [name],
      );

      if (result.insertId != null) {
        await UserChatsTable(db).insert(
          ChatRoomUser(
            chatId: result.insertId!,
            userId: userId,
            role: ChatRoomUserRole.admin,
          ),
        );
      }
      return ChatTable(db).get(result.insertId!);
    });
  }

  Future<bool> delete({
    required int chatId,
    required int userId,
  }) async {
    return db.transaction((db) async {
      final result = await db.query(
        'DELETE chat from chat INNER JOIN'
        ' chatRoomUser on chatRoomUser.chatId = chat.id'
        ' where chat.id = ? and chatRoomUser.userId = ?'
        " and chatRoomUser.role in ('admin');",
        [chatId, userId],
      );

      return (result.affectedRows ?? 0) > 0;
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
    bool withUsers = false,
    bool withMessages = false,
  }) async {
    final result = await db.query(
      '''
SELECT chat.*${withUsers ? ', chatRoomUser.*' : ''}${withMessages ? ', message.*' : ''} FROM chat
${withUsers ? 'LEFT JOIN chatRoomUser ON chat.id = chatRoomUser.chatId' : ''}
${withMessages ? 'LEFT JOIN message ON chat.id = message.chatId' : ''}
;''',
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
      ],
    );
    print('migrated $tableName $migrated');
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
        '''INSERT INTO message(chatId, message, referencedMessageId, userId, createdAt)
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
        EventType.messageSent,
        jsonEncode(_messageModel.toJson()),
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
  final TableConnection db;

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

  Future<int> insert(EventType type, String data) async {
    final result = await db.query(
      'INSERT INTO event(type, data) VALUES (?, ?)',
      [type.toJson(), data],
    );

    return result.insertId!;
  }

  Future<DBEvent?> get(int eventId) async {
    final result = await db.query(
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
    final result = await db.query(
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
    final migrated = await migrate(
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

@Mutation()
Future<ChatRoom?> createChatRoom(
  ReqCtx<Object> ctx,
  String name,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.insert(name, claims.userId);
}

@Mutation()
Future<bool> deleteChatRoom(
  ReqCtx<Object> ctx,
  int id,
) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.delete(chatId: id, userId: claims.userId);
}

@Query()
Future<List<ChatRoom>> getChatRooms(
  ReqCtx<Object> ctx,
) async {
  final controller = await chatControllerRef.get(ctx);
  final possibleSelections = ctx.lookahead()!.asObject;

  final withMessages = possibleSelections.contains('messages');
  final withUsers = possibleSelections.contains('users');

  return controller.chats.getAll(
    withMessages: withMessages,
    withUsers: withUsers,
  );
}

@Subscription()
Future<Stream<DBEvent>> onMessageEvent(
  ReqCtx<Object> ctx,
  EventType type,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.events.subscribeToChanges(type);
}
