// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatEvent _$ChatEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'created':
      return ChatCreatedEvent.fromJson(json);
    case 'deleted':
      return ChatDeletedEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ChatEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoom chat, int ownerId) created,
    required TResult Function(int chatId) deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatCreatedEvent value) created,
    required TResult Function(ChatDeletedEvent value) deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<$Res> {
  factory $ChatEventCopyWith(ChatEvent value, $Res Function(ChatEvent) then) =
      _$ChatEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res> implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  final ChatEvent _value;
  // ignore: unused_field
  final $Res Function(ChatEvent) _then;
}

/// @nodoc
abstract class _$$ChatCreatedEventCopyWith<$Res> {
  factory _$$ChatCreatedEventCopyWith(
          _$ChatCreatedEvent value, $Res Function(_$ChatCreatedEvent) then) =
      __$$ChatCreatedEventCopyWithImpl<$Res>;
  $Res call({ChatRoom chat, int ownerId});

  $ChatRoomCopyWith<$Res> get chat;
}

/// @nodoc
class __$$ChatCreatedEventCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res>
    implements _$$ChatCreatedEventCopyWith<$Res> {
  __$$ChatCreatedEventCopyWithImpl(
      _$ChatCreatedEvent _value, $Res Function(_$ChatCreatedEvent) _then)
      : super(_value, (v) => _then(v as _$ChatCreatedEvent));

  @override
  _$ChatCreatedEvent get _value => super._value as _$ChatCreatedEvent;

  @override
  $Res call({
    Object? chat = freezed,
    Object? ownerId = freezed,
  }) {
    return _then(_$ChatCreatedEvent(
      chat: chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatRoom,
      ownerId: ownerId == freezed
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $ChatRoomCopyWith<$Res> get chat {
    return $ChatRoomCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatCreatedEvent extends ChatCreatedEvent {
  const _$ChatCreatedEvent(
      {required this.chat, required this.ownerId, final String? $type})
      : $type = $type ?? 'created',
        super._();

  factory _$ChatCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatCreatedEventFromJson(json);

  @override
  final ChatRoom chat;
  @override
  final int ownerId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatEvent.created(chat: $chat, ownerId: $ownerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatCreatedEvent &&
            const DeepCollectionEquality().equals(other.chat, chat) &&
            const DeepCollectionEquality().equals(other.ownerId, ownerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chat),
      const DeepCollectionEquality().hash(ownerId));

  @JsonKey(ignore: true)
  @override
  _$$ChatCreatedEventCopyWith<_$ChatCreatedEvent> get copyWith =>
      __$$ChatCreatedEventCopyWithImpl<_$ChatCreatedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoom chat, int ownerId) created,
    required TResult Function(int chatId) deleted,
  }) {
    return created(chat, ownerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
  }) {
    return created?.call(chat, ownerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(chat, ownerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatCreatedEvent value) created,
    required TResult Function(ChatDeletedEvent value) deleted,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatCreatedEventToJson(this);
  }
}

abstract class ChatCreatedEvent extends ChatEvent {
  const factory ChatCreatedEvent(
      {required final ChatRoom chat,
      required final int ownerId}) = _$ChatCreatedEvent;
  const ChatCreatedEvent._() : super._();

  factory ChatCreatedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatCreatedEvent.fromJson;

  ChatRoom get chat => throw _privateConstructorUsedError;
  int get ownerId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ChatCreatedEventCopyWith<_$ChatCreatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatDeletedEventCopyWith<$Res> {
  factory _$$ChatDeletedEventCopyWith(
          _$ChatDeletedEvent value, $Res Function(_$ChatDeletedEvent) then) =
      __$$ChatDeletedEventCopyWithImpl<$Res>;
  $Res call({int chatId});
}

/// @nodoc
class __$$ChatDeletedEventCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res>
    implements _$$ChatDeletedEventCopyWith<$Res> {
  __$$ChatDeletedEventCopyWithImpl(
      _$ChatDeletedEvent _value, $Res Function(_$ChatDeletedEvent) _then)
      : super(_value, (v) => _then(v as _$ChatDeletedEvent));

  @override
  _$ChatDeletedEvent get _value => super._value as _$ChatDeletedEvent;

  @override
  $Res call({
    Object? chatId = freezed,
  }) {
    return _then(_$ChatDeletedEvent(
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatDeletedEvent extends ChatDeletedEvent {
  const _$ChatDeletedEvent({required this.chatId, final String? $type})
      : $type = $type ?? 'deleted',
        super._();

  factory _$ChatDeletedEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatDeletedEventFromJson(json);

  @override
  final int chatId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatEvent.deleted(chatId: $chatId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDeletedEvent &&
            const DeepCollectionEquality().equals(other.chatId, chatId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chatId));

  @JsonKey(ignore: true)
  @override
  _$$ChatDeletedEventCopyWith<_$ChatDeletedEvent> get copyWith =>
      __$$ChatDeletedEventCopyWithImpl<_$ChatDeletedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatRoom chat, int ownerId) created,
    required TResult Function(int chatId) deleted,
  }) {
    return deleted(chatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
  }) {
    return deleted?.call(chatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatRoom chat, int ownerId)? created,
    TResult Function(int chatId)? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(chatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatCreatedEvent value) created,
    required TResult Function(ChatDeletedEvent value) deleted,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatCreatedEvent value)? created,
    TResult Function(ChatDeletedEvent value)? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatDeletedEventToJson(this);
  }
}

abstract class ChatDeletedEvent extends ChatEvent {
  const factory ChatDeletedEvent({required final int chatId}) =
      _$ChatDeletedEvent;
  const ChatDeletedEvent._() : super._();

  factory ChatDeletedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatDeletedEvent.fromJson;

  int get chatId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ChatDeletedEventCopyWith<_$ChatDeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  @GraphQLField(omit: true)
  List<ChatMessage>? get messagesCache => throw _privateConstructorUsedError;
  @GraphQLField(omit: true)
  List<ChatRoomUser>? get usersCache => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      DateTime createdAt,
      @GraphQLField(omit: true) List<ChatMessage>? messagesCache,
      @GraphQLField(omit: true) List<ChatRoomUser>? usersCache});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res> implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  final ChatRoom _value;
  // ignore: unused_field
  final $Res Function(ChatRoom) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? messagesCache = freezed,
    Object? usersCache = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messagesCache: messagesCache == freezed
          ? _value.messagesCache
          : messagesCache // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      usersCache: usersCache == freezed
          ? _value.usersCache
          : usersCache // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomUser>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$$_ChatRoomCopyWith(
          _$_ChatRoom value, $Res Function(_$_ChatRoom) then) =
      __$$_ChatRoomCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      DateTime createdAt,
      @GraphQLField(omit: true) List<ChatMessage>? messagesCache,
      @GraphQLField(omit: true) List<ChatRoomUser>? usersCache});
}

