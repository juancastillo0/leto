// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<Droid, Object, Object> droidGraphQLField = field(
  'droid',
  droidGraphQlType,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return droid(args["id"] as String);
  },
  inputs: [
    GraphQLFieldInput(
      "id",
      graphQLString.nonNull().coerceToInputObject(),
      description: r"id of the droid",
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final humanSerializer = SerializerValue<Human>(
  fromJson: _$$_HumanFromJson,
  toJson: (m) => _$$_HumanToJson(m as _$_Human),
);

/// Auto-generated from [Human].
final GraphQLObjectType<Human> humanGraphQlType = objectType('Human',
    fields: [
      field('id', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.id,
          description: 'The id of the human.',
          deprecationReason: null),
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the human.',
          deprecationReason: null),
      field('appearsIn', listOf(graphQLInt.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.appearsIn,
          description: 'Which movies they appear in.',
          deprecationReason: null),
      field('friends', listOf(graphQLString.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.friends,
          description:
              'The friends of the human, or an empty list if they have none.',
          deprecationReason: null),
      field('homePlanet', graphQLString,
          resolve: (obj, ctx) => obj.homePlanet,
          description: 'The home planet of the human, or null if unknown.',
          deprecationReason: null)
    ],
    isInterface: false,
    interfaces: [],
    description: null);

final droidSerializer = SerializerValue<Droid>(
  fromJson: _$$_DroidFromJson,
  toJson: (m) => _$$_DroidToJson(m as _$_Droid),
);

/// Auto-generated from [Droid].
final GraphQLObjectType<Droid> droidGraphQlType = objectType('Droid',
    fields: [
      field('id', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.id,
          description: 'The id of the droid.',
          deprecationReason: null),
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          description: 'TODO: nullable from decoration',
          deprecationReason: null),
      field('friends', listOf(graphQLString.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.friends,
          description: 'TODO: nullable from decoration',
          deprecationReason: null),
      field('appearsIn', listOf(graphQLInt.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.appearsIn,
          description:
              'Which movies they appear in.\nTODO: episodeEnum for int',
          deprecationReason: null),
      field('primaryFunction', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.primaryFunction,
          description:
              'The primary function of the droid.\nTODO: nullable from decoration',
          deprecationReason: null)
    ],
    isInterface: false,
    interfaces: [],
    description: null);

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
