import 'package:graphql_schema/graphql_schema.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  test('int', () {
    expect(graphQLInt.serialize(23), 23);
  });

  test('float', () {
    expect(graphQLFloat.serialize(23.0), 23.0);
  });

  test('bool', () {
    expect(graphQLBoolean.serialize(true), true);
  });

  test('string', () {
    expect(graphQLString.serialize('a'), 'a');
  });

  test('enum', () {
    final response = enumTypeFromStrings('Response', ['YES', 'NO']);
    expect(response.serialize('YES'), 'YES');
  });

  test('enum only serializes correct values', () {
    final response = enumTypeFromStrings('Response', ['YES', 'NO']);
    expect(() => response.serialize('MAYBE'), throwsStateError);
  });

  test('date', () {
    final now = DateTime.now();
    expect(graphQLDate.serialize(now), now.toIso8601String());
  });

  test('list', () {
    expect(listOf(graphQLString).serialize(['foo', 'bar']), ['foo', 'bar']);

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    expect(listOf(graphQLDate).serialize([today, tomorrow]),
        [today.toIso8601String(), tomorrow.toIso8601String()]);
  });

  group('input object', () {
    final type = inputObjectType(
      'Foo',
      inputFields: [
        inputField('bar', graphQLString.nonNullable()),
        inputField('baz', graphQLFloat.nonNullable()),
      ],
    );

    test('serializes valid input', () {
      expect(
          type.serialize({'bar': 'a', 'baz': 2.0}), {'bar': 'a', 'baz': 2.0});
    });
  });

  test('object', () {
    final catchDate = DateTime.now();

    final pikachu = {'species': 'Pikachu', 'catch_date': catchDate};

    expect(pokemonType.serialize(pikachu),
        {'species': 'Pikachu', 'catch_date': catchDate.toIso8601String()});
  });

  test('union type lets any of its types serialize', () {
    final typeType = enumTypeFromStrings('Type', [
      'FIRE',
      'WATER',
      'GRASS',
    ]);

    final pokemonType = objectType<Object>('Pokémon', fields: [
      field(
        'name',
        graphQLString.nonNullable(),
      ),
      field(
        'type',
        typeType,
      ),
    ]);

    final digimonType = objectType<Object>(
      'Digimon',
      fields: [
        field('size', graphQLFloat.nonNullable()),
      ],
    );

    final u = GraphQLUnionType('Monster', [pokemonType, digimonType]);

    expect(u.serialize({'size': 10.0}), {'size': 10.0});
    expect(u.serialize({'name': 'Charmander', 'type': 'FIRE'}),
        {'name': 'Charmander', 'type': 'FIRE'});
  });

  test('nested object', () {
    final pikachuDate = DateTime.now(),
        charizardDate = pikachuDate.subtract(const Duration(days: 10));

    final pikachu = {'species': 'Pikachu', 'catch_date': pikachuDate};
    final charizard = {'species': 'Charizard', 'catch_date': charizardDate};

    final trainer = {'name': 'Tobe O'};

    final region = pokemonRegionType.serialize({
      'trainer': trainer,
      'pokemon_species': [pikachu, charizard]
    });
    print(region);

    expect(region, {
      'trainer': trainer,
      'pokemon_species': [
        {'species': 'Pikachu', 'catch_date': pikachuDate.toIso8601String()},
        {'species': 'Charizard', 'catch_date': charizardDate.toIso8601String()}
      ]
    });

    expect(
        () => pokemonRegionType.serialize({
              'trainer': trainer,
              'DIGIMON_species': [pikachu, charizard]
            }),
        throwsUnsupportedError);
  });
}
