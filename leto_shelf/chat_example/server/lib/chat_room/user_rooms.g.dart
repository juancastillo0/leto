// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rooms.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatRoomUser, Object, Object>
    addChatRoomUserGraphQLField = field(
  'addChatRoomUser',
  chatRoomUserGraphQlType as GraphQLType<ChatRoomUser, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return addChatRoomUser(
        ctx, (args["chatId"] as int), (args["userId"] as int),
        role: (args["role"] as ChatRoomUserRole));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "userId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "role",
      chatRoomUserRoleGraphQlType.nonNull().coerceToInputObject(),
      defaultValue: ChatRoomUserRole.peer,
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<bool, Object, Object> deleteChatRoomUserGraphQLField =
    field(
  'deleteChatRoomUser',
  graphQLBoolean.nonNull() as GraphQLType<bool, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return deleteChatRoomUser(
        ctx, (args["chatId"] as int), (args["userId"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "userId",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userChatAddedEventSerializer = SerializerValue<UserChatAddedEvent>(
  fromJson: _$$UserChatAddedEventFromJson,
  toJson: (m) => _$$UserChatAddedEventToJson(m as _$UserChatAddedEvent),
);
GraphQLObjectType<UserChatAddedEvent>? _userChatAddedEventGraphQlType;

/// Auto-generated from [UserChatAddedEvent].
GraphQLObjectType<UserChatAddedEvent> get userChatAddedEventGraphQlType {
  final __name = 'UserChatAddedEvent';
  if (_userChatAddedEventGraphQlType != null)
    return _userChatAddedEventGraphQlType!
        as GraphQLObjectType<UserChatAddedEvent>;

  final __userChatAddedEventGraphQlType = objectType<UserChatAddedEvent>(
      'UserChatAddedEvent',
      isInterface: false,
      interfaces: [],
      description: null);
  _userChatAddedEventGraphQlType = __userChatAddedEventGraphQlType;
  __userChatAddedEventGraphQlType.fields.addAll(
    [
      field('chatUser', chatRoomUserGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.chatUser,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      userChatEventGraphQlTypeDiscriminant()
    ],
  );

  return __userChatAddedEventGraphQlType;
}

final userChatRemovedEventSerializer = SerializerValue<UserChatRemovedEvent>(
  fromJson: _$$UserChatRemovedEventFromJson,
  toJson: (m) => _$$UserChatRemovedEventToJson(m as _$UserChatRemovedEvent),
);
GraphQLObjectType<UserChatRemovedEvent>? _userChatRemovedEventGraphQlType;

/// Auto-generated from [UserChatRemovedEvent].
GraphQLObjectType<UserChatRemovedEvent> get userChatRemovedEventGraphQlType {
  final __name = 'UserChatRemovedEvent';
  if (_userChatRemovedEventGraphQlType != null)
    return _userChatRemovedEventGraphQlType!
        as GraphQLObjectType<UserChatRemovedEvent>;

  final __userChatRemovedEventGraphQlType = objectType<UserChatRemovedEvent>(
      'UserChatRemovedEvent',
      isInterface: false,
      interfaces: [],
      description: null);
  _userChatRemovedEventGraphQlType = __userChatRemovedEventGraphQlType;
  __userChatRemovedEventGraphQlType.fields.addAll(
    [
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      userChatEventGraphQlTypeDiscriminant()
    ],
  );

  return __userChatRemovedEventGraphQlType;
}

final userChatEventSerializer = SerializerValue<UserChatEvent>(
  fromJson: _$UserChatEventFromJson,
  toJson: (m) => _$UserChatEventToJson(m as UserChatEvent),
);

Map<String, Object?> _$UserChatEventToJson(UserChatEvent instance) =>
    instance.toJson();

GraphQLObjectField<String, String, P>
    userChatEventGraphQlTypeDiscriminant<P extends UserChatEvent>() => field(
          'runtimeType',
          enumTypeFromStrings('UserChatEventType', ["added", "removed"]),
        );

GraphQLUnionType<UserChatEvent>? _userChatEventGraphQlType;
GraphQLUnionType<UserChatEvent> get userChatEventGraphQlType {
  return _userChatEventGraphQlType ??= GraphQLUnionType(
    'UserChatEvent',
    [userChatAddedEventGraphQlType, userChatRemovedEventGraphQlType],
  );
}

final chatRoomUserSerializer = SerializerValue<ChatRoomUser>(
  fromJson: _$ChatRoomUserFromJson,
  toJson: (m) => _$ChatRoomUserToJson(m as ChatRoomUser),
);
GraphQLObjectType<ChatRoomUser>? _chatRoomUserGraphQlType;

/// Auto-generated from [ChatRoomUser].
GraphQLObjectType<ChatRoomUser> get chatRoomUserGraphQlType {
  final __name = 'ChatRoomUser';
  if (_chatRoomUserGraphQlType != null)
    return _chatRoomUserGraphQlType! as GraphQLObjectType<ChatRoomUser>;

  final __chatRoomUserGraphQlType = objectType<ChatRoomUser>('ChatRoomUser',
      isInterface: false, interfaces: [], description: null);
  _chatRoomUserGraphQlType = __chatRoomUserGraphQlType;
  __chatRoomUserGraphQlType.fields.addAll(
    [
      field('user', userGraphQlType.nonNull(), resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.user(ctx);
      }, inputs: [], description: null, deprecationReason: null),
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('role', chatRoomUserRoleGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.role,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __chatRoomUserGraphQlType;
}

/// Auto-generated from [ChatRoomUserRole].
final GraphQLEnumType<ChatRoomUserRole> chatRoomUserRoleGraphQlType = enumType(
    'ChatRoomUserRole',
    const {'admin': ChatRoomUserRole.admin, 'peer': ChatRoomUserRole.peer});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomUser _$ChatRoomUserFromJson(Map<String, dynamic> json) => ChatRoomUser(
      userId: json['userId'] as int,
      chatId: json['chatId'] as int,
      role: _$enumDecode(_$ChatRoomUserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$ChatRoomUserToJson(ChatRoomUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'chatId': instance.chatId,
      'role': _$ChatRoomUserRoleEnumMap[instance.role],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ChatRoomUserRoleEnumMap = {
  ChatRoomUserRole.admin: 'admin',
  ChatRoomUserRole.peer: 'peer',
};

_$UserChatAddedEvent _$$UserChatAddedEventFromJson(Map<String, dynamic> json) =>
    _$UserChatAddedEvent(
      chatUser: ChatRoomUser.fromJson(json['chatUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChatAddedEventToJson(
        _$UserChatAddedEvent instance) =>
    <String, dynamic>{
      'chatUser': instance.chatUser,
    };

_$UserChatRemovedEvent _$$UserChatRemovedEventFromJson(
        Map<String, dynamic> json) =>
    _$UserChatRemovedEvent(
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$$UserChatRemovedEventToJson(
        _$UserChatRemovedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
    };
