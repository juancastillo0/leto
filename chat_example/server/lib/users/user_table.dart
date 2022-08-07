import 'package:leto/dataloader.dart';
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/events/events_api.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_api.dart';

final userTableRef = ScopedRef.global(
  (scope) => UserTable(
    chatRoomDatabase.get(scope),
  ),
  name: 'UserTable',
);

final userSessionRef = ScopedRef.global(
  (scope) => UserSessionTable(
    chatRoomDatabase.get(scope),
  ),
  name: 'UserSessionTable',
);

final userDataLoaderRef = ScopedRef.global(
  (scope) {
    final table = userTableRef.get(scope);
    return DataLoader<int, User?, int>(
      (ids) => table.getByIds(ids),
    );
  },
  name: 'UserDataLoader',
);

class UserTable {
  final TableConnection conn;

  UserTable(this.conn);

  Future<void> setup() async {
    const tableName = 'user';
    final migrated = await migrate(
      conn,
      tableName,
      [
        '''
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  name TEXT NULL,
  passwordHash TEXT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<User> insert({String? name, String? passwordHash}) async {
    return conn.transaction((conn) async {
      final createdAt = DateTime.now();
      final result = await conn.query(
        'insert into user(name, passwordHash, createdAt)'
        ' values (?, ?, ?)',
        [
          name,
          passwordHash,
          createdAt,
        ],
      );
      final user = User(
        id: result.insertId!,
        name: name,
        createdAt: createdAt,
        passwordHash: passwordHash,
      );
      // await EventTable(conn).insert(
      //   DBEventData.user(UserEvent.created(user: user)),
      //   // TODO:
      //   UserClaims(sessionId: '', userId: user.id),
      // );
      return user;
    });
  }

  Future<User?> update(
    int id, {
    required String name,
    required String passwordHash,
  }) async {
    // TODO: EventTable
    return conn.transaction((conn) async {
      final result = await conn.query(
        'update user set name = ?, passwordHash = ? where id = ?;',
        [name, passwordHash, id],
      );
      final updated = (result.affectedRows ?? 0) > 0;
      if (!updated) {
        return null;
      }
      return get(id);
    });
  }

  Future<User?> get(int id) async {
    final result = await conn.query(
      'select * from user where id = ?',
      [id],
    );
    return result.isEmpty ? null : User.fromJson(result.first);
  }

  Future<List<User?>> getByIds(List<int> ids) async {
    final result = await conn.query(
      'select * from user where id IN (${ids.map((e) => '?').join(',')})',
      ids,
    );
    final allUsers = Map.fromEntries(result.map((e) {
      final u = User.fromJson(e);
      return MapEntry(u.id, u);
    }));
    return ids.map((e) => allUsers[e]).toList();
  }

  Future<User?> getByName(String name) async {
    final result = await conn.query(
      'select * from user where name = ?',
      [name],
    );
    return result.isEmpty ? null : User.fromJson(result.first);
  }

  Future<List<User>> searchByName(String name) async {
    final _escaped = name.replaceAllMapped(
      RegExp('[%_]'),
      (match) => '\\${match.input.substring(match.start, match.end)}',
    );
    final result = await conn.query(
      "select * from user where name LIKE ? ESCAPE '\\';",
      ['%$_escaped%'],
    );
    return result.map((e) => User.fromJson(e)).toList();
  }
}

class UserSessionTable {
  final TableConnection conn;

  UserSessionTable(this.conn);

  Future<void> setup() async {
    const tableName = 'userSession';
    final migrated = await migrate(
      conn,
      tableName,
      [
        '''
CREATE TABLE $tableName (
  id TEXT NOT NULL,
  userId INTEGER NOT NULL,
  isActive BOOL NOT NULL DEFAULT true,
  platform TEXT NULL,
  userAgent TEXT NULL,
  appVersion TEXT NULL,
  endedAt TIMESTAMP NULL,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (userId) REFERENCES user (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<UserSession?> insert(UserSession session) async {
    await conn.query(
      'insert into userSession(id, userId, isActive, platform,'
      ' userAgent, appVersion, createdAt)'
      ' values (?, ?, ?, ?, ?, ?, ?)',
      [
        session.id,
        session.userId,
        session.isActive,
        session.platform,
        session.userAgent,
        session.appVersion,
        session.createdAt.toIso8601String(),
      ],
    );
    return session;
  }

  Future<UserSession?> get(String id) async {
    final result = await conn.query(
      'select * from userSession where id = ?',
      [id],
    );
    return result.isEmpty ? null : UserSession.fromJson(result.first);
  }

  Future<List<UserSession>> getForUser(int userId) async {
    final result = await conn.query(
      'select * from userSession where userId = ?',
      [userId],
    );
    return result.map((e) => UserSession.fromJson(e)).toList();
  }

  Future<bool> deactivate(UserClaims claims) async {
    return conn.transaction((conn) async {
      final result = await conn.query(
        'update userSession set isActive = false,'
        ' endedAt = CURRENT_TIMESTAMP where id = ?;',
        [claims.sessionId],
      );
      final deactivated = (result.affectedRows ?? 0) >= 1;
      if (deactivated) {
        await EventTable(conn).insert(
          DBEventData.user(
            UserEvent.signedOut(
              userId: claims.userId,
              sessionId: claims.sessionId,
            ),
          ),
          claims,
        );
      }
      return deactivated;
    });
  }
}
