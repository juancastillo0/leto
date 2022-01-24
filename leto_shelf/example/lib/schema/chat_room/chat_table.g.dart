// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ChatMessage?, Object?, Object?>
    get sendMessageGraphQLField => _sendMessageGraphQLField.value;
final _sendMessageGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ChatMessage?, Object?, Object?>>(
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
                graphQLInt.nonNull().inputField('chatId'),
                graphQLString.nonNull().inputField('message'),
                graphQLInt.inputField('referencedMessageId')
              ]));

GraphQLObjectField<List<ChatMessage>, Object?, Object?>
    get getMessageGraphQLField => _getMessageGraphQLField.value;
final _getMessageGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<ChatMessage>, Object?, Object?>>(
    (setValue) => setValue(
            chatMessageGraphQLType.nonNull().list().nonNull().field<Object?>(
          'getMessage',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getMessage(ctx, (args["chatId"] as int?));
          },
        ))
          ..inputs.addAll([graphQLInt.inputField('chatId')]));

GraphQLObjectField<List<ChatMessage>, Object?, Object?>
    get onMessageSentGraphQLField => _onMessageSentGraphQLField.value;
final _onMessageSentGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<ChatMessage>, Object?, Object?>>(
    (setValue) => setValue(
            chatMessageGraphQLType.nonNull().list().nonNull().field<Object?>(
          'onMessageSent',
          subscribe: (obj, ctx) {
            final args = ctx.args;

            return onMessageSent(ctx, (args["chatId"] as int));
          },
        ))
          ..inputs.addAll([graphQLInt.nonNull().inputField('chatId')]));

GraphQLObjectField<ChatRoom?, Object?, Object?>
    get createChatRoomGraphQLField => _createChatRoomGraphQLField.value;
final _createChatRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ChatRoom?, Object?, Object?>>(
        (setValue) => setValue(chatRoomGraphQLType.field<Object?>(
              'createChatRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return createChatRoom(ctx, (args["name"] as String));
              },
            ))
              ..inputs.addAll([graphQLString.nonNull().inputField('name')]));

GraphQLObjectField<List<ChatRoom>, Object?, Object?>
    get getChatRoomsGraphQLField => _getChatRoomsGraphQLField.value;
final _getChatRoomsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<ChatRoom>, Object?, Object?>>(
    (setValue) =>
        setValue(chatRoomGraphQLType.nonNull().list().nonNull().field<Object?>(
          'getChatRooms',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getChatRooms(ctx);
          },
        )));

GraphQLObjectField<DBEvent, Object?, Object?> get onMessageEventGraphQLField =>
    _onMessageEventGraphQLField.value;
final _onMessageEventGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<DBEvent, Object?, Object?>>(
    (setValue) => setValue(dBEventGraphQLType.nonNull().field<Object?>(
          'onMessageEvent',
          subscribe: (obj, ctx) {
            final args = ctx.args;

            return onMessageEvent(ctx, (args["type"] as EventType));
          },
        ))
          ..inputs.addAll([eventTypeGraphQLType.nonNull().inputField('type')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final dBEventSerializer = SerializerValue<DBEvent>(
  key: "DBEvent",
  fromJson: (ctx, json) => DBEvent.fromJson(json), // _$DBEventFromJson,
  // toJson: (m) => _$DBEventToJson(m as DBEvent),
);
final _dBEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<DBEvent>>((setValue) {
  final __name = 'DBEvent';

  final __dBEventGraphQLType =
      objectType<DBEvent>(__name, isInterface: false, interfaces: []);

  setValue(__dBEventGraphQLType);
  __dBEventGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      eventTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type),
      graphQLString.nonNull().field('data', resolve: (obj, ctx) => obj.data),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __dBEventGraphQLType;
});

/// Auto-generated from [DBEvent].
GraphQLObjectType<DBEvent> get dBEventGraphQLType => _dBEventGraphQLType.value;

final chatRoomSerializer = SerializerValue<ChatRoom>(
  key: "ChatRoom",
  fromJson: (ctx, json) => ChatRoom.fromJson(json), // _$$_ChatRoomFromJson,
  // toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);
final _chatRoomGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatRoom>>((setValue) {
  final __name = 'ChatRoom';

  final __chatRoomGraphQLType =
      objectType<ChatRoom>(__name, isInterface: false, interfaces: []);

  setValue(__chatRoomGraphQLType);
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
      })
    ],
  );

  return __chatRoomGraphQLType;
});

/// Auto-generated from [ChatRoom].
GraphQLObjectType<ChatRoom> get chatRoomGraphQLType =>
    _chatRoomGraphQLType.value;

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
      graphQLString
          .nonNull()
          .field('message', resolve: (obj, ctx) => obj.message),
      graphQLInt.field('referencedMessageId',
          resolve: (obj, ctx) => obj.referencedMessageId),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt),
      chatMessageGraphQLType.field('referencedMessage', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      })
    ],
  );

  return __chatMessageGraphQLType;
});

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQLType =>
    _chatMessageGraphQLType.value;

/// Auto-generated from [EventType].
final GraphQLEnumType<EventType> eventTypeGraphQLType = GraphQLEnumType(
    'EventType', [GraphQLEnumValue('messageSent', EventType.messageSent)]);

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
