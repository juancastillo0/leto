// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Human _$HumanFromJson(Map<String, dynamic> json) {
  return _Human.fromJson(json);
}

/// @nodoc
mixin _$Human {
// The id of the human.
  String get id => throw _privateConstructorUsedError; // The name of the human.
  @GraphQLField(nullable: true)
  String get name =>
      throw _privateConstructorUsedError; // Which movies they appear in.
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn =>
      throw _privateConstructorUsedError; // The friends of the human, or an empty list if they have none.
  @GraphQLField(omit: true)
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
      @GraphQLField(nullable: true) String name,
      @GraphQLField(type: 'listOf(episodeEnum)') List<int> appearsIn,
      @GraphQLField(omit: true) List<String> friends,
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
abstract class _$$_HumanCopyWith<$Res> implements $HumanCopyWith<$Res> {
  factory _$$_HumanCopyWith(_$_Human value, $Res Function(_$_Human) then) =
      __$$_HumanCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @GraphQLField(nullable: true) String name,
      @GraphQLField(type: 'listOf(episodeEnum)') List<int> appearsIn,
      @GraphQLField(omit: true) List<String> friends,
      String? homePlanet});
}

/// @nodoc
class __$$_HumanCopyWithImpl<$Res> extends _$HumanCopyWithImpl<$Res>
    implements _$$_HumanCopyWith<$Res> {
  __$$_HumanCopyWithImpl(_$_Human _value, $Res Function(_$_Human) _then)
      : super(_value, (v) => _then(v as _$_Human));

  @override
  _$_Human get _value => super._value as _$_Human;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? appearsIn = freezed,
    Object? friends = freezed,
    Object? homePlanet = freezed,
  }) {
    return _then(_$_Human(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appearsIn: appearsIn == freezed
          ? _value._appearsIn
          : appearsIn // ignore: cast_nullable_to_non_nullable
              as List<int>,
      friends: friends == freezed
          ? _value._friends
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
      @GraphQLField(nullable: true)
          required this.name,
      @GraphQLField(type: 'listOf(episodeEnum)')
          required final List<int> appearsIn,
      @GraphQLField(omit: true)
          required final List<String> friends,
      this.homePlanet})
      : _appearsIn = appearsIn,
        _friends = friends,
        super._();

  factory _$_Human.fromJson(Map<String, dynamic> json) =>
      _$$_HumanFromJson(json);

// The id of the human.
  @override
  final String id;
// The name of the human.
  @override
  @GraphQLField(nullable: true)
  final String name;
// Which movies they appear in.
  final List<int> _appearsIn;
// Which movies they appear in.
  @override
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appearsIn);
  }

// The friends of the human, or an empty list if they have none.
  final List<String> _friends;
// The friends of the human, or an empty list if they have none.
  @override
  @GraphQLField(omit: true)
  List<String> get friends {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

// The home planet of the human, or null if unknown.
  @override
  final String? homePlanet;

  @override
  String toString() {
    return 'Human(id: $id, name: $name, appearsIn: $appearsIn, friends: $friends, homePlanet: $homePlanet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Human &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other._appearsIn, _appearsIn) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality()
                .equals(other.homePlanet, homePlanet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_appearsIn),
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(homePlanet));

  @JsonKey(ignore: true)
  @override
  _$$_HumanCopyWith<_$_Human> get copyWith =>
      __$$_HumanCopyWithImpl<_$_Human>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HumanToJson(this);
  }
}

abstract class _Human extends Human {
  const factory _Human(
      {required final String id,
      @GraphQLField(nullable: true)
          required final String name,
      @GraphQLField(type: 'listOf(episodeEnum)')
          required final List<int> appearsIn,
      @GraphQLField(omit: true)
          required final List<String> friends,
      final String? homePlanet}) = _$_Human;
  const _Human._() : super._();

  factory _Human.fromJson(Map<String, dynamic> json) = _$_Human.fromJson;

