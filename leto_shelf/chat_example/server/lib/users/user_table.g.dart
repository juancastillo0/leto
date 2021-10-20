// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<List<User?>, Object, Object> searchUserGraphQLField =
    field(
  'searchUser',
  listOf(userGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<User?>, Object>,
  description: null,
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
  deprecationReason: null,
);

final GraphQLObjectField<String, Object, Object> refreshAuthTokenGraphQLField =
    field(
  'refreshAuthToken',
  graphQLString as GraphQLType<String, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return refreshAuthToken(ctx);
  },
  deprecationReason: null,
);

final GraphQLObjectField<Result<TokenWithUser, ErrC<SignUpError>>, Object,
    Object> signUpGraphQLField = field(
  'signUp',
  resultGraphQlType(tokenWithUserGraphQlType.nonNull(),
              errCGraphQlType(signUpErrorGraphQlType.nonNull()).nonNull())
          .nonNull()
      as GraphQLType<Result<TokenWithUser, ErrC<SignUpError>>, Object>,
  description: null,
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
  deprecationReason: null,
);

final GraphQLObjectField<Result<TokenWithUser, ErrC<SignInError>>, Object,
    Object> signInGraphQLField = field(
  'signIn',
  resultGraphQlType(tokenWithUserGraphQlType.nonNull(),
              errCGraphQlType(signInErrorGraphQlType.nonNull()).nonNull())
          .nonNull()
      as GraphQLType<Result<TokenWithUser, ErrC<SignInError>>, Object>,
  description: null,
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
  deprecationReason: null,
);

final GraphQLObjectField<String, Object, Object> signOutGraphQLField = field(
  'signOut',
  graphQLString as GraphQLType<String, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return signOut(ctx);
  },
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userSessionSerializer = SerializerValue<UserSession>(
  fromJson: _$UserSessionFromJson,
  toJson: (m) => _$UserSessionToJson(m as UserSession),
);
GraphQLObjectType<UserSession>? _userSessionGraphQlType;

/// Auto-generated from [UserSession].
GraphQLObjectType<UserSession> get userSessionGraphQlType {
  final __name = 'UserSession';
  if (_userSessionGraphQlType != null)
    return _userSessionGraphQlType! as GraphQLObjectType<UserSession>;

  final __userSessionGraphQlType = objectType<UserSession>('UserSession',
      isInterface: false, interfaces: [], description: null);
  _userSessionGraphQlType = __userSessionGraphQlType;
  __userSessionGraphQlType.fields.addAll(
    [
      field('id', graphQLId.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userAgent', graphQLString,
          resolve: (obj, ctx) => obj.userAgent,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('platform', graphQLString,
          resolve: (obj, ctx) => obj.platform,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('appVersion', graphQLString,
          resolve: (obj, ctx) => obj.appVersion,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('isActive', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.isActive,
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

  return __userSessionGraphQlType;
}

final userSerializer = SerializerValue<User>(
  fromJson: _$UserFromJson,
  toJson: (m) => _$UserToJson(m as User),
);
GraphQLObjectType<User>? _userGraphQlType;

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQlType {
  final __name = 'User';
  if (_userGraphQlType != null)
    return _userGraphQlType! as GraphQLObjectType<User>;

  final __userGraphQlType = objectType<User>('User',
      isInterface: false, interfaces: [], description: null);
  _userGraphQlType = __userGraphQlType;
  __userGraphQlType.fields.addAll(
    [
      field('sessions', listOf(userSessionGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.sessions(ctx);
      }, inputs: [], description: null, deprecationReason: null),
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('name', graphQLString,
          resolve: (obj, ctx) => obj.name,
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

  return __userGraphQlType;
}

final tokenWithUserSerializer = SerializerValue<TokenWithUser>(
  fromJson: _$TokenWithUserFromJson,
  toJson: (m) => _$TokenWithUserToJson(m as TokenWithUser),
);
GraphQLObjectType<TokenWithUser>? _tokenWithUserGraphQlType;

/// Auto-generated from [TokenWithUser].
GraphQLObjectType<TokenWithUser> get tokenWithUserGraphQlType {
  final __name = 'TokenWithUser';
  if (_tokenWithUserGraphQlType != null)
    return _tokenWithUserGraphQlType! as GraphQLObjectType<TokenWithUser>;

  final __tokenWithUserGraphQlType = objectType<TokenWithUser>('TokenWithUser',
      isInterface: false, interfaces: [], description: null);
  _tokenWithUserGraphQlType = __tokenWithUserGraphQlType;
  __tokenWithUserGraphQlType.fields.addAll(
    [
      field('accessToken', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.accessToken,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('refreshToken', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.refreshToken,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('expiresInSecs', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.expiresInSecs,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('user', userGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.user,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __tokenWithUserGraphQlType;
}

Map<String, GraphQLObjectType<ErrC>> _errCGraphQlType = {};

/// Auto-generated from [ErrC].
GraphQLObjectType<ErrC<T>> errCGraphQlType<T extends Object>(
  GraphQLType<T, Object> tGraphQlType,
) {
  final __name =
      'ErrC${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}';
  if (_errCGraphQlType[__name] != null)
    return _errCGraphQlType[__name]! as GraphQLObjectType<ErrC<T>>;

  final __errCGraphQlType = objectType<ErrC<T>>(
      'ErrC${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}',
      isInterface: false,
      interfaces: [],
      description: null);
  _errCGraphQlType[__name] = __errCGraphQlType;
  __errCGraphQlType.fields.addAll(
    [
      field('message', graphQLString,
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('value', tGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __errCGraphQlType;
}

/// Auto-generated from [SignUpError].
final GraphQLEnumType<SignUpError> signUpErrorGraphQlType =
    enumType('SignUpError', const {
  'nameTaken': SignUpError.nameTaken,
  'alreadySignedUp': SignUpError.alreadySignedUp,
  'unknown': SignUpError.unknown
});

/// Auto-generated from [SignInError].
final GraphQLEnumType<SignInError> signInErrorGraphQlType =
    enumType('SignInError', const {
  'wrong': SignInError.wrong,
  'unknown': SignInError.unknown,
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
