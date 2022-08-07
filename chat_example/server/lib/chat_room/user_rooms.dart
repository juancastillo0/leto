import 'dart:async';

import 'package:leto_schema/leto_schema.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/user_rooms_api.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/events/events_api.dart';
import 'package:server/users/auth.dart';

final userChatsRef = ScopedRef.global(
  (scope) => UserChatsTable(
    chatRoomDatabase.get(scope),
  ),
  name: 'UserChatsTable',
);

class UserChatsTable {
  final TableConnection conn;

  UserChatsTable(this.conn);

  Future<void> setup() async {
    const tableName = 'chatRoomUser';
    final migrated = await migrate(
      conn,
      tableName,
      [
        '''
CREATE TABLE chatRoomUser (
    userId INT NOT NULL,
    chatId INT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'peer')),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, chatId),
    FOREIGN KEY (userId) REFERENCES user (id),
    FOREIGN KEY (chatId) REFERENCES chat (id)
);''',
// add ON DELETE CASCADE on references
        'ALTER TABLE $tableName RENAME TO tmp_$tableName;',
        '''
CREATE TABLE $tableName (
    userId INT NOT NULL,
    chatId INT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'peer')),
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, chatId),
    FOREIGN KEY (userId) REFERENCES user (id) ON DELETE CASCADE,
    FOREIGN KEY (chatId) REFERENCES chat (id) ON DELETE CASCADE
);''',
        '''
INSERT INTO $tableName(userId, chatId, role, createdAt) 
SELECT userId, chatId, role, createdAt
FROM tmp_$tableName;''',
        'DROP TABLE tmp_$tableName;',
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<bool> insert(ChatRoomUser user, UserClaims claims) async {
    return conn.transaction((conn) async {
      final result = await conn.query(
        'insert into chatRoomUser(userId, chatId, role, createdAt)'
        ' values (?, ?, ?, ?)',
        [
          user.userId,
          user.chatId,
          user.role.toString().split('.')[1],
          user.createdAt,
        ],
      );
      final inserted = (result.affectedRows ?? 0) >= 1;
      if (inserted) {
        await EventTable(conn).insert(
          DBEventData.userChat(
            UserChatEvent.added(chatUser: user),
          ),
          claims,
        );
      }
      return inserted;
    });
  }

  Future<bool> delete({
    required int userId,
    required int chatId,
    required UserClaims claims,
  }) async {
    return conn.transaction((conn) async {
      final result = await conn.query(
        'delete from chatRoomUser where userId = ? and chatId = ?',
        [userId, chatId],
      );
      final deleted = (result.affectedRows ?? 0) >= 1;
      if (deleted) {
        await EventTable(conn).insert(
          DBEventData.userChat(
            UserChatEvent.removed(
              chatId: chatId,
              userId: userId,
            ),
          ),
          claims,
        );
      }
      return deleted;
    });
  }

  Future<ChatRoomUser?> get({
    required int chatId,
    required int userId,
  }) async {
    final result = await conn.query(
      'select * from chatRoomUser where chatId = ? and userId = ?;',
      [chatId, userId],
    );
    return result.isEmpty ? null : ChatRoomUser.fromJson(result.first);
  }

  Future<List<ChatRoomUser>?> getForChat(int id) async {
    final result = await conn.query(
      'select * from chatRoomUser where chatId = ?',
      [id],
    );
    return result.map((e) => ChatRoomUser.fromJson(e)).toList();
  }

  Future<List<ChatRoomUser>> getForUser(int id) async {
    final result = await conn.query(
      'select * from chatRoomUser where userId = ?',
      [id],
    );
    return result.map((e) => ChatRoomUser.fromJson(e)).toList();
  }
}