/// @nodoc
class __$$_ChatRoomCopyWithImpl<$Res> extends _$ChatRoomCopyWithImpl<$Res>
    implements _$$_ChatRoomCopyWith<$Res> {
  __$$_ChatRoomCopyWithImpl(
      _$_ChatRoom _value, $Res Function(_$_ChatRoom) _then)
      : super(_value, (v) => _then(v as _$_ChatRoom));

  @override
  _$_ChatRoom get _value => super._value as _$_ChatRoom;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? messagesCache = freezed,
    Object? usersCache = freezed,
  }) {
    return _then(_$_ChatRoom(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messagesCache: messagesCache == freezed
          ? _value._messagesCache
          : messagesCache // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      usersCache: usersCache == freezed
          ? _value._usersCache
          : usersCache // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomUser>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatRoom extends _ChatRoom {
  const _$_ChatRoom(
      {required this.id,
      required this.name,
      required this.createdAt,
      @GraphQLField(omit: true) final List<ChatMessage>? messagesCache,
      @GraphQLField(omit: true) final List<ChatRoomUser>? usersCache})
      : _messagesCache = messagesCache,
        _usersCache = usersCache,
        super._();

  factory _$_ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$$_ChatRoomFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  final List<ChatMessage>? _messagesCache;
  @override
  @GraphQLField(omit: true)
  List<ChatMessage>? get messagesCache {
    final value = _messagesCache;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ChatRoomUser>? _usersCache;
  @override
  @GraphQLField(omit: true)
  List<ChatRoomUser>? get usersCache {
    final value = _usersCache;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatRoom(id: $id, name: $name, createdAt: $createdAt, messagesCache: $messagesCache, usersCache: $usersCache)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatRoom &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other._messagesCache, _messagesCache) &&
            const DeepCollectionEquality()
                .equals(other._usersCache, _usersCache));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(_messagesCache),
      const DeepCollectionEquality().hash(_usersCache));

  @JsonKey(ignore: true)
  @override
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      __$$_ChatRoomCopyWithImpl<_$_ChatRoom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatRoomToJson(this);
  }
}

abstract class _ChatRoom extends ChatRoom {
  const factory _ChatRoom(
          {required final int id,
          required final String name,
          required final DateTime createdAt,
          @GraphQLField(omit: true) final List<ChatMessage>? messagesCache,
          @GraphQLField(omit: true) final List<ChatRoomUser>? usersCache}) =
      _$_ChatRoom;
  const _ChatRoom._() : super._();

  factory _ChatRoom.fromJson(Map<String, dynamic> json) = _$_ChatRoom.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @GraphQLField(omit: true)
  List<ChatMessage>? get messagesCache => throw _privateConstructorUsedError;
  @override
  @GraphQLField(omit: true)
  List<ChatRoomUser>? get usersCache => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
