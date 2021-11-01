// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_event.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<DBEvent, Object, Object> onEventGraphQLField = field(
  'onEvent',
  dBEventGraphQLType.nonNull(),
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onEvent(ctx);
  },
);

final GraphQLObjectField<DBEvent, Object, Object> onMessageEventGraphQLField =
    field(
  'onMessageEvent',
  dBEventGraphQLType.nonNull(),
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageEvent(ctx);
  },
);

final GraphQLObjectField<Paginated<DBEvent>, Object, Object>
    getEventsGraphQLField = field(
  'getEvents',
  paginatedGraphQLType<DBEvent>(dBEventGraphQLType.nonNull()).nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getEvents(ctx, (args["cursor"] as String?), (args["delta"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "cursor",
      graphQLString.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "delta",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatDBEventDataSerializer = SerializerValue<ChatDBEventData>(
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

  final __chatDBEventDataGraphQLType = objectType<ChatDBEventData>(
      'ChatDBEventData',
      isInterface: false,
      interfaces: []);

  _chatDBEventDataGraphQLType = __chatDBEventDataGraphQLType;
  __chatDBEventDataGraphQLType.fields.addAll(
    [
      field('value', chatEventGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatDBEventDataGraphQLType;
}

final userChatDBEventDataSerializer = SerializerValue<UserChatDBEventData>(
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
      'UserChatDBEventData',
      isInterface: false,
      interfaces: []);

  _userChatDBEventDataGraphQLType = __userChatDBEventDataGraphQLType;
  __userChatDBEventDataGraphQLType.fields.addAll(
    [
      field('value', userChatEventGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userChatDBEventDataGraphQLType;
}

final userDBEventDataSerializer = SerializerValue<UserDBEventData>(
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

  final __userDBEventDataGraphQLType = objectType<UserDBEventData>(
      'UserDBEventData',
      isInterface: false,
      interfaces: []);

  _userDBEventDataGraphQLType = __userDBEventDataGraphQLType;
  __userDBEventDataGraphQLType.fields.addAll(
    [
      field('value', userEventGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.value)
    ],
  );

  return __userDBEventDataGraphQLType;
}

final chatMessageDBEventDataSerializer =
    SerializerValue<ChatMessageDBEventData>(
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
      objectType<ChatMessageDBEventData>('ChatMessageDBEventData',
          isInterface: false, interfaces: []);

  _chatMessageDBEventDataGraphQLType = __chatMessageDBEventDataGraphQLType;
  __chatMessageDBEventDataGraphQLType.fields.addAll(
    [
      field('value', chatMessageEventGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.value)
    ],
  );

  return __chatMessageDBEventDataGraphQLType;
}

final dBEventDataSerializer = SerializerValue<DBEventData>(
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
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      field('sessionId', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.sessionId),
      field('type', eventTypeGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.type),
      field('data', dBEventDataGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.data),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt)
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

  final __paginatedGraphQLType = objectType<Paginated<T>>(
      'Paginated${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _paginatedGraphQLType[__name] = __paginatedGraphQLType;
  __paginatedGraphQLType.fields.addAll(
    [
      field('values', listOf(tGraphQLType.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.values),
      field('pageInfo', pageInfoGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.pageInfo)
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
      type: _$enumDecode(_$EventTypeEnumMap, json['type']),
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
