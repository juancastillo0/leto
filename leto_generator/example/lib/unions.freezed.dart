// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    TResult? Function(String? positional, int five)? cc,
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
    TResult? Function(_FreezedSingleInput value)? cc,
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
      _$FreezedSingleInputCopyWithImpl<$Res, FreezedSingleInput>;
  @useResult
  $Res call({String? positional, int five});
}

/// @nodoc
class _$FreezedSingleInputCopyWithImpl<$Res, $Val extends FreezedSingleInput>
    implements $FreezedSingleInputCopyWith<$Res> {
  _$FreezedSingleInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positional = freezed,
    Object? five = null,
  }) {
    return _then(_value.copyWith(
      positional: freezed == positional
          ? _value.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as String?,
      five: null == five
          ? _value.five
          : five // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedSingleInputImplCopyWith<$Res>
    implements $FreezedSingleInputCopyWith<$Res> {
  factory _$$FreezedSingleInputImplCopyWith(_$FreezedSingleInputImpl value,
          $Res Function(_$FreezedSingleInputImpl) then) =
      __$$FreezedSingleInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? positional, int five});
}

/// @nodoc
class __$$FreezedSingleInputImplCopyWithImpl<$Res>
    extends _$FreezedSingleInputCopyWithImpl<$Res, _$FreezedSingleInputImpl>
    implements _$$FreezedSingleInputImplCopyWith<$Res> {
  __$$FreezedSingleInputImplCopyWithImpl(_$FreezedSingleInputImpl _value,
      $Res Function(_$FreezedSingleInputImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positional = freezed,
    Object? five = null,
  }) {
    return _then(_$FreezedSingleInputImpl(
      freezed == positional
          ? _value.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as String?,
      five: null == five
          ? _value.five
          : five // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedSingleInputImpl implements _FreezedSingleInput {
  const _$FreezedSingleInputImpl(this.positional, {this.five = 5});

  factory _$FreezedSingleInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedSingleInputImplFromJson(json);

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
            other is _$FreezedSingleInputImpl &&
            (identical(other.positional, positional) ||
                other.positional == positional) &&
            (identical(other.five, five) || other.five == five));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, positional, five);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedSingleInputImplCopyWith<_$FreezedSingleInputImpl> get copyWith =>
      __$$FreezedSingleInputImplCopyWithImpl<_$FreezedSingleInputImpl>(
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
    TResult? Function(String? positional, int five)? cc,
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
    TResult? Function(_FreezedSingleInput value)? cc,
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
    return _$$FreezedSingleInputImplToJson(
      this,
    );
  }
}

abstract class _FreezedSingleInput implements FreezedSingleInput {
  const factory _FreezedSingleInput(final String? positional,
      {final int five}) = _$FreezedSingleInputImpl;

  factory _FreezedSingleInput.fromJson(Map<String, dynamic> json) =
      _$FreezedSingleInputImpl.fromJson;

  @override
  String? get positional;
  @override // five with default
  int get five;
  @override
  @JsonKey(ignore: true)
  _$$FreezedSingleInputImplCopyWith<_$FreezedSingleInputImpl> get copyWith =>
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
    TResult? Function(int one)? a1,
    TResult? Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
            Decimal? dec)?
        a2,
    TResult? Function(
            @GraphQLDocumentation(description: 'description for one')
            List<int>? one)?
        a3,
    TResult? Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
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
    TResult? Function(_UnionA1 value)? a1,
    TResult? Function(_UnionA2 value)? a2,
    TResult? Function(UnionA3 value)? a3,
    TResult? Function(_UnionA4 value)? a4,
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
      _$UnionACopyWithImpl<$Res, UnionA>;
}

/// @nodoc
class _$UnionACopyWithImpl<$Res, $Val extends UnionA>
    implements $UnionACopyWith<$Res> {
  _$UnionACopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnionA1ImplCopyWith<$Res> {
  factory _$$UnionA1ImplCopyWith(
          _$UnionA1Impl value, $Res Function(_$UnionA1Impl) then) =
      __$$UnionA1ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int one});
}

