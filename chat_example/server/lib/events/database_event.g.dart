// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_event.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final onEventGraphQLField = dBEventGraphQLType.nonNull().field<Object?>(
  'onEvent',
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onEvent(ctx);
  },
);

final onMessageEventGraphQLField = dBEventGraphQLType.nonNull().field<Object?>(
  'onMessageEvent',
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageEvent(ctx);
  },
);

final getEventsGraphQLField =
    paginatedGraphQLType<DBEvent>(dBEventGraphQLType.nonNull())
        .nonNull()
        .field<Object?>(
  'getEvents',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getEvents(ctx, (args["cursor"] as String?), (args["delta"] as int));
  },
  inputs: [
    graphQLString.coerceToInputObject().inputField('cursor'),
    graphQLInt.nonNull().coerceToInputObject().inputField('delta')
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatDBEventDataSerializer = SerializerValue<ChatDBEventData>(
  key: "ChatDBEventData",
  fromJson: (ctx, json) =>
      ChatDBEventData.fromJson(json), // _$$ChatDBEventDataFromJson,
  // toJson: (m) => _$$ChatDBEventDataToJson(m as _$ChatDBEventData),
);

GraphQLObjectType<ChatDBEventData>? _chatDBEventDataGraphQLType;

/// Auto-generated from [ChatDBEventData].
GraphQLObjectType<ChatDBEventData> get chatDBEventDataGraphQLType {
  final __name = 'ChatDBEventData';
  if (_chatDBEventDataGraphQLType != null)
    return _chatDBEventDataGraphQLType! as GraphQLObjectType<ChatDBEventData>;

  final __chatDBEventDataGraphQLType =
      objectType<ChatDBEventData>(__name, isInterface: false, interfaces: []);

  _chatDBEventDataGraphQLType = __chatDBEventDataGraphQLType;
  __chatDBEventDataGraphQLType.fields.addAll(
    [
      chatEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatDBEventDataGraphQLType;
}

final userChatDBEventDataSerializer = SerializerValue<UserChatDBEventData>(
  key: "UserChatDBEventData",
  fromJson: (ctx, json) =>
      UserChatDBEventData.fromJson(json), // _$$UserChatDBEventDataFromJson,
  // toJson: (m) => _$$UserChatDBEventDataToJson(m as _$UserChatDBEventData),
);

GraphQLObjectType<UserChatDBEventData>? _userChatDBEventDataGraphQLType;

/// Auto-generated from [UserChatDBEventData].
GraphQLObjectType<UserChatDBEventData> get userChatDBEventDataGraphQLType {
  final __name = 'UserChatDBEventData';
  if (_userChatDBEventDataGraphQLType != null)
    return _userChatDBEventDataGraphQLType!
        as GraphQLObjectType<UserChatDBEventData>;

  final __userChatDBEventDataGraphQLType = objectType<UserChatDBEventData>(
      __name,
      isInterface: false,
      interfaces: []);

  _userChatDBEventDataGraphQLType = __userChatDBEventDataGraphQLType;
  __userChatDBEventDataGraphQLType.fields.addAll(
    [
      userChatEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userChatDBEventDataGraphQLType;
}

final userDBEventDataSerializer = SerializerValue<UserDBEventData>(
  key: "UserDBEventData",
  fromJson: (ctx, json) =>
      UserDBEventData.fromJson(json), // _$$UserDBEventDataFromJson,
  // toJson: (m) => _$$UserDBEventDataToJson(m as _$UserDBEventData),
);

GraphQLObjectType<UserDBEventData>? _userDBEventDataGraphQLType;

/// Auto-generated from [UserDBEventData].
GraphQLObjectType<UserDBEventData> get userDBEventDataGraphQLType {
  final __name = 'UserDBEventData';
  if (_userDBEventDataGraphQLType != null)
    return _userDBEventDataGraphQLType! as GraphQLObjectType<UserDBEventData>;

  final __userDBEventDataGraphQLType =
      objectType<UserDBEventData>(__name, isInterface: false, interfaces: []);

  _userDBEventDataGraphQLType = __userDBEventDataGraphQLType;
  __userDBEventDataGraphQLType.fields.addAll(
    [
      userEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userDBEventDataGraphQLType;
}

final chatMessageDBEventDataSerializer =
    SerializerValue<ChatMessageDBEventData>(
  key: "ChatMessageDBEventData",
  fromJson: (ctx, json) => ChatMessageDBEventData.fromJson(
      json), // _$$ChatMessageDBEventDataFromJson,
  // toJson: (m) => _$$ChatMessageDBEventDataToJson(m as _$ChatMessageDBEventData),
);

GraphQLObjectType<ChatMessageDBEventData>? _chatMessageDBEventDataGraphQLType;

/// Auto-generated from [ChatMessageDBEventData].
GraphQLObjectType<ChatMessageDBEventData>
    get chatMessageDBEventDataGraphQLType {
  final __name = 'ChatMessageDBEventData';
  if (_chatMessageDBEventDataGraphQLType != null)
    return _chatMessageDBEventDataGraphQLType!
        as GraphQLObjectType<ChatMessageDBEventData>;

  final __chatMessageDBEventDataGraphQLType =
      objectType<ChatMessageDBEventData>(__name,
          isInterface: false, interfaces: []);

  _chatMessageDBEventDataGraphQLType = __chatMessageDBEventDataGraphQLType;
  __chatMessageDBEventDataGraphQLType.fields.addAll(
    [
      chatMessageEventGraphQLType
          .nonNull()
          .field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatMessageDBEventDataGraphQLType;
}

final dBEventDataSerializer = SerializerValue<DBEventData>(
  key: "DBEventData",
  fromJson: (ctx, json) => DBEventData.fromJson(json), // _$DBEventDataFromJson,
  // toJson: (m) => _$DBEventDataToJson(m as DBEventData),
);

GraphQLUnionType<DBEventData>? _dBEventDataGraphQLType;
GraphQLUnionType<DBEventData> get dBEventDataGraphQLType {
  return _dBEventDataGraphQLType ??= GraphQLUnionType(
    'DBEventData',
    [
      chatDBEventDataGraphQLType,
      userChatDBEventDataGraphQLType,
      userDBEventDataGraphQLType,
      chatMessageDBEventDataGraphQLType
    ],
  );
}

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
      objectType<DBEvent>(__name, isInterface: false, interfaces: []);

  _dBEventGraphQLType = __dBEventGraphQLType;
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
}

Map<String, GraphQLObjectType<Paginated>> _paginatedGraphQLType = {};

/// Auto-generated from [Paginated].
GraphQLObjectType<Paginated<T>> paginatedGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'Paginated${tGraphQLType.printableName}';
  if (_paginatedGraphQLType[__name] != null)
    return _paginatedGraphQLType[__name]! as GraphQLObjectType<Paginated<T>>;

  final __paginatedGraphQLType =
      objectType<Paginated<T>>(__name, isInterface: false, interfaces: []);

  _paginatedGraphQLType[__name] = __paginatedGraphQLType;
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
    enumType('EventType', const {
  'chatCreated': EventType.chatCreated,
  'chatDeleted': EventType.chatDeleted,
  'userChatRemoved': EventType.userChatRemoved,
  'userChatAdded': EventType.userChatAdded,
  'userCreated': EventType.userCreated,
  'userSessionSignedUp': EventType.userSessionSignedUp,
  'userSessionSignedIn': EventType.userSessionSignedIn,
  'userSessionSignedOut': EventType.userSessionSignedOut,
  'messageSent': EventType.messageSent,
  'messageDeleted': EventType.messageDeleted,
  'messageUpdated': EventType.messageUpdated
});

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
