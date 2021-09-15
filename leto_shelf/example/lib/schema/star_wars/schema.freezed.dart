// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Human _$HumanFromJson(Map<String, dynamic> json) {
  return _Human.fromJson(json);
}

/// @nodoc
class _$HumanTearOff {
  const _$HumanTearOff();

  _Human call(
      {required String id,
      required String name,
      required List<int> appearsIn,
      required List<String> friends,
      String? homePlanet}) {
    return _Human(
      id: id,
      name: name,
      appearsIn: appearsIn,
      friends: friends,
      homePlanet: homePlanet,
    );
  }

  Human fromJson(Map<String, Object> json) {
    return Human.fromJson(json);
  }
}

/// @nodoc
const $Human = _$HumanTearOff();

/// @nodoc
mixin _$Human {
// The id of the human.
  String get id => throw _privateConstructorUsedError; // The name of the human.
  String get name =>
      throw _privateConstructorUsedError; // Which movies they appear in.
  List<int> get appearsIn =>
      throw _privateConstructorUsedError; // The friends of the human, or an empty list if they have none.
  List<String> get friends =>
      throw _privateConstructorUsedError; // The home planet of the human, or null if unknown.
  String? get homePlanet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HumanCopyWith<Human> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HumanCopyWith<$Res> {
  factory $HumanCopyWith(Human value, $Res Function(Human) then) =
      _$HumanCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      List<int> appearsIn,
      List<String> friends,
      String? homePlanet});
}

/// @nodoc
class _$HumanCopyWithImpl<$Res> implements $HumanCopyWith<$Res> {
  _$HumanCopyWithImpl(this._value, this._then);

  final Human _value;
  // ignore: unused_field
  final $Res Function(Human) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? appearsIn = freezed,
    Object? friends = freezed,
    Object? homePlanet = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appearsIn: appearsIn == freezed
          ? _value.appearsIn
          : appearsIn // ignore: cast_nullable_to_non_nullable
              as List<int>,
      friends: friends == freezed
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      homePlanet: homePlanet == freezed
          ? _value.homePlanet
          : homePlanet // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$HumanCopyWith<$Res> implements $HumanCopyWith<$Res> {
  factory _$HumanCopyWith(_Human value, $Res Function(_Human) then) =
      __$HumanCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      List<int> appearsIn,
      List<String> friends,
      String? homePlanet});
}

