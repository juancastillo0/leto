// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatMessage, Object, Object> sendMessageGraphQLField =
    field(
  'sendMessage',
  chatMessageGraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendMessage(ctx, (args["chatId"] as int),
        (args["message"] as String), (args["referencedMessageId"] as int?));
  },
  inputs: [
    graphQLInt.nonNull().coerceToInputObject().inputField(
          "chatId",
        ),
    graphQLString.nonNull().coerceToInputObject().inputField(
          "message",
        ),
    graphQLInt.coerceToInputObject().inputField(
          "referencedMessageId",
        )
  ],
);

final GraphQLObjectField<List<ChatMessage>, Object, Object>
    getMessageGraphQLField = field(
  'getMessage',
  chatMessageGraphQLType.nonNull().list().nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getMessage(ctx, (args["chatId"] as int?));
  },
  inputs: [
    graphQLInt.coerceToInputObject().inputField(
          "chatId",
        )
  ],
);

final GraphQLObjectField<List<ChatMessage>, Object, Object>
    onMessageSentGraphQLField = field(
  'onMessageSent',
  chatMessageGraphQLType.nonNull().list().nonNull(),
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageSent(ctx, (args["chatId"] as int));
  },
  inputs: [
    graphQLInt.nonNull().coerceToInputObject().inputField(
          "chatId",
        )
  ],
);

final GraphQLObjectField<ChatRoom, Object, Object> createChatRoomGraphQLField =
    field(
  'createChatRoom',
  chatRoomGraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return createChatRoom(ctx, (args["name"] as String));
  },
  inputs: [
    graphQLString.nonNull().coerceToInputObject().inputField(
          "name",
        )
  ],
);

final GraphQLObjectField<List<ChatRoom>, Object, Object>
    getChatRoomsGraphQLField = field(
  'getChatRooms',
  chatRoomGraphQLType.nonNull().list().nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getChatRooms(ctx);
  },
);

final GraphQLObjectField<DBEvent, Object, Object> onMessageEventGraphQLField =
    field(
  'onMessageEvent',
  dBEventGraphQLType.nonNull(),
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageEvent(ctx, (args["type"] as EventType));
  },
  inputs: [
    eventTypeGraphQLType.nonNull().coerceToInputObject().inputField(
          "type",
        )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final dBEventSerializer = SerializerValue<DBEvent>(
  key: "DBEvent",
  fromJson: (ctx, json) => DBEvent.fromJson(json), // _$DBEventFromJson,
  // toJson: (m) => _$DBEventToJson(m as DBEvent),
);

GraphQLObjectType<DBEvent>? _dBEventGraphQLType;

/// Auto-generated from [DBEvent].
GraphQLObjectType<DBEvent> get dBEventGraphQLType {
  final __name = 'DBEvent';
  if (_dBEventGraphQLType != null)
    return _dBEventGraphQLType! as GraphQLObjectType<DBEvent>;

  final __dBEventGraphQLType =
      objectType<DBEvent>('DBEvent', isInterface: false, interfaces: []);

  _dBEventGraphQLType = __dBEventGraphQLType;
  __dBEventGraphQLType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id),
      field('type', eventTypeGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.type),
      field('data', graphQLString.nonNull(), resolve: (obj, ctx) => obj.data),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __dBEventGraphQLType;
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
      objectType<ChatRoom>('ChatRoom', isInterface: false, interfaces: []);

  _chatRoomGraphQLType = __chatRoomGraphQLType;
  __chatRoomGraphQLType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id),
      field('name', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt),
      field('messages', chatMessageGraphQLType.nonNull().list().nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.messages(ctx);
      })
    ],
  );

  return __chatRoomGraphQLType;
}

final chatMessageSerializer = SerializerValue<ChatMessage>(
  key: "ChatMessage",
  fromJson: (ctx, json) =>
      ChatMessage.fromJson(json), // _$$_ChatMessageFromJson,
  // toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);

GraphQLObjectType<ChatMessage>? _chatMessageGraphQLType;

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQLType {
  final __name = 'ChatMessage';
  if (_chatMessageGraphQLType != null)
    return _chatMessageGraphQLType! as GraphQLObjectType<ChatMessage>;

  final __chatMessageGraphQLType = objectType<ChatMessage>('ChatMessage',
      isInterface: false, interfaces: []);

  _chatMessageGraphQLType = __chatMessageGraphQLType;
  __chatMessageGraphQLType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id),
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      field('message', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.message),
      field('referencedMessageId', graphQLInt,
          resolve: (obj, ctx) => obj.referencedMessageId),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt),
      field('referencedMessage', chatMessageGraphQLType, resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      })
    ],
  );

  return __chatMessageGraphQLType;
}

/// Auto-generated from [EventType].
final GraphQLEnumType<EventType> eventTypeGraphQLType =
    enumType('EventType', const {'messageSent': EventType.messageSent});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBEvent _$DBEventFromJson(Map<String, dynamic> json) => DBEvent(
      id: json['id'] as int,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      data: json['data'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DBEventToJson(DBEvent instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$EventTypeEnumMap[instance.type],
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.messageSent: 'messageSent',
};

_$_ChatRoom _$$_ChatRoomFromJson(Map<String, dynamic> json) => _$_ChatRoom(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatRoomToJson(_$_ChatRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      message: json['message'] as String,
      referencedMessageId: json['referencedMessageId'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'message': instance.message,
      'referencedMessageId': instance.referencedMessageId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
