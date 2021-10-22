import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/messages/messages_table.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_table.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

part 'database_event.freezed.dart';
part 'database_event.g.dart';

@GraphQLClass()
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

class EventTable {
  final TableConnection db;

  EventTable(this.db);

  final subs = <String, Set<StreamSubscription>>{};
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
      final events = await getAllAfter(_subsLastEventId);
      if (events.isNotEmpty && subsLastEventId == _subsLastEventId) {
        subsLastEventId =
            events.map((e) => e.id).reduce((v, e) => v > e ? v : e);
        controller.add(events);
      }
    });
  }

  Future<int> insert(DBEventData data, UserClaims claims) async {
    final eventKey = data.eventKey;
    final result = await db.query(
      'INSERT INTO event(type, data, userId, sessionId) VALUES (?, ?, ?, ?)',
      [
        eventKey.key.toJson(),
        jsonEncode(data.toJson()),
        claims.userId,
        claims.sessionId,
      ],
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

  Future<Stream<DBEvent>> subscribeToChanges(UserClaims claims) async {
    final key = claims.sessionId;

    StreamSubscription<DBEvent>? _localSubs;
    late final StreamController<DBEvent> _controller;
    _controller = StreamController(
      onListen: () {
        _localSubs = controller.stream
            .expand((element) => element)
            .listen(_controller.add);
        if (subs.containsKey(key)) {
          subs[key]!.add(_localSubs!);
        } else {
          subs[key] = {_localSubs!};
          setUpSubscription();
        }
      },
      onCancel: () async {
        if (_localSubs != null) {
          final typeSubs = subs[key];
          if (typeSubs != null) {
            typeSubs.remove(_localSubs);
            if (typeSubs.isEmpty) {
              subs.remove(key);
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
        // ignore: leading_newlines_in_multiline_strings
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  type TEXT NOT NULL,
  data TEXT NOT NULL,
  userId INTEGER NOT NULL,
  sessionId TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (userId) REFERENCES user (id),
  FOREIGN KEY (sessionId) REFERENCES userSession (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }
}

@Subscription()
Future<Stream<DBEvent>> onEvent(ReqCtx<Object> ctx) async {
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
Future<Stream<DBEvent>> onMessageEvent(ReqCtx<Object> ctx) async {
  final stream = await onEvent(ctx);

  return stream.where(
    (event) => event.data.maybeWhen(
      message: (_) => true,
      orElse: () => false,
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
