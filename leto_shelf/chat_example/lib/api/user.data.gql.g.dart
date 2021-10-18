// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GrefreshAuthTokenData> _$grefreshAuthTokenDataSerializer =
    new _$GrefreshAuthTokenDataSerializer();
Serializer<GsignInData> _$gsignInDataSerializer = new _$GsignInDataSerializer();
Serializer<GsignInData_signIn__base> _$gsignInDataSignInBaseSerializer =
    new _$GsignInData_signIn__baseSerializer();
Serializer<GsignInData_signIn__asErrCSignInError>
    _$gsignInDataSignInAsErrCSignInErrorSerializer =
    new _$GsignInData_signIn__asErrCSignInErrorSerializer();
Serializer<GsignInData_signIn__asTokenWithUser>
    _$gsignInDataSignInAsTokenWithUserSerializer =
    new _$GsignInData_signIn__asTokenWithUserSerializer();
Serializer<GsignInData_signIn__asTokenWithUser_user>
    _$gsignInDataSignInAsTokenWithUserUserSerializer =
    new _$GsignInData_signIn__asTokenWithUser_userSerializer();
Serializer<GsignUpData> _$gsignUpDataSerializer = new _$GsignUpDataSerializer();
Serializer<GsignUpData_signUp__base> _$gsignUpDataSignUpBaseSerializer =
    new _$GsignUpData_signUp__baseSerializer();
Serializer<GsignUpData_signUp__asErrCSignUpError>
    _$gsignUpDataSignUpAsErrCSignUpErrorSerializer =
    new _$GsignUpData_signUp__asErrCSignUpErrorSerializer();
Serializer<GsignUpData_signUp__asTokenWithUser>
    _$gsignUpDataSignUpAsTokenWithUserSerializer =
    new _$GsignUpData_signUp__asTokenWithUserSerializer();
Serializer<GsignUpData_signUp__asTokenWithUser_user>
    _$gsignUpDataSignUpAsTokenWithUserUserSerializer =
    new _$GsignUpData_signUp__asTokenWithUser_userSerializer();
Serializer<GsignOutData> _$gsignOutDataSerializer =
    new _$GsignOutDataSerializer();
Serializer<GAUserData> _$gAUserDataSerializer = new _$GAUserDataSerializer();
Serializer<GSTokenWithUserData> _$gSTokenWithUserDataSerializer =
    new _$GSTokenWithUserDataSerializer();
Serializer<GSTokenWithUserData_user> _$gSTokenWithUserDataUserSerializer =
    new _$GSTokenWithUserData_userSerializer();

