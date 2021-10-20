// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api_schema.schema.gql.dart' as _i3;
import 'package:chat_example/serializers.gql.dart' as _i1;
import 'package:gql_code_builder/src/serializers/inline_fragment_serializer.dart'
    as _i2;

part 'user.data.gql.g.dart';

abstract class GrefreshAuthTokenData
    implements Built<GrefreshAuthTokenData, GrefreshAuthTokenDataBuilder> {
  GrefreshAuthTokenData._();

  factory GrefreshAuthTokenData(
          [Function(GrefreshAuthTokenDataBuilder b) updates]) =
      _$GrefreshAuthTokenData;

  static void _initializeBuilder(GrefreshAuthTokenDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get refreshAuthToken;
  static Serializer<GrefreshAuthTokenData> get serializer =>
      _$grefreshAuthTokenDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GrefreshAuthTokenData.serializer, this)
          as Map<String, dynamic>);
  static GrefreshAuthTokenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GrefreshAuthTokenData.serializer, json);
}

abstract class GsignInData implements Built<GsignInData, GsignInDataBuilder> {
  GsignInData._();

  factory GsignInData([Function(GsignInDataBuilder b) updates]) = _$GsignInData;

  static void _initializeBuilder(GsignInDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GsignInData_signIn get signIn;
  static Serializer<GsignInData> get serializer => _$gsignInDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignInData.serializer, this)
          as Map<String, dynamic>);
  static GsignInData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignInData.serializer, json);
}

abstract class GsignInData_signIn {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GsignInData_signIn> get serializer =>
      _i2.InlineFragmentSerializer<GsignInData_signIn>(
          'GsignInData_signIn', GsignInData_signIn__base, [
        GsignInData_signIn__asErrCSignInError,
        GsignInData_signIn__asTokenWithUser
      ]);
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignInData_signIn.serializer, this)
          as Map<String, dynamic>);
  static GsignInData_signIn? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignInData_signIn.serializer, json);
}

abstract class GsignInData_signIn__base
    implements
        Built<GsignInData_signIn__base, GsignInData_signIn__baseBuilder>,
        GsignInData_signIn {
  GsignInData_signIn__base._();

  factory GsignInData_signIn__base(
          [Function(GsignInData_signIn__baseBuilder b) updates]) =
      _$GsignInData_signIn__base;

  static void _initializeBuilder(GsignInData_signIn__baseBuilder b) =>
      b..G__typename = 'ResultTokenWithUserErrCSignInError';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GsignInData_signIn__base> get serializer =>
      _$gsignInDataSignInBaseSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignInData_signIn__base.serializer, this)
          as Map<String, dynamic>);
  static GsignInData_signIn__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GsignInData_signIn__base.serializer, json);
}

abstract class GsignInData_signIn__asErrCSignInError
    implements
        Built<GsignInData_signIn__asErrCSignInError,
            GsignInData_signIn__asErrCSignInErrorBuilder>,
        GsignInData_signIn {
  GsignInData_signIn__asErrCSignInError._();

  factory GsignInData_signIn__asErrCSignInError(
          [Function(GsignInData_signIn__asErrCSignInErrorBuilder b) updates]) =
      _$GsignInData_signIn__asErrCSignInError;

  static void _initializeBuilder(
          GsignInData_signIn__asErrCSignInErrorBuilder b) =>
      b..G__typename = 'ErrCSignInError';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  _i3.GSignInError get value;
  static Serializer<GsignInData_signIn__asErrCSignInError> get serializer =>
      _$gsignInDataSignInAsErrCSignInErrorSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GsignInData_signIn__asErrCSignInError.serializer, this)
      as Map<String, dynamic>);
  static GsignInData_signIn__asErrCSignInError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignInData_signIn__asErrCSignInError.serializer, json);
}

abstract class GsignInData_signIn__asTokenWithUser
    implements
        Built<GsignInData_signIn__asTokenWithUser,
            GsignInData_signIn__asTokenWithUserBuilder>,
        GsignInData_signIn,
        GSTokenWithUser {
  GsignInData_signIn__asTokenWithUser._();

  factory GsignInData_signIn__asTokenWithUser(
          [Function(GsignInData_signIn__asTokenWithUserBuilder b) updates]) =
      _$GsignInData_signIn__asTokenWithUser;

  static void _initializeBuilder(
          GsignInData_signIn__asTokenWithUserBuilder b) =>
      b..G__typename = 'TokenWithUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get refreshToken;
  String get accessToken;
  int get expiresInSecs;
  GsignInData_signIn__asTokenWithUser_user get user;
  static Serializer<GsignInData_signIn__asTokenWithUser> get serializer =>
      _$gsignInDataSignInAsTokenWithUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GsignInData_signIn__asTokenWithUser.serializer, this)
      as Map<String, dynamic>);
  static GsignInData_signIn__asTokenWithUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignInData_signIn__asTokenWithUser.serializer, json);
}

