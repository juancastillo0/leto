import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/query_builder.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/data_utils/sql_utils.dart';
import 'package:server/events/database_event.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_table.dart';

import 'package:shelf_graphql/shelf_graphql.dart';

part 'user_rooms.g.dart';
part 'user_rooms.freezed.dart';

final userChatsRef = RefWithDefault.global(
  'UserChatsTable',
  (scope) => UserChatsTable(
    chatRoomDatabase.get(scope),
  ),
);

@GraphQLClass()
@freezed
class UserChatEvent with _$UserChatEvent implements DBEventDataKeyed {
  const UserChatEvent._();
  const factory UserChatEvent.added({
    required ChatRoomUser chatUser,
  }) = UserChatAddedEvent;

  const factory UserChatEvent.removed({
    required int chatId,
    required int userId,
  }) = UserChatRemovedEvent;

  factory UserChatEvent.fromJson(Map<String, Object?> map) =>
      _$UserChatEventFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey {
    return map(
      added: (e) => MapEntry(
        EventType.userChatAdded,
        '${e.chatUser.chatId}/${e.chatUser.userId}',
      ),
      removed: (e) => MapEntry(
        EventType.userChatRemoved,
        '${e.chatId}/${e.userId}',
      ),
    );
  }

  int get chatId {
    return map(
      added: (e) => e.chatUser.chatId,
      removed: (e) => e.chatId,
    );
  }
}

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
  final DateTime createdAt;

  ChatRoomUser({
    required this.userId,
    required this.chatId,
    required this.role,
    required this.createdAt,
  });

  FutureOr<User> user(ReqCtx ctx) async {
    final _user = await userDataLoaderRef.get(ctx).load(userId);
    return _user!;
  }

  factory ChatRoomUser.fromJson(Map<String, Object?> json) =>
      _$ChatRoomUserFromJson(json);
}

Future<_ValidatedUserChat> validateEditPermission(
  ReqCtx ctx, {
  required int chatId,
  required int? userId,
}) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final currentChatUser = await userChatsRef.get(ctx).get(
        chatId: chatId,
        userId: claims.userId,
      );

  if (currentChatUser == null ||
      (currentChatUser.userId != userId &&
          !const [ChatRoomUserRole.admin].contains(currentChatUser.role))) {
    throw unauthorizedError;
  }
  return _ValidatedUserChat(currentChatUser, claims);
}

class _ValidatedUserChat {
  final ChatRoomUser chatUser;
  final UserClaims userClaims;

  _ValidatedUserChat(this.chatUser, this.userClaims);
}

@Mutation()
Future<ChatRoomUser?> addChatRoomUser(
  ReqCtx ctx,
  int chatId,
  int userId, {
  ChatRoomUserRole role = ChatRoomUserRole.peer,
}) async {
  final user = await validateEditPermission(
    ctx,
    chatId: chatId,
    userId: null,
  );
  final chatUser = ChatRoomUser(
    chatId: chatId,
    userId: userId,
    role: role,
    createdAt: DateTime.now(),
  );
  final success = await userChatsRef.get(ctx).insert(
        chatUser,
        user.userClaims,
      );
  if (!success) {
    return null;
  }

  return chatUser;
}

@Mutation()
Future<bool> deleteChatRoomUser(
  ReqCtx ctx,
  int chatId,
  int userId,
) async {
  final user = await validateEditPermission(
    ctx,
    chatId: chatId,
    userId: userId,
  );

  return userChatsRef.get(ctx).delete(
        userId: userId,
        chatId: chatId,
        claims: user.userClaims,
      );
}
