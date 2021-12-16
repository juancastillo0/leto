// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserEvent _$UserEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
    case 'created':
      return UserCreatedEvent.fromJson(json);
    case 'signedUp':
      return UserSignedUpEvent.fromJson(json);
    case 'signedIn':
      return UserSignedInEvent.fromJson(json);
    case 'signedOut':
      return UserSignedOutEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UserEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$UserEventTearOff {
  const _$UserEventTearOff();

  UserCreatedEvent created({required User user}) {
    return UserCreatedEvent(
      user: user,
    );
  }

  UserSignedUpEvent signedUp({required UserSession session}) {
    return UserSignedUpEvent(
      session: session,
    );
  }

  UserSignedInEvent signedIn({required UserSession session}) {
    return UserSignedInEvent(
      session: session,
    );
  }

  UserSignedOutEvent signedOut(
      {required int userId, required String sessionId}) {
    return UserSignedOutEvent(
      userId: userId,
      sessionId: sessionId,
    );
  }

  UserEvent fromJson(Map<String, Object> json) {
    return UserEvent.fromJson(json);
  }
}

/// @nodoc
const $UserEvent = _$UserEventTearOff();

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) created,
    required TResult Function(UserSession session) signedUp,
    required TResult Function(UserSession session) signedIn,
    required TResult Function(int userId, String sessionId) signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserCreatedEvent value) created,
    required TResult Function(UserSignedUpEvent value) signedUp,
    required TResult Function(UserSignedInEvent value) signedIn,
    required TResult Function(UserSignedOutEvent value) signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res> implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  final UserEvent _value;
  // ignore: unused_field
  final $Res Function(UserEvent) _then;
}

/// @nodoc
abstract class $UserCreatedEventCopyWith<$Res> {
  factory $UserCreatedEventCopyWith(
          UserCreatedEvent value, $Res Function(UserCreatedEvent) then) =
      _$UserCreatedEventCopyWithImpl<$Res>;
  $Res call({User user});
}

/// @nodoc
class _$UserCreatedEventCopyWithImpl<$Res> extends _$UserEventCopyWithImpl<$Res>
    implements $UserCreatedEventCopyWith<$Res> {
  _$UserCreatedEventCopyWithImpl(
      UserCreatedEvent _value, $Res Function(UserCreatedEvent) _then)
      : super(_value, (v) => _then(v as UserCreatedEvent));

  @override
  UserCreatedEvent get _value => super._value as UserCreatedEvent;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(UserCreatedEvent(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCreatedEvent extends UserCreatedEvent {
  const _$UserCreatedEvent({required this.user}) : super._();

  factory _$UserCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserCreatedEventFromJson(json);

  @override
  final User user;

  @override
  String toString() {
    return 'UserEvent.created(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCreatedEvent &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $UserCreatedEventCopyWith<UserCreatedEvent> get copyWith =>
      _$UserCreatedEventCopyWithImpl<UserCreatedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) created,
    required TResult Function(UserSession session) signedUp,
    required TResult Function(UserSession session) signedIn,
    required TResult Function(int userId, String sessionId) signedOut,
  }) {
    return created(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
  }) {
    return created?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserCreatedEvent value) created,
    required TResult Function(UserSignedUpEvent value) signedUp,
    required TResult Function(UserSignedInEvent value) signedIn,
    required TResult Function(UserSignedOutEvent value) signedOut,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCreatedEventToJson(this)..['runtimeType'] = 'created';
  }
}

abstract class UserCreatedEvent extends UserEvent {
  const factory UserCreatedEvent({required User user}) = _$UserCreatedEvent;
  const UserCreatedEvent._() : super._();

  factory UserCreatedEvent.fromJson(Map<String, dynamic> json) =
      _$UserCreatedEvent.fromJson;