abstract class GsignInData_signIn__asTokenWithUser_user
    implements
        Built<GsignInData_signIn__asTokenWithUser_user,
            GsignInData_signIn__asTokenWithUser_userBuilder>,
        GSTokenWithUser_user,
        GAUser {
  GsignInData_signIn__asTokenWithUser_user._();

  factory GsignInData_signIn__asTokenWithUser_user(
      [Function(GsignInData_signIn__asTokenWithUser_userBuilder b)
          updates]) = _$GsignInData_signIn__asTokenWithUser_user;

  static void _initializeBuilder(
          GsignInData_signIn__asTokenWithUser_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GsignInData_signIn__asTokenWithUser_user> get serializer =>
      _$gsignInDataSignInAsTokenWithUserUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GsignInData_signIn__asTokenWithUser_user.serializer, this)
      as Map<String, dynamic>);
  static GsignInData_signIn__asTokenWithUser_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignInData_signIn__asTokenWithUser_user.serializer, json);
}

abstract class GsignUpData implements Built<GsignUpData, GsignUpDataBuilder> {
  GsignUpData._();

  factory GsignUpData([Function(GsignUpDataBuilder b) updates]) = _$GsignUpData;

  static void _initializeBuilder(GsignUpDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GsignUpData_signUp get signUp;
  static Serializer<GsignUpData> get serializer => _$gsignUpDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignUpData.serializer, this)
          as Map<String, dynamic>);
  static GsignUpData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignUpData.serializer, json);
}

abstract class GsignUpData_signUp {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GsignUpData_signUp> get serializer =>
      _i2.InlineFragmentSerializer<GsignUpData_signUp>(
          'GsignUpData_signUp', GsignUpData_signUp__base, [
        GsignUpData_signUp__asErrCSignUpError,
        GsignUpData_signUp__asTokenWithUser
      ]);
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignUpData_signUp.serializer, this)
          as Map<String, dynamic>);
  static GsignUpData_signUp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignUpData_signUp.serializer, json);
}

abstract class GsignUpData_signUp__base
    implements
        Built<GsignUpData_signUp__base, GsignUpData_signUp__baseBuilder>,
        GsignUpData_signUp {
  GsignUpData_signUp__base._();

  factory GsignUpData_signUp__base(
          [Function(GsignUpData_signUp__baseBuilder b) updates]) =
      _$GsignUpData_signUp__base;

  static void _initializeBuilder(GsignUpData_signUp__baseBuilder b) =>
      b..G__typename = 'ResultTokenWithUserErrCSignUpError';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GsignUpData_signUp__base> get serializer =>
      _$gsignUpDataSignUpBaseSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignUpData_signUp__base.serializer, this)
          as Map<String, dynamic>);
  static GsignUpData_signUp__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GsignUpData_signUp__base.serializer, json);
}

abstract class GsignUpData_signUp__asErrCSignUpError
    implements
        Built<GsignUpData_signUp__asErrCSignUpError,
            GsignUpData_signUp__asErrCSignUpErrorBuilder>,
        GsignUpData_signUp {
  GsignUpData_signUp__asErrCSignUpError._();

  factory GsignUpData_signUp__asErrCSignUpError(
          [Function(GsignUpData_signUp__asErrCSignUpErrorBuilder b) updates]) =
      _$GsignUpData_signUp__asErrCSignUpError;

  static void _initializeBuilder(
          GsignUpData_signUp__asErrCSignUpErrorBuilder b) =>
      b..G__typename = 'ErrCSignUpError';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  _i3.GSignUpError get value;
  static Serializer<GsignUpData_signUp__asErrCSignUpError> get serializer =>
      _$gsignUpDataSignUpAsErrCSignUpErrorSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GsignUpData_signUp__asErrCSignUpError.serializer, this)
      as Map<String, dynamic>);
  static GsignUpData_signUp__asErrCSignUpError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignUpData_signUp__asErrCSignUpError.serializer, json);
}

