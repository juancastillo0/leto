// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GrefreshAuthTokenVars> _$grefreshAuthTokenVarsSerializer =
    new _$GrefreshAuthTokenVarsSerializer();
Serializer<GsignInVars> _$gsignInVarsSerializer = new _$GsignInVarsSerializer();
Serializer<GsignUpVars> _$gsignUpVarsSerializer = new _$GsignUpVarsSerializer();
Serializer<GsignOutVars> _$gsignOutVarsSerializer =
    new _$GsignOutVarsSerializer();
Serializer<GAUserVars> _$gAUserVarsSerializer = new _$GAUserVarsSerializer();
Serializer<GSTokenWithUserVars> _$gSTokenWithUserVarsSerializer =
    new _$GSTokenWithUserVarsSerializer();

class _$GrefreshAuthTokenVarsSerializer
    implements StructuredSerializer<GrefreshAuthTokenVars> {
  @override
  final Iterable<Type> types = const [
    GrefreshAuthTokenVars,
    _$GrefreshAuthTokenVars
  ];
  @override
  final String wireName = 'GrefreshAuthTokenVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GrefreshAuthTokenVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GrefreshAuthTokenVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GrefreshAuthTokenVarsBuilder().build();
  }
}

class _$GsignInVarsSerializer implements StructuredSerializer<GsignInVars> {
  @override
  final Iterable<Type> types = const [GsignInVars, _$GsignInVars];
  @override
  final String wireName = 'GsignInVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignInVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsignInVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignInVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignUpVarsSerializer implements StructuredSerializer<GsignUpVars> {
  @override
  final Iterable<Type> types = const [GsignUpVars, _$GsignUpVars];
  @override
  final String wireName = 'GsignUpVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignUpVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsignUpVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsignUpVarsBuilder();

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
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GsignOutVarsSerializer implements StructuredSerializer<GsignOutVars> {
  @override
  final Iterable<Type> types = const [GsignOutVars, _$GsignOutVars];
  @override
  final String wireName = 'GsignOutVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsignOutVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GsignOutVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GsignOutVarsBuilder().build();
  }
}

class _$GAUserVarsSerializer implements StructuredSerializer<GAUserVars> {
  @override
  final Iterable<Type> types = const [GAUserVars, _$GAUserVars];
  @override
  final String wireName = 'GAUserVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GAUserVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GAUserVarsBuilder().build();
  }
}

class _$GSTokenWithUserVarsSerializer
    implements StructuredSerializer<GSTokenWithUserVars> {
  @override
  final Iterable<Type> types = const [
    GSTokenWithUserVars,
    _$GSTokenWithUserVars
  ];
  @override
  final String wireName = 'GSTokenWithUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSTokenWithUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GSTokenWithUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GSTokenWithUserVarsBuilder().build();
  }
}

class _$GrefreshAuthTokenVars extends GrefreshAuthTokenVars {
  factory _$GrefreshAuthTokenVars(
          [void Function(GrefreshAuthTokenVarsBuilder)? updates]) =>
      (new GrefreshAuthTokenVarsBuilder()..update(updates)).build();

  _$GrefreshAuthTokenVars._() : super._();

