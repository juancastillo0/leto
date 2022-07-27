// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FreezedSingleInput _$FreezedSingleInputFromJson(Map<String, dynamic> json) {
  return _FreezedSingleInput.fromJson(json);
}

/// @nodoc
mixin _$FreezedSingleInput {
  String? get positional =>
      throw _privateConstructorUsedError; // five with default
  int get five => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? positional, int five) cc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? positional, int five)? cc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? positional, int five)? cc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FreezedSingleInput value) cc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_FreezedSingleInput value)? cc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FreezedSingleInput value)? cc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezedSingleInputCopyWith<FreezedSingleInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedSingleInputCopyWith<$Res> {
  factory $FreezedSingleInputCopyWith(
          FreezedSingleInput value, $Res Function(FreezedSingleInput) then) =
      _$FreezedSingleInputCopyWithImpl<$Res>;
  $Res call({String? positional, int five});
}

/// @nodoc
class _$FreezedSingleInputCopyWithImpl<$Res>
    implements $FreezedSingleInputCopyWith<$Res> {
  _$FreezedSingleInputCopyWithImpl(this._value, this._then);

  final FreezedSingleInput _value;
  // ignore: unused_field
  final $Res Function(FreezedSingleInput) _then;

  @override
  $Res call({
    Object? positional = freezed,
    Object? five = freezed,
  }) {
    return _then(_value.copyWith(
      positional: positional == freezed
          ? _value.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as String?,
      five: five == freezed
          ? _value.five
          : five // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_FreezedSingleInputCopyWith<$Res>
    implements $FreezedSingleInputCopyWith<$Res> {
  factory _$$_FreezedSingleInputCopyWith(_$_FreezedSingleInput value,
          $Res Function(_$_FreezedSingleInput) then) =
      __$$_FreezedSingleInputCopyWithImpl<$Res>;
  @override
  $Res call({String? positional, int five});
}

/// @nodoc
class __$$_FreezedSingleInputCopyWithImpl<$Res>
    extends _$FreezedSingleInputCopyWithImpl<$Res>
    implements _$$_FreezedSingleInputCopyWith<$Res> {
  __$$_FreezedSingleInputCopyWithImpl(
      _$_FreezedSingleInput _value, $Res Function(_$_FreezedSingleInput) _then)
      : super(_value, (v) => _then(v as _$_FreezedSingleInput));

  @override
  _$_FreezedSingleInput get _value => super._value as _$_FreezedSingleInput;

  @override
  $Res call({
    Object? positional = freezed,
    Object? five = freezed,
  }) {
    return _then(_$_FreezedSingleInput(
      positional == freezed
          ? _value.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as String?,
      five: five == freezed
          ? _value.five
          : five // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FreezedSingleInput implements _FreezedSingleInput {
  const _$_FreezedSingleInput(this.positional, {this.five = 5});

  factory _$_FreezedSingleInput.fromJson(Map<String, dynamic> json) =>
      _$$_FreezedSingleInputFromJson(json);

  @override
  final String? positional;
// five with default
  @override
  @JsonKey()
  final int five;

  @override
  String toString() {
    return 'FreezedSingleInput.cc(positional: $positional, five: $five)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FreezedSingleInput &&
            const DeepCollectionEquality()
                .equals(other.positional, positional) &&
            const DeepCollectionEquality().equals(other.five, five));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(positional),
      const DeepCollectionEquality().hash(five));

  @JsonKey(ignore: true)
  @override
  _$$_FreezedSingleInputCopyWith<_$_FreezedSingleInput> get copyWith =>
      __$$_FreezedSingleInputCopyWithImpl<_$_FreezedSingleInput>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? positional, int five) cc,
  }) {
    return cc(positional, five);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? positional, int five)? cc,
  }) {
    return cc?.call(positional, five);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? positional, int five)? cc,
    required TResult orElse(),
  }) {
    if (cc != null) {
      return cc(positional, five);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FreezedSingleInput value) cc,
  }) {
    return cc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_FreezedSingleInput value)? cc,
  }) {
    return cc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FreezedSingleInput value)? cc,
    required TResult orElse(),
  }) {
    if (cc != null) {
      return cc(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_FreezedSingleInputToJson(this);
  }
}

abstract class _FreezedSingleInput implements FreezedSingleInput {
  const factory _FreezedSingleInput(final String? positional,
      {final int five}) = _$_FreezedSingleInput;

  factory _FreezedSingleInput.fromJson(Map<String, dynamic> json) =
      _$_FreezedSingleInput.fromJson;

  @override
  String? get positional => throw _privateConstructorUsedError;
  @override // five with default
  int get five => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FreezedSingleInputCopyWith<_$_FreezedSingleInput> get copyWith =>
      throw _privateConstructorUsedError;
}

UnionA _$UnionAFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'a1':
      return _UnionA1.fromJson(json);
    case 'a2':
      return _UnionA2.fromJson(json);
    case 'a3':
      return UnionA3.fromJson(json);
    case 'a4':
      return _UnionA4.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UnionA',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionA {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int one) a1,
    required TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)
        a2,
    required TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)
        a3,
    required TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)
        a4,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionA1 value) a1,
    required TResult Function(_UnionA2 value) a2,
    required TResult Function(UnionA3 value) a3,
    required TResult Function(_UnionA4 value) a4,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnionACopyWith<$Res> {
  factory $UnionACopyWith(UnionA value, $Res Function(UnionA) then) =
      _$UnionACopyWithImpl<$Res>;
}

