import 'dart:async';

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
  final EventType type;
  final DBEventData data;
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
        // ignore: leading_newlines_in_multiline_strings
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

@Subscription()
Future<Stream<DBEvent>> onMessageEvent(ReqCtx<Object> ctx) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  return controller.events.subscribeToChanges(EventType.messageSent);
}