  @override
  GrefreshAuthTokenVars rebuild(
          void Function(GrefreshAuthTokenVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GrefreshAuthTokenVarsBuilder toBuilder() =>
      new GrefreshAuthTokenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GrefreshAuthTokenVars;
  }

  @override
  int get hashCode {
    return 376788666;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GrefreshAuthTokenVars').toString();
  }
}

class GrefreshAuthTokenVarsBuilder
    implements Builder<GrefreshAuthTokenVars, GrefreshAuthTokenVarsBuilder> {
  _$GrefreshAuthTokenVars? _$v;

  GrefreshAuthTokenVarsBuilder();

  @override
  void replace(GrefreshAuthTokenVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GrefreshAuthTokenVars;
  }

  @override
  void update(void Function(GrefreshAuthTokenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GrefreshAuthTokenVars build() {
    final _$result = _$v ?? new _$GrefreshAuthTokenVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GsignInVars extends GsignInVars {
  @override
  final String? name;
  @override
  final String? password;

  factory _$GsignInVars([void Function(GsignInVarsBuilder)? updates]) =>
      (new GsignInVarsBuilder()..update(updates)).build();

  _$GsignInVars._({this.name, this.password}) : super._();

  @override
  GsignInVars rebuild(void Function(GsignInVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignInVarsBuilder toBuilder() => new GsignInVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignInVars &&
        name == other.name &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignInVars')
          ..add('name', name)
          ..add('password', password))
        .toString();
  }
}

class GsignInVarsBuilder implements Builder<GsignInVars, GsignInVarsBuilder> {
  _$GsignInVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GsignInVarsBuilder();

  GsignInVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignInVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignInVars;
  }

  @override
  void update(void Function(GsignInVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignInVars build() {
    final _$result = _$v ?? new _$GsignInVars._(name: name, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$GsignUpVars extends GsignUpVars {
  @override
  final String name;
  @override
  final String password;

  factory _$GsignUpVars([void Function(GsignUpVarsBuilder)? updates]) =>
      (new GsignUpVarsBuilder()..update(updates)).build();

  _$GsignUpVars._({required this.name, required this.password}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'GsignUpVars', 'name');
    BuiltValueNullFieldError.checkNotNull(password, 'GsignUpVars', 'password');
  }

  @override
  GsignUpVars rebuild(void Function(GsignUpVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignUpVarsBuilder toBuilder() => new GsignUpVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignUpVars &&
        name == other.name &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsignUpVars')
          ..add('name', name)
          ..add('password', password))
        .toString();
  }
}

class GsignUpVarsBuilder implements Builder<GsignUpVars, GsignUpVarsBuilder> {
  _$GsignUpVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GsignUpVarsBuilder();

  GsignUpVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsignUpVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignUpVars;
  }

  @override
  void update(void Function(GsignUpVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignUpVars build() {
    final _$result = _$v ??
        new _$GsignUpVars._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'GsignUpVars', 'name'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'GsignUpVars', 'password'));
    replace(_$result);
    return _$result;
  }
}

class _$GsignOutVars extends GsignOutVars {
  factory _$GsignOutVars([void Function(GsignOutVarsBuilder)? updates]) =>
      (new GsignOutVarsBuilder()..update(updates)).build();

  _$GsignOutVars._() : super._();

  @override
  GsignOutVars rebuild(void Function(GsignOutVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsignOutVarsBuilder toBuilder() => new GsignOutVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsignOutVars;
  }

  @override
  int get hashCode {
    return 327595453;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GsignOutVars').toString();
  }
}

class GsignOutVarsBuilder
    implements Builder<GsignOutVars, GsignOutVarsBuilder> {
  _$GsignOutVars? _$v;

  GsignOutVarsBuilder();

  @override
  void replace(GsignOutVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsignOutVars;
  }

  @override
  void update(void Function(GsignOutVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsignOutVars build() {
    final _$result = _$v ?? new _$GsignOutVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GAUserVars extends GAUserVars {
  factory _$GAUserVars([void Function(GAUserVarsBuilder)? updates]) =>
      (new GAUserVarsBuilder()..update(updates)).build();

  _$GAUserVars._() : super._();

  @override
  GAUserVars rebuild(void Function(GAUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAUserVarsBuilder toBuilder() => new GAUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAUserVars;
  }

  @override
  int get hashCode {
    return 222199192;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GAUserVars').toString();
  }
}

class GAUserVarsBuilder implements Builder<GAUserVars, GAUserVarsBuilder> {
  _$GAUserVars? _$v;

  GAUserVarsBuilder();

  @override
  void replace(GAUserVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAUserVars;
  }

  @override
  void update(void Function(GAUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GAUserVars build() {
    final _$result = _$v ?? new _$GAUserVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GSTokenWithUserVars extends GSTokenWithUserVars {
  factory _$GSTokenWithUserVars(
          [void Function(GSTokenWithUserVarsBuilder)? updates]) =>
      (new GSTokenWithUserVarsBuilder()..update(updates)).build();

  _$GSTokenWithUserVars._() : super._();

  @override
  GSTokenWithUserVars rebuild(
          void Function(GSTokenWithUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSTokenWithUserVarsBuilder toBuilder() =>
      new GSTokenWithUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSTokenWithUserVars;
  }

  @override
  int get hashCode {
    return 851527424;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GSTokenWithUserVars').toString();
  }
}

class GSTokenWithUserVarsBuilder
    implements Builder<GSTokenWithUserVars, GSTokenWithUserVarsBuilder> {
  _$GSTokenWithUserVars? _$v;

  GSTokenWithUserVarsBuilder();

  @override
  void replace(GSTokenWithUserVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSTokenWithUserVars;
  }

  @override
  void update(void Function(GSTokenWithUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GSTokenWithUserVars build() {
    final _$result = _$v ?? new _$GSTokenWithUserVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
