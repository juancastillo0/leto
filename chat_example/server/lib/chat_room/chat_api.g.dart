// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

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

GraphQLObjectField<bool, Object?, Object?> get deleteChatRoomGraphQLField =>
    _deleteChatRoomGraphQLField.value;
final _deleteChatRoomGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<bool, Object?, Object?>>(
        (setValue) => setValue(graphQLBoolean.nonNull().field<Object?>(
              'deleteChatRoom',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return deleteChatRoom(ctx, (args["id"] as int));
              },
            ))
              ..inputs.addAll([graphQLInt.nonNull().inputField('id')]));

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

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatCreatedEventSerializer = SerializerValue<ChatCreatedEvent>(
  key: "ChatCreatedEvent",
  fromJson: (ctx, json) =>
      ChatCreatedEvent.fromJson(json), // _$$ChatCreatedEventFromJson,
  // toJson: (m) => _$$ChatCreatedEventToJson(m as _$ChatCreatedEvent),
);
final _chatCreatedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatCreatedEvent>>((setValue) {
  final __name = 'ChatCreatedEvent';

  final __chatCreatedEventGraphQLType = objectType<ChatCreatedEvent>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__chatCreatedEventGraphQLType);
  __chatCreatedEventGraphQLType.fields.addAll(
    [
      chatRoomGraphQLType.nonNull().field(
            'chat',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.chat,
          ),
      graphQLInt.nonNull().field(
            'ownerId',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.ownerId,
          ),
      graphQLInt.nonNull().field(
            'chatId',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.chatId,
          ),
    ],
  );

  return __chatCreatedEventGraphQLType;
});

/// Auto-generated from [ChatCreatedEvent].
GraphQLObjectType<ChatCreatedEvent> get chatCreatedEventGraphQLType =>
    _chatCreatedEventGraphQLType.value;

final chatDeletedEventSerializer = SerializerValue<ChatDeletedEvent>(
  key: "ChatDeletedEvent",
  fromJson: (ctx, json) =>
      ChatDeletedEvent.fromJson(json), // _$$ChatDeletedEventFromJson,
  // toJson: (m) => _$$ChatDeletedEventToJson(m as _$ChatDeletedEvent),
);
final _chatDeletedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatDeletedEvent>>((setValue) {
  final __name = 'ChatDeletedEvent';

  final __chatDeletedEventGraphQLType = objectType<ChatDeletedEvent>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__chatDeletedEventGraphQLType);
  __chatDeletedEventGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field(
            'chatId',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.chatId,
          )
    ],
  );

  return __chatDeletedEventGraphQLType;
});

/// Auto-generated from [ChatDeletedEvent].
GraphQLObjectType<ChatDeletedEvent> get chatDeletedEventGraphQLType =>
    _chatDeletedEventGraphQLType.value;

final chatEventSerializer = SerializerValue<ChatEvent>(
  key: "ChatEvent",
  fromJson: (ctx, json) => ChatEvent.fromJson(json), // _$ChatEventFromJson,
  // toJson: (m) => _$ChatEventToJson(m as ChatEvent),
);

/// Generated from [ChatEvent]
GraphQLUnionType<ChatEvent> get chatEventGraphQLType =>
    _chatEventGraphQLType.value;

final _chatEventGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<ChatEvent>>((setValue) {
  final type = GraphQLUnionType<ChatEvent>(
    'ChatEvent',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    chatCreatedEventGraphQLType,
    chatDeletedEventGraphQLType,
  ]);
  return type;
});

final chatRoomSerializer = SerializerValue<ChatRoom>(
  key: "ChatRoom",
  fromJson: (ctx, json) => ChatRoom.fromJson(json), // _$$_ChatRoomFromJson,
  // toJson: (m) => _$$_ChatRoomToJson(m as _$_ChatRoom),
);
final _chatRoomGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatRoom>>((setValue) {
  final __name = 'ChatRoom';

  final __chatRoomGraphQLType = objectType<ChatRoom>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__chatRoomGraphQLType);
  __chatRoomGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field(
            'id',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.id,
          ),
      graphQLString.nonNull().field(
            'name',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.name,
          ),
      graphQLDate.nonNull().field(
            'createdAt',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.createdAt,
          ),
      chatMessageGraphQLType.nonNull().list().nonNull().field(
        'messages',
        resolve: (
          obj,
          ctx,
        ) {
          final args = ctx.args;

          return obj.messages(ctx);
        },
      ),
      chatRoomUserGraphQLType.nonNull().list().nonNull().field(
        'users',
        resolve: (
          obj,
          ctx,
        ) {
          final args = ctx.args;

          return obj.users(ctx);
        },
      ),
    ],
  );

  return __chatRoomGraphQLType;
});

/// Auto-generated from [ChatRoom].
GraphQLObjectType<ChatRoom> get chatRoomGraphQLType =>
    _chatRoomGraphQLType.value;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatCreatedEvent _$$ChatCreatedEventFromJson(Map<String, dynamic> json) =>
    _$ChatCreatedEvent(
      chat: ChatRoom.fromJson(json['chat'] as Map<String, dynamic>),
      ownerId: json['ownerId'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ChatCreatedEventToJson(_$ChatCreatedEvent instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'ownerId': instance.ownerId,
      'runtimeType': instance.$type,
    };

_$ChatDeletedEvent _$$ChatDeletedEventFromJson(Map<String, dynamic> json) =>
    _$ChatDeletedEvent(
      chatId: json['chatId'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ChatDeletedEventToJson(_$ChatDeletedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'runtimeType': instance.$type,
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