/// @nodoc
class __$$UnionA1ImplCopyWithImpl<$Res>
    extends _$UnionACopyWithImpl<$Res, _$UnionA1Impl>
    implements _$$UnionA1ImplCopyWith<$Res> {
  __$$UnionA1ImplCopyWithImpl(
      _$UnionA1Impl _value, $Res Function(_$UnionA1Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? one = null,
  }) {
    return _then(_$UnionA1Impl(
      one: null == one
          ? _value.one
          : one // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA1Impl implements _UnionA1 {
  const _$UnionA1Impl({this.one = 5, final String? $type})
      : $type = $type ?? 'a1';

  factory _$UnionA1Impl.fromJson(Map<String, dynamic> json) =>
      _$$UnionA1ImplFromJson(json);

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
            other is _$UnionA1Impl &&
            (identical(other.one, one) || other.one == one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, one);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnionA1ImplCopyWith<_$UnionA1Impl> get copyWith =>
      __$$UnionA1ImplCopyWithImpl<_$UnionA1Impl>(this, _$identity);

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
    TResult? Function(int one)? a1,
    TResult? Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
            Decimal? dec)?
        a2,
    TResult? Function(
            @GraphQLDocumentation(description: 'description for one')
            List<int>? one)?
        a3,
    TResult? Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
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
    TResult? Function(_UnionA1 value)? a1,
    TResult? Function(_UnionA2 value)? a2,
    TResult? Function(UnionA3 value)? a3,
    TResult? Function(_UnionA4 value)? a4,
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
    return _$$UnionA1ImplToJson(
      this,
    );
  }
}

abstract class _UnionA1 implements UnionA {
  const factory _UnionA1({final int one}) = _$UnionA1Impl;

  factory _UnionA1.fromJson(Map<String, dynamic> json) = _$UnionA1Impl.fromJson;

// five with default
  int get one;
  @JsonKey(ignore: true)
  _$$UnionA1ImplCopyWith<_$UnionA1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnionA2ImplCopyWith<$Res> {
  factory _$$UnionA2ImplCopyWith(
          _$UnionA2Impl value, $Res Function(_$UnionA2Impl) then) =
      __$$UnionA2ImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
      Decimal? dec});
}

/// @nodoc
class __$$UnionA2ImplCopyWithImpl<$Res>
    extends _$UnionACopyWithImpl<$Res, _$UnionA2Impl>
    implements _$$UnionA2ImplCopyWith<$Res> {
  __$$UnionA2ImplCopyWithImpl(
      _$UnionA2Impl _value, $Res Function(_$UnionA2Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dec = freezed,
  }) {
    return _then(_$UnionA2Impl(
      dec: freezed == dec
          ? _value.dec
          : dec // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA2Impl implements _UnionA2 {
  const _$UnionA2Impl(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
      this.dec,
      final String? $type})
      : $type = $type ?? 'a2';

  factory _$UnionA2Impl.fromJson(Map<String, dynamic> json) =>
      _$$UnionA2ImplFromJson(json);

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
            other is _$UnionA2Impl &&
            (identical(other.dec, dec) || other.dec == dec));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dec);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnionA2ImplCopyWith<_$UnionA2Impl> get copyWith =>
      __$$UnionA2ImplCopyWithImpl<_$UnionA2Impl>(this, _$identity);

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
    TResult? Function(int one)? a1,
    TResult? Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
            Decimal? dec)?
        a2,
    TResult? Function(
            @GraphQLDocumentation(description: 'description for one')
            List<int>? one)?
        a3,
    TResult? Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
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
    TResult? Function(_UnionA1 value)? a1,
    TResult? Function(_UnionA2 value)? a2,
    TResult? Function(UnionA3 value)? a3,
    TResult? Function(_UnionA4 value)? a4,
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
    return _$$UnionA2ImplToJson(
      this,
    );
  }
}

abstract class _UnionA2 implements UnionA {
  const factory _UnionA2(
      {@JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
      @Deprecated('custom deprecated msg')
      final Decimal? dec}) = _$UnionA2Impl;

  factory _UnionA2.fromJson(Map<String, dynamic> json) = _$UnionA2Impl.fromJson;

  @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
  @Deprecated('custom deprecated msg')
  Decimal? get dec;
  @JsonKey(ignore: true)
  _$$UnionA2ImplCopyWith<_$UnionA2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnionA3ImplCopyWith<$Res> {
  factory _$$UnionA3ImplCopyWith(
          _$UnionA3Impl value, $Res Function(_$UnionA3Impl) then) =
      __$$UnionA3ImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@GraphQLDocumentation(description: 'description for one')
      List<int>? one});
}