/// @nodoc
class _$UnionACopyWithImpl<$Res> implements $UnionACopyWith<$Res> {
  _$UnionACopyWithImpl(this._value, this._then);

  final UnionA _value;
  // ignore: unused_field
  final $Res Function(UnionA) _then;
}

/// @nodoc
abstract class _$$_UnionA1CopyWith<$Res> {
  factory _$$_UnionA1CopyWith(
          _$_UnionA1 value, $Res Function(_$_UnionA1) then) =
      __$$_UnionA1CopyWithImpl<$Res>;
  $Res call({int one});
}

/// @nodoc
class __$$_UnionA1CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$$_UnionA1CopyWith<$Res> {
  __$$_UnionA1CopyWithImpl(_$_UnionA1 _value, $Res Function(_$_UnionA1) _then)
      : super(_value, (v) => _then(v as _$_UnionA1));

  @override
  _$_UnionA1 get _value => super._value as _$_UnionA1;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_$_UnionA1(
      one: one == freezed
          ? _value.one
          : one // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnionA1 implements _UnionA1 {
  const _$_UnionA1({this.one = 5, final String? $type}) : $type = $type ?? 'a1';

  factory _$_UnionA1.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA1FromJson(json);

// five with default
  @override
  @JsonKey()
  final int one;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UnionA.a1(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnionA1 &&
            const DeepCollectionEquality().equals(other.one, one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(one));

  @JsonKey(ignore: true)
  @override
  _$$_UnionA1CopyWith<_$_UnionA1> get copyWith =>
      __$$_UnionA1CopyWithImpl<_$_UnionA1>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int one) a1,
    required TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)
        a2,
    required TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)
        a3,
    required TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)
        a4,
  }) {
    return a1(one);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
  }) {
    return a1?.call(one);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
    required TResult orElse(),
  }) {
    if (a1 != null) {
      return a1(one);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionA1 value) a1,
    required TResult Function(_UnionA2 value) a2,
    required TResult Function(UnionA3 value) a3,
    required TResult Function(_UnionA4 value) a4,
  }) {
    return a1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
  }) {
    return a1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
    required TResult orElse(),
  }) {
    if (a1 != null) {
      return a1(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnionA1ToJson(this);
  }
}

abstract class _UnionA1 implements UnionA {
  const factory _UnionA1({final int one}) = _$_UnionA1;

  factory _UnionA1.fromJson(Map<String, dynamic> json) = _$_UnionA1.fromJson;

// five with default
  int get one => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_UnionA1CopyWith<_$_UnionA1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnionA2CopyWith<$Res> {
  factory _$$_UnionA2CopyWith(
          _$_UnionA2 value, $Res Function(_$_UnionA2) then) =
      __$$_UnionA2CopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          Decimal? dec});
}

