// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_rooms_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserChatEvent _$UserChatEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
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
class _$UserChatEventTearOff {
  const _$UserChatEventTearOff();

  UserChatAddedEvent added({required ChatRoomUser chatUser}) {
    return UserChatAddedEvent(
      chatUser: chatUser,
    );
  }

  UserChatRemovedEvent removed({required int chatId, required int userId}) {
    return UserChatRemovedEvent(
      chatId: chatId,
      userId: userId,
    );
  }

  UserChatEvent fromJson(Map<String, Object> json) {
    return UserChatEvent.fromJson(json);
  }
}

/// @nodoc
const $UserChatEvent = _$UserChatEventTearOff();

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
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
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
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
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
      _$UserChatEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserChatEventCopyWithImpl<$Res>
    implements $UserChatEventCopyWith<$Res> {
  _$UserChatEventCopyWithImpl(this._value, this._then);

  final UserChatEvent _value;
  // ignore: unused_field
  final $Res Function(UserChatEvent) _then;
}

/// @nodoc
abstract class $UserChatAddedEventCopyWith<$Res> {
  factory $UserChatAddedEventCopyWith(
          UserChatAddedEvent value, $Res Function(UserChatAddedEvent) then) =
      _$UserChatAddedEventCopyWithImpl<$Res>;
  $Res call({ChatRoomUser chatUser});
}

/// @nodoc
class _$UserChatAddedEventCopyWithImpl<$Res>
    extends _$UserChatEventCopyWithImpl<$Res>
    implements $UserChatAddedEventCopyWith<$Res> {
  _$UserChatAddedEventCopyWithImpl(
      UserChatAddedEvent _value, $Res Function(UserChatAddedEvent) _then)
      : super(_value, (v) => _then(v as UserChatAddedEvent));

  @override
  UserChatAddedEvent get _value => super._value as UserChatAddedEvent;

  @override
  $Res call({
    Object? chatUser = freezed,
  }) {
    return _then(UserChatAddedEvent(
      chatUser: chatUser == freezed
          ? _value.chatUser
          : chatUser // ignore: cast_nullable_to_non_nullable
              as ChatRoomUser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatAddedEvent extends UserChatAddedEvent {
  const _$UserChatAddedEvent({required this.chatUser}) : super._();

  factory _$UserChatAddedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserChatAddedEventFromJson(json);

  @override
  final ChatRoomUser chatUser;

  @override
  String toString() {
    return 'UserChatEvent.added(chatUser: $chatUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserChatAddedEvent &&
            (identical(other.chatUser, chatUser) ||
                const DeepCollectionEquality()
                    .equals(other.chatUser, chatUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chatUser);

  @JsonKey(ignore: true)
  @override
  $UserChatAddedEventCopyWith<UserChatAddedEvent> get copyWith =>
      _$UserChatAddedEventCopyWithImpl<UserChatAddedEvent>(this, _$identity);

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
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
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
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
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
    return _$$UserChatAddedEventToJson(this)..['runtimeType'] = 'added';
  }
}

abstract class UserChatAddedEvent extends UserChatEvent {
  const factory UserChatAddedEvent({required ChatRoomUser chatUser}) =
      _$UserChatAddedEvent;
  const UserChatAddedEvent._() : super._();

  factory UserChatAddedEvent.fromJson(Map<String, dynamic> json) =
      _$UserChatAddedEvent.fromJson;

  ChatRoomUser get chatUser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserChatAddedEventCopyWith<UserChatAddedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChatRemovedEventCopyWith<$Res> {
  factory $UserChatRemovedEventCopyWith(UserChatRemovedEvent value,
          $Res Function(UserChatRemovedEvent) then) =
      _$UserChatRemovedEventCopyWithImpl<$Res>;
  $Res call({int chatId, int userId});
}

/// @nodoc
class _$UserChatRemovedEventCopyWithImpl<$Res>
    extends _$UserChatEventCopyWithImpl<$Res>
    implements $UserChatRemovedEventCopyWith<$Res> {
  _$UserChatRemovedEventCopyWithImpl(
      UserChatRemovedEvent _value, $Res Function(UserChatRemovedEvent) _then)
      : super(_value, (v) => _then(v as UserChatRemovedEvent));

  @override
  UserChatRemovedEvent get _value => super._value as UserChatRemovedEvent;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? userId = freezed,
  }) {
    return _then(UserChatRemovedEvent(
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatRemovedEvent extends UserChatRemovedEvent {
  const _$UserChatRemovedEvent({required this.chatId, required this.userId})
      : super._();

  factory _$UserChatRemovedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserChatRemovedEventFromJson(json);

  @override
  final int chatId;
  @override
  final int userId;

  @override
  String toString() {
    return 'UserChatEvent.removed(chatId: $chatId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserChatRemovedEvent &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(userId);

  @JsonKey(ignore: true)
  @override
  $UserChatRemovedEventCopyWith<UserChatRemovedEvent> get copyWith =>
      _$UserChatRemovedEventCopyWithImpl<UserChatRemovedEvent>(
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
    TResult Function(ChatRoomUser chatUser)? added,
    TResult Function(int chatId, int userId)? removed,
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
    TResult Function(UserChatAddedEvent value)? added,
    TResult Function(UserChatRemovedEvent value)? removed,
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
    return _$$UserChatRemovedEventToJson(this)..['runtimeType'] = 'removed';
  }
}

abstract class UserChatRemovedEvent extends UserChatEvent {
  const factory UserChatRemovedEvent(
      {required int chatId, required int userId}) = _$UserChatRemovedEvent;
  const UserChatRemovedEvent._() : super._();

  factory UserChatRemovedEvent.fromJson(Map<String, dynamic> json) =
      _$UserChatRemovedEvent.fromJson;

  int get chatId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserChatRemovedEventCopyWith<UserChatRemovedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
