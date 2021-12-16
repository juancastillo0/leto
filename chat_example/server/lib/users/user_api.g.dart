// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<List<User>, Object?, Object?> get searchUserGraphQLField =>
    _searchUserGraphQLField.value;
final _searchUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<List<User>, Object?, Object?>>(
        (setValue) =>
            setValue(userGraphQLType.nonNull().list().nonNull().field<Object?>(
              'searchUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return searchUser(ctx, (args["name"] as String));
              },
            ))
              ..inputs.addAll([
                graphQLString.nonNull().coerceToInputObject().inputField('name')
              ]));

GraphQLObjectField<User?, Object?, Object?> get getUserGraphQLField =>
    _getUserGraphQLField.value;
final _getUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<User?, Object?, Object?>>(
        (setValue) => setValue(userGraphQLType.field<Object?>(
              'getUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getUser(ctx);
              },
            )));

GraphQLObjectField<String?, Object?, Object?>
    get refreshAuthTokenGraphQLField => _refreshAuthTokenGraphQLField.value;
final _refreshAuthTokenGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<String?, Object?, Object?>>(
        (setValue) => setValue(graphQLString.field<Object?>(
              'refreshAuthToken',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return refreshAuthToken(ctx);
              },
            )));

GraphQLObjectField<Result<TokenWithUser, ErrC<SignUpError>>, Object?, Object?>
    get signUpGraphQLField => _signUpGraphQLField.value;
final _signUpGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<Result<TokenWithUser, ErrC<SignUpError>>, Object?,
        Object?>>((setValue) =>
    setValue(resultGraphQLType<TokenWithUser, ErrC<SignUpError>>(
            tokenWithUserGraphQLType.nonNull(),
            errCGraphQLType<SignUpError>(signUpErrorGraphQLType.nonNull())
                .nonNull())
        .nonNull()
        .field<Object?>(
      'signUp',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return signUp(
            ctx, (args["name"] as String), (args["password"] as String));
      },
    ))
      ..inputs.addAll([
        graphQLString.nonNull().coerceToInputObject().inputField('name'),
        graphQLString.nonNull().coerceToInputObject().inputField('password')
      ]));

GraphQLObjectField<Result<TokenWithUser, ErrC<SignInError>>, Object?, Object?>
    get signInGraphQLField => _signInGraphQLField.value;
final _signInGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<Result<TokenWithUser, ErrC<SignInError>>, Object?,
        Object?>>((setValue) =>
    setValue(resultGraphQLType<TokenWithUser, ErrC<SignInError>>(
            tokenWithUserGraphQLType.nonNull(),
            errCGraphQLType<SignInError>(signInErrorGraphQLType.nonNull())
                .nonNull())
        .nonNull()
        .field<Object?>(
      'signIn',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return signIn(
            ctx, (args["name"] as String?), (args["password"] as String?));
      },
    ))
      ..inputs.addAll([
        graphQLString.coerceToInputObject().inputField('name'),
        graphQLString.coerceToInputObject().inputField('password')
      ]));

GraphQLObjectField<String?, Object?, Object?> get signOutGraphQLField =>
    _signOutGraphQLField.value;
