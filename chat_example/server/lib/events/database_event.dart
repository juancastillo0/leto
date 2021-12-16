import 'dart:async';
import 'dart:convert';

import 'package:query_builder/query_builder.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/events_api.dart';
import 'package:server/users/auth.dart';

class EventTable {
  final TableConnection db;

  EventTable(this.db);

  final subs = <String, Set<StreamSubscription>>{};
  Timer? _subsTimer;
  int? subsLastEventId;
  late final controller = StreamController<List<DBEvent>>.broadcast(
    onListen: setUpSubscription,
    onCancel: () {
      _subsTimer?.cancel();
      subsLastEventId = null;
    },
  );

  Future<void> setUpSubscription() async {
    _subsTimer?.cancel();
    if (subs.isEmpty) {
      return;
    }
    subsLastEventId ??= await getLastId() ?? -1;
    _subsTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      final _subsLastEventId = subsLastEventId!;
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

  Future<int?> getLastId() async {
    final result = await db.query(
      'SELECT MAX(id) FROM event;',
    );
    if (result.isEmpty) {
      return null;
    }
    return result.first.values.first as int?;
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

  Future<List<DBEvent>> getPaginated({
    required int? fromEventId,
    required int numEvents,
    int? userId,
    String? sessionId,
    bool ascending = true,
    bool bringEvent = false,
  }) async {
    final String comparison;
    if (ascending) {
      comparison = bringEvent ? 'id >= ?' : 'id > ?';
    } else {
      comparison = bringEvent ? 'id <= ?' : 'id < ?';
    }
    final result = await db.query(
      'SELECT * FROM event WHERE ${[
        if (fromEventId != null) comparison,
        if (userId != null) 'userId = ?',
        if (sessionId != null) 'sessionId = ?',
      ].join(' AND ')}'
      ' ORDER BY id ${ascending ? 'ASC' : 'DESC'} LIMIT ?;',
      [
        if (fromEventId != null) fromEventId,
        if (userId != null) userId,
        if (sessionId != null) sessionId,
        numEvents
      ],
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
              // ignore: unawaited_futures
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
