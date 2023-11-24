// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    TResult? Function(ChatRoom chat, int ownerId)? created,
    TResult? Function(int chatId)? deleted,
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
    TResult? Function(ChatCreatedEvent value)? created,
    TResult? Function(ChatDeletedEvent value)? deleted,
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
      _$ChatEventCopyWithImpl<$Res, ChatEvent>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res, $Val extends ChatEvent>
    implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatCreatedEventCopyWith<$Res> {
  factory _$$ChatCreatedEventCopyWith(
          _$ChatCreatedEvent value, $Res Function(_$ChatCreatedEvent) then) =
      __$$ChatCreatedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatRoom chat, int ownerId});

  $ChatRoomCopyWith<$Res> get chat;
}

/// @nodoc
class __$$ChatCreatedEventCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ChatCreatedEvent>
    implements _$$ChatCreatedEventCopyWith<$Res> {
  __$$ChatCreatedEventCopyWithImpl(
      _$ChatCreatedEvent _value, $Res Function(_$ChatCreatedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
    Object? ownerId = null,
  }) {
    return _then(_$ChatCreatedEvent(
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatRoom,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chat, ownerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(ChatRoom chat, int ownerId)? created,
    TResult? Function(int chatId)? deleted,
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
    TResult? Function(ChatCreatedEvent value)? created,
    TResult? Function(ChatDeletedEvent value)? deleted,
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
    return _$$ChatCreatedEventToJson(
      this,
    );
  }
}

abstract class ChatCreatedEvent extends ChatEvent {
  const factory ChatCreatedEvent(
      {required final ChatRoom chat,
      required final int ownerId}) = _$ChatCreatedEvent;
  const ChatCreatedEvent._() : super._();

  factory ChatCreatedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatCreatedEvent.fromJson;

  ChatRoom get chat;
  int get ownerId;
  @JsonKey(ignore: true)
  _$$ChatCreatedEventCopyWith<_$ChatCreatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatDeletedEventCopyWith<$Res> {
  factory _$$ChatDeletedEventCopyWith(
          _$ChatDeletedEvent value, $Res Function(_$ChatDeletedEvent) then) =
      __$$ChatDeletedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int chatId});
}

/// @nodoc
class __$$ChatDeletedEventCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ChatDeletedEvent>
    implements _$$ChatDeletedEventCopyWith<$Res> {
  __$$ChatDeletedEventCopyWithImpl(
      _$ChatDeletedEvent _value, $Res Function(_$ChatDeletedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_$ChatDeletedEvent(
      chatId: null == chatId
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
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(ChatRoom chat, int ownerId)? created,
    TResult? Function(int chatId)? deleted,
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
    TResult? Function(ChatCreatedEvent value)? created,
    TResult? Function(ChatDeletedEvent value)? deleted,
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
    return _$$ChatDeletedEventToJson(
      this,
    );
  }
}

abstract class ChatDeletedEvent extends ChatEvent {
  const factory ChatDeletedEvent({required final int chatId}) =
      _$ChatDeletedEvent;
  const ChatDeletedEvent._() : super._();

  factory ChatDeletedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatDeletedEvent.fromJson;

  int get chatId;
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
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime createdAt,
      @GraphQLField(omit: true) List<ChatMessage>? messagesCache,
      @GraphQLField(omit: true) List<ChatRoomUser>? usersCache});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? messagesCache = freezed,
    Object? usersCache = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messagesCache: freezed == messagesCache
          ? _value.messagesCache
          : messagesCache // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      usersCache: freezed == usersCache
          ? _value.usersCache
          : usersCache // ignore: cast_nullable_to_non_nullable
              as List<ChatRoomUser>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$$_ChatRoomCopyWith(
          _$_ChatRoom value, $Res Function(_$_ChatRoom) then) =
      __$$_ChatRoomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime createdAt,
      @GraphQLField(omit: true) List<ChatMessage>? messagesCache,
      @GraphQLField(omit: true) List<ChatRoomUser>? usersCache});
}

/// @nodoc
class __$$_ChatRoomCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$_ChatRoom>
    implements _$$_ChatRoomCopyWith<$Res> {
  __$$_ChatRoomCopyWithImpl(
      _$_ChatRoom _value, $Res Function(_$_ChatRoom) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? messagesCache = freezed,
    Object? usersCache = freezed,
  }) {
    return _then(_$_ChatRoom(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messagesCache: freezed == messagesCache
          ? _value._messagesCache
          : messagesCache // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      usersCache: freezed == usersCache
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
    if (_messagesCache is EqualUnmodifiableListView) return _messagesCache;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ChatRoomUser>? _usersCache;
  @override
  @GraphQLField(omit: true)
  List<ChatRoomUser>? get usersCache {
    final value = _usersCache;
    if (value == null) return null;
    if (_usersCache is EqualUnmodifiableListView) return _usersCache;
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._messagesCache, _messagesCache) &&
            const DeepCollectionEquality()
                .equals(other._usersCache, _usersCache));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      createdAt,
      const DeepCollectionEquality().hash(_messagesCache),
      const DeepCollectionEquality().hash(_usersCache));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      __$$_ChatRoomCopyWithImpl<_$_ChatRoom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatRoomToJson(
      this,
    );
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
  int get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  @GraphQLField(omit: true)
  List<ChatMessage>? get messagesCache;
  @override
  @GraphQLField(omit: true)
  List<ChatRoomUser>? get usersCache;
  @override
  @JsonKey(ignore: true)
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
