// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final createChatRoomGraphQLField = chatRoomGraphQLType.field<Object?>(
  'createChatRoom',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return createChatRoom(ctx, (args["name"] as String));
  },
  inputs: [graphQLString.nonNull().coerceToInputObject().inputField('name')],
);

final deleteChatRoomGraphQLField = graphQLBoolean.nonNull().field<Object?>(
  'deleteChatRoom',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return deleteChatRoom(ctx, (args["id"] as int));
  },
  inputs: [graphQLInt.nonNull().coerceToInputObject().inputField('id')],
);

final getChatRoomsGraphQLField =
    chatRoomGraphQLType.nonNull().list().nonNull().field<Object?>(
  'getChatRooms',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getChatRooms(ctx);
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatCreatedEventSerializer = SerializerValue<ChatCreatedEvent>(
  key: "ChatCreatedEvent",
  fromJson: (ctx, json) =>
      ChatCreatedEvent.fromJson(json), // _$$ChatCreatedEventFromJson,
  // toJson: (m) => _$$ChatCreatedEventToJson(m as _$ChatCreatedEvent),
);

GraphQLObjectType<ChatCreatedEvent>? _chatCreatedEventGraphQLType;

/// Auto-generated from [ChatCreatedEvent].
GraphQLObjectType<ChatCreatedEvent> get chatCreatedEventGraphQLType {
  final __name = 'ChatCreatedEvent';
  if (_chatCreatedEventGraphQLType != null)
    return _chatCreatedEventGraphQLType! as GraphQLObjectType<ChatCreatedEvent>;

  final __chatCreatedEventGraphQLType =
      objectType<ChatCreatedEvent>(__name, isInterface: false, interfaces: []);

  _chatCreatedEventGraphQLType = __chatCreatedEventGraphQLType;
  __chatCreatedEventGraphQLType.fields.addAll(
    [
      chatRoomGraphQLType
          .nonNull()
          .field('chat', resolve: (obj, ctx) => obj.chat),
      graphQLInt.nonNull().field('ownerId', resolve: (obj, ctx) => obj.ownerId),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId)
    ],
  );

  return __chatCreatedEventGraphQLType;
}

final chatDeletedEventSerializer = SerializerValue<ChatDeletedEvent>(
  key: "ChatDeletedEvent",
  fromJson: (ctx, json) =>
      ChatDeletedEvent.fromJson(json), // _$$ChatDeletedEventFromJson,
  // toJson: (m) => _$$ChatDeletedEventToJson(m as _$ChatDeletedEvent),
);

GraphQLObjectType<ChatDeletedEvent>? _chatDeletedEventGraphQLType;

/// Auto-generated from [ChatDeletedEvent].
GraphQLObjectType<ChatDeletedEvent> get chatDeletedEventGraphQLType {
  final __name = 'ChatDeletedEvent';
  if (_chatDeletedEventGraphQLType != null)
    return _chatDeletedEventGraphQLType! as GraphQLObjectType<ChatDeletedEvent>;

  final __chatDeletedEventGraphQLType =
      objectType<ChatDeletedEvent>(__name, isInterface: false, interfaces: []);

  _chatDeletedEventGraphQLType = __chatDeletedEventGraphQLType;
  __chatDeletedEventGraphQLType.fields.addAll(
    [graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId)],
  );

  return __chatDeletedEventGraphQLType;
}

final chatEventSerializer = SerializerValue<ChatEvent>(
  key: "ChatEvent",
  fromJson: (ctx, json) => ChatEvent.fromJson(json), // _$ChatEventFromJson,
  // toJson: (m) => _$ChatEventToJson(m as ChatEvent),
);

GraphQLUnionType<ChatEvent>? _chatEventGraphQLType;
GraphQLUnionType<ChatEvent> get chatEventGraphQLType {
  return _chatEventGraphQLType ??= GraphQLUnionType(
    'ChatEvent',
    [chatCreatedEventGraphQLType, chatDeletedEventGraphQLType],
  );
}

final chatRoomSerializer = SerializerValue<ChatRoom>(
  key: "ChatRoom",
  fromJson: (ctx, json) => ChatRoom.fromJson(json), // _$$_ChatRoomFromJson,
  // toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);

GraphQLObjectType<ChatRoom>? _chatRoomGraphQLType;

/// Auto-generated from [ChatRoom].
GraphQLObjectType<ChatRoom> get chatRoomGraphQLType {
  final __name = 'ChatRoom';
  if (_chatRoomGraphQLType != null)
    return _chatRoomGraphQLType! as GraphQLObjectType<ChatRoom>;

  final __chatRoomGraphQLType =
      objectType<ChatRoom>(__name, isInterface: false, interfaces: []);

  _chatRoomGraphQLType = __chatRoomGraphQLType;
  __chatRoomGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt),
      chatMessageGraphQLType.nonNull().list().nonNull().field('messages',
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.messages(ctx);
      }),
      chatRoomUserGraphQLType.nonNull().list().nonNull().field('users',
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.users(ctx);
      })
    ],
  );

  return __chatRoomGraphQLType;
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
