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

EventUnion _$EventUnionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
    case 'add':
      return _EventUnionAdd.fromJson(json);
    case 'delete':
      return EventUnionDelete.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'EventUnion',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$EventUnionTearOff {
  const _$EventUnionTearOff();

  _EventUnionAdd add(
      {required String name,
      String? description,
      List<DateTime>? dates,
      required List<TestModel?> models}) {
    return _EventUnionAdd(
      name: name,
      description: description,
      dates: dates,
      models: models,
    );
  }

  EventUnionDelete delete(
      {String? name, required int cost, List<DateTime>? dates}) {
    return EventUnionDelete(
      name: name,
      cost: cost,
      dates: dates,
    );
  }

  EventUnion fromJson(Map<String, Object> json) {
    return EventUnion.fromJson(json);
  }
}

/// @nodoc
const $EventUnion = _$EventUnionTearOff();

/// @nodoc
mixin _$EventUnion {
  List<DateTime>? get dates => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String? description,
            List<DateTime>? dates, List<TestModel?> models)
        add,
    required TResult Function(String? name, int cost, List<DateTime>? dates)
        delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
abstract class _$EventUnionAddCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory _$EventUnionAddCopyWith(
          _EventUnionAdd value, $Res Function(_EventUnionAdd) then) =
      __$EventUnionAddCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String? description,
      List<DateTime>? dates,
      List<TestModel?> models});
}

/// @nodoc
class __$EventUnionAddCopyWithImpl<$Res> extends _$EventUnionCopyWithImpl<$Res>
    implements _$EventUnionAddCopyWith<$Res> {
  __$EventUnionAddCopyWithImpl(
      _EventUnionAdd _value, $Res Function(_EventUnionAdd) _then)
      : super(_value, (v) => _then(v as _EventUnionAdd));

  @override
  _EventUnionAdd get _value => super._value as _EventUnionAdd;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? dates = freezed,
    Object? models = freezed,
  }) {
    return _then(_EventUnionAdd(
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
      models: models == freezed
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as List<TestModel?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventUnionAdd extends _EventUnionAdd {
  const _$_EventUnionAdd(
      {required this.name, this.description, this.dates, required this.models})
      : super._();

  factory _$_EventUnionAdd.fromJson(Map<String, dynamic> json) =>
      _$$_EventUnionAddFromJson(json);

  @override
  final String name;
  @override // Custom doc d
  final String? description;
  @override
  final List<DateTime>? dates;
  @override
  final List<TestModel?> models;

  @override
  String toString() {
    return 'EventUnion.add(name: $name, description: $description, dates: $dates, models: $models)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EventUnionAdd &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)) &&
            (identical(other.models, models) ||
                const DeepCollectionEquality().equals(other.models, models)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(dates) ^
      const DeepCollectionEquality().hash(models);

  @JsonKey(ignore: true)
  @override
  _$EventUnionAddCopyWith<_EventUnionAdd> get copyWith =>
      __$EventUnionAddCopyWithImpl<_EventUnionAdd>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String? description,
            List<DateTime>? dates, List<TestModel?> models)
        add,
    required TResult Function(String? name, int cost, List<DateTime>? dates)
        delete,
  }) {
    return add(name, description, dates, models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
  }) {
    return add?.call(name, description, dates, models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(name, description, dates, models);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventUnionAddToJson(this)..['runtimeType'] = 'add';
  }
}

abstract class _EventUnionAdd extends EventUnion {
  const factory _EventUnionAdd(
      {required String name,
      String? description,
      List<DateTime>? dates,
      required List<TestModel?> models}) = _$_EventUnionAdd;
  const _EventUnionAdd._() : super._();

  factory _EventUnionAdd.fromJson(Map<String, dynamic> json) =
      _$_EventUnionAdd.fromJson;

  String get name => throw _privateConstructorUsedError; // Custom doc d
  String? get description => throw _privateConstructorUsedError;
  @override
  List<DateTime>? get dates => throw _privateConstructorUsedError;
  List<TestModel?> get models => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EventUnionAddCopyWith<_EventUnionAdd> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventUnionDeleteCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory $EventUnionDeleteCopyWith(
          EventUnionDelete value, $Res Function(EventUnionDelete) then) =
      _$EventUnionDeleteCopyWithImpl<$Res>;
  @override
  $Res call({String? name, int cost, List<DateTime>? dates});
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
    Object? cost = freezed,
    Object? dates = freezed,
  }) {
    return _then(EventUnionDelete(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      dates: dates == freezed
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventUnionDelete extends EventUnionDelete {
  const _$EventUnionDelete({this.name, required this.cost, this.dates})
      : super._();

  factory _$EventUnionDelete.fromJson(Map<String, dynamic> json) =>
      _$$EventUnionDeleteFromJson(json);

  @override
  final String? name;
  @override
  final int cost;
  @override
  final List<DateTime>? dates;

  @override
  String toString() {
    return 'EventUnion.delete(name: $name, cost: $cost, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventUnionDelete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(cost) ^
      const DeepCollectionEquality().hash(dates);

  @JsonKey(ignore: true)
  @override
  $EventUnionDeleteCopyWith<EventUnionDelete> get copyWith =>
      _$EventUnionDeleteCopyWithImpl<EventUnionDelete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String? description,
            List<DateTime>? dates, List<TestModel?> models)
        add,
    required TResult Function(String? name, int cost, List<DateTime>? dates)
        delete,
  }) {
    return delete(name, cost, dates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
  }) {
    return delete?.call(name, cost, dates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult Function(String? name, int cost, List<DateTime>? dates)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(name, cost, dates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventUnionAdd value) add,
    required TResult Function(EventUnionDelete value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventUnionAdd value)? add,
    TResult Function(EventUnionDelete value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EventUnionDeleteToJson(this)..['runtimeType'] = 'delete';
  }
}

abstract class EventUnionDelete extends EventUnion {
  const factory EventUnionDelete(
      {String? name,
      required int cost,
      List<DateTime>? dates}) = _$EventUnionDelete;
  const EventUnionDelete._() : super._();

  factory EventUnionDelete.fromJson(Map<String, dynamic> json) =
      _$EventUnionDelete.fromJson;

  String? get name => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  @override
  List<DateTime>? get dates => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $EventUnionDeleteCopyWith<EventUnionDelete> get copyWith =>
      throw _privateConstructorUsedError;
}
