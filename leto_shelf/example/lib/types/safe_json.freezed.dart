// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'safe_json.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$JsonTearOff {
  const _$JsonTearOff();

  JsonMap map(Map<String, Json> value) {
    return JsonMap(
      value,
    );
  }

  JsonList list(List<Json> value) {
    return JsonList(
      value,
    );
  }

  JsonNumber number(num value) {
    return JsonNumber(
      value,
    );
  }

  JsonBoolean boolean(bool value) {
    return JsonBoolean(
      value,
    );
  }

  JsonStr str(String value) {
    return JsonStr(
      value,
    );
  }

  JsonNone none() {
    return const JsonNone();
  }
}

/// @nodoc
const $Json = _$JsonTearOff();

/// @nodoc
mixin _$Json {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonCopyWith<$Res> {
  factory $JsonCopyWith(Json value, $Res Function(Json) then) =
      _$JsonCopyWithImpl<$Res>;
}

/// @nodoc
class _$JsonCopyWithImpl<$Res> implements $JsonCopyWith<$Res> {
  _$JsonCopyWithImpl(this._value, this._then);

  final Json _value;
  // ignore: unused_field
  final $Res Function(Json) _then;
}

/// @nodoc
abstract class $JsonMapCopyWith<$Res> {
  factory $JsonMapCopyWith(JsonMap value, $Res Function(JsonMap) then) =
      _$JsonMapCopyWithImpl<$Res>;
  $Res call({Map<String, Json> value});
}

/// @nodoc
class _$JsonMapCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonMapCopyWith<$Res> {
  _$JsonMapCopyWithImpl(JsonMap _value, $Res Function(JsonMap) _then)
      : super(_value, (v) => _then(v as JsonMap));

  @override
  JsonMap get _value => super._value as JsonMap;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(JsonMap(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Map<String, Json>,
    ));
  }
}

/// @nodoc

class _$JsonMap extends JsonMap {
  const _$JsonMap(this.value) : super._();

  @override
  final Map<String, Json> value;

  @override
  String toString() {
    return 'Json.map(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JsonMap &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $JsonMapCopyWith<JsonMap> get copyWith =>
      _$JsonMapCopyWithImpl<JsonMap>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return map(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return map?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return map(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return map?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(this);
    }
    return orElse();
  }
}

abstract class JsonMap extends Json {
  const factory JsonMap(Map<String, Json> value) = _$JsonMap;
  const JsonMap._() : super._();

  Map<String, Json> get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonMapCopyWith<JsonMap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonListCopyWith<$Res> {
  factory $JsonListCopyWith(JsonList value, $Res Function(JsonList) then) =
      _$JsonListCopyWithImpl<$Res>;
  $Res call({List<Json> value});
}

/// @nodoc
class _$JsonListCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonListCopyWith<$Res> {
  _$JsonListCopyWithImpl(JsonList _value, $Res Function(JsonList) _then)
      : super(_value, (v) => _then(v as JsonList));

  @override
  JsonList get _value => super._value as JsonList;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(JsonList(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<Json>,
    ));
  }
}

/// @nodoc

class _$JsonList extends JsonList {
  const _$JsonList(this.value) : super._();

  @override
  final List<Json> value;

  @override
  String toString() {
    return 'Json.list(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JsonList &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $JsonListCopyWith<JsonList> get copyWith =>
      _$JsonListCopyWithImpl<JsonList>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return list(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return list?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return list(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return list?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(this);
    }
    return orElse();
  }
}

abstract class JsonList extends Json {
  const factory JsonList(List<Json> value) = _$JsonList;
  const JsonList._() : super._();

  List<Json> get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonListCopyWith<JsonList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonNumberCopyWith<$Res> {
  factory $JsonNumberCopyWith(
          JsonNumber value, $Res Function(JsonNumber) then) =
      _$JsonNumberCopyWithImpl<$Res>;
  $Res call({num value});
}

/// @nodoc
class _$JsonNumberCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonNumberCopyWith<$Res> {
  _$JsonNumberCopyWithImpl(JsonNumber _value, $Res Function(JsonNumber) _then)
      : super(_value, (v) => _then(v as JsonNumber));