final _signOutGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<String?, Object?, Object?>>(
        (setValue) => setValue(graphQLString.field<Object?>(
              'signOut',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return signOut(ctx);
              },
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userCreatedEventSerializer = SerializerValue<UserCreatedEvent>(
  key: "UserCreatedEvent",
  fromJson: (ctx, json) =>
      UserCreatedEvent.fromJson(json), // _$$UserCreatedEventFromJson,
  // toJson: (m) => _$$UserCreatedEventToJson(m as _$UserCreatedEvent),
);
final _userCreatedEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserCreatedEvent>>((setValue) {
  final __name = 'UserCreatedEvent';

  final __userCreatedEventGraphQLType =
      objectType<UserCreatedEvent>(__name, isInterface: false, interfaces: []);

  setValue(__userCreatedEventGraphQLType);
  __userCreatedEventGraphQLType.fields.addAll(
    [
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) => obj.user),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userCreatedEventGraphQLType;
});

/// Auto-generated from [UserCreatedEvent].
GraphQLObjectType<UserCreatedEvent> get userCreatedEventGraphQLType =>
    _userCreatedEventGraphQLType.value;

final userSignedUpEventSerializer = SerializerValue<UserSignedUpEvent>(
  key: "UserSignedUpEvent",
  fromJson: (ctx, json) =>
      UserSignedUpEvent.fromJson(json), // _$$UserSignedUpEventFromJson,
  // toJson: (m) => _$$UserSignedUpEventToJson(m as _$UserSignedUpEvent),
);
final _userSignedUpEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserSignedUpEvent>>((setValue) {
  final __name = 'UserSignedUpEvent';

  final __userSignedUpEventGraphQLType =
      objectType<UserSignedUpEvent>(__name, isInterface: false, interfaces: []);

  setValue(__userSignedUpEventGraphQLType);
  __userSignedUpEventGraphQLType.fields.addAll(
    [
      userSessionGraphQLType
          .nonNull()
          .field('session', resolve: (obj, ctx) => obj.session),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userSignedUpEventGraphQLType;
});

/// Auto-generated from [UserSignedUpEvent].
GraphQLObjectType<UserSignedUpEvent> get userSignedUpEventGraphQLType =>
    _userSignedUpEventGraphQLType.value;

final userSignedInEventSerializer = SerializerValue<UserSignedInEvent>(
  key: "UserSignedInEvent",
  fromJson: (ctx, json) =>
      UserSignedInEvent.fromJson(json), // _$$UserSignedInEventFromJson,
  // toJson: (m) => _$$UserSignedInEventToJson(m as _$UserSignedInEvent),
);
final _userSignedInEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserSignedInEvent>>((setValue) {
  final __name = 'UserSignedInEvent';

  final __userSignedInEventGraphQLType =
      objectType<UserSignedInEvent>(__name, isInterface: false, interfaces: []);

  setValue(__userSignedInEventGraphQLType);
  __userSignedInEventGraphQLType.fields.addAll(
    [
      userSessionGraphQLType
          .nonNull()
          .field('session', resolve: (obj, ctx) => obj.session),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId)
    ],
  );

  return __userSignedInEventGraphQLType;
});

/// Auto-generated from [UserSignedInEvent].
GraphQLObjectType<UserSignedInEvent> get userSignedInEventGraphQLType =>
    _userSignedInEventGraphQLType.value;

final userSignedOutEventSerializer = SerializerValue<UserSignedOutEvent>(
  key: "UserSignedOutEvent",
  fromJson: (ctx, json) =>
      UserSignedOutEvent.fromJson(json), // _$$UserSignedOutEventFromJson,
  // toJson: (m) => _$$UserSignedOutEventToJson(m as _$UserSignedOutEvent),
);
final _userSignedOutEventGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserSignedOutEvent>>((setValue) {
  final __name = 'UserSignedOutEvent';

  final __userSignedOutEventGraphQLType = objectType<UserSignedOutEvent>(__name,
      isInterface: false, interfaces: []);

  setValue(__userSignedOutEventGraphQLType);
  __userSignedOutEventGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId),
      graphQLString
          .nonNull()
          .field('sessionId', resolve: (obj, ctx) => obj.sessionId)
    ],
  );

  return __userSignedOutEventGraphQLType;
});

/// Auto-generated from [UserSignedOutEvent].
GraphQLObjectType<UserSignedOutEvent> get userSignedOutEventGraphQLType =>
    _userSignedOutEventGraphQLType.value;

final userEventSerializer = SerializerValue<UserEvent>(
  key: "UserEvent",
  fromJson: (ctx, json) => UserEvent.fromJson(json), // _$UserEventFromJson,
  // toJson: (m) => _$UserEventToJson(m as UserEvent),
);

/// Generated from [UserEvent]
GraphQLUnionType<UserEvent> get userEventGraphQLType =>
    _userEventGraphQLType.value;

final _userEventGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<UserEvent>>((setValue) {
  final type = GraphQLUnionType<UserEvent>(
    'UserEvent',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    userCreatedEventGraphQLType,
    userSignedUpEventGraphQLType,
    userSignedInEventGraphQLType,
    userSignedOutEventGraphQLType,
  ]);
  return type;
});

final userSessionSerializer = SerializerValue<UserSession>(
  key: "UserSession",
  fromJson: (ctx, json) => UserSession.fromJson(json), // _$UserSessionFromJson,
  // toJson: (m) => _$UserSessionToJson(m as UserSession),
);
final _userSessionGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserSession>>((setValue) {
  final __name = 'UserSession';

  final __userSessionGraphQLType =
      objectType<UserSession>(__name, isInterface: false, interfaces: []);

  setValue(__userSessionGraphQLType);
  __userSessionGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLInt.nonNull().field('userId', resolve: (obj, ctx) => obj.userId),
      graphQLString.field('userAgent', resolve: (obj, ctx) => obj.userAgent),
      graphQLString.field('platform', resolve: (obj, ctx) => obj.platform),
      graphQLString.field('appVersion', resolve: (obj, ctx) => obj.appVersion),
      graphQLBoolean
          .nonNull()
          .field('isActive', resolve: (obj, ctx) => obj.isActive),
      graphQLString.field('ipAddress', resolve: (obj, ctx) => obj.ipAddress),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt),
      graphQLDate.field('endedAt', resolve: (obj, ctx) => obj.endedAt)
    ],
  );

  return __userSessionGraphQLType;
});

