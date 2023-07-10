// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generator_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$TestModelFreezedCopyWithImpl<$Res, TestModelFreezed>;
  @useResult
  $Res call({String name, String? description, List<DateTime>? dates});
}

/// @nodoc
class _$TestModelFreezedCopyWithImpl<$Res, $Val extends TestModelFreezed>
    implements $TestModelFreezedCopyWith<$Res> {
  _$TestModelFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? dates = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: freezed == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TestModelFreezedCopyWith<$Res>
    implements $TestModelFreezedCopyWith<$Res> {
  factory _$$_TestModelFreezedCopyWith(
          _$_TestModelFreezed value, $Res Function(_$_TestModelFreezed) then) =
      __$$_TestModelFreezedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description, List<DateTime>? dates});
}

/// @nodoc
class __$$_TestModelFreezedCopyWithImpl<$Res>
    extends _$TestModelFreezedCopyWithImpl<$Res, _$_TestModelFreezed>
    implements _$$_TestModelFreezedCopyWith<$Res> {
  __$$_TestModelFreezedCopyWithImpl(
      _$_TestModelFreezed _value, $Res Function(_$_TestModelFreezed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? dates = freezed,
  }) {
    return _then(_$_TestModelFreezed(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: freezed == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_TestModelFreezed extends _TestModelFreezed {
  const _$_TestModelFreezed(
      {required this.name, this.description, final List<DateTime>? dates})
      : _dates = dates,
        super._();

  @override
  final String name;

  /// Custom doc d
  @override
  final String? description;
  final List<DateTime>? _dates;
  @override
  List<DateTime>? get dates {
    final value = _dates;
    if (value == null) return null;
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TestModelFreezed(name: $name, description: $description, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TestModelFreezed &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._dates, _dates));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_dates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TestModelFreezedCopyWith<_$_TestModelFreezed> get copyWith =>
      __$$_TestModelFreezedCopyWithImpl<_$_TestModelFreezed>(this, _$identity);
}

abstract class _TestModelFreezed extends TestModelFreezed {
  const factory _TestModelFreezed(
      {required final String name,
      final String? description,
      final List<DateTime>? dates}) = _$_TestModelFreezed;
  const _TestModelFreezed._() : super._();

  @override
  String get name;
  @override

  /// Custom doc d
  String? get description;
  @override
  List<DateTime>? get dates;
  @override
  @JsonKey(ignore: true)
  _$$_TestModelFreezedCopyWith<_$_TestModelFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

EventUnion _$EventUnionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
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
mixin _$EventUnion {
  String? get name => throw _privateConstructorUsedError;
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
    TResult? Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult? Function(String? name, int cost, List<DateTime>? dates)? delete,
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
    TResult? Function(_EventUnionAdd value)? add,
    TResult? Function(EventUnionDelete value)? delete,
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
      _$EventUnionCopyWithImpl<$Res, EventUnion>;
  @useResult
  $Res call({String name, List<DateTime>? dates});
}

/// @nodoc
class _$EventUnionCopyWithImpl<$Res, $Val extends EventUnion>
    implements $EventUnionCopyWith<$Res> {
  _$EventUnionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dates = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name!
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dates: freezed == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventUnionAddCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory _$$_EventUnionAddCopyWith(
          _$_EventUnionAdd value, $Res Function(_$_EventUnionAdd) then) =
      __$$_EventUnionAddCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      List<DateTime>? dates,
      List<TestModel?> models});
}

/// @nodoc
class __$$_EventUnionAddCopyWithImpl<$Res>
    extends _$EventUnionCopyWithImpl<$Res, _$_EventUnionAdd>
    implements _$$_EventUnionAddCopyWith<$Res> {
  __$$_EventUnionAddCopyWithImpl(
      _$_EventUnionAdd _value, $Res Function(_$_EventUnionAdd) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? dates = freezed,
    Object? models = null,
  }) {
    return _then(_$_EventUnionAdd(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dates: freezed == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      models: null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<TestModel?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventUnionAdd extends _EventUnionAdd {
  const _$_EventUnionAdd(
      {required this.name,
      this.description,
      final List<DateTime>? dates,
      required final List<TestModel?> models,
      final String? $type})
      : _dates = dates,
        _models = models,
        $type = $type ?? 'add',
        super._();

  factory _$_EventUnionAdd.fromJson(Map<String, dynamic> json) =>
      _$$_EventUnionAddFromJson(json);

  @override
  final String name;
// Custom doc d
  @override
  final String? description;
  final List<DateTime>? _dates;
  @override
  List<DateTime>? get dates {
    final value = _dates;
    if (value == null) return null;
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TestModel?> _models;
  @override
  List<TestModel?> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EventUnion.add(name: $name, description: $description, dates: $dates, models: $models)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventUnionAdd &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._dates, _dates) &&
            const DeepCollectionEquality().equals(other._models, _models));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_dates),
      const DeepCollectionEquality().hash(_models));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventUnionAddCopyWith<_$_EventUnionAdd> get copyWith =>
      __$$_EventUnionAddCopyWithImpl<_$_EventUnionAdd>(this, _$identity);

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
    TResult? Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult? Function(String? name, int cost, List<DateTime>? dates)? delete,
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
    TResult? Function(_EventUnionAdd value)? add,
    TResult? Function(EventUnionDelete value)? delete,
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
    return _$$_EventUnionAddToJson(
      this,
    );
  }
}

abstract class _EventUnionAdd extends EventUnion {
  const factory _EventUnionAdd(
      {required final String name,
      final String? description,
      final List<DateTime>? dates,
      required final List<TestModel?> models}) = _$_EventUnionAdd;
  const _EventUnionAdd._() : super._();

  factory _EventUnionAdd.fromJson(Map<String, dynamic> json) =
      _$_EventUnionAdd.fromJson;

  @override
  String get name; // Custom doc d
  String? get description;
  @override
  List<DateTime>? get dates;
  List<TestModel?> get models;
  @override
  @JsonKey(ignore: true)
  _$$_EventUnionAddCopyWith<_$_EventUnionAdd> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventUnionDeleteCopyWith<$Res>
    implements $EventUnionCopyWith<$Res> {
  factory _$$EventUnionDeleteCopyWith(
          _$EventUnionDelete value, $Res Function(_$EventUnionDelete) then) =
      __$$EventUnionDeleteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, int cost, List<DateTime>? dates});
}

/// @nodoc
class __$$EventUnionDeleteCopyWithImpl<$Res>
    extends _$EventUnionCopyWithImpl<$Res, _$EventUnionDelete>
    implements _$$EventUnionDeleteCopyWith<$Res> {
  __$$EventUnionDeleteCopyWithImpl(
      _$EventUnionDelete _value, $Res Function(_$EventUnionDelete) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? cost = null,
    Object? dates = freezed,
  }) {
    return _then(_$EventUnionDelete(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      dates: freezed == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventUnionDelete extends EventUnionDelete {
  const _$EventUnionDelete(
      {this.name,
      required this.cost,
      final List<DateTime>? dates,
      final String? $type})
      : _dates = dates,
        $type = $type ?? 'delete',
        super._();

  factory _$EventUnionDelete.fromJson(Map<String, dynamic> json) =>
      _$$EventUnionDeleteFromJson(json);

  @override
  final String? name;
  @override
  final int cost;
  final List<DateTime>? _dates;
  @override
  List<DateTime>? get dates {
    final value = _dates;
    if (value == null) return null;
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EventUnion.delete(name: $name, cost: $cost, dates: $dates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventUnionDelete &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            const DeepCollectionEquality().equals(other._dates, _dates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, cost, const DeepCollectionEquality().hash(_dates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventUnionDeleteCopyWith<_$EventUnionDelete> get copyWith =>
      __$$EventUnionDeleteCopyWithImpl<_$EventUnionDelete>(this, _$identity);

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
    TResult? Function(String name, String? description, List<DateTime>? dates,
            List<TestModel?> models)?
        add,
    TResult? Function(String? name, int cost, List<DateTime>? dates)? delete,
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
    TResult? Function(_EventUnionAdd value)? add,
    TResult? Function(EventUnionDelete value)? delete,
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
    return _$$EventUnionDeleteToJson(
      this,
    );
  }
}

abstract class EventUnionDelete extends EventUnion {
  const factory EventUnionDelete(
      {final String? name,
      required final int cost,
      final List<DateTime>? dates}) = _$EventUnionDelete;
  const EventUnionDelete._() : super._();

  factory EventUnionDelete.fromJson(Map<String, dynamic> json) =
      _$EventUnionDelete.fromJson;

  @override
  String? get name;
  int get cost;
  @override
  List<DateTime>? get dates;
  @override
  @JsonKey(ignore: true)
  _$$EventUnionDeleteCopyWith<_$EventUnionDelete> get copyWith =>
      throw _privateConstructorUsedError;
}