  User get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCreatedEventCopyWith<UserCreatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSignedUpEventCopyWith<$Res> {
  factory $UserSignedUpEventCopyWith(
          UserSignedUpEvent value, $Res Function(UserSignedUpEvent) then) =
      _$UserSignedUpEventCopyWithImpl<$Res>;
  $Res call({UserSession session});
}

/// @nodoc
class _$UserSignedUpEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res>
    implements $UserSignedUpEventCopyWith<$Res> {
  _$UserSignedUpEventCopyWithImpl(
      UserSignedUpEvent _value, $Res Function(UserSignedUpEvent) _then)
      : super(_value, (v) => _then(v as UserSignedUpEvent));

  @override
  UserSignedUpEvent get _value => super._value as UserSignedUpEvent;

  @override
  $Res call({
    Object? session = freezed,
  }) {
    return _then(UserSignedUpEvent(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as UserSession,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedUpEvent extends UserSignedUpEvent {
  const _$UserSignedUpEvent({required this.session}) : super._();

  factory _$UserSignedUpEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedUpEventFromJson(json);

  @override
  final UserSession session;

  @override
  String toString() {
    return 'UserEvent.signedUp(session: $session)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSignedUpEvent &&
            (identical(other.session, session) ||
                const DeepCollectionEquality().equals(other.session, session)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(session);

  @JsonKey(ignore: true)
  @override
  $UserSignedUpEventCopyWith<UserSignedUpEvent> get copyWith =>
      _$UserSignedUpEventCopyWithImpl<UserSignedUpEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) created,
    required TResult Function(UserSession session) signedUp,
    required TResult Function(UserSession session) signedIn,
    required TResult Function(int userId, String sessionId) signedOut,
  }) {
    return signedUp(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
  }) {
    return signedUp?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
    required TResult orElse(),
  }) {
    if (signedUp != null) {
      return signedUp(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserCreatedEvent value) created,
    required TResult Function(UserSignedUpEvent value) signedUp,
    required TResult Function(UserSignedInEvent value) signedIn,
    required TResult Function(UserSignedOutEvent value) signedOut,
  }) {
    return signedUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
  }) {
    return signedUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
    required TResult orElse(),
  }) {
    if (signedUp != null) {
      return signedUp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSignedUpEventToJson(this)..['runtimeType'] = 'signedUp';
  }
}

abstract class UserSignedUpEvent extends UserEvent {
  const factory UserSignedUpEvent({required UserSession session}) =
      _$UserSignedUpEvent;
  const UserSignedUpEvent._() : super._();

  factory UserSignedUpEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedUpEvent.fromJson;

  UserSession get session => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSignedUpEventCopyWith<UserSignedUpEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSignedInEventCopyWith<$Res> {
  factory $UserSignedInEventCopyWith(
          UserSignedInEvent value, $Res Function(UserSignedInEvent) then) =
      _$UserSignedInEventCopyWithImpl<$Res>;
  $Res call({UserSession session});
}

/// @nodoc
class _$UserSignedInEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res>
    implements $UserSignedInEventCopyWith<$Res> {
  _$UserSignedInEventCopyWithImpl(
      UserSignedInEvent _value, $Res Function(UserSignedInEvent) _then)
      : super(_value, (v) => _then(v as UserSignedInEvent));

  @override
  UserSignedInEvent get _value => super._value as UserSignedInEvent;

  @override
  $Res call({
    Object? session = freezed,
  }) {
    return _then(UserSignedInEvent(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as UserSession,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedInEvent extends UserSignedInEvent {
  const _$UserSignedInEvent({required this.session}) : super._();

  factory _$UserSignedInEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedInEventFromJson(json);

  @override
  final UserSession session;

  @override
  String toString() {
    return 'UserEvent.signedIn(session: $session)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSignedInEvent &&
            (identical(other.session, session) ||
                const DeepCollectionEquality().equals(other.session, session)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(session);

  @JsonKey(ignore: true)
  @override
  $UserSignedInEventCopyWith<UserSignedInEvent> get copyWith =>
      _$UserSignedInEventCopyWithImpl<UserSignedInEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) created,
    required TResult Function(UserSession session) signedUp,
    required TResult Function(UserSession session) signedIn,
    required TResult Function(int userId, String sessionId) signedOut,
  }) {
    return signedIn(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
  }) {
    return signedIn?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserCreatedEvent value) created,
    required TResult Function(UserSignedUpEvent value) signedUp,
    required TResult Function(UserSignedInEvent value) signedIn,
    required TResult Function(UserSignedOutEvent value) signedOut,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSignedInEventToJson(this)..['runtimeType'] = 'signedIn';
  }
}

abstract class UserSignedInEvent extends UserEvent {
  const factory UserSignedInEvent({required UserSession session}) =
      _$UserSignedInEvent;
  const UserSignedInEvent._() : super._();

  factory UserSignedInEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedInEvent.fromJson;

  UserSession get session => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSignedInEventCopyWith<UserSignedInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSignedOutEventCopyWith<$Res> {
  factory $UserSignedOutEventCopyWith(
          UserSignedOutEvent value, $Res Function(UserSignedOutEvent) then) =
      _$UserSignedOutEventCopyWithImpl<$Res>;
  $Res call({int userId, String sessionId});
}

/// @nodoc
class _$UserSignedOutEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res>
    implements $UserSignedOutEventCopyWith<$Res> {
  _$UserSignedOutEventCopyWithImpl(
      UserSignedOutEvent _value, $Res Function(UserSignedOutEvent) _then)
      : super(_value, (v) => _then(v as UserSignedOutEvent));

  @override
  UserSignedOutEvent get _value => super._value as UserSignedOutEvent;

  @override
  $Res call({
    Object? userId = freezed,
    Object? sessionId = freezed,
  }) {
    return _then(UserSignedOutEvent(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      sessionId: sessionId == freezed
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedOutEvent extends UserSignedOutEvent {
  const _$UserSignedOutEvent({required this.userId, required this.sessionId})
      : super._();

  factory _$UserSignedOutEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedOutEventFromJson(json);

  @override
  final int userId;
  @override
  final String sessionId;

  @override
  String toString() {
    return 'UserEvent.signedOut(userId: $userId, sessionId: $sessionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSignedOutEvent &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(sessionId);

  @JsonKey(ignore: true)
  @override
  $UserSignedOutEventCopyWith<UserSignedOutEvent> get copyWith =>
      _$UserSignedOutEventCopyWithImpl<UserSignedOutEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) created,
    required TResult Function(UserSession session) signedUp,
    required TResult Function(UserSession session) signedIn,
    required TResult Function(int userId, String sessionId) signedOut,
  }) {
    return signedOut(userId, sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
  }) {
    return signedOut?.call(userId, sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? created,
    TResult Function(UserSession session)? signedUp,
    TResult Function(UserSession session)? signedIn,
    TResult Function(int userId, String sessionId)? signedOut,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut(userId, sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserCreatedEvent value) created,
    required TResult Function(UserSignedUpEvent value) signedUp,
    required TResult Function(UserSignedInEvent value) signedIn,
    required TResult Function(UserSignedOutEvent value) signedOut,
  }) {
    return signedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
  }) {
    return signedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserCreatedEvent value)? created,
    TResult Function(UserSignedUpEvent value)? signedUp,
    TResult Function(UserSignedInEvent value)? signedIn,
    TResult Function(UserSignedOutEvent value)? signedOut,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSignedOutEventToJson(this)..['runtimeType'] = 'signedOut';
  }
}

abstract class UserSignedOutEvent extends UserEvent {
  const factory UserSignedOutEvent(
      {required int userId, required String sessionId}) = _$UserSignedOutEvent;
  const UserSignedOutEvent._() : super._();

  factory UserSignedOutEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedOutEvent.fromJson;

  int get userId => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSignedOutEventCopyWith<UserSignedOutEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
