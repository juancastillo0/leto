// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatMessage, Object, Object> sendMessageGraphQLField =
    field(
  'sendMessage',
  chatMessageGraphQlType as GraphQLType<ChatMessage, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendMessage(ctx, (args["chatId"] as int),
        (args["message"] as String), (args["referencedMessageId"] as int?));
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
  listOf(chatMessageGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<ChatMessage?>, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getMessage(ctx, (args["chatId"] as int?));
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
  listOf(chatMessageGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<ChatMessage?>, Object>,
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageSent(ctx, (args["chatId"] as int));
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

final GraphQLObjectField<DBEvent, Object, Object> onMessageEventGraphQLField =
    field(
  'onMessageEvent',
  dBEventGraphQlType.nonNull() as GraphQLType<DBEvent, Object>,
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageEvent(ctx, (args["type"] as EventType));
  },
  inputs: [
    GraphQLFieldInput(
      "type",
      eventTypeGraphQlType.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final dBEventSerializer = SerializerValue<DBEvent>(
  fromJson: _$DBEventFromJson,
  toJson: (m) => _$DBEventToJson(m as DBEvent),
);
GraphQLObjectType<DBEvent>? _dBEventGraphQlType;

/// Auto-generated from [DBEvent].
GraphQLObjectType<DBEvent> get dBEventGraphQlType {
  final __name = 'DBEvent';
  if (_dBEventGraphQlType != null)
    return _dBEventGraphQlType! as GraphQLObjectType<DBEvent>;

  final __dBEventGraphQlType = objectType<DBEvent>('DBEvent',
      isInterface: false, interfaces: [], description: null);
  _dBEventGraphQlType = __dBEventGraphQlType;
  __dBEventGraphQlType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('type', eventTypeGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.type,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('data', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.data,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __dBEventGraphQlType;
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

final chatMessageSerializer = SerializerValue<ChatMessage>(
  fromJson: _$$_ChatMessageFromJson,
  toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);
GraphQLObjectType<ChatMessage>? _chatMessageGraphQlType;

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQlType {
  final __name = 'ChatMessage';
  if (_chatMessageGraphQlType != null)
    return _chatMessageGraphQlType! as GraphQLObjectType<ChatMessage>;

  final __chatMessageGraphQlType = objectType<ChatMessage>('ChatMessage',
      isInterface: false, interfaces: [], description: null);
  _chatMessageGraphQlType = __chatMessageGraphQlType;
  __chatMessageGraphQlType.fields.addAll(
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
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
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

  return __chatMessageGraphQlType;
}

/// Auto-generated from [EventType].
final GraphQLEnumType<EventType> eventTypeGraphQlType =
    enumType('EventType', const {'messageSent': EventType.messageSent});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBEvent _$DBEventFromJson(Map<String, dynamic> json) => DBEvent(
      id: json['id'] as int,
      type: _$enumDecode(_$EventTypeEnumMap, json['type']),
      data: json['data'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DBEventToJson(DBEvent instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$EventTypeEnumMap[instance.type],
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
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

const _$EventTypeEnumMap = {
  EventType.messageSent: 'messageSent',
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

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
      message: json['message'] as String,
      referencedMessageId: json['referencedMessageId'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'message': instance.message,
      'referencedMessageId': instance.referencedMessageId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
