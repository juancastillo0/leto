// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_table.dart';

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
);

final GraphQLObjectField<ChatMessage, Object, Object>
    sendFileMessageGraphQLField = field(
  'sendFileMessage',
  chatMessageGraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendFileMessage(
        ctx, (args["chatId"] as int), (args["file"] as UploadedFile),
        referencedMessageId: (args["referencedMessageId"] as int?),
        message: (args["message"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "file",
      uploadedFileGraphQLType.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "referencedMessageId",
      graphQLInt.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "message",
      graphQLString.nonNull().coerceToInputObject(),
      defaultValue: '',
    )
  ],
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    getMessageGraphQLField = field(
  'getMessage',
  listOf(chatMessageGraphQLType.nonNull()).nonNull(),
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
);

final GraphQLObjectField<LinksMetadata, Object, Object>
    getMessageLinksMetadataGraphQLField = field(
  'getMessageLinksMetadata',
  linksMetadataGraphQLType.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getMessageLinksMetadata((args["message"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "message",
      graphQLString.nonNull().coerceToInputObject(),
    )
  ],
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    onMessageSentGraphQLField = field(
  'onMessageSent',
  listOf(chatMessageGraphQLType.nonNull()).nonNull(),
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
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatMessageSerializer = SerializerValue<ChatMessage>(
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
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      field('message', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.message),
      field('type', messageTypeGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.type),
      field('fileUrl', graphQLString, resolve: (obj, ctx) => obj.fileUrl),
      field('referencedMessageId', graphQLInt,
          resolve: (obj, ctx) => obj.referencedMessageId),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt),
      field('referencedMessage', chatMessageGraphQLType, resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      }),
      field('metadata', messageMetadataGraphQLType, resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.metadata();
      })
    ],
  );

  return __chatMessageGraphQLType;
}

final chatMessageSentEventSerializer = SerializerValue<ChatMessageSentEvent>(
  fromJson: (ctx, json) =>
      ChatMessageSentEvent.fromJson(json), // _$$ChatMessageSentEventFromJson,
  // toJson: (m) => _$$ChatMessageSentEventToJson(m as _$ChatMessageSentEvent),
);

GraphQLObjectType<ChatMessageSentEvent>? _chatMessageSentEventGraphQLType;

/// Auto-generated from [ChatMessageSentEvent].
GraphQLObjectType<ChatMessageSentEvent> get chatMessageSentEventGraphQLType {
  final __name = 'ChatMessageSentEvent';
  if (_chatMessageSentEventGraphQLType != null)
    return _chatMessageSentEventGraphQLType!
        as GraphQLObjectType<ChatMessageSentEvent>;

  final __chatMessageSentEventGraphQLType = objectType<ChatMessageSentEvent>(
      'ChatMessageSentEvent',
      isInterface: false,
      interfaces: []);

  _chatMessageSentEventGraphQLType = __chatMessageSentEventGraphQLType;
  __chatMessageSentEventGraphQLType.fields.addAll(
    [
      field('message', chatMessageGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.message),
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      chatMessageEventGraphQLTypeDiscriminant()
    ],
  );

  return __chatMessageSentEventGraphQLType;
}

final chatMessageDeletedEventSerializer =
    SerializerValue<ChatMessageDeletedEvent>(
  fromJson: (ctx, json) => ChatMessageDeletedEvent.fromJson(
      json), // _$$ChatMessageDeletedEventFromJson,
  // toJson: (m) => _$$ChatMessageDeletedEventToJson(m as _$ChatMessageDeletedEvent),
);

GraphQLObjectType<ChatMessageDeletedEvent>? _chatMessageDeletedEventGraphQLType;

