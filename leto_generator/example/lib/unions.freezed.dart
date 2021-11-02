// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FreezedSingleInput _$FreezedSingleInputFromJson(Map<String, dynamic> json) {
  return _FreezedSingleInput.fromJson(json);
}

/// @nodoc
class _$FreezedSingleInputTearOff {
  const _$FreezedSingleInputTearOff();

  _FreezedSingleInput cc(String? positional, {int five = 5}) {
    return _FreezedSingleInput(
      positional,
      five: five,
    );
  }

  FreezedSingleInput fromJson(Map<String, Object?> json) {
    return FreezedSingleInput.fromJson(json);
  }
}

/// @nodoc
const $FreezedSingleInput = _$FreezedSingleInputTearOff();

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
abstract class _$FreezedSingleInputCopyWith<$Res>
    implements $FreezedSingleInputCopyWith<$Res> {
  factory _$FreezedSingleInputCopyWith(
          _FreezedSingleInput value, $Res Function(_FreezedSingleInput) then) =
      __$FreezedSingleInputCopyWithImpl<$Res>;
  @override
  $Res call({String? positional, int five});
}

/// @nodoc
class __$FreezedSingleInputCopyWithImpl<$Res>
    extends _$FreezedSingleInputCopyWithImpl<$Res>
    implements _$FreezedSingleInputCopyWith<$Res> {
  __$FreezedSingleInputCopyWithImpl(
      _FreezedSingleInput _value, $Res Function(_FreezedSingleInput) _then)
      : super(_value, (v) => _then(v as _FreezedSingleInput));

  @override
  _FreezedSingleInput get _value => super._value as _FreezedSingleInput;

  @override
  $Res call({
    Object? positional = freezed,
    Object? five = freezed,
  }) {
    return _then(_FreezedSingleInput(
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
  @JsonKey(defaultValue: 5)
  @override // five with default
  final int five;

  @override
  String toString() {
    return 'FreezedSingleInput.cc(positional: $positional, five: $five)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreezedSingleInput &&
            (identical(other.positional, positional) ||
                other.positional == positional) &&
            (identical(other.five, five) || other.five == five));
  }

  @override
  int get hashCode => Object.hash(runtimeType, positional, five);

  @JsonKey(ignore: true)
  @override
  _$FreezedSingleInputCopyWith<_FreezedSingleInput> get copyWith =>
      __$FreezedSingleInputCopyWithImpl<_FreezedSingleInput>(this, _$identity);

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
  const factory _FreezedSingleInput(String? positional, {int five}) =
      _$_FreezedSingleInput;

  factory _FreezedSingleInput.fromJson(Map<String, dynamic> json) =
      _$_FreezedSingleInput.fromJson;

  @override
  String? get positional;
  @override // five with default
  int get five;
  @override
  @JsonKey(ignore: true)
  _$FreezedSingleInputCopyWith<_FreezedSingleInput> get copyWith =>
      throw _privateConstructorUsedError;
}

UnionA _$UnionAFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
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
class _$UnionATearOff {
  const _$UnionATearOff();

  _UnionA1 a1({int one = 5}) {
    return _UnionA1(
      one: one,
    );
  }

  _UnionA2 a2(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          Decimal? dec}) {
    return _UnionA2(
      dec: dec,
    );
  }

  UnionA3 a3(
      {@GraphQLDocumentation(description: 'description for one')
          List<int>? one}) {
    return UnionA3(
      one: one,
    );
  }

  _UnionA4 a4({@GraphQLField(name: 'oneRenamed') required List<int> one}) {
    return _UnionA4(
      one: one,
    );
  }

  UnionA fromJson(Map<String, Object?> json) {
    return UnionA.fromJson(json);
  }
}

/// @nodoc
const $UnionA = _$UnionATearOff();

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
abstract class _$UnionA1CopyWith<$Res> {
  factory _$UnionA1CopyWith(_UnionA1 value, $Res Function(_UnionA1) then) =
      __$UnionA1CopyWithImpl<$Res>;
  $Res call({int one});
}

/// @nodoc
class __$UnionA1CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$UnionA1CopyWith<$Res> {
  __$UnionA1CopyWithImpl(_UnionA1 _value, $Res Function(_UnionA1) _then)
      : super(_value, (v) => _then(v as _UnionA1));

  @override
  _UnionA1 get _value => super._value as _UnionA1;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_UnionA1(
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
  const _$_UnionA1({this.one = 5});

  factory _$_UnionA1.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA1FromJson(json);

  @JsonKey(defaultValue: 5)
  @override // five with default
  final int one;

  @override
  String toString() {
    return 'UnionA.a1(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionA1 &&
            (identical(other.one, one) || other.one == one));
  }

  @override
  int get hashCode => Object.hash(runtimeType, one);

  @JsonKey(ignore: true)
  @override
  _$UnionA1CopyWith<_UnionA1> get copyWith =>
      __$UnionA1CopyWithImpl<_UnionA1>(this, _$identity);

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
    return _$$_UnionA1ToJson(this)..['runtimeType'] = 'a1';
  }
}

abstract class _UnionA1 implements UnionA {
  const factory _UnionA1({int one}) = _$_UnionA1;

  factory _UnionA1.fromJson(Map<String, dynamic> json) = _$_UnionA1.fromJson;

// five with default
  int get one;
  @JsonKey(ignore: true)
  _$UnionA1CopyWith<_UnionA1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UnionA2CopyWith<$Res> {
  factory _$UnionA2CopyWith(_UnionA2 value, $Res Function(_UnionA2) then) =
      __$UnionA2CopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          Decimal? dec});
}

