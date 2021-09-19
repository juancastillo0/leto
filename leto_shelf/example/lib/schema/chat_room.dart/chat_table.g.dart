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

    return sendMessage(ctx, args["chatId"] as int, args["message"] as String);
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "message",
      graphQLString.nonNull().coerceToInputObject(),
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

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatRoomSerializer = SerializerValue<ChatRoom>(
  fromJson: _$$_ChatRoomFromJson,
  toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);

/// Auto-generated from [ChatRoom].
final GraphQLObjectType<ChatRoom> chatRoomGraphQlType = objectType('ChatRoom',
    fields: [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          description: null,
          deprecationReason: null),
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          description: null,
          deprecationReason: null)
    ],
    isInterface: false,
    interfaces: [],
    description: null);

final chatMessageSerializer = SerializerValue<ChatMessage>(
  fromJson: _$$_ChatMessageFromJson,
  toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);

/// Auto-generated from [ChatMessage].
final GraphQLObjectType<ChatMessage> chatMessageGraphQlType =
    objectType('ChatMessage',
        fields: [
          field('id', graphQLInt.nonNull(),
              resolve: (obj, ctx) => obj.id,
              description: null,
              deprecationReason: null),
          field('chatId', graphQLInt.nonNull(),
              resolve: (obj, ctx) => obj.chatId,
              description: null,
              deprecationReason: null),
          field('message', graphQLString.nonNull(),
              resolve: (obj, ctx) => obj.message,
              description: null,
              deprecationReason: null),
          field('createdAt', graphQLDate.nonNull(),
              resolve: (obj, ctx) => obj.createdAt,
              description: null,
              deprecationReason: null)
        ],
        isInterface: false,
        interfaces: [],
        description: null);

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
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
    };