  @override
  JsonNumber get _value => super._value as JsonNumber;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(JsonNumber(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

class _$JsonNumber extends JsonNumber {
  const _$JsonNumber(this.value) : super._();

  @override
  final num value;

  @override
  String toString() {
    return 'Json.number(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JsonNumber &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $JsonNumberCopyWith<JsonNumber> get copyWith =>
      _$JsonNumberCopyWithImpl<JsonNumber>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return number(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return number?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return number(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return number?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(this);
    }
    return orElse();
  }
}

abstract class JsonNumber extends Json {
  const factory JsonNumber(num value) = _$JsonNumber;
  const JsonNumber._() : super._();

  num get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonNumberCopyWith<JsonNumber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonBooleanCopyWith<$Res> {
  factory $JsonBooleanCopyWith(
          JsonBoolean value, $Res Function(JsonBoolean) then) =
      _$JsonBooleanCopyWithImpl<$Res>;
  $Res call({bool value});
}

/// @nodoc
class _$JsonBooleanCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonBooleanCopyWith<$Res> {
  _$JsonBooleanCopyWithImpl(
      JsonBoolean _value, $Res Function(JsonBoolean) _then)
      : super(_value, (v) => _then(v as JsonBoolean));

  @override
  JsonBoolean get _value => super._value as JsonBoolean;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(JsonBoolean(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$JsonBoolean extends JsonBoolean {
  const _$JsonBoolean(this.value) : super._();

  @override
  final bool value;

  @override
  String toString() {
    return 'Json.boolean(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JsonBoolean &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $JsonBooleanCopyWith<JsonBoolean> get copyWith =>
      _$JsonBooleanCopyWithImpl<JsonBoolean>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return boolean(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return boolean?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return boolean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return boolean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(this);
    }
    return orElse();
  }
}

abstract class JsonBoolean extends Json {
  const factory JsonBoolean(bool value) = _$JsonBoolean;
  const JsonBoolean._() : super._();

  bool get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonBooleanCopyWith<JsonBoolean> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonStrCopyWith<$Res> {
  factory $JsonStrCopyWith(JsonStr value, $Res Function(JsonStr) then) =
      _$JsonStrCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$JsonStrCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonStrCopyWith<$Res> {
  _$JsonStrCopyWithImpl(JsonStr _value, $Res Function(JsonStr) _then)
      : super(_value, (v) => _then(v as JsonStr));

  @override
  JsonStr get _value => super._value as JsonStr;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(JsonStr(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$JsonStr extends JsonStr {
  const _$JsonStr(this.value) : super._();

  @override
  final String value;

  @override
  String toString() {
    return 'Json.str(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JsonStr &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $JsonStrCopyWith<JsonStr> get copyWith =>
      _$JsonStrCopyWithImpl<JsonStr>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return str(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return str?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (str != null) {
      return str(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return str(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return str?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (str != null) {
      return str(this);
    }
    return orElse();
  }
}

abstract class JsonStr extends Json {
  const factory JsonStr(String value) = _$JsonStr;
  const JsonStr._() : super._();

  String get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonStrCopyWith<JsonStr> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonNoneCopyWith<$Res> {
  factory $JsonNoneCopyWith(JsonNone value, $Res Function(JsonNone) then) =
      _$JsonNoneCopyWithImpl<$Res>;
}

/// @nodoc
class _$JsonNoneCopyWithImpl<$Res> extends _$JsonCopyWithImpl<$Res>
    implements $JsonNoneCopyWith<$Res> {
  _$JsonNoneCopyWithImpl(JsonNone _value, $Res Function(JsonNone) _then)
      : super(_value, (v) => _then(v as JsonNone));

  @override
  JsonNone get _value => super._value as JsonNone;
}

/// @nodoc

class _$JsonNone extends JsonNone {
  const _$JsonNone() : super._();

  @override
  String toString() {
    return 'Json.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is JsonNone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, Json> value) map,
    required TResult Function(List<Json> value) list,
    required TResult Function(num value) number,
    required TResult Function(bool value) boolean,
    required TResult Function(String value) str,
    required TResult Function() none,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, Json> value)? map,
    TResult Function(List<Json> value)? list,
    TResult Function(num value)? number,
    TResult Function(bool value)? boolean,
    TResult Function(String value)? str,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JsonMap value) map,
    required TResult Function(JsonList value) list,
    required TResult Function(JsonNumber value) number,
    required TResult Function(JsonBoolean value) boolean,
    required TResult Function(JsonStr value) str,
    required TResult Function(JsonNone value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JsonMap value)? map,
    TResult Function(JsonList value)? list,
    TResult Function(JsonNumber value)? number,
    TResult Function(JsonBoolean value)? boolean,
    TResult Function(JsonStr value)? str,
    TResult Function(JsonNone value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class JsonNone extends Json {
  const factory JsonNone() = _$JsonNone;
  const JsonNone._() : super._();
}
