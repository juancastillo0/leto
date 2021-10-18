import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/chat_room/sql_utils.dart';
import 'package:server/users/user_table.dart';

import 'package:shelf_graphql/shelf_graphql.dart';

part 'user_rooms.g.dart';

final userChatsRef = RefWithDefault.global(
  'UserChatsTable',
  (scope) => UserChatsTable(
    chatRoomDatabase.get(scope),
  ),
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
      ],
    );
    print('migrated $tableName $migrated');
  }

  Future<bool> insert(ChatRoomUser user) async {
    final result = await conn.query(
      'insert into chatRoomUser(userId, chatId, role, createdAt)'
      ' values (?, ?, ? CURRENT_TIMESTAMP)',
      [
        user.userId,
        user.chatId,
        user.role.toString().split('.')[1],
      ],
    );
    return (result.affectedRows ?? 0) >= 1;
  }

  Future<bool> delete({
    required int userId,
    required int chatId,
  }) async {
    final result = await conn.query(
      'delete from chatRoomUser where userId = ? and chatId = ?',
      [
        userId,
        chatId,
      ],
    );
    return (result.affectedRows ?? 0) >= 1;
  }

  Future<List<ChatRoomUser>?> getForChat(int id) async {
    final result = await conn.query(
      'select * from chatRoomUser where chatId = ?',
      [id],
    );
    return result.map((e) => ChatRoomUser.fromJson(e)).toList();
  }

  Future<List<ChatRoomUser>?> getForUser(int id) async {
    final result = await conn.query(
      'select * from chatRoomUser where userId = ?',
      [id],
    );
    return result.map((e) => ChatRoomUser.fromJson(e)).toList();
  }
}

@GraphQLClass()
enum ChatRoomUserRole {
  admin,
  peer,
}

@GraphQLClass()
@JsonSerializable()
class ChatRoomUser {
  final int userId;
  final int chatId;
  final ChatRoomUserRole role;

  ChatRoomUser({
    required this.userId,
    required this.chatId,
    required this.role,
  });

  FutureOr<User> user(ReqCtx ctx) async {
    final _user = await userDataloaderRef.get(ctx).load(userId);
    return _user!;
  }

  factory ChatRoomUser.fromJson(Map<String, Object?> json) =>
      _$ChatRoomUserFromJson(json);
}
