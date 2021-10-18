// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder/src/serializers/default_scalar_serializer.dart'
    as _i1;

part 'api_schema.schema.gql.g.dart';

abstract class GDate implements Built<GDate, GDateBuilder> {
  GDate._();

  factory GDate([String? value]) =>
      _$GDate((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GDate> get serializer => _i1.DefaultScalarSerializer<GDate>(
      (Object serialized) => GDate((serialized as String?)));
}

class GChatRoomUserRole extends EnumClass {
  const GChatRoomUserRole._(String name) : super(name);

  static const GChatRoomUserRole admin = _$gChatRoomUserRoleadmin;

  static const GChatRoomUserRole peer = _$gChatRoomUserRolepeer;

  static Serializer<GChatRoomUserRole> get serializer =>
      _$gChatRoomUserRoleSerializer;
  static BuiltSet<GChatRoomUserRole> get values => _$gChatRoomUserRoleValues;
  static GChatRoomUserRole valueOf(String name) =>
      _$gChatRoomUserRoleValueOf(name);
}

class GSignUpError extends EnumClass {
  const GSignUpError._(String name) : super(name);

  static const GSignUpError nameTaken = _$gSignUpErrornameTaken;

  static const GSignUpError alreadySignedUp = _$gSignUpErroralreadySignedUp;

  static const GSignUpError unknown = _$gSignUpErrorunknown;

  static Serializer<GSignUpError> get serializer => _$gSignUpErrorSerializer;
  static BuiltSet<GSignUpError> get values => _$gSignUpErrorValues;
  static GSignUpError valueOf(String name) => _$gSignUpErrorValueOf(name);
}

class GSignInError extends EnumClass {
  const GSignInError._(String name) : super(name);

  static const GSignInError wrong = _$gSignInErrorwrong;

  static const GSignInError unknown = _$gSignInErrorunknown;

  static const GSignInError alreadySignedIn = _$gSignInErroralreadySignedIn;

  static Serializer<GSignInError> get serializer => _$gSignInErrorSerializer;
  static BuiltSet<GSignInError> get values => _$gSignInErrorValues;
  static GSignInError valueOf(String name) => _$gSignInErrorValueOf(name);
}

class GEventType extends EnumClass {
  const GEventType._(String name) : super(name);

  static const GEventType messageSent = _$gEventTypemessageSent;

  static Serializer<GEventType> get serializer => _$gEventTypeSerializer;
  static BuiltSet<GEventType> get values => _$gEventTypeValues;
  static GEventType valueOf(String name) => _$gEventTypeValueOf(name);
}
