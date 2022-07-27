// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'messages_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatMessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageEventCopyWith<$Res> {
  factory $ChatMessageEventCopyWith(
          ChatMessageEvent value, $Res Function(ChatMessageEvent) then) =
      _$ChatMessageEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageEventCopyWith<$Res> {
  _$ChatMessageEventCopyWithImpl(this._value, this._then);

  final ChatMessageEvent _value;
  // ignore: unused_field
  final $Res Function(ChatMessageEvent) _then;
}

/// @nodoc
abstract class _$$ChatMessageSentEventCopyWith<$Res> {
  factory _$$ChatMessageSentEventCopyWith(_$ChatMessageSentEvent value,
          $Res Function(_$ChatMessageSentEvent) then) =
      __$$ChatMessageSentEventCopyWithImpl<$Res>;
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value});
}

/// @nodoc
class __$$ChatMessageSentEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements _$$ChatMessageSentEventCopyWith<$Res> {
  __$$ChatMessageSentEventCopyWithImpl(_$ChatMessageSentEvent _value,
      $Res Function(_$ChatMessageSentEvent) _then)
      : super(_value, (v) => _then(v as _$ChatMessageSentEvent));

  @override
  _$ChatMessageSentEvent get _value => super._value as _$ChatMessageSentEvent;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$ChatMessageSentEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageSentEvent
    with DiagnosticableTreeMixin
    implements ChatMessageSentEvent {
  const _$ChatMessageSentEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
      value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessageEvent.sent(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessageEvent.sent'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSentEvent &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$ChatMessageSentEventCopyWith<_$ChatMessageSentEvent> get copyWith =>
      __$$ChatMessageSentEventCopyWithImpl<_$ChatMessageSentEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return sent(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
  }) {
    return sent?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class ChatMessageSentEvent implements ChatMessageEvent {
  const factory ChatMessageSentEvent(
      final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value) = _$ChatMessageSentEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ChatMessageSentEventCopyWith<_$ChatMessageSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageDeletedEventCopyWith<$Res> {
  factory _$$ChatMessageDeletedEventCopyWith(_$ChatMessageDeletedEvent value,
          $Res Function(_$ChatMessageDeletedEvent) then) =
      __$$ChatMessageDeletedEventCopyWithImpl<$Res>;
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value});
}

/// @nodoc
class __$$ChatMessageDeletedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements _$$ChatMessageDeletedEventCopyWith<$Res> {
  __$$ChatMessageDeletedEventCopyWithImpl(_$ChatMessageDeletedEvent _value,
      $Res Function(_$ChatMessageDeletedEvent) _then)
      : super(_value, (v) => _then(v as _$ChatMessageDeletedEvent));

  @override
  _$ChatMessageDeletedEvent get _value =>
      super._value as _$ChatMessageDeletedEvent;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$ChatMessageDeletedEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageDeletedEvent
    with DiagnosticableTreeMixin
    implements ChatMessageDeletedEvent {
  const _$ChatMessageDeletedEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
      value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessageEvent.deleted(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessageEvent.deleted'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDeletedEvent &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$ChatMessageDeletedEventCopyWith<_$ChatMessageDeletedEvent> get copyWith =>
      __$$ChatMessageDeletedEventCopyWithImpl<_$ChatMessageDeletedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return deleted(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
  }) {
    return deleted?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class ChatMessageDeletedEvent implements ChatMessageEvent {
  const factory ChatMessageDeletedEvent(
      final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value) = _$ChatMessageDeletedEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ChatMessageDeletedEventCopyWith<_$ChatMessageDeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageUpdatedEventCopyWith<$Res> {
  factory _$$ChatMessageUpdatedEventCopyWith(_$ChatMessageUpdatedEvent value,
          $Res Function(_$ChatMessageUpdatedEvent) then) =
      __$$ChatMessageUpdatedEventCopyWithImpl<$Res>;
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value});
}

/// @nodoc
class __$$ChatMessageUpdatedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements _$$ChatMessageUpdatedEventCopyWith<$Res> {
  __$$ChatMessageUpdatedEventCopyWithImpl(_$ChatMessageUpdatedEvent _value,
      $Res Function(_$ChatMessageUpdatedEvent) _then)
      : super(_value, (v) => _then(v as _$ChatMessageUpdatedEvent));

  @override
  _$ChatMessageUpdatedEvent get _value =>
      super._value as _$ChatMessageUpdatedEvent;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$ChatMessageUpdatedEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageUpdatedEvent
    with DiagnosticableTreeMixin
    implements ChatMessageUpdatedEvent {
  const _$ChatMessageUpdatedEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
      value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessageEvent.updated(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessageEvent.updated'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageUpdatedEvent &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$ChatMessageUpdatedEventCopyWith<_$ChatMessageUpdatedEvent> get copyWith =>
      __$$ChatMessageUpdatedEventCopyWithImpl<_$ChatMessageUpdatedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return updated(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
  }) {
    return updated?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class ChatMessageUpdatedEvent implements ChatMessageEvent {
  const factory ChatMessageUpdatedEvent(
      final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value) = _$ChatMessageUpdatedEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ChatMessageUpdatedEventCopyWith<_$ChatMessageUpdatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
