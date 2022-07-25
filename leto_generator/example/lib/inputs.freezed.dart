// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'inputs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OneOfFreezedInput _$OneOfFreezedInputFromJson(Map<String, dynamic> json) {
  return _OneOfFreezedInput.fromJson(json);
}

/// @nodoc
mixin _$OneOfFreezedInput {
  String get str => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OneOfFreezedInputCopyWith<OneOfFreezedInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneOfFreezedInputCopyWith<$Res> {
  factory $OneOfFreezedInputCopyWith(
          OneOfFreezedInput value, $Res Function(OneOfFreezedInput) then) =
      _$OneOfFreezedInputCopyWithImpl<$Res>;
  $Res call({String str});
}

/// @nodoc
class _$OneOfFreezedInputCopyWithImpl<$Res>
    implements $OneOfFreezedInputCopyWith<$Res> {
  _$OneOfFreezedInputCopyWithImpl(this._value, this._then);

  final OneOfFreezedInput _value;
  // ignore: unused_field
  final $Res Function(OneOfFreezedInput) _then;

  @override
  $Res call({
    Object? str = freezed,
  }) {
    return _then(_value.copyWith(
      str: str == freezed
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_OneOfFreezedInputCopyWith<$Res>
    implements $OneOfFreezedInputCopyWith<$Res> {
  factory _$$_OneOfFreezedInputCopyWith(_$_OneOfFreezedInput value,
          $Res Function(_$_OneOfFreezedInput) then) =
      __$$_OneOfFreezedInputCopyWithImpl<$Res>;
  @override
  $Res call({String str});
}

/// @nodoc
class __$$_OneOfFreezedInputCopyWithImpl<$Res>
    extends _$OneOfFreezedInputCopyWithImpl<$Res>
    implements _$$_OneOfFreezedInputCopyWith<$Res> {
  __$$_OneOfFreezedInputCopyWithImpl(
      _$_OneOfFreezedInput _value, $Res Function(_$_OneOfFreezedInput) _then)
      : super(_value, (v) => _then(v as _$_OneOfFreezedInput));

  @override
  _$_OneOfFreezedInput get _value => super._value as _$_OneOfFreezedInput;

  @override
  $Res call({
    Object? str = freezed,
  }) {
    return _then(_$_OneOfFreezedInput(
      str == freezed
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OneOfFreezedInput implements _OneOfFreezedInput {
  const _$_OneOfFreezedInput(this.str);

  factory _$_OneOfFreezedInput.fromJson(Map<String, dynamic> json) =>
      _$$_OneOfFreezedInputFromJson(json);

  @override
  final String str;

  @override
  String toString() {
    return 'OneOfFreezedInput(str: $str)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OneOfFreezedInput &&
            const DeepCollectionEquality().equals(other.str, str));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(str));

  @JsonKey(ignore: true)
  @override
  _$$_OneOfFreezedInputCopyWith<_$_OneOfFreezedInput> get copyWith =>
      __$$_OneOfFreezedInputCopyWithImpl<_$_OneOfFreezedInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OneOfFreezedInputToJson(this);
  }
}

abstract class _OneOfFreezedInput implements OneOfFreezedInput {
  const factory _OneOfFreezedInput(final String str) = _$_OneOfFreezedInput;

  factory _OneOfFreezedInput.fromJson(Map<String, dynamic> json) =
      _$_OneOfFreezedInput.fromJson;

  @override
  String get str => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OneOfFreezedInputCopyWith<_$_OneOfFreezedInput> get copyWith =>
      throw _privateConstructorUsedError;
}