/// @nodoc
class __$HumanCopyWithImpl<$Res> extends _$HumanCopyWithImpl<$Res>
    implements _$HumanCopyWith<$Res> {
  __$HumanCopyWithImpl(_Human _value, $Res Function(_Human) _then)
      : super(_value, (v) => _then(v as _Human));

  @override
  _Human get _value => super._value as _Human;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? appearsIn = freezed,
    Object? friends = freezed,
    Object? homePlanet = freezed,
  }) {
    return _then(_Human(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appearsIn: appearsIn == freezed
          ? _value.appearsIn
          : appearsIn // ignore: cast_nullable_to_non_nullable
              as List<int>,
      friends: friends == freezed
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      homePlanet: homePlanet == freezed
          ? _value.homePlanet
          : homePlanet // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Human extends _Human {
  const _$_Human(
      {required this.id,
      required this.name,
      required this.appearsIn,
      required this.friends,
      this.homePlanet})
      : super._();

  factory _$_Human.fromJson(Map<String, dynamic> json) =>
      _$$_HumanFromJson(json);

  @override // The id of the human.
  final String id;
  @override // The name of the human.
  final String name;
  @override // Which movies they appear in.
  final List<int> appearsIn;
  @override // The friends of the human, or an empty list if they have none.
  final List<String> friends;
  @override // The home planet of the human, or null if unknown.
  final String? homePlanet;

  @override
  String toString() {
    return 'Human(id: $id, name: $name, appearsIn: $appearsIn, friends: $friends, homePlanet: $homePlanet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Human &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.appearsIn, appearsIn) ||
                const DeepCollectionEquality()
                    .equals(other.appearsIn, appearsIn)) &&
            (identical(other.friends, friends) ||
                const DeepCollectionEquality()
                    .equals(other.friends, friends)) &&
            (identical(other.homePlanet, homePlanet) ||
                const DeepCollectionEquality()
                    .equals(other.homePlanet, homePlanet)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(appearsIn) ^
      const DeepCollectionEquality().hash(friends) ^
      const DeepCollectionEquality().hash(homePlanet);

  @JsonKey(ignore: true)
  @override
  _$HumanCopyWith<_Human> get copyWith =>
      __$HumanCopyWithImpl<_Human>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HumanToJson(this);
  }
}

abstract class _Human extends Human {
  const factory _Human(
      {required String id,
      required String name,
      required List<int> appearsIn,
      required List<String> friends,
      String? homePlanet}) = _$_Human;
  const _Human._() : super._();

  factory _Human.fromJson(Map<String, dynamic> json) = _$_Human.fromJson;

  @override // The id of the human.
  String get id => throw _privateConstructorUsedError;
  @override // The name of the human.
  String get name => throw _privateConstructorUsedError;
  @override // Which movies they appear in.
  List<int> get appearsIn => throw _privateConstructorUsedError;
  @override // The friends of the human, or an empty list if they have none.
  List<String> get friends => throw _privateConstructorUsedError;
  @override // The home planet of the human, or null if unknown.
  String? get homePlanet => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HumanCopyWith<_Human> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$DroidTearOff {
  const _$DroidTearOff();

  _Droid call(
      {required String id,
      required String name,
      required List<String> friends,
      required List<int> appearsIn,
      required String primaryFunction}) {
    return _Droid(
      id: id,
      name: name,
      friends: friends,
      appearsIn: appearsIn,
      primaryFunction: primaryFunction,
    );
  }
}

/// @nodoc
const $Droid = _$DroidTearOff();

/// @nodoc
mixin _$Droid {
  /// The id of the droid.
  String get id =>
      throw _privateConstructorUsedError; // TODO: nullable from decoration
  String get name =>
      throw _privateConstructorUsedError; // TODO: nullable from decoration
  List<String> get friends =>
      throw _privateConstructorUsedError; // Which movies they appear in.
// TODO: episodeEnum for int
  List<int> get appearsIn =>
      throw _privateConstructorUsedError; // The primary function of the droid.
// TODO: nullable from decoration
  String get primaryFunction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DroidCopyWith<Droid> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DroidCopyWith<$Res> {
  factory $DroidCopyWith(Droid value, $Res Function(Droid) then) =
      _$DroidCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      List<String> friends,
      List<int> appearsIn,
      String primaryFunction});
}

/// @nodoc
class _$DroidCopyWithImpl<$Res> implements $DroidCopyWith<$Res> {
  _$DroidCopyWithImpl(this._value, this._then);

  final Droid _value;
  // ignore: unused_field
  final $Res Function(Droid) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? friends = freezed,
    Object? appearsIn = freezed,
    Object? primaryFunction = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      friends: friends == freezed
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      appearsIn: appearsIn == freezed
          ? _value.appearsIn
          : appearsIn // ignore: cast_nullable_to_non_nullable
              as List<int>,
      primaryFunction: primaryFunction == freezed
          ? _value.primaryFunction
          : primaryFunction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$DroidCopyWith<$Res> implements $DroidCopyWith<$Res> {
  factory _$DroidCopyWith(_Droid value, $Res Function(_Droid) then) =
      __$DroidCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      List<String> friends,
      List<int> appearsIn,
      String primaryFunction});
}

/// @nodoc
class __$DroidCopyWithImpl<$Res> extends _$DroidCopyWithImpl<$Res>
    implements _$DroidCopyWith<$Res> {
  __$DroidCopyWithImpl(_Droid _value, $Res Function(_Droid) _then)
      : super(_value, (v) => _then(v as _Droid));

  @override
  _Droid get _value => super._value as _Droid;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? friends = freezed,
    Object? appearsIn = freezed,
    Object? primaryFunction = freezed,
  }) {
    return _then(_Droid(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      friends: friends == freezed
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      appearsIn: appearsIn == freezed
          ? _value.appearsIn
          : appearsIn // ignore: cast_nullable_to_non_nullable
              as List<int>,
      primaryFunction: primaryFunction == freezed
          ? _value.primaryFunction
          : primaryFunction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Droid extends _Droid {
  const _$_Droid(
      {required this.id,
      required this.name,
      required this.friends,
      required this.appearsIn,
      required this.primaryFunction})
      : super._();

  @override

  /// The id of the droid.
  final String id;
  @override // TODO: nullable from decoration
  final String name;
  @override // TODO: nullable from decoration
  final List<String> friends;
  @override // Which movies they appear in.
// TODO: episodeEnum for int
  final List<int> appearsIn;
  @override // The primary function of the droid.
// TODO: nullable from decoration
  final String primaryFunction;

  @override
  String toString() {
    return 'Droid(id: $id, name: $name, friends: $friends, appearsIn: $appearsIn, primaryFunction: $primaryFunction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Droid &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.friends, friends) ||
                const DeepCollectionEquality()
                    .equals(other.friends, friends)) &&
            (identical(other.appearsIn, appearsIn) ||
                const DeepCollectionEquality()
                    .equals(other.appearsIn, appearsIn)) &&
            (identical(other.primaryFunction, primaryFunction) ||
                const DeepCollectionEquality()
                    .equals(other.primaryFunction, primaryFunction)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(friends) ^
      const DeepCollectionEquality().hash(appearsIn) ^
      const DeepCollectionEquality().hash(primaryFunction);

  @JsonKey(ignore: true)
  @override
  _$DroidCopyWith<_Droid> get copyWith =>
      __$DroidCopyWithImpl<_Droid>(this, _$identity);
}

abstract class _Droid extends Droid {
  const factory _Droid(
      {required String id,
      required String name,
      required List<String> friends,
      required List<int> appearsIn,
      required String primaryFunction}) = _$_Droid;
  const _Droid._() : super._();

  @override

  /// The id of the droid.
  String get id => throw _privateConstructorUsedError;
  @override // TODO: nullable from decoration
  String get name => throw _privateConstructorUsedError;
  @override // TODO: nullable from decoration
  List<String> get friends => throw _privateConstructorUsedError;
  @override // Which movies they appear in.
// TODO: episodeEnum for int
  List<int> get appearsIn => throw _privateConstructorUsedError;
  @override // The primary function of the droid.
// TODO: nullable from decoration
  String get primaryFunction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DroidCopyWith<_Droid> get copyWith => throw _privateConstructorUsedError;
}
