import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/events/events_api.dart';
import 'package:server/users/auth.dart';
import 'package:server/users/user_api.dart';
import 'package:server/users/user_table.dart';

part 'user_rooms_api.g.dart';
part 'user_rooms_api.freezed.dart';

@GraphQLObject()
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

@GraphQLEnum()
enum ChatRoomUserRole {
  admin,
  peer,
}

@GraphQLObject()
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

  FutureOr<User> user(Ctx ctx) async {
    final _user = await userDataLoaderRef.get(ctx).load(userId);
    return _user!;
  }

  factory ChatRoomUser.fromJson(Map<String, Object?> json) =>
      _$ChatRoomUserFromJson(json);

  Map<String, Object?> toJson() => _$ChatRoomUserToJson(this);
}

Future<_ValidatedUserChat> validateEditPermission(
  Ctx ctx, {
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
  Ctx ctx,
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
  Ctx ctx,
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
