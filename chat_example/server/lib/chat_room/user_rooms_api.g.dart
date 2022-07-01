// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rooms_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ChatRoomUser?, Object?, Object?>
    get addChatRoomUserGraphQLField => _addChatRoomUserGraphQLField.value;
final _addChatRoomUserGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ChatRoomUser?, Object?, Object?>>(
    (setValue) => setValue(chatRoomUserGraphQLType.field<Object?>(
          'addChatRoomUser',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return addChatRoomUser(
                ctx, (args["chatId"] as int), (args["userId"] as int),
                role: (args["role"] as ChatRoomUserRole));
          },
        ))
          ..inputs.addAll([
            graphQLInt.nonNull().inputField('chatId'),
            graphQLInt.nonNull().inputField('userId'),
            chatRoomUserRoleGraphQLType
                .nonNull()
                .inputField('role', defaultValue: ChatRoomUserRole.peer)
          ]));

GraphQLObjectField<bool, Object?, Object?> get deleteChatRoomUserGraphQLField =>
    _deleteChatRoomUserGraphQLField.value;
final _deleteChatRoomUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<bool, Object?, Object?>>(
        (setValue) => setValue(graphQLBoolean.nonNull().field<Object?>(
              'deleteChatRoomUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return deleteChatRoomUser(
                    ctx, (args["chatId"] as int), (args["userId"] as int));
              },
            ))
              ..inputs.addAll([
                graphQLInt.nonNull().inputField('chatId'),
                graphQLInt.nonNull().inputField('userId')
              ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userChatAddedEventSerializer = SerializerValue<UserChatAddedEvent>(
  key: "UserChatAddedEvent",
  fromJson: (ctx, json) =>
      UserChatAddedEvent.fromJson(json), // _$$UserChatAddedEventFromJson,
  // toJson: (m) => _$$UserChatAddedEventToJson(m as _$UserChatAddedEvent),
);
final _userChatAddedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserChatAddedEvent>>((setValue) {
  final __name = 'UserChatAddedEvent';

  final __userChatAddedEventGraphQLType = objectType<UserChatAddedEvent>(__name,
      isInterface: false, interfaces: []);

  setValue(__userChatAddedEventGraphQLType);
  __userChatAddedEventGraphQLType.fields.addAll(
    [
      chatRoomUserGraphQLType
          .nonNull()
          .field('chatUser', resolve: (obj, ctx) => obj.chatUser),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId)
    ],
  );

  return __userChatAddedEventGraphQLType;
});

/// Auto-generated from [UserChatAddedEvent].
GraphQLObjectType<UserChatAddedEvent> get userChatAddedEventGraphQLType =>
    _userChatAddedEventGraphQLType.value;

final userChatRemovedEventSerializer = SerializerValue<UserChatRemovedEvent>(
  key: "UserChatRemovedEvent",
  fromJson: (ctx, json) =>
      UserChatRemovedEvent.fromJson(json), // _$$UserChatRemovedEventFromJson,
  // toJson: (m) => _$$UserChatRemovedEventToJson(m as _$UserChatRemovedEvent),
);
final _userChatRemovedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserChatRemovedEvent>>(
        (setValue) {
  final __name = 'UserChatRemovedEvent';

  final __userChatRemovedEventGraphQLType = objectType<UserChatRemovedEvent>(
      __name,
      isInterface: false,
      interfaces: []);

  setValue(__userChatRemovedEventGraphQLType);
  __userChatRemovedEventGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userChatRemovedEventGraphQLType;
});

/// Auto-generated from [UserChatRemovedEvent].
GraphQLObjectType<UserChatRemovedEvent> get userChatRemovedEventGraphQLType =>
    _userChatRemovedEventGraphQLType.value;

final userChatEventSerializer = SerializerValue<UserChatEvent>(
  key: "UserChatEvent",
  fromJson: (ctx, json) =>
      UserChatEvent.fromJson(json), // _$UserChatEventFromJson,
  // toJson: (m) => _$UserChatEventToJson(m as UserChatEvent),
);

/// Generated from [UserChatEvent]
GraphQLUnionType<UserChatEvent> get userChatEventGraphQLType =>
    _userChatEventGraphQLType.value;

final _userChatEventGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<UserChatEvent>>((setValue) {
  final type = GraphQLUnionType<UserChatEvent>(
    'UserChatEvent',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    userChatAddedEventGraphQLType,
    userChatRemovedEventGraphQLType,
  ]);
  return type;
});

final chatRoomUserSerializer = SerializerValue<ChatRoomUser>(
  key: "ChatRoomUser",
  fromJson: (ctx, json) =>
      ChatRoomUser.fromJson(json), // _$ChatRoomUserFromJson,
  // toJson: (m) => _$ChatRoomUserToJson(m as ChatRoomUser),
);
final _chatRoomUserGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatRoomUser>>((setValue) {
  final __name = 'ChatRoomUser';

  final __chatRoomUserGraphQLType =
      objectType<ChatRoomUser>(__name, isInterface: false, interfaces: []);

  setValue(__chatRoomUserGraphQLType);
  __chatRoomUserGraphQLType.fields.addAll(
    [
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.user(ctx);
      }),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId),
      chatRoomUserRoleGraphQLType
          .nonNull()
          .field('role', resolve: (obj, ctx) => obj.role),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __chatRoomUserGraphQLType;
});

/// Auto-generated from [ChatRoomUser].
GraphQLObjectType<ChatRoomUser> get chatRoomUserGraphQLType =>
    _chatRoomUserGraphQLType.value;

/// Auto-generated from [ChatRoomUserRole].
final GraphQLEnumType<ChatRoomUserRole> chatRoomUserRoleGraphQLType =
    GraphQLEnumType('ChatRoomUserRole', [
  GraphQLEnumValue('admin', ChatRoomUserRole.admin),
  GraphQLEnumValue('peer', ChatRoomUserRole.peer)
]);

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomUser _$ChatRoomUserFromJson(Map<String, dynamic> json) => ChatRoomUser(
      userId: json['userId'] as int,
      chatId: json['chatId'] as int,
      role: $enumDecode(_$ChatRoomUserRoleEnumMap, json['role']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ChatRoomUserToJson(ChatRoomUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'chatId': instance.chatId,
      'role': _$ChatRoomUserRoleEnumMap[instance.role],
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ChatRoomUserRoleEnumMap = {
  ChatRoomUserRole.admin: 'admin',
  ChatRoomUserRole.peer: 'peer',
};

_$UserChatAddedEvent _$$UserChatAddedEventFromJson(Map<String, dynamic> json) =>
    _$UserChatAddedEvent(
      chatUser: ChatRoomUser.fromJson(json['chatUser'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserChatAddedEventToJson(
        _$UserChatAddedEvent instance) =>
    <String, dynamic>{
      'chatUser': instance.chatUser,
      'runtimeType': instance.$type,
    };

_$UserChatRemovedEvent _$$UserChatRemovedEventFromJson(
        Map<String, dynamic> json) =>
    _$UserChatRemovedEvent(
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserChatRemovedEventToJson(
        _$UserChatRemovedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
      'runtimeType': instance.$type,
    };