  @override // The id of the human.
  String get id => throw _privateConstructorUsedError;
  @override // The name of the human.
  @GraphQLField(nullable: true)
  String get name => throw _privateConstructorUsedError;
  @override // Which movies they appear in.
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn => throw _privateConstructorUsedError;
  @override // The friends of the human, or an empty list if they have none.
  @GraphQLField(omit: true)
  List<String> get friends => throw _privateConstructorUsedError;
  @override // The home planet of the human, or null if unknown.
  String? get homePlanet => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_HumanCopyWith<_$_Human> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Droid {
  /// The id of the droid.
  String get id => throw _privateConstructorUsedError;
  @GraphQLField(nullable: true)
  String get name => throw _privateConstructorUsedError;
  @GraphQLField(omit: true)
  List<String> get friends =>
      throw _privateConstructorUsedError; // Which movies they appear in.
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn =>
      throw _privateConstructorUsedError; // The primary function of the droid.
  @GraphQLField(nullable: true)
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
      @GraphQLField(nullable: true) String name,
      @GraphQLField(omit: true) List<String> friends,
      @GraphQLField(type: 'listOf(episodeEnum)') List<int> appearsIn,
      @GraphQLField(nullable: true) String primaryFunction});
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
abstract class _$$_DroidCopyWith<$Res> implements $DroidCopyWith<$Res> {
  factory _$$_DroidCopyWith(_$_Droid value, $Res Function(_$_Droid) then) =
      __$$_DroidCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @GraphQLField(nullable: true) String name,
      @GraphQLField(omit: true) List<String> friends,
      @GraphQLField(type: 'listOf(episodeEnum)') List<int> appearsIn,
      @GraphQLField(nullable: true) String primaryFunction});
}

/// @nodoc
class __$$_DroidCopyWithImpl<$Res> extends _$DroidCopyWithImpl<$Res>
    implements _$$_DroidCopyWith<$Res> {
  __$$_DroidCopyWithImpl(_$_Droid _value, $Res Function(_$_Droid) _then)
      : super(_value, (v) => _then(v as _$_Droid));

  @override
  _$_Droid get _value => super._value as _$_Droid;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? friends = freezed,
    Object? appearsIn = freezed,
    Object? primaryFunction = freezed,
  }) {
    return _then(_$_Droid(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      friends: friends == freezed
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      appearsIn: appearsIn == freezed
          ? _value._appearsIn
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
      @GraphQLField(nullable: true)
          required this.name,
      @GraphQLField(omit: true)
          required final List<String> friends,
      @GraphQLField(type: 'listOf(episodeEnum)')
          required final List<int> appearsIn,
      @GraphQLField(nullable: true)
          required this.primaryFunction})
      : _friends = friends,
        _appearsIn = appearsIn,
        super._();

  /// The id of the droid.
  @override
  final String id;
  @override
  @GraphQLField(nullable: true)
  final String name;
  final List<String> _friends;
  @override
  @GraphQLField(omit: true)
  List<String> get friends {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

// Which movies they appear in.
  final List<int> _appearsIn;
// Which movies they appear in.
  @override
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appearsIn);
  }

// The primary function of the droid.
  @override
  @GraphQLField(nullable: true)
  final String primaryFunction;

  @override
  String toString() {
    return 'Droid(id: $id, name: $name, friends: $friends, appearsIn: $appearsIn, primaryFunction: $primaryFunction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Droid &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality()
                .equals(other._appearsIn, _appearsIn) &&
            const DeepCollectionEquality()
                .equals(other.primaryFunction, primaryFunction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_appearsIn),
      const DeepCollectionEquality().hash(primaryFunction));

  @JsonKey(ignore: true)
  @override
  _$$_DroidCopyWith<_$_Droid> get copyWith =>
      __$$_DroidCopyWithImpl<_$_Droid>(this, _$identity);
}

abstract class _Droid extends Droid {
  const factory _Droid(
      {required final String id,
      @GraphQLField(nullable: true)
          required final String name,
      @GraphQLField(omit: true)
          required final List<String> friends,
      @GraphQLField(type: 'listOf(episodeEnum)')
          required final List<int> appearsIn,
      @GraphQLField(nullable: true)
          required final String primaryFunction}) = _$_Droid;
  const _Droid._() : super._();

  @override

  /// The id of the droid.
  String get id => throw _privateConstructorUsedError;
  @override
  @GraphQLField(nullable: true)
  String get name => throw _privateConstructorUsedError;
  @override
  @GraphQLField(omit: true)
  List<String> get friends => throw _privateConstructorUsedError;
  @override // Which movies they appear in.
  @GraphQLField(type: 'listOf(episodeEnum)')
  List<int> get appearsIn => throw _privateConstructorUsedError;
  @override // The primary function of the droid.
  @GraphQLField(nullable: true)
  String get primaryFunction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DroidCopyWith<_$_Droid> get copyWith =>
      throw _privateConstructorUsedError;
}