/// Auto-generated from [ChatMessageDeletedEvent].
GraphQLObjectType<ChatMessageDeletedEvent>
    get chatMessageDeletedEventGraphQLType {
  final __name = 'ChatMessageDeletedEvent';
  if (_chatMessageDeletedEventGraphQLType != null)
    return _chatMessageDeletedEventGraphQLType!
        as GraphQLObjectType<ChatMessageDeletedEvent>;

  final __chatMessageDeletedEventGraphQLType =
      objectType<ChatMessageDeletedEvent>('ChatMessageDeletedEvent',
          isInterface: false, interfaces: []);

  _chatMessageDeletedEventGraphQLType = __chatMessageDeletedEventGraphQLType;
  __chatMessageDeletedEventGraphQLType.fields.addAll(
    [
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      field('messageId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.messageId),
      chatMessageEventGraphQLTypeDiscriminant()
    ],
  );

  return __chatMessageDeletedEventGraphQLType;
}

final chatMessageUpdatedEventSerializer =
    SerializerValue<ChatMessageUpdatedEvent>(
  fromJson: (ctx, json) => ChatMessageUpdatedEvent.fromJson(
      json), // _$$ChatMessageUpdatedEventFromJson,
  // toJson: (m) => _$$ChatMessageUpdatedEventToJson(m as _$ChatMessageUpdatedEvent),
);

GraphQLObjectType<ChatMessageUpdatedEvent>? _chatMessageUpdatedEventGraphQLType;

/// Auto-generated from [ChatMessageUpdatedEvent].
GraphQLObjectType<ChatMessageUpdatedEvent>
    get chatMessageUpdatedEventGraphQLType {
  final __name = 'ChatMessageUpdatedEvent';
  if (_chatMessageUpdatedEventGraphQLType != null)
    return _chatMessageUpdatedEventGraphQLType!
        as GraphQLObjectType<ChatMessageUpdatedEvent>;

  final __chatMessageUpdatedEventGraphQLType =
      objectType<ChatMessageUpdatedEvent>('ChatMessageUpdatedEvent',
          isInterface: false, interfaces: []);

  _chatMessageUpdatedEventGraphQLType = __chatMessageUpdatedEventGraphQLType;
  __chatMessageUpdatedEventGraphQLType.fields.addAll(
    [
      field('message', chatMessageGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.message),
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      chatMessageEventGraphQLTypeDiscriminant()
    ],
  );

  return __chatMessageUpdatedEventGraphQLType;
}

final chatMessageEventSerializer = SerializerValue<ChatMessageEvent>(
  fromJson: (ctx, json) =>
      ChatMessageEvent.fromJson(json), // _$ChatMessageEventFromJson,
  // toJson: (m) => _$ChatMessageEventToJson(m as ChatMessageEvent),
);

// Map<String, Object?> _$ChatMessageEventToJson(ChatMessageEvent instance) => instance.toJson();

GraphQLObjectField<String, String, P>
    chatMessageEventGraphQLTypeDiscriminant<P extends ChatMessageEvent>() =>
        field(
          'runtimeType',
          enumTypeFromStrings(
              'ChatMessageEventType', ["sent", "deleted", "updated"]),
        );

GraphQLUnionType<ChatMessageEvent>? _chatMessageEventGraphQLType;
GraphQLUnionType<ChatMessageEvent> get chatMessageEventGraphQLType {
  return _chatMessageEventGraphQLType ??= GraphQLUnionType(
    'ChatMessageEvent',
    [
      chatMessageSentEventGraphQLType,
      chatMessageDeletedEventGraphQLType,
      chatMessageUpdatedEventGraphQLType
    ],
  );
}

/// Auto-generated from [MessageType].
final GraphQLEnumType<MessageType> messageTypeGraphQLType = enumType(
    'MessageType', const {'FILE': MessageType.FILE, 'TEXT': MessageType.TEXT});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
      message: json['message'] as String,
      type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
      fileUrl: json['fileUrl'] as String?,
      metadataJson: json['metadataJson'] as String?,
      referencedMessageId: json['referencedMessageId'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'message': instance.message,
      'type': _$MessageTypeEnumMap[instance.type],
      'fileUrl': instance.fileUrl,
      'metadataJson': instance.metadataJson,
      'referencedMessageId': instance.referencedMessageId,
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

const _$MessageTypeEnumMap = {
  MessageType.FILE: 'FILE',
  MessageType.TEXT: 'TEXT',
};

_$ChatMessageSentEvent _$$ChatMessageSentEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageSentEvent(
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageSentEventToJson(
        _$ChatMessageSentEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$ChatMessageDeletedEvent _$$ChatMessageDeletedEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageDeletedEvent(
      chatId: json['chatId'] as int,
      messageId: json['messageId'] as int,
    );

Map<String, dynamic> _$$ChatMessageDeletedEventToJson(
        _$ChatMessageDeletedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'messageId': instance.messageId,
    };

_$ChatMessageUpdatedEvent _$$ChatMessageUpdatedEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageUpdatedEvent(
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageUpdatedEventToJson(
        _$ChatMessageUpdatedEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
