import 'package:leto_schema/leto_schema.dart';

final GraphQLObjectType pokemonType = objectType<Object>('Pokemon', fields: [
  field('species', graphQLString),
  field('catch_date', graphQLDate)
]);

final GraphQLObjectType trainerType =
    objectType<Object>('Trainer', fields: [field('name', graphQLString)]);

final GraphQLObjectType pokemonRegionType = objectType<Object>('PokemonRegion',
    fields: [
      field('trainer', trainerType),
      field('pokemon_species', pokemonType.list())
    ]);