/// @nodoc
class __$$_UnionA2CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$$_UnionA2CopyWith<$Res> {
  __$$_UnionA2CopyWithImpl(_$_UnionA2 _value, $Res Function(_$_UnionA2) _then)
      : super(_value, (v) => _then(v as _$_UnionA2));

  @override
  _$_UnionA2 get _value => super._value as _$_UnionA2;

  @override
  $Res call({
    Object? dec = freezed,
  }) {
    return _then(_$_UnionA2(
      dec: dec == freezed
          ? _value.dec
          : dec // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnionA2 implements _UnionA2 {
  const _$_UnionA2(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          this.dec,
      final String? $type})
      : $type = $type ?? 'a2';

  factory _$_UnionA2.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA2FromJson(json);

  @override
  @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
  @Deprecated('custom deprecated msg')
  final Decimal? dec;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UnionA.a2(dec: $dec)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnionA2 &&
            const DeepCollectionEquality().equals(other.dec, dec));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dec));

  @JsonKey(ignore: true)
  @override
  _$$_UnionA2CopyWith<_$_UnionA2> get copyWith =>
      __$$_UnionA2CopyWithImpl<_$_UnionA2>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int one) a1,
    required TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)
        a2,
    required TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)
        a3,
    required TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)
        a4,
  }) {
    return a2(dec);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
  }) {
    return a2?.call(dec);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
    required TResult orElse(),
  }) {
    if (a2 != null) {
      return a2(dec);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionA1 value) a1,
    required TResult Function(_UnionA2 value) a2,
    required TResult Function(UnionA3 value) a3,
    required TResult Function(_UnionA4 value) a4,
  }) {
    return a2(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
  }) {
    return a2?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
    required TResult orElse(),
  }) {
    if (a2 != null) {
      return a2(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnionA2ToJson(this);
  }
}

abstract class _UnionA2 implements UnionA {
  const factory _UnionA2(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          final Decimal? dec}) = _$_UnionA2;

  factory _UnionA2.fromJson(Map<String, dynamic> json) = _$_UnionA2.fromJson;

  @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
  @Deprecated('custom deprecated msg')
  Decimal? get dec => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_UnionA2CopyWith<_$_UnionA2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnionA3CopyWith<$Res> {
  factory _$$UnionA3CopyWith(_$UnionA3 value, $Res Function(_$UnionA3) then) =
      __$$UnionA3CopyWithImpl<$Res>;
  $Res call(
      {@GraphQLDocumentation(description: 'description for one')
          List<int>? one});
}

/// @nodoc
class __$$UnionA3CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$$UnionA3CopyWith<$Res> {
  __$$UnionA3CopyWithImpl(_$UnionA3 _value, $Res Function(_$UnionA3) _then)
      : super(_value, (v) => _then(v as _$UnionA3));

  @override
  _$UnionA3 get _value => super._value as _$UnionA3;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_$UnionA3(
      one: one == freezed
          ? _value._one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA3 implements UnionA3 {
  const _$UnionA3(
      {@GraphQLDocumentation(description: 'description for one')
          final List<int>? one,
      final String? $type})
      : _one = one,
        $type = $type ?? 'a3';

  factory _$UnionA3.fromJson(Map<String, dynamic> json) =>
      _$$UnionA3FromJson(json);

  final List<int>? _one;
  @override
  @GraphQLDocumentation(description: 'description for one')
  List<int>? get one {
    final value = _one;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UnionA.a3(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnionA3 &&
            const DeepCollectionEquality().equals(other._one, _one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_one));

  @JsonKey(ignore: true)
  @override
  _$$UnionA3CopyWith<_$UnionA3> get copyWith =>
      __$$UnionA3CopyWithImpl<_$UnionA3>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int one) a1,
    required TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)
        a2,
    required TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)
        a3,
    required TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)
        a4,
  }) {
    return a3(one);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
  }) {
    return a3?.call(one);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
    required TResult orElse(),
  }) {
    if (a3 != null) {
      return a3(one);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionA1 value) a1,
    required TResult Function(_UnionA2 value) a2,
    required TResult Function(UnionA3 value) a3,
    required TResult Function(_UnionA4 value) a4,
  }) {
    return a3(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
  }) {
    return a3?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
    required TResult orElse(),
  }) {
    if (a3 != null) {
      return a3(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnionA3ToJson(this);
  }
}

abstract class UnionA3 implements UnionA {
  const factory UnionA3(
      {@GraphQLDocumentation(description: 'description for one')
          final List<int>? one}) = _$UnionA3;

  factory UnionA3.fromJson(Map<String, dynamic> json) = _$UnionA3.fromJson;

  @GraphQLDocumentation(description: 'description for one')
  List<int>? get one => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$UnionA3CopyWith<_$UnionA3> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnionA4CopyWith<$Res> {
  factory _$$_UnionA4CopyWith(
          _$_UnionA4 value, $Res Function(_$_UnionA4) then) =
      __$$_UnionA4CopyWithImpl<$Res>;
  $Res call({@GraphQLField(name: 'oneRenamed') List<int> one});
}

/// @nodoc
class __$$_UnionA4CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$$_UnionA4CopyWith<$Res> {
  __$$_UnionA4CopyWithImpl(_$_UnionA4 _value, $Res Function(_$_UnionA4) _then)
      : super(_value, (v) => _then(v as _$_UnionA4));

  @override
  _$_UnionA4 get _value => super._value as _$_UnionA4;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_$_UnionA4(
      one: one == freezed
          ? _value._one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnionA4 implements _UnionA4 {
  const _$_UnionA4(
      {@GraphQLField(name: 'oneRenamed') required final List<int> one,
      final String? $type})
      : _one = one,
        $type = $type ?? 'a4';

  factory _$_UnionA4.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA4FromJson(json);

  final List<int> _one;
  @override
  @GraphQLField(name: 'oneRenamed')
  List<int> get one {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_one);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UnionA.a4(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnionA4 &&
            const DeepCollectionEquality().equals(other._one, _one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_one));

  @JsonKey(ignore: true)
  @override
  _$$_UnionA4CopyWith<_$_UnionA4> get copyWith =>
      __$$_UnionA4CopyWithImpl<_$_UnionA4>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int one) a1,
    required TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)
        a2,
    required TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)
        a3,
    required TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)
        a4,
  }) {
    return a4(one);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
  }) {
    return a4?.call(one);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int one)? a1,
    TResult Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
                Decimal? dec)?
        a2,
    TResult Function(
            @GraphQLDocumentation(description: 'description for one')
                List<int>? one)?
        a3,
    TResult Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
    required TResult orElse(),
  }) {
    if (a4 != null) {
      return a4(one);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionA1 value) a1,
    required TResult Function(_UnionA2 value) a2,
    required TResult Function(UnionA3 value) a3,
    required TResult Function(_UnionA4 value) a4,
  }) {
    return a4(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
  }) {
    return a4?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnionA1 value)? a1,
    TResult Function(_UnionA2 value)? a2,
    TResult Function(UnionA3 value)? a3,
    TResult Function(_UnionA4 value)? a4,
    required TResult orElse(),
  }) {
    if (a4 != null) {
      return a4(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnionA4ToJson(this);
  }
}

abstract class _UnionA4 implements UnionA {
  const factory _UnionA4(
          {@GraphQLField(name: 'oneRenamed') required final List<int> one}) =
      _$_UnionA4;

  factory _UnionA4.fromJson(Map<String, dynamic> json) = _$_UnionA4.fromJson;

  @GraphQLField(name: 'oneRenamed')
  List<int> get one => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_UnionA4CopyWith<_$_UnionA4> get copyWith =>
      throw _privateConstructorUsedError;
}