class _$GrefreshAuthTokenDataSerializer
    implements StructuredSerializer<GrefreshAuthTokenData> {
  @override
  final Iterable<Type> types = const [
    GrefreshAuthTokenData,
    _$GrefreshAuthTokenData
  ];
  @override
  final String wireName = 'GrefreshAuthTokenData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GrefreshAuthTokenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.refreshAuthToken;
    if (value != null) {
      result
        ..add('refreshAuthToken')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GrefreshAuthTokenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GrefreshAuthTokenDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refreshAuthToken':
          result.refreshAuthToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignInDataSerializer implements StructuredSerializer<GsignInData> {
  @override
  final Iterable<Type> types = const [GsignInData, _$GsignInData];
  @override
  final String wireName = 'GsignInData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignInData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'signIn',
      serializers.serialize(object.signIn,
          specifiedType: const FullType(GsignInData_signIn)),
    ];

    return result;
  }

  @override
  GsignInData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'signIn':
          result.signIn = serializers.deserialize(value,
                  specifiedType: const FullType(GsignInData_signIn))
              as GsignInData_signIn;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignInData_signIn__baseSerializer
    implements StructuredSerializer<GsignInData_signIn__base> {
  @override
  final Iterable<Type> types = const [
    GsignInData_signIn__base,
    _$GsignInData_signIn__base
  ];
  @override
  final String wireName = 'GsignInData_signIn__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignInData_signIn__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsignInData_signIn__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInData_signIn__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignInData_signIn__asErrCSignInErrorSerializer
    implements StructuredSerializer<GsignInData_signIn__asErrCSignInError> {
  @override
  final Iterable<Type> types = const [
    GsignInData_signIn__asErrCSignInError,
    _$GsignInData_signIn__asErrCSignInError
  ];
  @override
  final String wireName = 'GsignInData_signIn__asErrCSignInError';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignInData_signIn__asErrCSignInError object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(_i3.GSignInError)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignInData_signIn__asErrCSignInError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInData_signIn__asErrCSignInErrorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GSignInError))
              as _i3.GSignInError;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignInData_signIn__asTokenWithUserSerializer
    implements StructuredSerializer<GsignInData_signIn__asTokenWithUser> {
  @override
  final Iterable<Type> types = const [
    GsignInData_signIn__asTokenWithUser,
    _$GsignInData_signIn__asTokenWithUser
  ];
  @override
  final String wireName = 'GsignInData_signIn__asTokenWithUser';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignInData_signIn__asTokenWithUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
      'accessToken',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'expiresInSecs',
      serializers.serialize(object.expiresInSecs,
          specifiedType: const FullType(int)),
      'user',
      serializers.serialize(object.user,
          specifiedType:
              const FullType(GsignInData_signIn__asTokenWithUser_user)),
    ];

    return result;
  }

  @override
  GsignInData_signIn__asTokenWithUser deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInData_signIn__asTokenWithUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expiresInSecs':
          result.expiresInSecs = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GsignInData_signIn__asTokenWithUser_user))!
              as GsignInData_signIn__asTokenWithUser_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GsignInData_signIn__asTokenWithUser_userSerializer
    implements StructuredSerializer<GsignInData_signIn__asTokenWithUser_user> {
  @override
  final Iterable<Type> types = const [
    GsignInData_signIn__asTokenWithUser_user,
    _$GsignInData_signIn__asTokenWithUser_user
  ];
  @override
  final String wireName = 'GsignInData_signIn__asTokenWithUser_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignInData_signIn__asTokenWithUser_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i3.GDate)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignInData_signIn__asTokenWithUser_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInData_signIn__asTokenWithUser_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i3.GDate))! as _i3.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpDataSerializer implements StructuredSerializer<GsignUpData> {
  @override
  final Iterable<Type> types = const [GsignUpData, _$GsignUpData];
  @override
  final String wireName = 'GsignUpData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignUpData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'signUp',
      serializers.serialize(object.signUp,
          specifiedType: const FullType(GsignUpData_signUp)),
    ];

    return result;
  }

  @override
  GsignUpData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'signUp':
          result.signUp = serializers.deserialize(value,
                  specifiedType: const FullType(GsignUpData_signUp))
              as GsignUpData_signUp;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpData_signUp__baseSerializer
    implements StructuredSerializer<GsignUpData_signUp__base> {
  @override
  final Iterable<Type> types = const [
    GsignUpData_signUp__base,
    _$GsignUpData_signUp__base
  ];
  @override
  final String wireName = 'GsignUpData_signUp__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignUpData_signUp__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsignUpData_signUp__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpData_signUp__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpData_signUp__asErrCSignUpErrorSerializer
    implements StructuredSerializer<GsignUpData_signUp__asErrCSignUpError> {
  @override
  final Iterable<Type> types = const [
    GsignUpData_signUp__asErrCSignUpError,
    _$GsignUpData_signUp__asErrCSignUpError
  ];
  @override
  final String wireName = 'GsignUpData_signUp__asErrCSignUpError';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignUpData_signUp__asErrCSignUpError object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(_i3.GSignUpError)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignUpData_signUp__asErrCSignUpError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpData_signUp__asErrCSignUpErrorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GSignUpError))
              as _i3.GSignUpError;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpData_signUp__asTokenWithUserSerializer
    implements StructuredSerializer<GsignUpData_signUp__asTokenWithUser> {
  @override
  final Iterable<Type> types = const [
    GsignUpData_signUp__asTokenWithUser,
    _$GsignUpData_signUp__asTokenWithUser
  ];
  @override
  final String wireName = 'GsignUpData_signUp__asTokenWithUser';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignUpData_signUp__asTokenWithUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
      'accessToken',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'expiresInSecs',
      serializers.serialize(object.expiresInSecs,
          specifiedType: const FullType(int)),
      'user',
      serializers.serialize(object.user,
          specifiedType:
              const FullType(GsignUpData_signUp__asTokenWithUser_user)),
    ];

    return result;
  }

  @override
  GsignUpData_signUp__asTokenWithUser deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpData_signUp__asTokenWithUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expiresInSecs':
          result.expiresInSecs = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GsignUpData_signUp__asTokenWithUser_user))!
              as GsignUpData_signUp__asTokenWithUser_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpData_signUp__asTokenWithUser_userSerializer
    implements StructuredSerializer<GsignUpData_signUp__asTokenWithUser_user> {
  @override
  final Iterable<Type> types = const [
    GsignUpData_signUp__asTokenWithUser_user,
    _$GsignUpData_signUp__asTokenWithUser_user
  ];
  @override
  final String wireName = 'GsignUpData_signUp__asTokenWithUser_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsignUpData_signUp__asTokenWithUser_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i3.GDate)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignUpData_signUp__asTokenWithUser_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpData_signUp__asTokenWithUser_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i3.GDate))! as _i3.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GsignOutDataSerializer implements StructuredSerializer<GsignOutData> {
  @override
  final Iterable<Type> types = const [GsignOutData, _$GsignOutData];
  @override
  final String wireName = 'GsignOutData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignOutData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.signOut;
    if (value != null) {
      result
        ..add('signOut')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignOutData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignOutDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'signOut':
          result.signOut = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAUserDataSerializer implements StructuredSerializer<GAUserData> {
  @override
  final Iterable<Type> types = const [GAUserData, _$GAUserData];
  @override
  final String wireName = 'GAUserData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i3.GDate)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAUserData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAUserDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i3.GDate))! as _i3.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GSTokenWithUserDataSerializer
    implements StructuredSerializer<GSTokenWithUserData> {
  @override
  final Iterable<Type> types = const [
    GSTokenWithUserData,
    _$GSTokenWithUserData
  ];
  @override
  final String wireName = 'GSTokenWithUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSTokenWithUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
      'accessToken',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'expiresInSecs',
      serializers.serialize(object.expiresInSecs,
          specifiedType: const FullType(int)),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(GSTokenWithUserData_user)),
    ];

    return result;
  }

  @override
  GSTokenWithUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSTokenWithUserDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expiresInSecs':
          result.expiresInSecs = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GSTokenWithUserData_user))!
              as GSTokenWithUserData_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GSTokenWithUserData_userSerializer
    implements StructuredSerializer<GSTokenWithUserData_user> {
  @override
  final Iterable<Type> types = const [
    GSTokenWithUserData_user,
    _$GSTokenWithUserData_user
  ];
  @override
  final String wireName = 'GSTokenWithUserData_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSTokenWithUserData_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i3.GDate)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSTokenWithUserData_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSTokenWithUserData_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i3.GDate))! as _i3.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GrefreshAuthTokenData extends GrefreshAuthTokenData {
  @override
  final String G__typename;
  @override
  final String? refreshAuthToken;

  factory _$GrefreshAuthTokenData(
          [void Function(GrefreshAuthTokenDataBuilder)? updates]) =>
      (new GrefreshAuthTokenDataBuilder()..update(updates)).build();

  _$GrefreshAuthTokenData._({required this.G__typename, this.refreshAuthToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GrefreshAuthTokenData', 'G__typename');
  }

  @override
  GrefreshAuthTokenData rebuild(
          void Function(GrefreshAuthTokenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GrefreshAuthTokenDataBuilder toBuilder() =>
      new GrefreshAuthTokenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GrefreshAuthTokenData &&
        G__typename == other.G__typename &&
        refreshAuthToken == other.refreshAuthToken;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), refreshAuthToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GrefreshAuthTokenData')
          ..add('G__typename', G__typename)
          ..add('refreshAuthToken', refreshAuthToken))
        .toString();
  }
}