/// Auto-generated from [UserSession].
GraphQLObjectType<UserSession> get userSessionGraphQLType =>
    _userSessionGraphQLType.value;

final userSerializer = SerializerValue<User>(
  key: "User",
  fromJson: (ctx, json) => User.fromJson(json), // _$UserFromJson,
  // toJson: (m) => _$UserToJson(m as User),
);
final _userGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<User>>((setValue) {
  final __name = 'User';

  final __userGraphQLType =
      objectType<User>(__name, isInterface: false, interfaces: []);

  setValue(__userGraphQLType);
  __userGraphQLType.fields.addAll(
    [
      userSessionGraphQLType.nonNull().list().nonNull().field('sessions',
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.sessions(ctx);
      }),
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.field('name', resolve: (obj, ctx) => obj.name),
      graphQLDate
          .nonNull()
          .field('createdAt', resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __userGraphQLType;
});

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType => _userGraphQLType.value;

final tokenWithUserSerializer = SerializerValue<TokenWithUser>(
  key: "TokenWithUser",
  fromJson: (ctx, json) =>
      TokenWithUser.fromJson(json), // _$TokenWithUserFromJson,
  // toJson: (m) => _$TokenWithUserToJson(m as TokenWithUser),
);
final _tokenWithUserGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<TokenWithUser>>((setValue) {
  final __name = 'TokenWithUser';

  final __tokenWithUserGraphQLType =
      objectType<TokenWithUser>(__name, isInterface: false, interfaces: []);

  setValue(__tokenWithUserGraphQLType);
  __tokenWithUserGraphQLType.fields.addAll(
    [
      graphQLString
          .nonNull()
          .field('accessToken', resolve: (obj, ctx) => obj.accessToken),
      graphQLString
          .nonNull()
          .field('refreshToken', resolve: (obj, ctx) => obj.refreshToken),
      graphQLInt
          .nonNull()
          .field('expiresInSecs', resolve: (obj, ctx) => obj.expiresInSecs),
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) => obj.user)
    ],
  );

  return __tokenWithUserGraphQLType;
});

/// Auto-generated from [TokenWithUser].
GraphQLObjectType<TokenWithUser> get tokenWithUserGraphQLType =>
    _tokenWithUserGraphQLType.value;

final errCSerdeCtx = SerdeCtx();
final _errCGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<ErrC>>>((_) => {});

/// Auto-generated from [ErrC].
GraphQLObjectType<ErrC<T>> errCGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'ErrC${tGraphQLType.printableName}';
  if (_errCGraphQLType.value[__name] != null)
    return _errCGraphQLType.value[__name]! as GraphQLObjectType<ErrC<T>>;
  final __errCGraphQLType =
      objectType<ErrC<T>>(__name, isInterface: false, interfaces: []);
  errCSerdeCtx.add(
    SerializerValue<ErrC<T>>(
      fromJson: (ctx, json) => ErrC.fromJson(json, ctx.fromJson),
    ),
  );
  _errCGraphQLType.value[__name] = __errCGraphQLType;
  __errCGraphQLType.fields.addAll(
    [
      graphQLString.field('message', resolve: (obj, ctx) => obj.message),
      tGraphQLType.field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __errCGraphQLType;
}

/// Auto-generated from [SignUpError].
final GraphQLEnumType<SignUpError> signUpErrorGraphQLType =
    GraphQLEnumType('SignUpError', [
  GraphQLEnumValue('nameTaken', SignUpError.nameTaken),
  GraphQLEnumValue('alreadySignedUp', SignUpError.alreadySignedUp),
  GraphQLEnumValue('unknown', SignUpError.unknown)
]);

/// Auto-generated from [SignInError].
final GraphQLEnumType<SignInError> signInErrorGraphQLType =
    GraphQLEnumType('SignInError', [
  GraphQLEnumValue('wrong', SignInError.wrong),
  GraphQLEnumValue('alreadySignedIn', SignInError.alreadySignedIn)
]);

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSession _$UserSessionFromJson(Map<String, dynamic> json) => UserSession(
      id: json['id'] as String,
      userId: json['userId'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      ipAddress: json['ipAddress'] as String?,
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
      'ipAddress': instance.ipAddress,
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
