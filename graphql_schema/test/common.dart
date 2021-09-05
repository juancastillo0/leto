import 'package:graphql_schema/graphql_schema.dart';

final GraphQLObjectType pokemonType = objectType('Pokemon', fields: [
  field('species', graphQLString),
  field('catch_date', graphQLDateValue)
]);

final GraphQLObjectType trainerType =
    objectType('Trainer', fields: [field('name', graphQLString)]);

final GraphQLObjectType pokemonRegionType = objectType('PokemonRegion',
    fields: [
      field('trainer', trainerType),
      field('pokemon_species', listOf(pokemonType))
    ]);