/// @nodoc
class __$$UnionA3ImplCopyWithImpl<$Res>
    extends _$UnionACopyWithImpl<$Res, _$UnionA3Impl>
    implements _$$UnionA3ImplCopyWith<$Res> {
  __$$UnionA3ImplCopyWithImpl(
      _$UnionA3Impl _value, $Res Function(_$UnionA3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? one = freezed,
  }) {
    return _then(_$UnionA3Impl(
      one: freezed == one
          ? _value._one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA3Impl implements UnionA3 {
  const _$UnionA3Impl(
      {@GraphQLDocumentation(description: 'description for one')
      final List<int>? one,
      final String? $type})
      : _one = one,
        $type = $type ?? 'a3';

  factory _$UnionA3Impl.fromJson(Map<String, dynamic> json) =>
      _$$UnionA3ImplFromJson(json);

  final List<int>? _one;
  @override
  @GraphQLDocumentation(description: 'description for one')
  List<int>? get one {
    final value = _one;
    if (value == null) return null;
    if (_one is EqualUnmodifiableListView) return _one;
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
            other is _$UnionA3Impl &&
            const DeepCollectionEquality().equals(other._one, _one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_one));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnionA3ImplCopyWith<_$UnionA3Impl> get copyWith =>
      __$$UnionA3ImplCopyWithImpl<_$UnionA3Impl>(this, _$identity);

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
    TResult? Function(int one)? a1,
    TResult? Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
            Decimal? dec)?
        a2,
    TResult? Function(
            @GraphQLDocumentation(description: 'description for one')
            List<int>? one)?
        a3,
    TResult? Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
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
    TResult? Function(_UnionA1 value)? a1,
    TResult? Function(_UnionA2 value)? a2,
    TResult? Function(UnionA3 value)? a3,
    TResult? Function(_UnionA4 value)? a4,
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
    return _$$UnionA3ImplToJson(
      this,
    );
  }
}

abstract class UnionA3 implements UnionA {
  const factory UnionA3(
      {@GraphQLDocumentation(description: 'description for one')
      final List<int>? one}) = _$UnionA3Impl;

  factory UnionA3.fromJson(Map<String, dynamic> json) = _$UnionA3Impl.fromJson;

  @GraphQLDocumentation(description: 'description for one')
  List<int>? get one;
  @JsonKey(ignore: true)
  _$$UnionA3ImplCopyWith<_$UnionA3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnionA4ImplCopyWith<$Res> {
  factory _$$UnionA4ImplCopyWith(
          _$UnionA4Impl value, $Res Function(_$UnionA4Impl) then) =
      __$$UnionA4ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({@GraphQLField(name: 'oneRenamed') List<int> one});
}

/// @nodoc
class __$$UnionA4ImplCopyWithImpl<$Res>
    extends _$UnionACopyWithImpl<$Res, _$UnionA4Impl>
    implements _$$UnionA4ImplCopyWith<$Res> {
  __$$UnionA4ImplCopyWithImpl(
      _$UnionA4Impl _value, $Res Function(_$UnionA4Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? one = null,
  }) {
    return _then(_$UnionA4Impl(
      one: null == one
          ? _value._one
          : one // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnionA4Impl implements _UnionA4 {
  const _$UnionA4Impl(
      {@GraphQLField(name: 'oneRenamed') required final List<int> one,
      final String? $type})
      : _one = one,
        $type = $type ?? 'a4';

  factory _$UnionA4Impl.fromJson(Map<String, dynamic> json) =>
      _$$UnionA4ImplFromJson(json);

  final List<int> _one;
  @override
  @GraphQLField(name: 'oneRenamed')
  List<int> get one {
    if (_one is EqualUnmodifiableListView) return _one;
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
            other is _$UnionA4Impl &&
            const DeepCollectionEquality().equals(other._one, _one));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_one));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnionA4ImplCopyWith<_$UnionA4Impl> get copyWith =>
      __$$UnionA4ImplCopyWithImpl<_$UnionA4Impl>(this, _$identity);

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
    TResult? Function(int one)? a1,
    TResult? Function(
            @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
            @Deprecated('custom deprecated msg')
            Decimal? dec)?
        a2,
    TResult? Function(
            @GraphQLDocumentation(description: 'description for one')
            List<int>? one)?
        a3,
    TResult? Function(@GraphQLField(name: 'oneRenamed') List<int> one)? a4,
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
    TResult? Function(_UnionA1 value)? a1,
    TResult? Function(_UnionA2 value)? a2,
    TResult? Function(UnionA3 value)? a3,
    TResult? Function(_UnionA4 value)? a4,
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
    return _$$UnionA4ImplToJson(
      this,
    );
  }
}

abstract class _UnionA4 implements UnionA {
  const factory _UnionA4(
          {@GraphQLField(name: 'oneRenamed') required final List<int> one}) =
      _$UnionA4Impl;

  factory _UnionA4.fromJson(Map<String, dynamic> json) = _$UnionA4Impl.fromJson;

  @GraphQLField(name: 'oneRenamed')
  List<int> get one;
  @JsonKey(ignore: true)
  _$$UnionA4ImplCopyWith<_$UnionA4Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