class GrefreshAuthTokenDataBuilder
    implements Builder<GrefreshAuthTokenData, GrefreshAuthTokenDataBuilder> {
  _$GrefreshAuthTokenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _refreshAuthToken;
  String? get refreshAuthToken => _$this._refreshAuthToken;
  set refreshAuthToken(String? refreshAuthToken) =>
      _$this._refreshAuthToken = refreshAuthToken;

  GrefreshAuthTokenDataBuilder() {
    GrefreshAuthTokenData._initializeBuilder(this);
  }

  GrefreshAuthTokenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshAuthToken = $v.refreshAuthToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GrefreshAuthTokenData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GrefreshAuthTokenData;
  }

  @override
  void update(void Function(GrefreshAuthTokenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GrefreshAuthTokenData build() {
    final _$result = _$v ??
        new _$GrefreshAuthTokenData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GrefreshAuthTokenData', 'G__typename'),
            refreshAuthToken: refreshAuthToken);
    replace(_$result);
    return _$result;
  }
}

class _$GsignInData extends GsignInData {
  @override
  final String G__typename;
  @override
  final GsignInData_signIn signIn;

  factory _$GsignInData([void Function(GsignInDataBuilder)? updates]) =>
      (new GsignInDataBuilder()..update(updates)).build();

  _$GsignInData._({required this.G__typename, required this.signIn})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignInData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(signIn, 'GsignInData', 'signIn');
  }

  @override
  GsignInData rebuild(void Function(GsignInDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInDataBuilder toBuilder() => new GsignInDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInData &&
        G__typename == other.G__typename &&
        signIn == other.signIn;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), signIn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignInData')
          ..add('G__typename', G__typename)
          ..add('signIn', signIn))
        .toString();
  }
}

class GsignInDataBuilder implements Builder<GsignInData, GsignInDataBuilder> {
  _$GsignInData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsignInData_signIn? _signIn;
  GsignInData_signIn? get signIn => _$this._signIn;
  set signIn(GsignInData_signIn? signIn) => _$this._signIn = signIn;

  GsignInDataBuilder() {
    GsignInData._initializeBuilder(this);
  }

  GsignInDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _signIn = $v.signIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInData;
  }

  @override
  void update(void Function(GsignInDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInData build() {
    final _$result = _$v ??
        new _$GsignInData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsignInData', 'G__typename'),
            signIn: BuiltValueNullFieldError.checkNotNull(
                signIn, 'GsignInData', 'signIn'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignInData_signIn__base extends GsignInData_signIn__base {
  @override
  final String G__typename;

  factory _$GsignInData_signIn__base(
          [void Function(GsignInData_signIn__baseBuilder)? updates]) =>
      (new GsignInData_signIn__baseBuilder()..update(updates)).build();

  _$GsignInData_signIn__base._({required this.G__typename}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignInData_signIn__base', 'G__typename');
  }

  @override
  GsignInData_signIn__base rebuild(
          void Function(GsignInData_signIn__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInData_signIn__baseBuilder toBuilder() =>
      new GsignInData_signIn__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInData_signIn__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    return $jf($jc(0, G__typename.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignInData_signIn__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GsignInData_signIn__baseBuilder
    implements
        Builder<GsignInData_signIn__base, GsignInData_signIn__baseBuilder> {
  _$GsignInData_signIn__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsignInData_signIn__baseBuilder() {
    GsignInData_signIn__base._initializeBuilder(this);
  }

  GsignInData_signIn__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInData_signIn__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInData_signIn__base;
  }

  @override
  void update(void Function(GsignInData_signIn__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInData_signIn__base build() {
    final _$result = _$v ??
        new _$GsignInData_signIn__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsignInData_signIn__base', 'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignInData_signIn__asErrCSignInError
    extends GsignInData_signIn__asErrCSignInError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final _i3.GSignInError value;

  factory _$GsignInData_signIn__asErrCSignInError(
          [void Function(GsignInData_signIn__asErrCSignInErrorBuilder)?
              updates]) =>
      (new GsignInData_signIn__asErrCSignInErrorBuilder()..update(updates))
          .build();

  _$GsignInData_signIn__asErrCSignInError._(
      {required this.G__typename, this.message, required this.value})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignInData_signIn__asErrCSignInError', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        value, 'GsignInData_signIn__asErrCSignInError', 'value');
  }

  @override
  GsignInData_signIn__asErrCSignInError rebuild(
          void Function(GsignInData_signIn__asErrCSignInErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInData_signIn__asErrCSignInErrorBuilder toBuilder() =>
      new GsignInData_signIn__asErrCSignInErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInData_signIn__asErrCSignInError &&
        G__typename == other.G__typename &&
        message == other.message &&
        value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, G__typename.hashCode), message.hashCode), value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignInData_signIn__asErrCSignInError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('value', value))
        .toString();
  }
}

class GsignInData_signIn__asErrCSignInErrorBuilder
    implements
        Builder<GsignInData_signIn__asErrCSignInError,
            GsignInData_signIn__asErrCSignInErrorBuilder> {
  _$GsignInData_signIn__asErrCSignInError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i3.GSignInError? _value;
  _i3.GSignInError? get value => _$this._value;
  set value(_i3.GSignInError? value) => _$this._value = value;

  GsignInData_signIn__asErrCSignInErrorBuilder() {
    GsignInData_signIn__asErrCSignInError._initializeBuilder(this);
  }

  GsignInData_signIn__asErrCSignInErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInData_signIn__asErrCSignInError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInData_signIn__asErrCSignInError;
  }

  @override
  void update(
      void Function(GsignInData_signIn__asErrCSignInErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInData_signIn__asErrCSignInError build() {
    final _$result = _$v ??
        new _$GsignInData_signIn__asErrCSignInError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                'GsignInData_signIn__asErrCSignInError', 'G__typename'),
            message: message,
            value: BuiltValueNullFieldError.checkNotNull(
                value, 'GsignInData_signIn__asErrCSignInError', 'value'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignInData_signIn__asTokenWithUser
    extends GsignInData_signIn__asTokenWithUser {
  @override
  final String G__typename;
  @override
  final String refreshToken;
  @override
  final String accessToken;
  @override
  final int expiresInSecs;
  @override
  final GsignInData_signIn__asTokenWithUser_user user;

  factory _$GsignInData_signIn__asTokenWithUser(
          [void Function(GsignInData_signIn__asTokenWithUserBuilder)?
              updates]) =>
      (new GsignInData_signIn__asTokenWithUserBuilder()..update(updates))
          .build();

  _$GsignInData_signIn__asTokenWithUser._(
      {required this.G__typename,
      required this.refreshToken,
      required this.accessToken,
      required this.expiresInSecs,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignInData_signIn__asTokenWithUser', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, 'GsignInData_signIn__asTokenWithUser', 'refreshToken');
    BuiltValueNullFieldError.checkNotNull(
        accessToken, 'GsignInData_signIn__asTokenWithUser', 'accessToken');
    BuiltValueNullFieldError.checkNotNull(
        expiresInSecs, 'GsignInData_signIn__asTokenWithUser', 'expiresInSecs');
    BuiltValueNullFieldError.checkNotNull(
        user, 'GsignInData_signIn__asTokenWithUser', 'user');
  }

  @override
  GsignInData_signIn__asTokenWithUser rebuild(
          void Function(GsignInData_signIn__asTokenWithUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInData_signIn__asTokenWithUserBuilder toBuilder() =>
      new GsignInData_signIn__asTokenWithUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInData_signIn__asTokenWithUser &&
        G__typename == other.G__typename &&
        refreshToken == other.refreshToken &&
        accessToken == other.accessToken &&
        expiresInSecs == other.expiresInSecs &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), refreshToken.hashCode),
                accessToken.hashCode),
            expiresInSecs.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignInData_signIn__asTokenWithUser')
          ..add('G__typename', G__typename)
          ..add('refreshToken', refreshToken)
          ..add('accessToken', accessToken)
          ..add('expiresInSecs', expiresInSecs)
          ..add('user', user))
        .toString();
  }
}

class GsignInData_signIn__asTokenWithUserBuilder
    implements
        Builder<GsignInData_signIn__asTokenWithUser,
            GsignInData_signIn__asTokenWithUserBuilder> {
  _$GsignInData_signIn__asTokenWithUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  int? _expiresInSecs;
  int? get expiresInSecs => _$this._expiresInSecs;
  set expiresInSecs(int? expiresInSecs) =>
      _$this._expiresInSecs = expiresInSecs;

  GsignInData_signIn__asTokenWithUser_userBuilder? _user;
  GsignInData_signIn__asTokenWithUser_userBuilder get user =>
      _$this._user ??= new GsignInData_signIn__asTokenWithUser_userBuilder();
  set user(GsignInData_signIn__asTokenWithUser_userBuilder? user) =>
      _$this._user = user;

  GsignInData_signIn__asTokenWithUserBuilder() {
    GsignInData_signIn__asTokenWithUser._initializeBuilder(this);
  }

  GsignInData_signIn__asTokenWithUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshToken = $v.refreshToken;
      _accessToken = $v.accessToken;
      _expiresInSecs = $v.expiresInSecs;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInData_signIn__asTokenWithUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInData_signIn__asTokenWithUser;
  }

  @override
  void update(
      void Function(GsignInData_signIn__asTokenWithUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInData_signIn__asTokenWithUser build() {
    _$GsignInData_signIn__asTokenWithUser _$result;
    try {
      _$result = _$v ??
          new _$GsignInData_signIn__asTokenWithUser._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GsignInData_signIn__asTokenWithUser', 'G__typename'),
              refreshToken: BuiltValueNullFieldError.checkNotNull(refreshToken,
                  'GsignInData_signIn__asTokenWithUser', 'refreshToken'),
              accessToken: BuiltValueNullFieldError.checkNotNull(accessToken,
                  'GsignInData_signIn__asTokenWithUser', 'accessToken'),
              expiresInSecs: BuiltValueNullFieldError.checkNotNull(
                  expiresInSecs,
                  'GsignInData_signIn__asTokenWithUser',
                  'expiresInSecs'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsignInData_signIn__asTokenWithUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsignInData_signIn__asTokenWithUser_user
    extends GsignInData_signIn__asTokenWithUser_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;
  @override
  final _i3.GDate createdAt;

  factory _$GsignInData_signIn__asTokenWithUser_user(
          [void Function(GsignInData_signIn__asTokenWithUser_userBuilder)?
              updates]) =>
      (new GsignInData_signIn__asTokenWithUser_userBuilder()..update(updates))
          .build();

  _$GsignInData_signIn__asTokenWithUser_user._(
      {required this.G__typename,
      required this.id,
      this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignInData_signIn__asTokenWithUser_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GsignInData_signIn__asTokenWithUser_user', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GsignInData_signIn__asTokenWithUser_user', 'createdAt');
  }

  @override
  GsignInData_signIn__asTokenWithUser_user rebuild(
          void Function(GsignInData_signIn__asTokenWithUser_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInData_signIn__asTokenWithUser_userBuilder toBuilder() =>
      new GsignInData_signIn__asTokenWithUser_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInData_signIn__asTokenWithUser_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GsignInData_signIn__asTokenWithUser_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GsignInData_signIn__asTokenWithUser_userBuilder
    implements
        Builder<GsignInData_signIn__asTokenWithUser_user,
            GsignInData_signIn__asTokenWithUser_userBuilder> {
  _$GsignInData_signIn__asTokenWithUser_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i3.GDateBuilder? _createdAt;
  _i3.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i3.GDateBuilder();
  set createdAt(_i3.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GsignInData_signIn__asTokenWithUser_userBuilder() {
    GsignInData_signIn__asTokenWithUser_user._initializeBuilder(this);
  }

  GsignInData_signIn__asTokenWithUser_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInData_signIn__asTokenWithUser_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInData_signIn__asTokenWithUser_user;
  }

  @override
  void update(
      void Function(GsignInData_signIn__asTokenWithUser_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInData_signIn__asTokenWithUser_user build() {
    _$GsignInData_signIn__asTokenWithUser_user _$result;
    try {
      _$result = _$v ??
          new _$GsignInData_signIn__asTokenWithUser_user._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GsignInData_signIn__asTokenWithUser_user', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GsignInData_signIn__asTokenWithUser_user', 'id'),
              name: name,
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsignInData_signIn__asTokenWithUser_user',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpData extends GsignUpData {
  @override
  final String G__typename;
  @override
  final GsignUpData_signUp signUp;

  factory _$GsignUpData([void Function(GsignUpDataBuilder)? updates]) =>
      (new GsignUpDataBuilder()..update(updates)).build();

  _$GsignUpData._({required this.G__typename, required this.signUp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignUpData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(signUp, 'GsignUpData', 'signUp');
  }

  @override
  GsignUpData rebuild(void Function(GsignUpDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpDataBuilder toBuilder() => new GsignUpDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpData &&
        G__typename == other.G__typename &&
        signUp == other.signUp;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), signUp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignUpData')
          ..add('G__typename', G__typename)
          ..add('signUp', signUp))
        .toString();
  }
}

class GsignUpDataBuilder implements Builder<GsignUpData, GsignUpDataBuilder> {
  _$GsignUpData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsignUpData_signUp? _signUp;
  GsignUpData_signUp? get signUp => _$this._signUp;
  set signUp(GsignUpData_signUp? signUp) => _$this._signUp = signUp;

  GsignUpDataBuilder() {
    GsignUpData._initializeBuilder(this);
  }

  GsignUpDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _signUp = $v.signUp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpData;
  }

  @override
  void update(void Function(GsignUpDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpData build() {
    final _$result = _$v ??
        new _$GsignUpData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsignUpData', 'G__typename'),
            signUp: BuiltValueNullFieldError.checkNotNull(
                signUp, 'GsignUpData', 'signUp'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpData_signUp__base extends GsignUpData_signUp__base {
  @override
  final String G__typename;

  factory _$GsignUpData_signUp__base(
          [void Function(GsignUpData_signUp__baseBuilder)? updates]) =>
      (new GsignUpData_signUp__baseBuilder()..update(updates)).build();

  _$GsignUpData_signUp__base._({required this.G__typename}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignUpData_signUp__base', 'G__typename');
  }

  @override
  GsignUpData_signUp__base rebuild(
          void Function(GsignUpData_signUp__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpData_signUp__baseBuilder toBuilder() =>
      new GsignUpData_signUp__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpData_signUp__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    return $jf($jc(0, G__typename.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignUpData_signUp__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GsignUpData_signUp__baseBuilder
    implements
        Builder<GsignUpData_signUp__base, GsignUpData_signUp__baseBuilder> {
  _$GsignUpData_signUp__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsignUpData_signUp__baseBuilder() {
    GsignUpData_signUp__base._initializeBuilder(this);
  }

  GsignUpData_signUp__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpData_signUp__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpData_signUp__base;
  }

  @override
  void update(void Function(GsignUpData_signUp__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpData_signUp__base build() {
    final _$result = _$v ??
        new _$GsignUpData_signUp__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsignUpData_signUp__base', 'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpData_signUp__asErrCSignUpError
    extends GsignUpData_signUp__asErrCSignUpError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final _i3.GSignUpError value;

  factory _$GsignUpData_signUp__asErrCSignUpError(
          [void Function(GsignUpData_signUp__asErrCSignUpErrorBuilder)?
              updates]) =>
      (new GsignUpData_signUp__asErrCSignUpErrorBuilder()..update(updates))
          .build();

  _$GsignUpData_signUp__asErrCSignUpError._(
      {required this.G__typename, this.message, required this.value})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignUpData_signUp__asErrCSignUpError', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        value, 'GsignUpData_signUp__asErrCSignUpError', 'value');
  }

  @override
  GsignUpData_signUp__asErrCSignUpError rebuild(
          void Function(GsignUpData_signUp__asErrCSignUpErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpData_signUp__asErrCSignUpErrorBuilder toBuilder() =>
      new GsignUpData_signUp__asErrCSignUpErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpData_signUp__asErrCSignUpError &&
        G__typename == other.G__typename &&
        message == other.message &&
        value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, G__typename.hashCode), message.hashCode), value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignUpData_signUp__asErrCSignUpError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('value', value))
        .toString();
  }
}

class GsignUpData_signUp__asErrCSignUpErrorBuilder
    implements
        Builder<GsignUpData_signUp__asErrCSignUpError,
            GsignUpData_signUp__asErrCSignUpErrorBuilder> {
  _$GsignUpData_signUp__asErrCSignUpError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i3.GSignUpError? _value;
  _i3.GSignUpError? get value => _$this._value;
  set value(_i3.GSignUpError? value) => _$this._value = value;

  GsignUpData_signUp__asErrCSignUpErrorBuilder() {
    GsignUpData_signUp__asErrCSignUpError._initializeBuilder(this);
  }

  GsignUpData_signUp__asErrCSignUpErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpData_signUp__asErrCSignUpError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpData_signUp__asErrCSignUpError;
  }

  @override
  void update(
      void Function(GsignUpData_signUp__asErrCSignUpErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpData_signUp__asErrCSignUpError build() {
    final _$result = _$v ??
        new _$GsignUpData_signUp__asErrCSignUpError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                'GsignUpData_signUp__asErrCSignUpError', 'G__typename'),
            message: message,
            value: BuiltValueNullFieldError.checkNotNull(
                value, 'GsignUpData_signUp__asErrCSignUpError', 'value'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpData_signUp__asTokenWithUser
    extends GsignUpData_signUp__asTokenWithUser {
  @override
  final String G__typename;
  @override
  final String refreshToken;
  @override
  final String accessToken;
  @override
  final int expiresInSecs;
  @override
  final GsignUpData_signUp__asTokenWithUser_user user;

  factory _$GsignUpData_signUp__asTokenWithUser(
          [void Function(GsignUpData_signUp__asTokenWithUserBuilder)?
              updates]) =>
      (new GsignUpData_signUp__asTokenWithUserBuilder()..update(updates))
          .build();

  _$GsignUpData_signUp__asTokenWithUser._(
      {required this.G__typename,
      required this.refreshToken,
      required this.accessToken,
      required this.expiresInSecs,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignUpData_signUp__asTokenWithUser', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, 'GsignUpData_signUp__asTokenWithUser', 'refreshToken');
    BuiltValueNullFieldError.checkNotNull(
        accessToken, 'GsignUpData_signUp__asTokenWithUser', 'accessToken');
    BuiltValueNullFieldError.checkNotNull(
        expiresInSecs, 'GsignUpData_signUp__asTokenWithUser', 'expiresInSecs');
    BuiltValueNullFieldError.checkNotNull(
        user, 'GsignUpData_signUp__asTokenWithUser', 'user');
  }

  @override
  GsignUpData_signUp__asTokenWithUser rebuild(
          void Function(GsignUpData_signUp__asTokenWithUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpData_signUp__asTokenWithUserBuilder toBuilder() =>
      new GsignUpData_signUp__asTokenWithUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpData_signUp__asTokenWithUser &&
        G__typename == other.G__typename &&
        refreshToken == other.refreshToken &&
        accessToken == other.accessToken &&
        expiresInSecs == other.expiresInSecs &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), refreshToken.hashCode),
                accessToken.hashCode),
            expiresInSecs.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignUpData_signUp__asTokenWithUser')
          ..add('G__typename', G__typename)
          ..add('refreshToken', refreshToken)
          ..add('accessToken', accessToken)
          ..add('expiresInSecs', expiresInSecs)
          ..add('user', user))
        .toString();
  }
}

class GsignUpData_signUp__asTokenWithUserBuilder
    implements
        Builder<GsignUpData_signUp__asTokenWithUser,
            GsignUpData_signUp__asTokenWithUserBuilder> {
  _$GsignUpData_signUp__asTokenWithUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  int? _expiresInSecs;
  int? get expiresInSecs => _$this._expiresInSecs;
  set expiresInSecs(int? expiresInSecs) =>
      _$this._expiresInSecs = expiresInSecs;

  GsignUpData_signUp__asTokenWithUser_userBuilder? _user;
  GsignUpData_signUp__asTokenWithUser_userBuilder get user =>
      _$this._user ??= new GsignUpData_signUp__asTokenWithUser_userBuilder();
  set user(GsignUpData_signUp__asTokenWithUser_userBuilder? user) =>
      _$this._user = user;

  GsignUpData_signUp__asTokenWithUserBuilder() {
    GsignUpData_signUp__asTokenWithUser._initializeBuilder(this);
  }

  GsignUpData_signUp__asTokenWithUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshToken = $v.refreshToken;
      _accessToken = $v.accessToken;
      _expiresInSecs = $v.expiresInSecs;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpData_signUp__asTokenWithUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpData_signUp__asTokenWithUser;
  }

  @override
  void update(
      void Function(GsignUpData_signUp__asTokenWithUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpData_signUp__asTokenWithUser build() {
    _$GsignUpData_signUp__asTokenWithUser _$result;
    try {
      _$result = _$v ??
          new _$GsignUpData_signUp__asTokenWithUser._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GsignUpData_signUp__asTokenWithUser', 'G__typename'),
              refreshToken: BuiltValueNullFieldError.checkNotNull(refreshToken,
                  'GsignUpData_signUp__asTokenWithUser', 'refreshToken'),
              accessToken: BuiltValueNullFieldError.checkNotNull(accessToken,
                  'GsignUpData_signUp__asTokenWithUser', 'accessToken'),
              expiresInSecs: BuiltValueNullFieldError.checkNotNull(
                  expiresInSecs,
                  'GsignUpData_signUp__asTokenWithUser',
                  'expiresInSecs'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsignUpData_signUp__asTokenWithUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpData_signUp__asTokenWithUser_user
    extends GsignUpData_signUp__asTokenWithUser_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;
  @override
  final _i3.GDate createdAt;

  factory _$GsignUpData_signUp__asTokenWithUser_user(
          [void Function(GsignUpData_signUp__asTokenWithUser_userBuilder)?
              updates]) =>
      (new GsignUpData_signUp__asTokenWithUser_userBuilder()..update(updates))
          .build();

  _$GsignUpData_signUp__asTokenWithUser_user._(
      {required this.G__typename,
      required this.id,
      this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignUpData_signUp__asTokenWithUser_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GsignUpData_signUp__asTokenWithUser_user', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GsignUpData_signUp__asTokenWithUser_user', 'createdAt');
  }

  @override
  GsignUpData_signUp__asTokenWithUser_user rebuild(
          void Function(GsignUpData_signUp__asTokenWithUser_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpData_signUp__asTokenWithUser_userBuilder toBuilder() =>
      new GsignUpData_signUp__asTokenWithUser_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpData_signUp__asTokenWithUser_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GsignUpData_signUp__asTokenWithUser_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GsignUpData_signUp__asTokenWithUser_userBuilder
    implements
        Builder<GsignUpData_signUp__asTokenWithUser_user,
            GsignUpData_signUp__asTokenWithUser_userBuilder> {
  _$GsignUpData_signUp__asTokenWithUser_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i3.GDateBuilder? _createdAt;
  _i3.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i3.GDateBuilder();
  set createdAt(_i3.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GsignUpData_signUp__asTokenWithUser_userBuilder() {
    GsignUpData_signUp__asTokenWithUser_user._initializeBuilder(this);
  }

  GsignUpData_signUp__asTokenWithUser_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpData_signUp__asTokenWithUser_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpData_signUp__asTokenWithUser_user;
  }

  @override
  void update(
      void Function(GsignUpData_signUp__asTokenWithUser_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpData_signUp__asTokenWithUser_user build() {
    _$GsignUpData_signUp__asTokenWithUser_user _$result;
    try {
      _$result = _$v ??
          new _$GsignUpData_signUp__asTokenWithUser_user._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GsignUpData_signUp__asTokenWithUser_user', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GsignUpData_signUp__asTokenWithUser_user', 'id'),
              name: name,
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsignUpData_signUp__asTokenWithUser_user',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsignOutData extends GsignOutData {
  @override
  final String G__typename;
  @override
  final String? signOut;

  factory _$GsignOutData([void Function(GsignOutDataBuilder)? updates]) =>
      (new GsignOutDataBuilder()..update(updates)).build();

  _$GsignOutData._({required this.G__typename, this.signOut}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsignOutData', 'G__typename');
  }

  @override
  GsignOutData rebuild(void Function(GsignOutDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignOutDataBuilder toBuilder() => new GsignOutDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignOutData &&
        G__typename == other.G__typename &&
        signOut == other.signOut;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), signOut.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignOutData')
          ..add('G__typename', G__typename)
          ..add('signOut', signOut))
        .toString();
  }
}

class GsignOutDataBuilder
    implements Builder<GsignOutData, GsignOutDataBuilder> {
  _$GsignOutData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _signOut;
  String? get signOut => _$this._signOut;
  set signOut(String? signOut) => _$this._signOut = signOut;

  GsignOutDataBuilder() {
    GsignOutData._initializeBuilder(this);
  }

  GsignOutDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _signOut = $v.signOut;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignOutData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignOutData;
  }

  @override
  void update(void Function(GsignOutDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignOutData build() {
    final _$result = _$v ??
        new _$GsignOutData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsignOutData', 'G__typename'),
            signOut: signOut);
    replace(_$result);
    return _$result;
  }
}

class _$GAUserData extends GAUserData {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;
  @override
  final _i3.GDate createdAt;

  factory _$GAUserData([void Function(GAUserDataBuilder)? updates]) =>
      (new GAUserDataBuilder()..update(updates)).build();

  _$GAUserData._(
      {required this.G__typename,
      required this.id,
      this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GAUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GAUserData', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, 'GAUserData', 'createdAt');
  }

  @override
  GAUserData rebuild(void Function(GAUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAUserDataBuilder toBuilder() => new GAUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAUserData &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GAUserData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GAUserDataBuilder implements Builder<GAUserData, GAUserDataBuilder> {
  _$GAUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i3.GDateBuilder? _createdAt;
  _i3.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i3.GDateBuilder();
  set createdAt(_i3.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GAUserDataBuilder() {
    GAUserData._initializeBuilder(this);
  }

  GAUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAUserData;
  }

  @override
  void update(void Function(GAUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GAUserData build() {
    _$GAUserData _$result;
    try {
      _$result = _$v ??
          new _$GAUserData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GAUserData', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(id, 'GAUserData', 'id'),
              name: name,
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GAUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSTokenWithUserData extends GSTokenWithUserData {
  @override
  final String G__typename;
  @override
  final String refreshToken;
  @override
  final String accessToken;
  @override
  final int expiresInSecs;
  @override
  final GSTokenWithUserData_user user;

  factory _$GSTokenWithUserData(
          [void Function(GSTokenWithUserDataBuilder)? updates]) =>
      (new GSTokenWithUserDataBuilder()..update(updates)).build();

  _$GSTokenWithUserData._(
      {required this.G__typename,
      required this.refreshToken,
      required this.accessToken,
      required this.expiresInSecs,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GSTokenWithUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, 'GSTokenWithUserData', 'refreshToken');
    BuiltValueNullFieldError.checkNotNull(
        accessToken, 'GSTokenWithUserData', 'accessToken');
    BuiltValueNullFieldError.checkNotNull(
        expiresInSecs, 'GSTokenWithUserData', 'expiresInSecs');
    BuiltValueNullFieldError.checkNotNull(user, 'GSTokenWithUserData', 'user');
  }

  @override
  GSTokenWithUserData rebuild(
          void Function(GSTokenWithUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSTokenWithUserDataBuilder toBuilder() =>
      new GSTokenWithUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSTokenWithUserData &&
        G__typename == other.G__typename &&
        refreshToken == other.refreshToken &&
        accessToken == other.accessToken &&
        expiresInSecs == other.expiresInSecs &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), refreshToken.hashCode),
                accessToken.hashCode),
            expiresInSecs.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GSTokenWithUserData')
          ..add('G__typename', G__typename)
          ..add('refreshToken', refreshToken)
          ..add('accessToken', accessToken)
          ..add('expiresInSecs', expiresInSecs)
          ..add('user', user))
        .toString();
  }
}

class GSTokenWithUserDataBuilder
    implements Builder<GSTokenWithUserData, GSTokenWithUserDataBuilder> {
  _$GSTokenWithUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  int? _expiresInSecs;
  int? get expiresInSecs => _$this._expiresInSecs;
  set expiresInSecs(int? expiresInSecs) =>
      _$this._expiresInSecs = expiresInSecs;

  GSTokenWithUserData_userBuilder? _user;
  GSTokenWithUserData_userBuilder get user =>
      _$this._user ??= new GSTokenWithUserData_userBuilder();
  set user(GSTokenWithUserData_userBuilder? user) => _$this._user = user;

  GSTokenWithUserDataBuilder() {
    GSTokenWithUserData._initializeBuilder(this);
  }

  GSTokenWithUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshToken = $v.refreshToken;
      _accessToken = $v.accessToken;
      _expiresInSecs = $v.expiresInSecs;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSTokenWithUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSTokenWithUserData;
  }

  @override
  void update(void Function(GSTokenWithUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GSTokenWithUserData build() {
    _$GSTokenWithUserData _$result;
    try {
      _$result = _$v ??
          new _$GSTokenWithUserData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GSTokenWithUserData', 'G__typename'),
              refreshToken: BuiltValueNullFieldError.checkNotNull(
                  refreshToken, 'GSTokenWithUserData', 'refreshToken'),
              accessToken: BuiltValueNullFieldError.checkNotNull(
                  accessToken, 'GSTokenWithUserData', 'accessToken'),
              expiresInSecs: BuiltValueNullFieldError.checkNotNull(
                  expiresInSecs, 'GSTokenWithUserData', 'expiresInSecs'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GSTokenWithUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSTokenWithUserData_user extends GSTokenWithUserData_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;
  @override
  final _i3.GDate createdAt;

  factory _$GSTokenWithUserData_user(
          [void Function(GSTokenWithUserData_userBuilder)? updates]) =>
      (new GSTokenWithUserData_userBuilder()..update(updates)).build();

  _$GSTokenWithUserData_user._(
      {required this.G__typename,
      required this.id,
      this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GSTokenWithUserData_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GSTokenWithUserData_user', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GSTokenWithUserData_user', 'createdAt');
  }

  @override
  GSTokenWithUserData_user rebuild(
          void Function(GSTokenWithUserData_userBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSTokenWithUserData_userBuilder toBuilder() =>
      new GSTokenWithUserData_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSTokenWithUserData_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GSTokenWithUserData_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GSTokenWithUserData_userBuilder
    implements
        Builder<GSTokenWithUserData_user, GSTokenWithUserData_userBuilder> {
  _$GSTokenWithUserData_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i3.GDateBuilder? _createdAt;
  _i3.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i3.GDateBuilder();
  set createdAt(_i3.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GSTokenWithUserData_userBuilder() {
    GSTokenWithUserData_user._initializeBuilder(this);
  }

  GSTokenWithUserData_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSTokenWithUserData_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSTokenWithUserData_user;
  }

  @override
  void update(void Function(GSTokenWithUserData_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GSTokenWithUserData_user build() {
    _$GSTokenWithUserData_user _$result;
    try {
      _$result = _$v ??
          new _$GSTokenWithUserData_user._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GSTokenWithUserData_user', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GSTokenWithUserData_user', 'id'),
              name: name,
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GSTokenWithUserData_user', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
