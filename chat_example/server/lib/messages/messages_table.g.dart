// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ChatMessage?, Object?, Object?>
    get sendMessageGraphQLField => _sendMessageGraphQLField.value;
final _sendMessageGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ChatMessage?, Object?, Object?>>(
    (setValue) => setValue(chatMessageGraphQLType.field<Object?>(
          'sendMessage',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return sendMessage(
                ctx,
                (args["chatId"] as int),
                (args["message"] as String),
                (args["referencedMessageId"] as int?));
          },
        ))
          ..inputs.addAll([
            graphQLInt.nonNull().coerceToInputObject().inputField('chatId'),
            graphQLString.nonNull().coerceToInputObject().inputField('message'),
            graphQLInt.coerceToInputObject().inputField('referencedMessageId')
          ]));

GraphQLObjectField<ChatMessage?, Object?, Object?>
    get sendFileMessageGraphQLField => _sendFileMessageGraphQLField.value;
final _sendFileMessageGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ChatMessage?, Object?, Object?>>(
        (setValue) => setValue(chatMessageGraphQLType.field<Object?>(
              'sendFileMessage',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return sendFileMessage(
                    ctx, (args["chatId"] as int), (args["file"] as Upload),
                    referencedMessageId: (args["referencedMessageId"] as int?),
                    message: (args["message"] as String));
              },
            ))
              ..inputs.addAll([
                graphQLInt.nonNull().coerceToInputObject().inputField('chatId'),
                Upload.graphQLType()
                    .nonNull()
                    .coerceToInputObject()
                    .inputField('file'),
                graphQLInt
                    .coerceToInputObject()
                    .inputField('referencedMessageId'),
                graphQLString
                    .nonNull()
                    .coerceToInputObject()
                    .inputField('message', defaultValue: '')
              ]));

GraphQLObjectField<List<ChatMessage>, Object?, Object?>
    get getMessageGraphQLField => _getMessageGraphQLField.value;
final _getMessageGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<List<ChatMessage>, Object?,
        Object?>>((setValue) =>
    setValue(chatMessageGraphQLType.nonNull().list().nonNull().field<Object?>(
      'getMessage',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return getMessage(ctx, (args["chatId"] as int?));
      },
    ))
      ..inputs.addAll([graphQLInt.coerceToInputObject().inputField('chatId')]));

GraphQLObjectField<LinksMetadata, Object?, Object?>
    get getMessageLinksMetadataGraphQLField =>
        _getMessageLinksMetadataGraphQLField.value;
final _getMessageLinksMetadataGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<LinksMetadata, Object?, Object?>>(
    (setValue) => setValue(linksMetadataGraphQLType.nonNull().field<Object?>(
          'getMessageLinksMetadata',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getMessageLinksMetadata((args["message"] as String));
          },
        ))
          ..inputs.addAll([
            graphQLString.nonNull().coerceToInputObject().inputField('message')
          ]));

GraphQLObjectField<List<ChatMessage>, Object?, Object?>
    get onMessageSentGraphQLField => _onMessageSentGraphQLField.value;
final _onMessageSentGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<List<ChatMessage>, Object?,
        Object?>>((setValue) =>
    setValue(chatMessageGraphQLType.nonNull().list().nonNull().field<Object?>(
      'onMessageSent',
      subscribe: (obj, ctx) {
        final args = ctx.args;

        return onMessageSent(ctx, (args["chatId"] as int));
      },
    ))
      ..inputs.addAll(
          [graphQLInt.nonNull().coerceToInputObject().inputField('chatId')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatMessageSerializer = SerializerValue<ChatMessage>(
  key: "ChatMessage",
  fromJson: (ctx, json) =>
      ChatMessage.fromJson(json), // _$$_ChatMessageFromJson,
  // toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);
final _chatMessageGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatMessage>>((setValue) {
  final __name = 'ChatMessage';

  final __chatMessageGraphQLType =
      objectType<ChatMessage>(__name, isInterface: false, interfaces: []);

  setValue(__chatMessageGraphQLType);
  __chatMessageGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId),
      graphQLString
          .nonNull()
          .field('message', resolve: (obj, ctx) => obj.message),
      messageTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type),
      graphQLString.field('fileUrl', resolve: (obj, ctx) => obj.fileUrl),
      graphQLInt.field('referencedMessageId',
          resolve: (obj, ctx) => obj.referencedMessageId),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt),
      chatMessageGraphQLType.field('referencedMessage', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      }),
      messageMetadataGraphQLType.field('metadata', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.metadata();
      })
    ],
  );

  return __chatMessageGraphQLType;
});

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQLType =>
    _chatMessageGraphQLType.value;

