// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<Droid, Object, Object> droidGraphQLField = field(
  'droid',
  droidGraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return droid((args["id"] as String));
  },
  inputs: [
    GraphQLFieldInput(
      "id",
      graphQLId.nonNull().coerceToInputObject(),
      description: r"id of the droid",
    )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final humanSerializer = SerializerValue<Human>(
  fromJson: (ctx, json) => Human.fromJson(json), // _$$_HumanFromJson,
  // toJson: (m) => _$$_HumanToJson(m as _$_Human),
);

GraphQLObjectType<Human>? _humanGraphQLType;

/// Auto-generated from [Human].
GraphQLObjectType<Human> get humanGraphQLType {
  final __name = 'Human';
  if (_humanGraphQLType != null)
    return _humanGraphQLType! as GraphQLObjectType<Human>;

  final __humanGraphQLType = objectType<Human>('Human',
      isInterface: false, interfaces: [characterInterface()]);

  _humanGraphQLType = __humanGraphQLType;
  __humanGraphQLType.fields.addAll(
    [
      field('id', graphQLId.nonNull(),
          resolve: (obj, ctx) => obj.id, description: 'The id of the human.'),
      field('name', graphQLString,
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the human.'),
      field('appearsIn', listOf(episodeEnum),
          resolve: (obj, ctx) => obj.appearsIn,
          description: 'Which movies they appear in.'),
      field('homePlanet', graphQLString,
          resolve: (obj, ctx) => obj.homePlanet,
          description: 'The home planet of the human, or null if unknown.'),
      field('friends', listOf(characterInterface()),
          resolve: (obj, ctx) => obj.fetchFriends),
      field('secretBackstory', graphQLString,
          resolve: (obj, ctx) => obj.secretBackstory)
    ],
  );

  return __humanGraphQLType;
}

GraphQLObjectType<Droid>? _droidGraphQLType;

/// Auto-generated from [Droid].
GraphQLObjectType<Droid> get droidGraphQLType {
  final __name = 'Droid';
  if (_droidGraphQLType != null)
    return _droidGraphQLType! as GraphQLObjectType<Droid>;

  final __droidGraphQLType = objectType<Droid>('Droid',
      isInterface: false,
      interfaces: [characterInterface()],
      description: 'A mechanical creature in the Star Wars universe.');

  _droidGraphQLType = __droidGraphQLType;
  __droidGraphQLType.fields.addAll(
    [
      field('id', graphQLId.nonNull(),
          resolve: (obj, ctx) => obj.id, description: 'The id of the droid.'),
      field('name', graphQLString, resolve: (obj, ctx) => obj.name),
      field('appearsIn', listOf(episodeEnum),
          resolve: (obj, ctx) => obj.appearsIn,
          description: 'Which movies they appear in.'),
      field('primaryFunction', graphQLString,
          resolve: (obj, ctx) => obj.primaryFunction,
          description: 'The primary function of the droid.'),
      field('friends', listOf(characterInterface()),
          resolve: (obj, ctx) => obj.fetchFriends),
      field('secretBackstory', graphQLString,
          resolve: (obj, ctx) => obj.secretBackstory)
    ],
  );

  return __droidGraphQLType;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Human _$$_HumanFromJson(Map<String, dynamic> json) => _$_Human(
      id: json['id'] as String,
      name: json['name'] as String,
      appearsIn:
          (json['appearsIn'] as List<dynamic>).map((e) => e as int).toList(),
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      homePlanet: json['homePlanet'] as String?,
    );

Map<String, dynamic> _$$_HumanToJson(_$_Human instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'appearsIn': instance.appearsIn,
      'friends': instance.friends,
      'homePlanet': instance.homePlanet,
    };

_$_Droid _$$_DroidFromJson(Map<String, dynamic> json) => _$_Droid(
      id: json['id'] as String,
      name: json['name'] as String,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      appearsIn:
          (json['appearsIn'] as List<dynamic>).map((e) => e as int).toList(),
      primaryFunction: json['primaryFunction'] as String,
    );

Map<String, dynamic> _$$_DroidToJson(_$_Droid instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'friends': instance.friends,
      'appearsIn': instance.appearsIn,
      'primaryFunction': instance.primaryFunction,
    };
