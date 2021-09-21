// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatMessage, Object, Object> sendMessageGraphQLField =
    field(
  'sendMessage',
  chatMessageGraphQlType,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendMessage(ctx, args["chatId"] as int, args["message"] as String,
        args["referencedMessageId"] as int?);
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "message",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "referencedMessageId",
      graphQLInt.coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    getMessageGraphQLField = field(
  'getMessage',
  listOf(chatMessageGraphQlType.nonNull()).nonNull(),
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getMessage(ctx, args["chatId"] as int?);
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    onMessageSentGraphQLField = field(
  'onMessageSent',
  listOf(chatMessageGraphQlType.nonNull()).nonNull(),
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageSent(ctx, args["chatId"] as int);
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<ChatRoom, Object, Object> createChatRoomGraphQLField =
    field(
  'createChatRoom',
  chatRoomGraphQlType,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return createChatRoom(ctx, args["name"] as String);
  },
  inputs: [
    GraphQLFieldInput(
      "name",
      graphQLString.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatRoom?>, Object, Object>
    getChatRoomsGraphQLField = field(
  'getChatRooms',
  listOf(chatRoomGraphQlType.nonNull()).nonNull(),
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

final chatRoomSerializer = SerializerValue<ChatRoom>(
  fromJson: _$$_ChatRoomFromJson,
  toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);
GraphQLObjectType<ChatRoom>? _chatRoomGraphQlType;

/// Auto-generated from [ChatRoom].
GraphQLObjectType<ChatRoom> get chatRoomGraphQlType {
  if (_chatRoomGraphQlType != null) return _chatRoomGraphQlType!;

  _chatRoomGraphQlType = objectType('ChatRoom',
      isInterface: false, interfaces: [], description: null);
  _chatRoomGraphQlType!.fields.addAll(
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
      }, inputs: [], description: null, deprecationReason: null)
    ],
  );

  return _chatRoomGraphQlType!;
}

final chatMessageSerializer = SerializerValue<ChatMessage>(
  fromJson: _$$_ChatMessageFromJson,
  toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);
GraphQLObjectType<ChatMessage>? _chatMessageGraphQlType;

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQlType {
  if (_chatMessageGraphQlType != null) return _chatMessageGraphQlType!;

  _chatMessageGraphQlType = objectType('ChatMessage',
      isInterface: false, interfaces: [], description: null);
  _chatMessageGraphQlType!.fields.addAll(
    [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('message', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('referencedMessageId', graphQLInt,
          resolve: (obj, ctx) => obj.referencedMessageId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('referencedMessage', chatMessageGraphQlType, resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      }, inputs: [], description: null, deprecationReason: null)
    ],
  );

  return _chatMessageGraphQlType!;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
