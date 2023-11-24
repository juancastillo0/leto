// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$OneOfFreezedInputCopyWithImpl<$Res, OneOfFreezedInput>;
  @useResult
  $Res call({String str});
}

/// @nodoc
class _$OneOfFreezedInputCopyWithImpl<$Res, $Val extends OneOfFreezedInput>
    implements $OneOfFreezedInputCopyWith<$Res> {
  _$OneOfFreezedInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? str = null,
  }) {
    return _then(_value.copyWith(
      str: null == str
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OneOfFreezedInputImplCopyWith<$Res>
    implements $OneOfFreezedInputCopyWith<$Res> {
  factory _$$OneOfFreezedInputImplCopyWith(_$OneOfFreezedInputImpl value,
          $Res Function(_$OneOfFreezedInputImpl) then) =
      __$$OneOfFreezedInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String str});
}

/// @nodoc
class __$$OneOfFreezedInputImplCopyWithImpl<$Res>
    extends _$OneOfFreezedInputCopyWithImpl<$Res, _$OneOfFreezedInputImpl>
    implements _$$OneOfFreezedInputImplCopyWith<$Res> {
  __$$OneOfFreezedInputImplCopyWithImpl(_$OneOfFreezedInputImpl _value,
      $Res Function(_$OneOfFreezedInputImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? str = null,
  }) {
    return _then(_$OneOfFreezedInputImpl(
      null == str
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OneOfFreezedInputImpl implements _OneOfFreezedInput {
  const _$OneOfFreezedInputImpl(this.str);

  factory _$OneOfFreezedInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$OneOfFreezedInputImplFromJson(json);

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
            other is _$OneOfFreezedInputImpl &&
            (identical(other.str, str) || other.str == str));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, str);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OneOfFreezedInputImplCopyWith<_$OneOfFreezedInputImpl> get copyWith =>
      __$$OneOfFreezedInputImplCopyWithImpl<_$OneOfFreezedInputImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OneOfFreezedInputImplToJson(
      this,
    );
  }
}

abstract class _OneOfFreezedInput implements OneOfFreezedInput {
  const factory _OneOfFreezedInput(final String str) = _$OneOfFreezedInputImpl;

  factory _OneOfFreezedInput.fromJson(Map<String, dynamic> json) =
      _$OneOfFreezedInputImpl.fromJson;

  @override
  String get str;
  @override
  @JsonKey(ignore: true)
  _$$OneOfFreezedInputImplCopyWith<_$OneOfFreezedInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