abstract class GsignUpData_signUp__asTokenWithUser
    implements
        Built<GsignUpData_signUp__asTokenWithUser,
            GsignUpData_signUp__asTokenWithUserBuilder>,
        GsignUpData_signUp,
        GSTokenWithUser {
  GsignUpData_signUp__asTokenWithUser._();

  factory GsignUpData_signUp__asTokenWithUser(
          [Function(GsignUpData_signUp__asTokenWithUserBuilder b) updates]) =
      _$GsignUpData_signUp__asTokenWithUser;

  static void _initializeBuilder(
          GsignUpData_signUp__asTokenWithUserBuilder b) =>
      b..G__typename = 'TokenWithUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get refreshToken;
  String get accessToken;
  int get expiresInSecs;
  GsignUpData_signUp__asTokenWithUser_user get user;
  static Serializer<GsignUpData_signUp__asTokenWithUser> get serializer =>
      _$gsignUpDataSignUpAsTokenWithUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GsignUpData_signUp__asTokenWithUser.serializer, this)
      as Map<String, dynamic>);
  static GsignUpData_signUp__asTokenWithUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignUpData_signUp__asTokenWithUser.serializer, json);
}

abstract class GsignUpData_signUp__asTokenWithUser_user
    implements
        Built<GsignUpData_signUp__asTokenWithUser_user,
            GsignUpData_signUp__asTokenWithUser_userBuilder>,
        GSTokenWithUser_user,
        GAUser {
  GsignUpData_signUp__asTokenWithUser_user._();

  factory GsignUpData_signUp__asTokenWithUser_user(
      [Function(GsignUpData_signUp__asTokenWithUser_userBuilder b)
          updates]) = _$GsignUpData_signUp__asTokenWithUser_user;

  static void _initializeBuilder(
          GsignUpData_signUp__asTokenWithUser_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GsignUpData_signUp__asTokenWithUser_user> get serializer =>
      _$gsignUpDataSignUpAsTokenWithUserUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GsignUpData_signUp__asTokenWithUser_user.serializer, this)
      as Map<String, dynamic>);
  static GsignUpData_signUp__asTokenWithUser_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsignUpData_signUp__asTokenWithUser_user.serializer, json);
}

abstract class GsignOutData
    implements Built<GsignOutData, GsignOutDataBuilder> {
  GsignOutData._();

  factory GsignOutData([Function(GsignOutDataBuilder b) updates]) =
      _$GsignOutData;

  static void _initializeBuilder(GsignOutDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get signOut;
  static Serializer<GsignOutData> get serializer => _$gsignOutDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignOutData.serializer, this)
          as Map<String, dynamic>);
  static GsignOutData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignOutData.serializer, json);
}

abstract class GAUser {
  String get G__typename;
  int get id;
  String? get name;
  Map<String, dynamic> toJson();
}

abstract class GAUserData
    implements Built<GAUserData, GAUserDataBuilder>, GAUser {
  GAUserData._();

  factory GAUserData([Function(GAUserDataBuilder b) updates]) = _$GAUserData;

  static void _initializeBuilder(GAUserDataBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GAUserData> get serializer => _$gAUserDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GAUserData.serializer, this)
          as Map<String, dynamic>);
  static GAUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GAUserData.serializer, json);
}

abstract class GSTokenWithUser {
  String get G__typename;
  String get refreshToken;
  String get accessToken;
  int get expiresInSecs;
  GSTokenWithUser_user get user;
  Map<String, dynamic> toJson();
}

abstract class GSTokenWithUser_user implements GAUser {
  String get G__typename;
  int get id;
  String? get name;
  Map<String, dynamic> toJson();
}

abstract class GSTokenWithUserData
    implements
        Built<GSTokenWithUserData, GSTokenWithUserDataBuilder>,
        GSTokenWithUser {
  GSTokenWithUserData._();

  factory GSTokenWithUserData(
      [Function(GSTokenWithUserDataBuilder b) updates]) = _$GSTokenWithUserData;

  static void _initializeBuilder(GSTokenWithUserDataBuilder b) =>
      b..G__typename = 'TokenWithUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get refreshToken;
  String get accessToken;
  int get expiresInSecs;
  GSTokenWithUserData_user get user;
  static Serializer<GSTokenWithUserData> get serializer =>
      _$gSTokenWithUserDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSTokenWithUserData.serializer, this)
          as Map<String, dynamic>);
  static GSTokenWithUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GSTokenWithUserData.serializer, json);
}

abstract class GSTokenWithUserData_user
    implements
        Built<GSTokenWithUserData_user, GSTokenWithUserData_userBuilder>,
        GSTokenWithUser_user,
        GAUser {
  GSTokenWithUserData_user._();

  factory GSTokenWithUserData_user(
          [Function(GSTokenWithUserData_userBuilder b) updates]) =
      _$GSTokenWithUserData_user;

  static void _initializeBuilder(GSTokenWithUserData_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GSTokenWithUserData_user> get serializer =>
      _$gSTokenWithUserDataUserSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSTokenWithUserData_user.serializer, this)
          as Map<String, dynamic>);
  static GSTokenWithUserData_user? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GSTokenWithUserData_user.serializer, json);
}
