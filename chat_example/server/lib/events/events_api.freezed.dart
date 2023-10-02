// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DBEventData _$DBEventDataFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'chat':
      return ChatDBEventData.fromJson(json);
    case 'userChat':
      return UserChatDBEventData.fromJson(json);
    case 'user':
      return UserDBEventData.fromJson(json);
    case 'message':
      return ChatMessageDBEventData.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'DBEventData',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$DBEventData {
  DBEventDataKeyed get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatEvent value) chat,
    required TResult Function(UserChatEvent value) userChat,
    required TResult Function(UserEvent value) user,
    required TResult Function(ChatMessageEvent value) message,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatEvent value)? chat,
    TResult? Function(UserChatEvent value)? userChat,
    TResult? Function(UserEvent value)? user,
    TResult? Function(ChatMessageEvent value)? message,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatEvent value)? chat,
    TResult Function(UserChatEvent value)? userChat,
    TResult Function(UserEvent value)? user,
    TResult Function(ChatMessageEvent value)? message,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDBEventData value) chat,
    required TResult Function(UserChatDBEventData value) userChat,
    required TResult Function(UserDBEventData value) user,
    required TResult Function(ChatMessageDBEventData value) message,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDBEventData value)? chat,
    TResult? Function(UserChatDBEventData value)? userChat,
    TResult? Function(UserDBEventData value)? user,
    TResult? Function(ChatMessageDBEventData value)? message,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDBEventData value)? chat,
    TResult Function(UserChatDBEventData value)? userChat,
    TResult Function(UserDBEventData value)? user,
    TResult Function(ChatMessageDBEventData value)? message,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DBEventDataCopyWith<$Res> {
  factory $DBEventDataCopyWith(
          DBEventData value, $Res Function(DBEventData) then) =
      _$DBEventDataCopyWithImpl<$Res, DBEventData>;
}

/// @nodoc
class _$DBEventDataCopyWithImpl<$Res, $Val extends DBEventData>
    implements $DBEventDataCopyWith<$Res> {
  _$DBEventDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatDBEventDataCopyWith<$Res> {
  factory _$$ChatDBEventDataCopyWith(
          _$ChatDBEventData value, $Res Function(_$ChatDBEventData) then) =
      __$$ChatDBEventDataCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatEvent value});

  $ChatEventCopyWith<$Res> get value;
}

/// @nodoc
class __$$ChatDBEventDataCopyWithImpl<$Res>
    extends _$DBEventDataCopyWithImpl<$Res, _$ChatDBEventData>
    implements _$$ChatDBEventDataCopyWith<$Res> {
  __$$ChatDBEventDataCopyWithImpl(
      _$ChatDBEventData _value, $Res Function(_$ChatDBEventData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ChatDBEventData(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as ChatEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatEventCopyWith<$Res> get value {
    return $ChatEventCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatDBEventData extends ChatDBEventData {
  const _$ChatDBEventData(this.value, {final String? $type})
      : $type = $type ?? 'chat',
        super._();

  factory _$ChatDBEventData.fromJson(Map<String, dynamic> json) =>
      _$$ChatDBEventDataFromJson(json);

  @override
  final ChatEvent value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DBEventData.chat(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDBEventData &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDBEventDataCopyWith<_$ChatDBEventData> get copyWith =>
      __$$ChatDBEventDataCopyWithImpl<_$ChatDBEventData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatEvent value) chat,
    required TResult Function(UserChatEvent value) userChat,
    required TResult Function(UserEvent value) user,
    required TResult Function(ChatMessageEvent value) message,
  }) {
    return chat(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatEvent value)? chat,
    TResult? Function(UserChatEvent value)? userChat,
    TResult? Function(UserEvent value)? user,
    TResult? Function(ChatMessageEvent value)? message,
  }) {
    return chat?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatEvent value)? chat,
    TResult Function(UserChatEvent value)? userChat,
    TResult Function(UserEvent value)? user,
    TResult Function(ChatMessageEvent value)? message,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDBEventData value) chat,
    required TResult Function(UserChatDBEventData value) userChat,
    required TResult Function(UserDBEventData value) user,
    required TResult Function(ChatMessageDBEventData value) message,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDBEventData value)? chat,
    TResult? Function(UserChatDBEventData value)? userChat,
    TResult? Function(UserDBEventData value)? user,
    TResult? Function(ChatMessageDBEventData value)? message,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDBEventData value)? chat,
    TResult Function(UserChatDBEventData value)? userChat,
    TResult Function(UserDBEventData value)? user,
    TResult Function(ChatMessageDBEventData value)? message,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatDBEventDataToJson(
      this,
    );
  }
}

abstract class ChatDBEventData extends DBEventData {
  const factory ChatDBEventData(final ChatEvent value) = _$ChatDBEventData;
  const ChatDBEventData._() : super._();

  factory ChatDBEventData.fromJson(Map<String, dynamic> json) =
      _$ChatDBEventData.fromJson;

