// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GcreateRoomVars> _$gcreateRoomVarsSerializer =
    new _$GcreateRoomVarsSerializer();
Serializer<GgetRoomsVars> _$ggetRoomsVarsSerializer =
    new _$GgetRoomsVarsSerializer();
Serializer<GBaseChatRoomVars> _$gBaseChatRoomVarsSerializer =
    new _$GBaseChatRoomVarsSerializer();

class _$GcreateRoomVarsSerializer
    implements StructuredSerializer<GcreateRoomVars> {
  @override
  final Iterable<Type> types = const [GcreateRoomVars, _$GcreateRoomVars];
  @override
  final String wireName = 'GcreateRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GcreateRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GcreateRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GcreateRoomVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsVarsSerializer implements StructuredSerializer<GgetRoomsVars> {
  @override
  final Iterable<Type> types = const [GgetRoomsVars, _$GgetRoomsVars];
  @override
  final String wireName = 'GgetRoomsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetRoomsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GgetRoomsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GgetRoomsVarsBuilder().build();
  }
}

class _$GBaseChatRoomVarsSerializer
    implements StructuredSerializer<GBaseChatRoomVars> {
  @override
  final Iterable<Type> types = const [GBaseChatRoomVars, _$GBaseChatRoomVars];
  @override
  final String wireName = 'GBaseChatRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBaseChatRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GBaseChatRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GBaseChatRoomVarsBuilder().build();
  }
}

class _$GcreateRoomVars extends GcreateRoomVars {
  @override
  final String name;

  factory _$GcreateRoomVars([void Function(GcreateRoomVarsBuilder)? updates]) =>
      (new GcreateRoomVarsBuilder()..update(updates)).build();

  _$GcreateRoomVars._({required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'GcreateRoomVars', 'name');
  }

  @override
  GcreateRoomVars rebuild(void Function(GcreateRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GcreateRoomVarsBuilder toBuilder() =>
      new GcreateRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GcreateRoomVars && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GcreateRoomVars')..add('name', name))
        .toString();
  }
}

class GcreateRoomVarsBuilder
    implements Builder<GcreateRoomVars, GcreateRoomVarsBuilder> {
  _$GcreateRoomVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GcreateRoomVarsBuilder();

  GcreateRoomVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GcreateRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GcreateRoomVars;
  }

  @override
  void update(void Function(GcreateRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GcreateRoomVars build() {
    final _$result = _$v ??
        new _$GcreateRoomVars._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'GcreateRoomVars', 'name'));
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsVars extends GgetRoomsVars {
  factory _$GgetRoomsVars([void Function(GgetRoomsVarsBuilder)? updates]) =>
      (new GgetRoomsVarsBuilder()..update(updates)).build();

  _$GgetRoomsVars._() : super._();

  @override
  GgetRoomsVars rebuild(void Function(GgetRoomsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsVarsBuilder toBuilder() => new GgetRoomsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsVars;
  }

  @override
  int get hashCode {
    return 481284813;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GgetRoomsVars').toString();
  }
}

class GgetRoomsVarsBuilder
    implements Builder<GgetRoomsVars, GgetRoomsVarsBuilder> {
  _$GgetRoomsVars? _$v;

  GgetRoomsVarsBuilder();

  @override
  void replace(GgetRoomsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsVars;
  }

  @override
  void update(void Function(GgetRoomsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsVars build() {
    final _$result = _$v ?? new _$GgetRoomsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GBaseChatRoomVars extends GBaseChatRoomVars {
  factory _$GBaseChatRoomVars(
          [void Function(GBaseChatRoomVarsBuilder)? updates]) =>
      (new GBaseChatRoomVarsBuilder()..update(updates)).build();

  _$GBaseChatRoomVars._() : super._();

  @override
  GBaseChatRoomVars rebuild(void Function(GBaseChatRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBaseChatRoomVarsBuilder toBuilder() =>
      new GBaseChatRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBaseChatRoomVars;
  }

  @override
  int get hashCode {
    return 1071874162;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GBaseChatRoomVars').toString();
  }
}

class GBaseChatRoomVarsBuilder
    implements Builder<GBaseChatRoomVars, GBaseChatRoomVarsBuilder> {
  _$GBaseChatRoomVars? _$v;

  GBaseChatRoomVarsBuilder();

  @override
  void replace(GBaseChatRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBaseChatRoomVars;
  }

  @override
  void update(void Function(GBaseChatRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GBaseChatRoomVars build() {
    final _$result = _$v ?? new _$GBaseChatRoomVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
