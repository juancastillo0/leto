// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<Droid?, Object?, Object?> get droidGraphQLField =>
    _droidGraphQLField.value;
final _droidGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<Droid?, Object?, Object?>>(
        (setValue) => setValue(droidGraphQLType.field<Object?>(
              'droid',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return droid((args["id"] as String));
              },
            ))
              ..inputs.addAll([
                graphQLId
                    .nonNull()
                    .coerceToInputObject()
                    .inputField('id', description: 'id of the droid')
              ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final humanSerializer = SerializerValue<Human>(
  key: "Human",
  fromJson: (ctx, json) => Human.fromJson(json), // _$$_HumanFromJson,
  // toJson: (m) => _$$_HumanToJson(m as _$_Human),
);
final _humanGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Human>>((setValue) {
  final __name = 'Human';

  final __humanGraphQLType = objectType<Human>(__name,
      isInterface: false, interfaces: [characterInterface()]);

  setValue(__humanGraphQLType);
  __humanGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id',
          resolve: (obj, ctx) => obj.id, description: 'The id of the human.'),
      graphQLString.field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the human.'),
      listOf(episodeEnum).field('appearsIn',
          resolve: (obj, ctx) => obj.appearsIn,
          description: 'Which movies they appear in.'),
      graphQLString.field('homePlanet',
          resolve: (obj, ctx) => obj.homePlanet,
          description: 'The home planet of the human, or null if unknown.'),
      listOf(characterInterface())
          .field('friends', resolve: (obj, ctx) => obj.fetchFriends),
      graphQLString.field('secretBackstory',
          resolve: (obj, ctx) => obj.secretBackstory)
    ],
  );

  return __humanGraphQLType;
});

/// Auto-generated from [Human].
GraphQLObjectType<Human> get humanGraphQLType => _humanGraphQLType.value;

final _droidGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Droid>>((setValue) {
  final __name = 'Droid';

  final __droidGraphQLType = objectType<Droid>(__name,
      isInterface: false,
      interfaces: [characterInterface()],
      description: 'A mechanical creature in the Star Wars universe.');

  setValue(__droidGraphQLType);
  __droidGraphQLType.fields.addAll(
    [
      graphQLId.nonNull().field('id',
          resolve: (obj, ctx) => obj.id, description: 'The id of the droid.'),
      graphQLString.field('name', resolve: (obj, ctx) => obj.name),
      listOf(episodeEnum).field('appearsIn',
          resolve: (obj, ctx) => obj.appearsIn,
          description: 'Which movies they appear in.'),
      graphQLString.field('primaryFunction',
          resolve: (obj, ctx) => obj.primaryFunction,
          description: 'The primary function of the droid.'),
      listOf(characterInterface())
          .field('friends', resolve: (obj, ctx) => obj.fetchFriends),
      graphQLString.field('secretBackstory',
          resolve: (obj, ctx) => obj.secretBackstory)
    ],
  );

  return __droidGraphQLType;
});

/// Auto-generated from [Droid].
GraphQLObjectType<Droid> get droidGraphQLType => _droidGraphQLType.value;

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