  @override
  ChatEvent get value;
  @JsonKey(ignore: true)
  _$$ChatDBEventDataCopyWith<_$ChatDBEventData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserChatDBEventDataCopyWith<$Res> {
  factory _$$UserChatDBEventDataCopyWith(_$UserChatDBEventData value,
          $Res Function(_$UserChatDBEventData) then) =
      __$$UserChatDBEventDataCopyWithImpl<$Res>;
  @useResult
  $Res call({UserChatEvent value});

  $UserChatEventCopyWith<$Res> get value;
}

/// @nodoc
class __$$UserChatDBEventDataCopyWithImpl<$Res>
    extends _$DBEventDataCopyWithImpl<$Res, _$UserChatDBEventData>
    implements _$$UserChatDBEventDataCopyWith<$Res> {
  __$$UserChatDBEventDataCopyWithImpl(
      _$UserChatDBEventData _value, $Res Function(_$UserChatDBEventData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$UserChatDBEventData(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as UserChatEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserChatEventCopyWith<$Res> get value {
    return $UserChatEventCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatDBEventData extends UserChatDBEventData {
  const _$UserChatDBEventData(this.value, {final String? $type})
      : $type = $type ?? 'userChat',
        super._();

  factory _$UserChatDBEventData.fromJson(Map<String, dynamic> json) =>
      _$$UserChatDBEventDataFromJson(json);

  @override
  final UserChatEvent value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DBEventData.userChat(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChatDBEventData &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChatDBEventDataCopyWith<_$UserChatDBEventData> get copyWith =>
      __$$UserChatDBEventDataCopyWithImpl<_$UserChatDBEventData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatEvent value) chat,
    required TResult Function(UserChatEvent value) userChat,
    required TResult Function(UserEvent value) user,
    required TResult Function(ChatMessageEvent value) message,
  }) {
    return userChat(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatEvent value)? chat,
    TResult? Function(UserChatEvent value)? userChat,
    TResult? Function(UserEvent value)? user,
    TResult? Function(ChatMessageEvent value)? message,
  }) {
    return userChat?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatEvent value)? chat,
    TResult Function(UserChatEvent value)? userChat,
    TResult Function(UserEvent value)? user,
    TResult Function(ChatMessageEvent value)? message,
    required TResult orElse(),
  }) {
    if (userChat != null) {
      return userChat(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDBEventData value) chat,
    required TResult Function(UserChatDBEventData value) userChat,
    required TResult Function(UserDBEventData value) user,
    required TResult Function(ChatMessageDBEventData value) message,
  }) {
    return userChat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDBEventData value)? chat,
    TResult? Function(UserChatDBEventData value)? userChat,
    TResult? Function(UserDBEventData value)? user,
    TResult? Function(ChatMessageDBEventData value)? message,
  }) {
    return userChat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDBEventData value)? chat,
    TResult Function(UserChatDBEventData value)? userChat,
    TResult Function(UserDBEventData value)? user,
    TResult Function(ChatMessageDBEventData value)? message,
    required TResult orElse(),
  }) {
    if (userChat != null) {
      return userChat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChatDBEventDataToJson(
      this,
    );
  }
}

abstract class UserChatDBEventData extends DBEventData {
  const factory UserChatDBEventData(final UserChatEvent value) =
      _$UserChatDBEventData;
  const UserChatDBEventData._() : super._();

  factory UserChatDBEventData.fromJson(Map<String, dynamic> json) =
      _$UserChatDBEventData.fromJson;

  @override
  UserChatEvent get value;
  @JsonKey(ignore: true)
  _$$UserChatDBEventDataCopyWith<_$UserChatDBEventData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserDBEventDataCopyWith<$Res> {
  factory _$$UserDBEventDataCopyWith(
          _$UserDBEventData value, $Res Function(_$UserDBEventData) then) =
      __$$UserDBEventDataCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEvent value});

  $UserEventCopyWith<$Res> get value;
}

