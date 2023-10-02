// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_rooms_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserChatEvent _$UserChatEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'added':
      return UserChatAddedEvent.fromJson(json);
    case 'removed':
      return UserChatRemovedEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UserChatEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UserChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoomUser chatUser) added,
    required TResult Function(int chatId, int userId) removed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatRoomUser chatUser)? added,
    TResult? Function(int chatId, int userId)? removed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserChatAddedEvent value) added,
    required TResult Function(UserChatRemovedEvent value) removed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserChatAddedEvent value)? added,
    TResult? Function(UserChatRemovedEvent value)? removed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChatEventCopyWith<$Res> {
  factory $UserChatEventCopyWith(
          UserChatEvent value, $Res Function(UserChatEvent) then) =
      _$UserChatEventCopyWithImpl<$Res, UserChatEvent>;
}

/// @nodoc
class _$UserChatEventCopyWithImpl<$Res, $Val extends UserChatEvent>
    implements $UserChatEventCopyWith<$Res> {
  _$UserChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UserChatAddedEventCopyWith<$Res> {
  factory _$$UserChatAddedEventCopyWith(_$UserChatAddedEvent value,
          $Res Function(_$UserChatAddedEvent) then) =
      __$$UserChatAddedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatRoomUser chatUser});
}

/// @nodoc
class __$$UserChatAddedEventCopyWithImpl<$Res>
    extends _$UserChatEventCopyWithImpl<$Res, _$UserChatAddedEvent>
    implements _$$UserChatAddedEventCopyWith<$Res> {
  __$$UserChatAddedEventCopyWithImpl(
      _$UserChatAddedEvent _value, $Res Function(_$UserChatAddedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatUser = null,
  }) {
    return _then(_$UserChatAddedEvent(
      chatUser: null == chatUser
          ? _value.chatUser
          : chatUser // ignore: cast_nullable_to_non_nullable
              as ChatRoomUser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatAddedEvent extends UserChatAddedEvent {
  const _$UserChatAddedEvent({required this.chatUser, final String? $type})
      : $type = $type ?? 'added',
        super._();

  factory _$UserChatAddedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserChatAddedEventFromJson(json);

  @override
  final ChatRoomUser chatUser;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserChatEvent.added(chatUser: $chatUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChatAddedEvent &&
            (identical(other.chatUser, chatUser) ||
                other.chatUser == chatUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChatAddedEventCopyWith<_$UserChatAddedEvent> get copyWith =>
      __$$UserChatAddedEventCopyWithImpl<_$UserChatAddedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoomUser chatUser) added,
    required TResult Function(int chatId, int userId) removed,
  }) {
    return added(chatUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatRoomUser chatUser)? added,
    TResult? Function(int chatId, int userId)? removed,
  }) {
    return added?.call(chatUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(chatUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserChatAddedEvent value) added,
    required TResult Function(UserChatRemovedEvent value) removed,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserChatAddedEvent value)? added,
    TResult? Function(UserChatRemovedEvent value)? removed,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChatAddedEventToJson(
      this,
    );
  }
}

abstract class UserChatAddedEvent extends UserChatEvent {
  const factory UserChatAddedEvent({required final ChatRoomUser chatUser}) =
      _$UserChatAddedEvent;
  const UserChatAddedEvent._() : super._();

  factory UserChatAddedEvent.fromJson(Map<String, dynamic> json) =
      _$UserChatAddedEvent.fromJson;

  ChatRoomUser get chatUser;
  @JsonKey(ignore: true)
  _$$UserChatAddedEventCopyWith<_$UserChatAddedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserChatRemovedEventCopyWith<$Res> {
  factory _$$UserChatRemovedEventCopyWith(_$UserChatRemovedEvent value,
          $Res Function(_$UserChatRemovedEvent) then) =
      __$$UserChatRemovedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int chatId, int userId});
}

/// @nodoc
class __$$UserChatRemovedEventCopyWithImpl<$Res>
    extends _$UserChatEventCopyWithImpl<$Res, _$UserChatRemovedEvent>
    implements _$$UserChatRemovedEventCopyWith<$Res> {
  __$$UserChatRemovedEventCopyWithImpl(_$UserChatRemovedEvent _value,
      $Res Function(_$UserChatRemovedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? userId = null,
  }) {
    return _then(_$UserChatRemovedEvent(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatRemovedEvent extends UserChatRemovedEvent {
  const _$UserChatRemovedEvent(
      {required this.chatId, required this.userId, final String? $type})
      : $type = $type ?? 'removed',
        super._();

  factory _$UserChatRemovedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserChatRemovedEventFromJson(json);

  @override
  final int chatId;
  @override
  final int userId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserChatEvent.removed(chatId: $chatId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChatRemovedEvent &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChatRemovedEventCopyWith<_$UserChatRemovedEvent> get copyWith =>
      __$$UserChatRemovedEventCopyWithImpl<_$UserChatRemovedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoomUser chatUser) added,
    required TResult Function(int chatId, int userId) removed,
  }) {
    return removed(chatId, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatRoomUser chatUser)? added,
    TResult? Function(int chatId, int userId)? removed,
  }) {
    return removed?.call(chatId, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed(chatId, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserChatAddedEvent value) added,
    required TResult Function(UserChatRemovedEvent value) removed,
  }) {
    return removed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserChatAddedEvent value)? added,
    TResult? Function(UserChatRemovedEvent value)? removed,
  }) {
    return removed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChatRemovedEventToJson(
      this,
    );
  }
}

abstract class UserChatRemovedEvent extends UserChatEvent {
  const factory UserChatRemovedEvent(
      {required final int chatId,
      required final int userId}) = _$UserChatRemovedEvent;
  const UserChatRemovedEvent._() : super._();

  factory UserChatRemovedEvent.fromJson(Map<String, dynamic> json) =
      _$UserChatRemovedEvent.fromJson;

  int get chatId;
  int get userId;
  @JsonKey(ignore: true)
  _$$UserChatRemovedEventCopyWith<_$UserChatRemovedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
