// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<List<User?>, Object, Object> searchUserGraphQLField =
    field(
  'searchUser',
  listOf(userGraphQLType.nonNull()).nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return searchUser(ctx, (args["name"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "name",
      graphQLString.nonNull().coerceToInputObject(),
    )
  ],
);

final GraphQLObjectField<User, Object, Object> getUserGraphQLField = field(
  'getUser',
  userGraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getUser(ctx);
  },
);

final GraphQLObjectField<String, Object, Object> refreshAuthTokenGraphQLField =
    field(
  'refreshAuthToken',
  graphQLString,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return refreshAuthToken(ctx);
  },
);

final GraphQLObjectField<Result<TokenWithUser, ErrC<SignUpError>>, Object,
    Object> signUpGraphQLField = field(
  'signUp',
  resultGraphQLType<TokenWithUser, ErrC<SignUpError>>(
          tokenWithUserGraphQLType.nonNull(),
          errCGraphQLType<SignUpError>(signUpErrorGraphQLType.nonNull())
              .nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return signUp(ctx, (args["name"] as String), (args["password"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "name",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "password",
      graphQLString.nonNull().coerceToInputObject(),
    )
  ],
);

final GraphQLObjectField<Result<TokenWithUser, ErrC<SignInError>>, Object,
    Object> signInGraphQLField = field(
  'signIn',
  resultGraphQLType<TokenWithUser, ErrC<SignInError>>(
          tokenWithUserGraphQLType.nonNull(),
          errCGraphQLType<SignInError>(signInErrorGraphQLType.nonNull())
              .nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return signIn(
        ctx, (args["name"] as String?), (args["password"] as String?));
  },
  inputs: [
    GraphQLFieldInput(
      "name",
      graphQLString.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "password",
      graphQLString.coerceToInputObject(),
    )
  ],
);

final GraphQLObjectField<String, Object, Object> signOutGraphQLField = field(
  'signOut',
  graphQLString,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return signOut(ctx);
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userCreatedEventSerializer = SerializerValue<UserCreatedEvent>(
  fromJson: (ctx, json) =>
      UserCreatedEvent.fromJson(json), // _$$UserCreatedEventFromJson,
  // toJson: (m) => _$$UserCreatedEventToJson(m as _$UserCreatedEvent),
);

GraphQLObjectType<UserCreatedEvent>? _userCreatedEventGraphQLType;

/// Auto-generated from [UserCreatedEvent].
GraphQLObjectType<UserCreatedEvent> get userCreatedEventGraphQLType {
  final __name = 'UserCreatedEvent';
  if (_userCreatedEventGraphQLType != null)
    return _userCreatedEventGraphQLType! as GraphQLObjectType<UserCreatedEvent>;

  final __userCreatedEventGraphQLType = objectType<UserCreatedEvent>(
      'UserCreatedEvent',
      isInterface: false,
      interfaces: []);

  _userCreatedEventGraphQLType = __userCreatedEventGraphQLType;
  __userCreatedEventGraphQLType.fields.addAll(
    [
      field('user', userGraphQLType.nonNull(), resolve: (obj, ctx) => obj.user),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userCreatedEventGraphQLType;
}

final userSignedUpEventSerializer = SerializerValue<UserSignedUpEvent>(
  fromJson: (ctx, json) =>
      UserSignedUpEvent.fromJson(json), // _$$UserSignedUpEventFromJson,
  // toJson: (m) => _$$UserSignedUpEventToJson(m as _$UserSignedUpEvent),
);

GraphQLObjectType<UserSignedUpEvent>? _userSignedUpEventGraphQLType;

/// Auto-generated from [UserSignedUpEvent].
GraphQLObjectType<UserSignedUpEvent> get userSignedUpEventGraphQLType {
  final __name = 'UserSignedUpEvent';
  if (_userSignedUpEventGraphQLType != null)
    return _userSignedUpEventGraphQLType!
        as GraphQLObjectType<UserSignedUpEvent>;

  final __userSignedUpEventGraphQLType = objectType<UserSignedUpEvent>(
      'UserSignedUpEvent',
      isInterface: false,
      interfaces: []);

  _userSignedUpEventGraphQLType = __userSignedUpEventGraphQLType;
  __userSignedUpEventGraphQLType.fields.addAll(
    [
      field('session', userSessionGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.session),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userSignedUpEventGraphQLType;
}

final userSignedInEventSerializer = SerializerValue<UserSignedInEvent>(
  fromJson: (ctx, json) =>
      UserSignedInEvent.fromJson(json), // _$$UserSignedInEventFromJson,
  // toJson: (m) => _$$UserSignedInEventToJson(m as _$UserSignedInEvent),
);

GraphQLObjectType<UserSignedInEvent>? _userSignedInEventGraphQLType;

/// Auto-generated from [UserSignedInEvent].
GraphQLObjectType<UserSignedInEvent> get userSignedInEventGraphQLType {
  final __name = 'UserSignedInEvent';
  if (_userSignedInEventGraphQLType != null)
    return _userSignedInEventGraphQLType!
        as GraphQLObjectType<UserSignedInEvent>;

  final __userSignedInEventGraphQLType = objectType<UserSignedInEvent>(
      'UserSignedInEvent',
      isInterface: false,
      interfaces: []);

  _userSignedInEventGraphQLType = __userSignedInEventGraphQLType;
  __userSignedInEventGraphQLType.fields.addAll(
    [
      field('session', userSessionGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.session),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userSignedInEventGraphQLType;
}

final userSignedOutEventSerializer = SerializerValue<UserSignedOutEvent>(
  fromJson: (ctx, json) =>
      UserSignedOutEvent.fromJson(json), // _$$UserSignedOutEventFromJson,
  // toJson: (m) => _$$UserSignedOutEventToJson(m as _$UserSignedOutEvent),
);

GraphQLObjectType<UserSignedOutEvent>? _userSignedOutEventGraphQLType;

/// Auto-generated from [UserSignedOutEvent].
GraphQLObjectType<UserSignedOutEvent> get userSignedOutEventGraphQLType {
  final __name = 'UserSignedOutEvent';
  if (_userSignedOutEventGraphQLType != null)
    return _userSignedOutEventGraphQLType!
        as GraphQLObjectType<UserSignedOutEvent>;

  final __userSignedOutEventGraphQLType = objectType<UserSignedOutEvent>(
      'UserSignedOutEvent',
      isInterface: false,
      interfaces: []);

  _userSignedOutEventGraphQLType = __userSignedOutEventGraphQLType;
  __userSignedOutEventGraphQLType.fields.addAll(
    [
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      field('sessionId', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.sessionId)
    ],
  );

  return __userSignedOutEventGraphQLType;
}

final userEventSerializer = SerializerValue<UserEvent>(
  fromJson: (ctx, json) => UserEvent.fromJson(json), // _$UserEventFromJson,
  // toJson: (m) => _$UserEventToJson(m as UserEvent),
);

GraphQLUnionType<UserEvent>? _userEventGraphQLType;
GraphQLUnionType<UserEvent> get userEventGraphQLType {
  return _userEventGraphQLType ??= GraphQLUnionType(
    'UserEvent',
    [
      userCreatedEventGraphQLType,
      userSignedUpEventGraphQLType,
      userSignedInEventGraphQLType,
      userSignedOutEventGraphQLType
    ],
  );
}

final userSessionSerializer = SerializerValue<UserSession>(
  fromJson: (ctx, json) => UserSession.fromJson(json), // _$UserSessionFromJson,
  // toJson: (m) => _$UserSessionToJson(m as UserSession),
);

GraphQLObjectType<UserSession>? _userSessionGraphQLType;

/// Auto-generated from [UserSession].
GraphQLObjectType<UserSession> get userSessionGraphQLType {
  final __name = 'UserSession';
  if (_userSessionGraphQLType != null)
    return _userSessionGraphQLType! as GraphQLObjectType<UserSession>;

  final __userSessionGraphQLType = objectType<UserSession>('UserSession',
      isInterface: false, interfaces: []);

  _userSessionGraphQLType = __userSessionGraphQLType;
  __userSessionGraphQLType.fields.addAll(
    [
      field('id', graphQLId.nonNull(), resolve: (obj, ctx) => obj.id),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      field('userAgent', graphQLString, resolve: (obj, ctx) => obj.userAgent),
      field('platform', graphQLString, resolve: (obj, ctx) => obj.platform),
      field('appVersion', graphQLString, resolve: (obj, ctx) => obj.appVersion),
      field('isActive', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.isActive),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt),
      field('endedAt', graphQLDate, resolve: (obj, ctx) => obj.endedAt)
    ],
  );

  return __userSessionGraphQLType;
}

final userSerializer = SerializerValue<User>(
  fromJson: (ctx, json) => User.fromJson(json), // _$UserFromJson,
  // toJson: (m) => _$UserToJson(m as User),
);

GraphQLObjectType<User>? _userGraphQLType;

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType {
  final __name = 'User';
  if (_userGraphQLType != null)
    return _userGraphQLType! as GraphQLObjectType<User>;

  final __userGraphQLType =
      objectType<User>('User', isInterface: false, interfaces: []);

  _userGraphQLType = __userGraphQLType;
  __userGraphQLType.fields.addAll(
    [
      field('sessions', listOf(userSessionGraphQLType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.sessions(ctx);
      }),
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id),
      field('name', graphQLString, resolve: (obj, ctx) => obj.name),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __userGraphQLType;
}

final tokenWithUserSerializer = SerializerValue<TokenWithUser>(
  fromJson: (ctx, json) =>
      TokenWithUser.fromJson(json), // _$TokenWithUserFromJson,
  // toJson: (m) => _$TokenWithUserToJson(m as TokenWithUser),
);

GraphQLObjectType<TokenWithUser>? _tokenWithUserGraphQLType;

/// Auto-generated from [TokenWithUser].
GraphQLObjectType<TokenWithUser> get tokenWithUserGraphQLType {
  final __name = 'TokenWithUser';
  if (_tokenWithUserGraphQLType != null)
    return _tokenWithUserGraphQLType! as GraphQLObjectType<TokenWithUser>;

  final __tokenWithUserGraphQLType = objectType<TokenWithUser>('TokenWithUser',
      isInterface: false, interfaces: []);

  _tokenWithUserGraphQLType = __tokenWithUserGraphQLType;
  __tokenWithUserGraphQLType.fields.addAll(
    [
      field('accessToken', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.accessToken),
      field('refreshToken', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.refreshToken),
      field('expiresInSecs', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.expiresInSecs),
      field('user', userGraphQLType.nonNull(), resolve: (obj, ctx) => obj.user)
    ],
  );

  return __tokenWithUserGraphQLType;
}

final errCSerdeCtx = SerdeCtx();
Map<String, GraphQLObjectType<ErrC>> _errCGraphQLType = {};

/// Auto-generated from [ErrC].
GraphQLObjectType<ErrC<T>> errCGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrC${tGraphQLType.printableName}';
  if (_errCGraphQLType[__name] != null)
    return _errCGraphQLType[__name]! as GraphQLObjectType<ErrC<T>>;

  final __errCGraphQLType = objectType<ErrC<T>>(
      'ErrC${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);
  errCSerdeCtx.add(
    SerializerValue<ErrC<T>>(
      fromJson: (ctx, json) => ErrC.fromJson(json, ctx.fromJson),
    ),
  );
  _errCGraphQLType[__name] = __errCGraphQLType;
  __errCGraphQLType.fields.addAll(
    [
      field('message', graphQLString, resolve: (obj, ctx) => obj.message),
      field('value', tGraphQLType.nonNull(), resolve: (obj, ctx) => obj.value)
    ],
  );

  return __errCGraphQLType;
}

/// Auto-generated from [SignUpError].
final GraphQLEnumType<SignUpError> signUpErrorGraphQLType =
    enumType('SignUpError', const {
  'nameTaken': SignUpError.nameTaken,
  'alreadySignedUp': SignUpError.alreadySignedUp,
  'unknown': SignUpError.unknown
});

/// Auto-generated from [SignInError].
final GraphQLEnumType<SignInError> signInErrorGraphQLType = enumType(
    'SignInError', const {
  'wrong': SignInError.wrong,
  'alreadySignedIn': SignInError.alreadySignedIn
});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSession _$UserSessionFromJson(Map<String, dynamic> json) => UserSession(
      id: json['id'] as String,
      userId: json['userId'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userAgent: json['userAgent'] as String?,
      platform: json['platform'] as String?,
      appVersion: json['appVersion'] as String?,
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
    );

Map<String, dynamic> _$UserSessionToJson(UserSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userAgent': instance.userAgent,
      'platform': instance.platform,
      'appVersion': instance.appVersion,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      passwordHash: json['passwordHash'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'passwordHash': instance.passwordHash,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
    };

TokenWithUser _$TokenWithUserFromJson(Map<String, dynamic> json) =>
    TokenWithUser(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      expiresInSecs: json['expiresInSecs'] as int,
    );

Map<String, dynamic> _$TokenWithUserToJson(TokenWithUser instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresInSecs': instance.expiresInSecs,
      'user': instance.user,
    };

ErrC<T> _$ErrCFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ErrC<T>(
      fromJsonT(json['value']),
      json['message'] as String?,
    );

Map<String, dynamic> _$ErrCToJson<T>(
  ErrC<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'value': toJsonT(instance.value),
    };

_$UserCreatedEvent _$$UserCreatedEventFromJson(Map<String, dynamic> json) =>
    _$UserCreatedEvent(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserCreatedEventToJson(_$UserCreatedEvent instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

_$UserSignedUpEvent _$$UserSignedUpEventFromJson(Map<String, dynamic> json) =>
    _$UserSignedUpEvent(
      session: UserSession.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserSignedUpEventToJson(_$UserSignedUpEvent instance) =>
    <String, dynamic>{
      'session': instance.session,
    };

_$UserSignedInEvent _$$UserSignedInEventFromJson(Map<String, dynamic> json) =>
    _$UserSignedInEvent(
      session: UserSession.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserSignedInEventToJson(_$UserSignedInEvent instance) =>
    <String, dynamic>{
      'session': instance.session,
    };

_$UserSignedOutEvent _$$UserSignedOutEventFromJson(Map<String, dynamic> json) =>
    _$UserSignedOutEvent(
      userId: json['userId'] as int,
      sessionId: json['sessionId'] as String,
    );

Map<String, dynamic> _$$UserSignedOutEventToJson(
        _$UserSignedOutEvent instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'sessionId': instance.sessionId,
    };
