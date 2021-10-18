// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GChatRoomUserRole _$gChatRoomUserRoleadmin =
    const GChatRoomUserRole._('admin');
const GChatRoomUserRole _$gChatRoomUserRolepeer =
    const GChatRoomUserRole._('peer');

GChatRoomUserRole _$gChatRoomUserRoleValueOf(String name) {
  switch (name) {
    case 'admin':
      return _$gChatRoomUserRoleadmin;
    case 'peer':
      return _$gChatRoomUserRolepeer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GChatRoomUserRole> _$gChatRoomUserRoleValues =
    new BuiltSet<GChatRoomUserRole>(const <GChatRoomUserRole>[
  _$gChatRoomUserRoleadmin,
  _$gChatRoomUserRolepeer,
]);

const GSignUpError _$gSignUpErrornameTaken = const GSignUpError._('nameTaken');
const GSignUpError _$gSignUpErroralreadySignedUp =
    const GSignUpError._('alreadySignedUp');
const GSignUpError _$gSignUpErrorunknown = const GSignUpError._('unknown');

GSignUpError _$gSignUpErrorValueOf(String name) {
  switch (name) {
    case 'nameTaken':
      return _$gSignUpErrornameTaken;
    case 'alreadySignedUp':
      return _$gSignUpErroralreadySignedUp;
    case 'unknown':
      return _$gSignUpErrorunknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GSignUpError> _$gSignUpErrorValues =
    new BuiltSet<GSignUpError>(const <GSignUpError>[
  _$gSignUpErrornameTaken,
  _$gSignUpErroralreadySignedUp,
  _$gSignUpErrorunknown,
]);

const GSignInError _$gSignInErrorwrong = const GSignInError._('wrong');
const GSignInError _$gSignInErrorunknown = const GSignInError._('unknown');
const GSignInError _$gSignInErroralreadySignedIn =
    const GSignInError._('alreadySignedIn');

GSignInError _$gSignInErrorValueOf(String name) {
  switch (name) {
    case 'wrong':
      return _$gSignInErrorwrong;
    case 'unknown':
      return _$gSignInErrorunknown;
    case 'alreadySignedIn':
      return _$gSignInErroralreadySignedIn;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GSignInError> _$gSignInErrorValues =
    new BuiltSet<GSignInError>(const <GSignInError>[
  _$gSignInErrorwrong,
  _$gSignInErrorunknown,
  _$gSignInErroralreadySignedIn,
]);

const GEventType _$gEventTypemessageSent = const GEventType._('messageSent');

GEventType _$gEventTypeValueOf(String name) {
  switch (name) {
    case 'messageSent':
      return _$gEventTypemessageSent;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GEventType> _$gEventTypeValues =
    new BuiltSet<GEventType>(const <GEventType>[
  _$gEventTypemessageSent,
]);

Serializer<GChatRoomUserRole> _$gChatRoomUserRoleSerializer =
    new _$GChatRoomUserRoleSerializer();
Serializer<GSignUpError> _$gSignUpErrorSerializer =
    new _$GSignUpErrorSerializer();
Serializer<GSignInError> _$gSignInErrorSerializer =
    new _$GSignInErrorSerializer();
Serializer<GEventType> _$gEventTypeSerializer = new _$GEventTypeSerializer();

class _$GChatRoomUserRoleSerializer
    implements PrimitiveSerializer<GChatRoomUserRole> {
  @override
  final Iterable<Type> types = const <Type>[GChatRoomUserRole];
  @override
  final String wireName = 'GChatRoomUserRole';

  @override
  Object serialize(Serializers serializers, GChatRoomUserRole object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GChatRoomUserRole deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GChatRoomUserRole.valueOf(serialized as String);
}

class _$GSignUpErrorSerializer implements PrimitiveSerializer<GSignUpError> {
  @override
  final Iterable<Type> types = const <Type>[GSignUpError];
  @override
  final String wireName = 'GSignUpError';

  @override
  Object serialize(Serializers serializers, GSignUpError object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GSignUpError deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GSignUpError.valueOf(serialized as String);
}

class _$GSignInErrorSerializer implements PrimitiveSerializer<GSignInError> {
  @override
  final Iterable<Type> types = const <Type>[GSignInError];
  @override
  final String wireName = 'GSignInError';

  @override
  Object serialize(Serializers serializers, GSignInError object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GSignInError deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GSignInError.valueOf(serialized as String);
}

class _$GEventTypeSerializer implements PrimitiveSerializer<GEventType> {
  @override
  final Iterable<Type> types = const <Type>[GEventType];
  @override
  final String wireName = 'GEventType';

  @override
  Object serialize(Serializers serializers, GEventType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GEventType.valueOf(serialized as String);
}

class _$GDate extends GDate {
  @override
  final String value;

  factory _$GDate([void Function(GDateBuilder)? updates]) =>
      (new GDateBuilder()..update(updates)).build();

  _$GDate._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, 'GDate', 'value');
  }

  @override
  GDate rebuild(void Function(GDateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDateBuilder toBuilder() => new GDateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDate && value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(0, value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GDate')..add('value', value))
        .toString();
  }
}

class GDateBuilder implements Builder<GDate, GDateBuilder> {
  _$GDate? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  GDateBuilder();

  GDateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDate other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDate;
  }

  @override
  void update(void Function(GDateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GDate build() {
    final _$result = _$v ??
        new _$GDate._(
            value:
                BuiltValueNullFieldError.checkNotNull(value, 'GDate', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
