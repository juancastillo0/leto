// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserEvent _$UserEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
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
    TResult? Function(User user)? created,
    TResult? Function(UserSession session)? signedUp,
    TResult? Function(UserSession session)? signedIn,
    TResult? Function(int userId, String sessionId)? signedOut,
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
    TResult? Function(UserCreatedEvent value)? created,
    TResult? Function(UserSignedUpEvent value)? signedUp,
    TResult? Function(UserSignedInEvent value)? signedIn,
    TResult? Function(UserSignedOutEvent value)? signedOut,
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
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UserCreatedEventCopyWith<$Res> {
  factory _$$UserCreatedEventCopyWith(
          _$UserCreatedEvent value, $Res Function(_$UserCreatedEvent) then) =
      __$$UserCreatedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$UserCreatedEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserCreatedEvent>
    implements _$$UserCreatedEventCopyWith<$Res> {
  __$$UserCreatedEventCopyWithImpl(
      _$UserCreatedEvent _value, $Res Function(_$UserCreatedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UserCreatedEvent(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCreatedEvent extends UserCreatedEvent {
  const _$UserCreatedEvent({required this.user, final String? $type})
      : $type = $type ?? 'created',
        super._();

  factory _$UserCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserCreatedEventFromJson(json);

  @override
  final User user;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserEvent.created(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCreatedEvent &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCreatedEventCopyWith<_$UserCreatedEvent> get copyWith =>
      __$$UserCreatedEventCopyWithImpl<_$UserCreatedEvent>(this, _$identity);

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
    TResult? Function(User user)? created,
    TResult? Function(UserSession session)? signedUp,
    TResult? Function(UserSession session)? signedIn,
    TResult? Function(int userId, String sessionId)? signedOut,
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
    TResult? Function(UserCreatedEvent value)? created,
    TResult? Function(UserSignedUpEvent value)? signedUp,
    TResult? Function(UserSignedInEvent value)? signedIn,
    TResult? Function(UserSignedOutEvent value)? signedOut,
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
    return _$$UserCreatedEventToJson(
      this,
    );
  }
}

abstract class UserCreatedEvent extends UserEvent {
  const factory UserCreatedEvent({required final User user}) =
      _$UserCreatedEvent;
  const UserCreatedEvent._() : super._();

  factory UserCreatedEvent.fromJson(Map<String, dynamic> json) =
      _$UserCreatedEvent.fromJson;

  User get user;
  @JsonKey(ignore: true)
  _$$UserCreatedEventCopyWith<_$UserCreatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserSignedUpEventCopyWith<$Res> {
  factory _$$UserSignedUpEventCopyWith(
          _$UserSignedUpEvent value, $Res Function(_$UserSignedUpEvent) then) =
      __$$UserSignedUpEventCopyWithImpl<$Res>;
  @useResult
  $Res call({UserSession session});
}

/// @nodoc
class __$$UserSignedUpEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserSignedUpEvent>
    implements _$$UserSignedUpEventCopyWith<$Res> {
  __$$UserSignedUpEventCopyWithImpl(
      _$UserSignedUpEvent _value, $Res Function(_$UserSignedUpEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$UserSignedUpEvent(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as UserSession,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedUpEvent extends UserSignedUpEvent {
  const _$UserSignedUpEvent({required this.session, final String? $type})
      : $type = $type ?? 'signedUp',
        super._();

  factory _$UserSignedUpEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedUpEventFromJson(json);

  @override
  final UserSession session;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserEvent.signedUp(session: $session)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSignedUpEvent &&
            (identical(other.session, session) || other.session == session));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSignedUpEventCopyWith<_$UserSignedUpEvent> get copyWith =>
      __$$UserSignedUpEventCopyWithImpl<_$UserSignedUpEvent>(this, _$identity);

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
    TResult? Function(User user)? created,
    TResult? Function(UserSession session)? signedUp,
    TResult? Function(UserSession session)? signedIn,
    TResult? Function(int userId, String sessionId)? signedOut,
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
    TResult? Function(UserCreatedEvent value)? created,
    TResult? Function(UserSignedUpEvent value)? signedUp,
    TResult? Function(UserSignedInEvent value)? signedIn,
    TResult? Function(UserSignedOutEvent value)? signedOut,
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
    return _$$UserSignedUpEventToJson(
      this,
    );
  }
}

abstract class UserSignedUpEvent extends UserEvent {
  const factory UserSignedUpEvent({required final UserSession session}) =
      _$UserSignedUpEvent;
  const UserSignedUpEvent._() : super._();

  factory UserSignedUpEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedUpEvent.fromJson;

  UserSession get session;
  @JsonKey(ignore: true)
  _$$UserSignedUpEventCopyWith<_$UserSignedUpEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserSignedInEventCopyWith<$Res> {
  factory _$$UserSignedInEventCopyWith(
          _$UserSignedInEvent value, $Res Function(_$UserSignedInEvent) then) =
      __$$UserSignedInEventCopyWithImpl<$Res>;
  @useResult
  $Res call({UserSession session});
}

/// @nodoc
class __$$UserSignedInEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserSignedInEvent>
    implements _$$UserSignedInEventCopyWith<$Res> {
  __$$UserSignedInEventCopyWithImpl(
      _$UserSignedInEvent _value, $Res Function(_$UserSignedInEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$UserSignedInEvent(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as UserSession,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedInEvent extends UserSignedInEvent {
  const _$UserSignedInEvent({required this.session, final String? $type})
      : $type = $type ?? 'signedIn',
        super._();

  factory _$UserSignedInEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedInEventFromJson(json);

  @override
  final UserSession session;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserEvent.signedIn(session: $session)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSignedInEvent &&
            (identical(other.session, session) || other.session == session));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSignedInEventCopyWith<_$UserSignedInEvent> get copyWith =>
      __$$UserSignedInEventCopyWithImpl<_$UserSignedInEvent>(this, _$identity);

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
    TResult? Function(User user)? created,
    TResult? Function(UserSession session)? signedUp,
    TResult? Function(UserSession session)? signedIn,
    TResult? Function(int userId, String sessionId)? signedOut,
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
    TResult? Function(UserCreatedEvent value)? created,
    TResult? Function(UserSignedUpEvent value)? signedUp,
    TResult? Function(UserSignedInEvent value)? signedIn,
    TResult? Function(UserSignedOutEvent value)? signedOut,
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
    return _$$UserSignedInEventToJson(
      this,
    );
  }
}

abstract class UserSignedInEvent extends UserEvent {
  const factory UserSignedInEvent({required final UserSession session}) =
      _$UserSignedInEvent;
  const UserSignedInEvent._() : super._();

  factory UserSignedInEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedInEvent.fromJson;

  UserSession get session;
  @JsonKey(ignore: true)
  _$$UserSignedInEventCopyWith<_$UserSignedInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserSignedOutEventCopyWith<$Res> {
  factory _$$UserSignedOutEventCopyWith(_$UserSignedOutEvent value,
          $Res Function(_$UserSignedOutEvent) then) =
      __$$UserSignedOutEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int userId, String sessionId});
}

/// @nodoc
class __$$UserSignedOutEventCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserSignedOutEvent>
    implements _$$UserSignedOutEventCopyWith<$Res> {
  __$$UserSignedOutEventCopyWithImpl(
      _$UserSignedOutEvent _value, $Res Function(_$UserSignedOutEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? sessionId = null,
  }) {
    return _then(_$UserSignedOutEvent(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSignedOutEvent extends UserSignedOutEvent {
  const _$UserSignedOutEvent(
      {required this.userId, required this.sessionId, final String? $type})
      : $type = $type ?? 'signedOut',
        super._();

  factory _$UserSignedOutEvent.fromJson(Map<String, dynamic> json) =>
      _$$UserSignedOutEventFromJson(json);

  @override
  final int userId;
  @override
  final String sessionId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserEvent.signedOut(userId: $userId, sessionId: $sessionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSignedOutEvent &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, sessionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSignedOutEventCopyWith<_$UserSignedOutEvent> get copyWith =>
      __$$UserSignedOutEventCopyWithImpl<_$UserSignedOutEvent>(
          this, _$identity);

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
    TResult? Function(User user)? created,
    TResult? Function(UserSession session)? signedUp,
    TResult? Function(UserSession session)? signedIn,
    TResult? Function(int userId, String sessionId)? signedOut,
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
    TResult? Function(UserCreatedEvent value)? created,
    TResult? Function(UserSignedUpEvent value)? signedUp,
    TResult? Function(UserSignedInEvent value)? signedIn,
    TResult? Function(UserSignedOutEvent value)? signedOut,
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
    return _$$UserSignedOutEventToJson(
      this,
    );
  }
}

abstract class UserSignedOutEvent extends UserEvent {
  const factory UserSignedOutEvent(
      {required final int userId,
      required final String sessionId}) = _$UserSignedOutEvent;
  const UserSignedOutEvent._() : super._();

  factory UserSignedOutEvent.fromJson(Map<String, dynamic> json) =
      _$UserSignedOutEvent.fromJson;

  int get userId;
  String get sessionId;
  @JsonKey(ignore: true)
  _$$UserSignedOutEventCopyWith<_$UserSignedOutEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
