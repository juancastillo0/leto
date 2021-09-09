// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'generator_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TestModelFreezedTearOff {
  const _$TestModelFreezedTearOff();

  _TestModelFreezed call(
      {required String name, String? description, List<DateTime>? dates}) {
    return _TestModelFreezed(
      name: name,
      description: description,
      dates: dates,
    );
  }
}

/// @nodoc
const $TestModelFreezed = _$TestModelFreezedTearOff();

/// @nodoc
mixin _$TestModelFreezed {
  String get name => throw _privateConstructorUsedError;

  /// Custom doc d
  String? get description => throw _privateConstructorUsedError;
  List<DateTime>? get dates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TestModelFreezedCopyWith<TestModelFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestModelFreezedCopyWith<$Res> {
  factory $TestModelFreezedCopyWith(
          TestModelFreezed value, $Res Function(TestModelFreezed) then) =
      _$TestModelFreezedCopyWithImpl<$Res>;
  $Res call({String name, String? description, List<DateTime>? dates});
}

/// @nodoc
class _$TestModelFreezedCopyWithImpl<$Res>
    implements $TestModelFreezedCopyWith<$Res> {
  _$TestModelFreezedCopyWithImpl(this._value, this._then);

  final TestModelFreezed _value;
  // ignore: unused_field
  final $Res Function(TestModelFreezed) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? dates = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc
abstract class _$TestModelFreezedCopyWith<$Res>
    implements $TestModelFreezedCopyWith<$Res> {
  factory _$TestModelFreezedCopyWith(
          _TestModelFreezed value, $Res Function(_TestModelFreezed) then) =
      __$TestModelFreezedCopyWithImpl<$Res>;
  @override
  $Res call({String name, String? description, List<DateTime>? dates});
}

/// @nodoc
class __$TestModelFreezedCopyWithImpl<$Res>
    extends _$TestModelFreezedCopyWithImpl<$Res>
    implements _$TestModelFreezedCopyWith<$Res> {
  __$TestModelFreezedCopyWithImpl(
      _TestModelFreezed _value, $Res Function(_TestModelFreezed) _then)
      : super(_value, (v) => _then(v as _TestModelFreezed));

  @override
  _TestModelFreezed get _value => super._value as _TestModelFreezed;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? dates = freezed,
  }) {
    return _then(_TestModelFreezed(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_TestModelFreezed extends _TestModelFreezed {
  const _$_TestModelFreezed({required this.name, this.description, this.dates})
      : super._();

  @override
  final String name;
  @override

  /// Custom doc d
  final String? description;
  @override
  final List<DateTime>? dates;

  @override
  String toString() {
    return 'TestModelFreezed(name: $name, description: $description, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TestModelFreezed &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(dates);

  @JsonKey(ignore: true)
  @override
  _$TestModelFreezedCopyWith<_TestModelFreezed> get copyWith =>
      __$TestModelFreezedCopyWithImpl<_TestModelFreezed>(this, _$identity);
}

abstract class _TestModelFreezed extends TestModelFreezed {
  const factory _TestModelFreezed(
      {required String name,
      String? description,
      List<DateTime>? dates}) = _$_TestModelFreezed;
  const _TestModelFreezed._() : super._();

  @override
  String get name => throw _privateConstructorUsedError;
  @override

  /// Custom doc d
  String? get description => throw _privateConstructorUsedError;
  @override
  List<DateTime>? get dates => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TestModelFreezedCopyWith<_TestModelFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$EventUnionTearOff {
  const _$EventUnionTearOff();

  EventUnionAdd add(
      {required String name, String? description, List<DateTime>? dates}) {
    return EventUnionAdd(
      name: name,
      description: description,
      dates: dates,
    );
  }

  EventUnionDelete delete({String? name, List<DateTime>? dates}) {
    return EventUnionDelete(
      name: name,
      dates: dates,
    );
  }
}

/// @nodoc
const $EventUnion = _$EventUnionTearOff();

/// @nodoc
mixin _$EventUnion {
  List<DateTime>? get dates => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String? description, List<DateTime>? dates)
        add,
    required TResult Function(String? name, List<DateTime>? dates) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventUnionCopyWith<EventUnion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventUnionCopyWith<$Res> {
  factory $EventUnionCopyWith(
          EventUnion value, $Res Function(EventUnion) then) =
      _$EventUnionCopyWithImpl<$Res>;
  $Res call({List<DateTime>? dates});
}

/// @nodoc
class _$EventUnionCopyWithImpl<$Res> implements $EventUnionCopyWith<$Res> {
  _$EventUnionCopyWithImpl(this._value, this._then);

  final EventUnion _value;
  // ignore: unused_field
  final $Res Function(EventUnion) _then;

  @override
  $Res call({
    Object? dates = freezed,
  }) {
    return _then(_value.copyWith(
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc
abstract class $EventUnionAddCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory $EventUnionAddCopyWith(
          EventUnionAdd value, $Res Function(EventUnionAdd) then) =
      _$EventUnionAddCopyWithImpl<$Res>;
  @override
  $Res call({String name, String? description, List<DateTime>? dates});
}

/// @nodoc
class _$EventUnionAddCopyWithImpl<$Res> extends _$EventUnionCopyWithImpl<$Res>
    implements $EventUnionAddCopyWith<$Res> {
  _$EventUnionAddCopyWithImpl(
      EventUnionAdd _value, $Res Function(EventUnionAdd) _then)
      : super(_value, (v) => _then(v as EventUnionAdd));

  @override
  EventUnionAdd get _value => super._value as EventUnionAdd;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? dates = freezed,
  }) {
    return _then(EventUnionAdd(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$EventUnionAdd extends EventUnionAdd {
  const _$EventUnionAdd({required this.name, this.description, this.dates})
      : super._();

  @override
  final String name;
  @override // Custom doc d
  final String? description;
  @override
  final List<DateTime>? dates;

  @override
  String toString() {
    return 'EventUnion.add(name: $name, description: $description, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventUnionAdd &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(dates);

  @JsonKey(ignore: true)
  @override
  $EventUnionAddCopyWith<EventUnionAdd> get copyWith =>
      _$EventUnionAddCopyWithImpl<EventUnionAdd>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String? description, List<DateTime>? dates)
        add,
    required TResult Function(String? name, List<DateTime>? dates) delete,
  }) {
    return add(name, description, dates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
  }) {
    return add?.call(name, description, dates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(name, description, dates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class EventUnionAdd extends EventUnion {
  const factory EventUnionAdd(
      {required String name,
      String? description,
      List<DateTime>? dates}) = _$EventUnionAdd;
  const EventUnionAdd._() : super._();

  String get name => throw _privateConstructorUsedError; // Custom doc d
  String? get description => throw _privateConstructorUsedError;
  @override
  List<DateTime>? get dates => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $EventUnionAddCopyWith<EventUnionAdd> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventUnionDeleteCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory $EventUnionDeleteCopyWith(
          EventUnionDelete value, $Res Function(EventUnionDelete) then) =
      _$EventUnionDeleteCopyWithImpl<$Res>;
  @override
  $Res call({String? name, List<DateTime>? dates});
}

/// @nodoc
class _$EventUnionDeleteCopyWithImpl<$Res>
    extends _$EventUnionCopyWithImpl<$Res>
    implements $EventUnionDeleteCopyWith<$Res> {
  _$EventUnionDeleteCopyWithImpl(
      EventUnionDelete _value, $Res Function(EventUnionDelete) _then)
      : super(_value, (v) => _then(v as EventUnionDelete));

  @override
  EventUnionDelete get _value => super._value as EventUnionDelete;

  @override
  $Res call({
    Object? name = freezed,
    Object? dates = freezed,
  }) {
    return _then(EventUnionDelete(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc

class _$EventUnionDelete extends EventUnionDelete {
  const _$EventUnionDelete({this.name, this.dates}) : super._();

  @override
  final String? name;
  @override
  final List<DateTime>? dates;

  @override
  String toString() {
    return 'EventUnion.delete(name: $name, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventUnionDelete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(dates);

  @JsonKey(ignore: true)
  @override
  $EventUnionDeleteCopyWith<EventUnionDelete> get copyWith =>
      _$EventUnionDeleteCopyWithImpl<EventUnionDelete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String? description, List<DateTime>? dates)
        add,
    required TResult Function(String? name, List<DateTime>? dates) delete,
  }) {
    return delete(name, dates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
  }) {
    return delete?.call(name, dates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates)?
        add,
    TResult Function(String? name, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(name, dates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class EventUnionDelete extends EventUnion {
  const factory EventUnionDelete({String? name, List<DateTime>? dates}) =
      _$EventUnionDelete;
  const EventUnionDelete._() : super._();

  String? get name => throw _privateConstructorUsedError;
  @override
  List<DateTime>? get dates => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $EventUnionDeleteCopyWith<EventUnionDelete> get copyWith =>
      throw _privateConstructorUsedError;
}