/// @nodoc
class __$$UserDBEventDataCopyWithImpl<$Res>
    extends _$DBEventDataCopyWithImpl<$Res, _$UserDBEventData>
    implements _$$UserDBEventDataCopyWith<$Res> {
  __$$UserDBEventDataCopyWithImpl(
      _$UserDBEventData _value, $Res Function(_$UserDBEventData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$UserDBEventData(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as UserEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEventCopyWith<$Res> get value {
    return $UserEventCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDBEventData extends UserDBEventData {
  const _$UserDBEventData(this.value, {final String? $type})
      : $type = $type ?? 'user',
        super._();

  factory _$UserDBEventData.fromJson(Map<String, dynamic> json) =>
      _$$UserDBEventDataFromJson(json);

  @override
  final UserEvent value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DBEventData.user(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDBEventData &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDBEventDataCopyWith<_$UserDBEventData> get copyWith =>
      __$$UserDBEventDataCopyWithImpl<_$UserDBEventData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatEvent value) chat,
    required TResult Function(UserChatEvent value) userChat,
    required TResult Function(UserEvent value) user,
    required TResult Function(ChatMessageEvent value) message,
  }) {
    return user(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatEvent value)? chat,
    TResult? Function(UserChatEvent value)? userChat,
    TResult? Function(UserEvent value)? user,
    TResult? Function(ChatMessageEvent value)? message,
  }) {
    return user?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatEvent value)? chat,
    TResult Function(UserChatEvent value)? userChat,
    TResult Function(UserEvent value)? user,
    TResult Function(ChatMessageEvent value)? message,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDBEventData value) chat,
    required TResult Function(UserChatDBEventData value) userChat,
    required TResult Function(UserDBEventData value) user,
    required TResult Function(ChatMessageDBEventData value) message,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDBEventData value)? chat,
    TResult? Function(UserChatDBEventData value)? userChat,
    TResult? Function(UserDBEventData value)? user,
    TResult? Function(ChatMessageDBEventData value)? message,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDBEventData value)? chat,
    TResult Function(UserChatDBEventData value)? userChat,
    TResult Function(UserDBEventData value)? user,
    TResult Function(ChatMessageDBEventData value)? message,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDBEventDataToJson(
      this,
    );
  }
}

abstract class UserDBEventData extends DBEventData {
  const factory UserDBEventData(final UserEvent value) = _$UserDBEventData;
  const UserDBEventData._() : super._();

  factory UserDBEventData.fromJson(Map<String, dynamic> json) =
      _$UserDBEventData.fromJson;

  @override
  UserEvent get value;
  @JsonKey(ignore: true)
  _$$UserDBEventDataCopyWith<_$UserDBEventData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageDBEventDataCopyWith<$Res> {
  factory _$$ChatMessageDBEventDataCopyWith(_$ChatMessageDBEventData value,
          $Res Function(_$ChatMessageDBEventData) then) =
      __$$ChatMessageDBEventDataCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatMessageEvent value});

  $ChatMessageEventCopyWith<$Res> get value;
}

/// @nodoc
class __$$ChatMessageDBEventDataCopyWithImpl<$Res>
    extends _$DBEventDataCopyWithImpl<$Res, _$ChatMessageDBEventData>
    implements _$$ChatMessageDBEventDataCopyWith<$Res> {
  __$$ChatMessageDBEventDataCopyWithImpl(_$ChatMessageDBEventData _value,
      $Res Function(_$ChatMessageDBEventData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ChatMessageDBEventData(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as ChatMessageEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageEventCopyWith<$Res> get value {
    return $ChatMessageEventCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageDBEventData extends ChatMessageDBEventData {
  const _$ChatMessageDBEventData(this.value, {final String? $type})
      : $type = $type ?? 'message',
        super._();

  factory _$ChatMessageDBEventData.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDBEventDataFromJson(json);

  @override
  final ChatMessageEvent value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DBEventData.message(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDBEventData &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDBEventDataCopyWith<_$ChatMessageDBEventData> get copyWith =>
      __$$ChatMessageDBEventDataCopyWithImpl<_$ChatMessageDBEventData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatEvent value) chat,
    required TResult Function(UserChatEvent value) userChat,
    required TResult Function(UserEvent value) user,
    required TResult Function(ChatMessageEvent value) message,
  }) {
    return message(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatEvent value)? chat,
    TResult? Function(UserChatEvent value)? userChat,
    TResult? Function(UserEvent value)? user,
    TResult? Function(ChatMessageEvent value)? message,
  }) {
    return message?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatEvent value)? chat,
    TResult Function(UserChatEvent value)? userChat,
    TResult Function(UserEvent value)? user,
    TResult Function(ChatMessageEvent value)? message,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDBEventData value) chat,
    required TResult Function(UserChatDBEventData value) userChat,
    required TResult Function(UserDBEventData value) user,
    required TResult Function(ChatMessageDBEventData value) message,
  }) {
    return message(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDBEventData value)? chat,
    TResult? Function(UserChatDBEventData value)? userChat,
    TResult? Function(UserDBEventData value)? user,
    TResult? Function(ChatMessageDBEventData value)? message,
  }) {
    return message?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDBEventData value)? chat,
    TResult Function(UserChatDBEventData value)? userChat,
    TResult Function(UserDBEventData value)? user,
    TResult Function(ChatMessageDBEventData value)? message,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDBEventDataToJson(
      this,
    );
  }
}

abstract class ChatMessageDBEventData extends DBEventData {
  const factory ChatMessageDBEventData(final ChatMessageEvent value) =
      _$ChatMessageDBEventData;
  const ChatMessageDBEventData._() : super._();

  factory ChatMessageDBEventData.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDBEventData.fromJson;

  @override
  ChatMessageEvent get value;
  @JsonKey(ignore: true)
  _$$ChatMessageDBEventDataCopyWith<_$ChatMessageDBEventData> get copyWith =>
      throw _privateConstructorUsedError;
}
