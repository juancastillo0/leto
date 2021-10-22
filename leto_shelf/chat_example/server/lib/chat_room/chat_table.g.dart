// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatRoom, Object, Object> createChatRoomGraphQLField =
    field(
  'createChatRoom',
  chatRoomGraphQlType as GraphQLType<ChatRoom, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return createChatRoom(ctx, (args["name"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "name",
      graphQLString.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<bool, Object, Object> deleteChatRoomGraphQLField =
    field(
  'deleteChatRoom',
  graphQLBoolean.nonNull() as GraphQLType<bool, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return deleteChatRoom(ctx, (args["id"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "id",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatRoom?>, Object, Object>
    getChatRoomsGraphQLField = field(
  'getChatRooms',
  listOf(chatRoomGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<ChatRoom?>, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getChatRooms(ctx);
  },
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatCreatedEventSerializer = SerializerValue<ChatCreatedEvent>(
  fromJson: _$$ChatCreatedEventFromJson,
  toJson: (m) => _$$ChatCreatedEventToJson(m as _$ChatCreatedEvent),
);
GraphQLObjectType<ChatCreatedEvent>? _chatCreatedEventGraphQlType;

/// Auto-generated from [ChatCreatedEvent].
GraphQLObjectType<ChatCreatedEvent> get chatCreatedEventGraphQlType {
  final __name = 'ChatCreatedEvent';
  if (_chatCreatedEventGraphQlType != null)
    return _chatCreatedEventGraphQlType! as GraphQLObjectType<ChatCreatedEvent>;

  final __chatCreatedEventGraphQlType = objectType<ChatCreatedEvent>(
      'ChatCreatedEvent',
      isInterface: false,
      interfaces: [],
      description: null);
  _chatCreatedEventGraphQlType = __chatCreatedEventGraphQlType;
  __chatCreatedEventGraphQlType.fields.addAll(
    [
      field('chat', chatRoomGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.chat,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('ownerId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.ownerId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      chatEventGraphQlTypeDiscriminant()
    ],
  );

  return __chatCreatedEventGraphQlType;
}

final chatDeletedEventSerializer = SerializerValue<ChatDeletedEvent>(
  fromJson: _$$ChatDeletedEventFromJson,
  toJson: (m) => _$$ChatDeletedEventToJson(m as _$ChatDeletedEvent),
);
GraphQLObjectType<ChatDeletedEvent>? _chatDeletedEventGraphQlType;

/// Auto-generated from [ChatDeletedEvent].
GraphQLObjectType<ChatDeletedEvent> get chatDeletedEventGraphQlType {
  final __name = 'ChatDeletedEvent';
  if (_chatDeletedEventGraphQlType != null)
    return _chatDeletedEventGraphQlType! as GraphQLObjectType<ChatDeletedEvent>;

  final __chatDeletedEventGraphQlType = objectType<ChatDeletedEvent>(
      'ChatDeletedEvent',
      isInterface: false,
      interfaces: [],
      description: null);
  _chatDeletedEventGraphQlType = __chatDeletedEventGraphQlType;
  __chatDeletedEventGraphQlType.fields.addAll(
    [
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      chatEventGraphQlTypeDiscriminant()
    ],
  );

  return __chatDeletedEventGraphQlType;
}

final chatEventSerializer = SerializerValue<ChatEvent>(
  fromJson: _$ChatEventFromJson,
  toJson: (m) => _$ChatEventToJson(m as ChatEvent),
);

Map<String, Object?> _$ChatEventToJson(ChatEvent instance) => instance.toJson();

GraphQLObjectField<String, String, P>
    chatEventGraphQlTypeDiscriminant<P extends ChatEvent>() => field(
          'runtimeType',
          enumTypeFromStrings('ChatEventType', ["created", "deleted"]),
        );

GraphQLUnionType<ChatEvent>? _chatEventGraphQlType;
GraphQLUnionType<ChatEvent> get chatEventGraphQlType {
  return _chatEventGraphQlType ??= GraphQLUnionType(
    'ChatEvent',
    [chatCreatedEventGraphQlType, chatDeletedEventGraphQlType],
  );
}

final chatRoomSerializer = SerializerValue<ChatRoom>(
  fromJson: _$$_ChatRoomFromJson,
  toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);
GraphQLObjectType<ChatRoom>? _chatRoomGraphQlType;

/// Auto-generated from [ChatRoom].
GraphQLObjectType<ChatRoom> get chatRoomGraphQlType {
  final __name = 'ChatRoom';
  if (_chatRoomGraphQlType != null)
    return _chatRoomGraphQlType! as GraphQLObjectType<ChatRoom>;

  final __chatRoomGraphQlType = objectType<ChatRoom>('ChatRoom',
      isInterface: false, interfaces: [], description: null);
  _chatRoomGraphQlType = __chatRoomGraphQlType;
  __chatRoomGraphQlType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('messages', listOf(chatMessageGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.messages(ctx);
      }, inputs: [], description: null, deprecationReason: null),
      field('users', listOf(chatRoomUserGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.users(ctx);
      }, inputs: [], description: null, deprecationReason: null)
    ],
  );

  return __chatRoomGraphQlType;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatCreatedEvent _$$ChatCreatedEventFromJson(Map<String, dynamic> json) =>
    _$ChatCreatedEvent(
      chat: ChatRoom.fromJson(json['chat'] as Map<String, dynamic>),
      ownerId: json['ownerId'] as int,
    );

Map<String, dynamic> _$$ChatCreatedEventToJson(_$ChatCreatedEvent instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'ownerId': instance.ownerId,
    };

_$ChatDeletedEvent _$$ChatDeletedEventFromJson(Map<String, dynamic> json) =>
    _$ChatDeletedEvent(
      chatId: json['chatId'] as int,
    );

Map<String, dynamic> _$$ChatDeletedEventToJson(_$ChatDeletedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
    };

_$_ChatRoom _$$_ChatRoomFromJson(Map<String, dynamic> json) => _$_ChatRoom(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      messagesCache: (json['messagesCache'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      usersCache: (json['usersCache'] as List<dynamic>?)
          ?.map((e) => ChatRoomUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChatRoomToJson(_$_ChatRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'messagesCache': instance.messagesCache,
      'usersCache': instance.usersCache,
    };