final chatMessageSentEventSerializer = SerializerValue<ChatMessageSentEvent>(
  key: "ChatMessageSentEvent",
  fromJson: (ctx, json) =>
      ChatMessageSentEvent.fromJson(json), // _$$ChatMessageSentEventFromJson,
  // toJson: (m) => _$$ChatMessageSentEventToJson(m as _$ChatMessageSentEvent),
);
final _chatMessageSentEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatMessageSentEvent>>(
        (setValue) {
  final __name = 'ChatMessageSentEvent';

  final __chatMessageSentEventGraphQLType = objectType<ChatMessageSentEvent>(
      __name,
      isInterface: false,
      interfaces: []);

  setValue(__chatMessageSentEventGraphQLType);
  __chatMessageSentEventGraphQLType.fields.addAll(
    [
      chatMessageGraphQLType
          .nonNull()
          .field('message', resolve: (obj, ctx) => obj.message),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId)
    ],
  );

  return __chatMessageSentEventGraphQLType;
});

/// Auto-generated from [ChatMessageSentEvent].
GraphQLObjectType<ChatMessageSentEvent> get chatMessageSentEventGraphQLType =>
    _chatMessageSentEventGraphQLType.value;

final chatMessageDeletedEventSerializer =
    SerializerValue<ChatMessageDeletedEvent>(
  key: "ChatMessageDeletedEvent",
  fromJson: (ctx, json) => ChatMessageDeletedEvent.fromJson(
      json), // _$$ChatMessageDeletedEventFromJson,
  // toJson: (m) => _$$ChatMessageDeletedEventToJson(m as _$ChatMessageDeletedEvent),
);
final _chatMessageDeletedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatMessageDeletedEvent>>(
        (setValue) {
  final __name = 'ChatMessageDeletedEvent';

  final __chatMessageDeletedEventGraphQLType =
      objectType<ChatMessageDeletedEvent>(__name,
          isInterface: false, interfaces: []);

  setValue(__chatMessageDeletedEventGraphQLType);
  __chatMessageDeletedEventGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId),
      graphQLInt
          .nonNull()
          .field('messageId', resolve: (obj, ctx) => obj.messageId)
    ],
  );

  return __chatMessageDeletedEventGraphQLType;
});

/// Auto-generated from [ChatMessageDeletedEvent].
GraphQLObjectType<ChatMessageDeletedEvent>
    get chatMessageDeletedEventGraphQLType =>
        _chatMessageDeletedEventGraphQLType.value;

final chatMessageUpdatedEventSerializer =
    SerializerValue<ChatMessageUpdatedEvent>(
  key: "ChatMessageUpdatedEvent",
  fromJson: (ctx, json) => ChatMessageUpdatedEvent.fromJson(
      json), // _$$ChatMessageUpdatedEventFromJson,
  // toJson: (m) => _$$ChatMessageUpdatedEventToJson(m as _$ChatMessageUpdatedEvent),
);
final _chatMessageUpdatedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatMessageUpdatedEvent>>(
        (setValue) {
  final __name = 'ChatMessageUpdatedEvent';

  final __chatMessageUpdatedEventGraphQLType =
      objectType<ChatMessageUpdatedEvent>(__name,
          isInterface: false, interfaces: []);

  setValue(__chatMessageUpdatedEventGraphQLType);
  __chatMessageUpdatedEventGraphQLType.fields.addAll(
    [
      chatMessageGraphQLType
          .nonNull()
          .field('message', resolve: (obj, ctx) => obj.message),
      graphQLInt.nonNull().field('chatId', resolve: (obj, ctx) => obj.chatId)
    ],
  );

  return __chatMessageUpdatedEventGraphQLType;
});

/// Auto-generated from [ChatMessageUpdatedEvent].
GraphQLObjectType<ChatMessageUpdatedEvent>
    get chatMessageUpdatedEventGraphQLType =>
        _chatMessageUpdatedEventGraphQLType.value;

final chatMessageEventSerializer = SerializerValue<ChatMessageEvent>(
  key: "ChatMessageEvent",
  fromJson: (ctx, json) =>
      ChatMessageEvent.fromJson(json), // _$ChatMessageEventFromJson,
  // toJson: (m) => _$ChatMessageEventToJson(m as ChatMessageEvent),
);

/// Generated from [ChatMessageEvent]
GraphQLUnionType<ChatMessageEvent> get chatMessageEventGraphQLType =>
    _chatMessageEventGraphQLType.value;

final _chatMessageEventGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<ChatMessageEvent>>((setValue) {
  final type = GraphQLUnionType<ChatMessageEvent>(
    'ChatMessageEvent',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    chatMessageSentEventGraphQLType,
    chatMessageDeletedEventGraphQLType,
    chatMessageUpdatedEventGraphQLType,
  ]);
  return type;
});

/// Auto-generated from [MessageType].
final GraphQLEnumType<MessageType> messageTypeGraphQLType =
    GraphQLEnumType('MessageType', [
  GraphQLEnumValue('FILE', MessageType.FILE),
  GraphQLEnumValue('TEXT', MessageType.TEXT)
]);

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
      message: json['message'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
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
