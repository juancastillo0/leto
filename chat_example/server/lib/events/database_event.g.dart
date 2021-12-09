// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_event.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<DBEvent, Object?, Object?> get onEventGraphQLField =>
    _onEventGraphQLField.value;
final _onEventGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<DBEvent, Object?, Object?>>(
        (setValue) => setValue(dBEventGraphQLType.nonNull().field<Object?>(
              'onEvent',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                return onEvent(ctx);
              },
            )));

GraphQLObjectField<DBEvent, Object?, Object?> get onMessageEventGraphQLField =>
    _onMessageEventGraphQLField.value;
final _onMessageEventGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<DBEvent, Object?, Object?>>(
        (setValue) => setValue(dBEventGraphQLType.nonNull().field<Object?>(
              'onMessageEvent',
              subscribe: (obj, ctx) {
                final args = ctx.args;

                return onMessageEvent(ctx);
              },
            )));

GraphQLObjectField<Paginated<DBEvent>, Object?, Object?>
    get getEventsGraphQLField => _getEventsGraphQLField.value;
final _getEventsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<Paginated<DBEvent>, Object?, Object?>>(
    (setValue) => setValue(
            paginatedGraphQLType<DBEvent>(dBEventGraphQLType.nonNull())
                .nonNull()
                .field<Object?>(
          'getEvents',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getEvents(
                ctx, (args["cursor"] as String?), (args["delta"] as int));
          },
        ))
          ..inputs.addAll([
            graphQLString.coerceToInputObject().inputField('cursor'),
            graphQLInt.nonNull().coerceToInputObject().inputField('delta')
          ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatDBEventDataSerializer = SerializerValue<ChatDBEventData>(
  key: "ChatDBEventData",
  fromJson: (ctx, json) =>
      ChatDBEventData.fromJson(json), // _$$ChatDBEventDataFromJson,
  // toJson: (m) => _$$ChatDBEventDataToJson(m as _$ChatDBEventData),
);
final _chatDBEventDataGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatDBEventData>>((setValue) {
  final __name = 'ChatDBEventData';

  final __chatDBEventDataGraphQLType =
      objectType<ChatDBEventData>(__name, isInterface: false, interfaces: []);

  setValue(__chatDBEventDataGraphQLType);
  __chatDBEventDataGraphQLType.fields.addAll(
    [
      chatEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatDBEventDataGraphQLType;
});

/// Auto-generated from [ChatDBEventData].
GraphQLObjectType<ChatDBEventData> get chatDBEventDataGraphQLType =>
    _chatDBEventDataGraphQLType.value;

final userChatDBEventDataSerializer = SerializerValue<UserChatDBEventData>(
  key: "UserChatDBEventData",
  fromJson: (ctx, json) =>
      UserChatDBEventData.fromJson(json), // _$$UserChatDBEventDataFromJson,
  // toJson: (m) => _$$UserChatDBEventDataToJson(m as _$UserChatDBEventData),
);
final _userChatDBEventDataGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserChatDBEventData>>((setValue) {
  final __name = 'UserChatDBEventData';

  final __userChatDBEventDataGraphQLType = objectType<UserChatDBEventData>(
      __name,
      isInterface: false,
      interfaces: []);

  setValue(__userChatDBEventDataGraphQLType);
  __userChatDBEventDataGraphQLType.fields.addAll(
    [
      userChatEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userChatDBEventDataGraphQLType;
});

/// Auto-generated from [UserChatDBEventData].
GraphQLObjectType<UserChatDBEventData> get userChatDBEventDataGraphQLType =>
    _userChatDBEventDataGraphQLType.value;

final userDBEventDataSerializer = SerializerValue<UserDBEventData>(
  key: "UserDBEventData",
  fromJson: (ctx, json) =>
      UserDBEventData.fromJson(json), // _$$UserDBEventDataFromJson,
  // toJson: (m) => _$$UserDBEventDataToJson(m as _$UserDBEventData),
);
final _userDBEventDataGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserDBEventData>>((setValue) {
  final __name = 'UserDBEventData';

  final __userDBEventDataGraphQLType =
      objectType<UserDBEventData>(__name, isInterface: false, interfaces: []);

  setValue(__userDBEventDataGraphQLType);
  __userDBEventDataGraphQLType.fields.addAll(
    [
      userEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userDBEventDataGraphQLType;
});

/// Auto-generated from [UserDBEventData].
GraphQLObjectType<UserDBEventData> get userDBEventDataGraphQLType =>
    _userDBEventDataGraphQLType.value;

final chatMessageDBEventDataSerializer =
    SerializerValue<ChatMessageDBEventData>(
  key: "ChatMessageDBEventData",
  fromJson: (ctx, json) => ChatMessageDBEventData.fromJson(
      json), // _$$ChatMessageDBEventDataFromJson,
  // toJson: (m) => _$$ChatMessageDBEventDataToJson(m as _$ChatMessageDBEventData),
);
final _chatMessageDBEventDataGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ChatMessageDBEventData>>(
        (setValue) {
  final __name = 'ChatMessageDBEventData';

  final __chatMessageDBEventDataGraphQLType =
      objectType<ChatMessageDBEventData>(__name,
          isInterface: false, interfaces: []);

  setValue(__chatMessageDBEventDataGraphQLType);
  __chatMessageDBEventDataGraphQLType.fields.addAll(
    [
      chatMessageEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatMessageDBEventDataGraphQLType;
});

/// Auto-generated from [ChatMessageDBEventData].
GraphQLObjectType<ChatMessageDBEventData>
    get chatMessageDBEventDataGraphQLType =>
        _chatMessageDBEventDataGraphQLType.value;

final dBEventDataSerializer = SerializerValue<DBEventData>(
  key: "DBEventData",
  fromJson: (ctx, json) => DBEventData.fromJson(json), // _$DBEventDataFromJson,
  // toJson: (m) => _$DBEventDataToJson(m as DBEventData),
);

/// Generated from [DBEventData]
GraphQLUnionType<DBEventData> get dBEventDataGraphQLType =>
    _dBEventDataGraphQLType.value;

final _dBEventDataGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<DBEventData>>((setValue) {
  final type = GraphQLUnionType<DBEventData>(
    'DBEventData',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    chatDBEventDataGraphQLType,
    userChatDBEventDataGraphQLType,
    userDBEventDataGraphQLType,
    chatMessageDBEventDataGraphQLType,
  ]);
  return type;
});

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
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId),
      graphQLString
          .nonNull()
          .field('sessionId', resolve: (obj, ctx) => obj.sessionId),
      eventTypeGraphQLType
          .nonNull()
          .field('type', resolve: (obj, ctx) => obj.type),
      dBEventDataGraphQLType
          .nonNull()
          .field('data', resolve: (obj, ctx) => obj.data),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __dBEventGraphQLType;
});

/// Auto-generated from [DBEvent].
GraphQLObjectType<DBEvent> get dBEventGraphQLType => _dBEventGraphQLType.value;

final _paginatedGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<Paginated>>>(
        (_) => {});

/// Auto-generated from [Paginated].
GraphQLObjectType<Paginated<T>> paginatedGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'Paginated${tGraphQLType.printableName}';
  if (_paginatedGraphQLType.value[__name] != null)
    return _paginatedGraphQLType.value[__name]!
        as GraphQLObjectType<Paginated<T>>;
  final __paginatedGraphQLType =
      objectType<Paginated<T>>(__name, isInterface: false, interfaces: []);

  _paginatedGraphQLType.value[__name] = __paginatedGraphQLType;
  __paginatedGraphQLType.fields.addAll(
    [
      tGraphQLType
          .list()
          .nonNull()
          .field('values', resolve: (obj, ctx) => obj.values),
      PageInfo.graphQLType
          .nonNull()
          .field('pageInfo', resolve: (obj, ctx) => obj.pageInfo)
    ],
  );

  return __paginatedGraphQLType;
}

/// Auto-generated from [EventType].
final GraphQLEnumType<EventType> eventTypeGraphQLType =
    GraphQLEnumType('EventType', [
  GraphQLEnumValue('chatCreated', EventType.chatCreated),
  GraphQLEnumValue('chatDeleted', EventType.chatDeleted),
  GraphQLEnumValue('userChatRemoved', EventType.userChatRemoved),
  GraphQLEnumValue('userChatAdded', EventType.userChatAdded),
  GraphQLEnumValue('userCreated', EventType.userCreated),
  GraphQLEnumValue('userSessionSignedUp', EventType.userSessionSignedUp),
  GraphQLEnumValue('userSessionSignedIn', EventType.userSessionSignedIn),
  GraphQLEnumValue('userSessionSignedOut', EventType.userSessionSignedOut),
  GraphQLEnumValue('messageSent', EventType.messageSent),
  GraphQLEnumValue('messageDeleted', EventType.messageDeleted),
  GraphQLEnumValue('messageUpdated', EventType.messageUpdated)
]);

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBEvent _$DBEventFromJson(Map<String, dynamic> json) => DBEvent(
      id: json['id'] as int,
      userId: json['userId'] as int,
      sessionId: json['sessionId'] as String,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      data: DBEventData.fromJson(json['data'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DBEventToJson(DBEvent instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'type': _$EventTypeEnumMap[instance.type],
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.chatCreated: 'chatCreated',
  EventType.chatDeleted: 'chatDeleted',
  EventType.userChatRemoved: 'userChatRemoved',
  EventType.userChatAdded: 'userChatAdded',
  EventType.userCreated: 'userCreated',
  EventType.userSessionSignedUp: 'userSessionSignedUp',
  EventType.userSessionSignedIn: 'userSessionSignedIn',
  EventType.userSessionSignedOut: 'userSessionSignedOut',
  EventType.messageSent: 'messageSent',
  EventType.messageDeleted: 'messageDeleted',
  EventType.messageUpdated: 'messageUpdated',
};

_$ChatDBEventData _$$ChatDBEventDataFromJson(Map<String, dynamic> json) =>
    _$ChatDBEventData(
      ChatEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatDBEventDataToJson(_$ChatDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$UserChatDBEventData _$$UserChatDBEventDataFromJson(
        Map<String, dynamic> json) =>
    _$UserChatDBEventData(
      UserChatEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChatDBEventDataToJson(
        _$UserChatDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$UserDBEventData _$$UserDBEventDataFromJson(Map<String, dynamic> json) =>
    _$UserDBEventData(
      UserEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserDBEventDataToJson(_$UserDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$ChatMessageDBEventData _$$ChatMessageDBEventDataFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageDBEventData(
      ChatMessageEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageDBEventDataToJson(
        _$ChatMessageDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