/// @nodoc
class __$UnionA2CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$UnionA2CopyWith<$Res> {
  __$UnionA2CopyWithImpl(_UnionA2 _value, $Res Function(_UnionA2) _then)
      : super(_value, (v) => _then(v as _UnionA2));

  @override
  _UnionA2 get _value => super._value as _UnionA2;

  @override
  $Res call({
    Object? dec = freezed,
  }) {
    return _then(_UnionA2(
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
          this.dec});

  factory _$_UnionA2.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA2FromJson(json);

  @override
  @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
  @Deprecated('custom deprecated msg')
  final Decimal? dec;

  @override
  String toString() {
    return 'UnionA.a2(dec: $dec)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionA2 &&
            (identical(other.dec, dec) || other.dec == dec));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dec);

  @JsonKey(ignore: true)
  @override
  _$UnionA2CopyWith<_UnionA2> get copyWith =>
      __$UnionA2CopyWithImpl<_UnionA2>(this, _$identity);

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
    return _$$_UnionA2ToJson(this)..['runtimeType'] = 'a2';
  }
}

abstract class _UnionA2 implements UnionA {
  const factory _UnionA2(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
          Decimal? dec}) = _$_UnionA2;

  factory _UnionA2.fromJson(Map<String, dynamic> json) = _$_UnionA2.fromJson;

  @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
  @Deprecated('custom deprecated msg')
  Decimal? get dec;
  @JsonKey(ignore: true)
  _$UnionA2CopyWith<_UnionA2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnionA3CopyWith<$Res> {
  factory $UnionA3CopyWith(UnionA3 value, $Res Function(UnionA3) then) =
      _$UnionA3CopyWithImpl<$Res>;
  $Res call(
      {@GraphQLDocumentation(description: 'description for one')
          List<int>? one});
}

/// @nodoc
class _$UnionA3CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements $UnionA3CopyWith<$Res> {
  _$UnionA3CopyWithImpl(UnionA3 _value, $Res Function(UnionA3) _then)
      : super(_value, (v) => _then(v as UnionA3));

  @override
  UnionA3 get _value => super._value as UnionA3;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(UnionA3(
      one: one == freezed
          ? _value.one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA3 implements UnionA3 {
  const _$UnionA3(
      {@GraphQLDocumentation(description: 'description for one') this.one});

  factory _$UnionA3.fromJson(Map<String, dynamic> json) =>
      _$$UnionA3FromJson(json);

  @override
  @GraphQLDocumentation(description: 'description for one')
  final List<int>? one;

  @override
  String toString() {
    return 'UnionA.a3(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionA3 &&
            const DeepCollectionEquality().equals(other.one, one));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(one));

  @JsonKey(ignore: true)
  @override
  $UnionA3CopyWith<UnionA3> get copyWith =>
      _$UnionA3CopyWithImpl<UnionA3>(this, _$identity);

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
    return _$$UnionA3ToJson(this)..['runtimeType'] = 'a3';
  }
}

abstract class UnionA3 implements UnionA {
  const factory UnionA3(
      {@GraphQLDocumentation(description: 'description for one')
          List<int>? one}) = _$UnionA3;

  factory UnionA3.fromJson(Map<String, dynamic> json) = _$UnionA3.fromJson;

  @GraphQLDocumentation(description: 'description for one')
  List<int>? get one;
  @JsonKey(ignore: true)
  $UnionA3CopyWith<UnionA3> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UnionA4CopyWith<$Res> {
  factory _$UnionA4CopyWith(_UnionA4 value, $Res Function(_UnionA4) then) =
      __$UnionA4CopyWithImpl<$Res>;
  $Res call({@GraphQLField(name: 'oneRenamed') List<int> one});
}

/// @nodoc
class __$UnionA4CopyWithImpl<$Res> extends _$UnionACopyWithImpl<$Res>
    implements _$UnionA4CopyWith<$Res> {
  __$UnionA4CopyWithImpl(_UnionA4 _value, $Res Function(_UnionA4) _then)
      : super(_value, (v) => _then(v as _UnionA4));

  @override
  _UnionA4 get _value => super._value as _UnionA4;

  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_UnionA4(
      one: one == freezed
          ? _value.one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnionA4 implements _UnionA4 {
  const _$_UnionA4({@GraphQLField(name: 'oneRenamed') required this.one});

  factory _$_UnionA4.fromJson(Map<String, dynamic> json) =>
      _$$_UnionA4FromJson(json);

  @override
  @GraphQLField(name: 'oneRenamed')
  final List<int> one;

  @override
  String toString() {
    return 'UnionA.a4(one: $one)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionA4 &&
            const DeepCollectionEquality().equals(other.one, one));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(one));

  @JsonKey(ignore: true)
  @override
  _$UnionA4CopyWith<_UnionA4> get copyWith =>
      __$UnionA4CopyWithImpl<_UnionA4>(this, _$identity);

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
    return _$$_UnionA4ToJson(this)..['runtimeType'] = 'a4';
  }
}

abstract class _UnionA4 implements UnionA {
  const factory _UnionA4(
      {@GraphQLField(name: 'oneRenamed') required List<int> one}) = _$_UnionA4;

  factory _UnionA4.fromJson(Map<String, dynamic> json) = _$_UnionA4.fromJson;

  @GraphQLField(name: 'oneRenamed')
  List<int> get one;
  @JsonKey(ignore: true)
  _$UnionA4CopyWith<_UnionA4> get copyWith =>
      throw _privateConstructorUsedError;
}
