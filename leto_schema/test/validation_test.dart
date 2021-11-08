import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

void main() {
  final typeType = enumTypeFromStrings('Type', [
    'FIRE',
    'WATER',
    'GRASS',
  ]);

  final pokemonType = objectType<Object>('Pokémon', fields: [
    field(
      'name',
      graphQLString.nonNull(),
    ),
    field(
      'type',
      typeType,
    ),
  ]);

  final isValidPokemon = predicate<Object?>(
      (x) =>
          pokemonType.validate('@root', x as Map<String, dynamic>).successful,
      'is a valid Pokémon');

  final throwsATypeError = throwsA(predicate<Object?>(
      (x) => x is TypeError || x is CastError, 'is a type or cast error'));

  test('object accepts valid input', () {
    expect({'name': 'Charmander', 'type': 'FIRE'}, isValidPokemon);
  });

  test('mismatched scalar type', () {
    expect(pokemonType.validate('@root', {'name': 24}).errors.first,
        contains('Expected "name" to be a string.'));
  });

  test('empty passed for non-nullable', () {
    expect(<String, dynamic>{}, isNot(isValidPokemon));
  });

  test('null passed for non-nullable', () {
    expect({'name': null}, isNot(isValidPokemon));
  });

  test('rejects extraneous fields', () {
    expect({'name': 'Vulpix', 'foo': 'bar'}, isNot(isValidPokemon));
  });

  test('enum accepts valid value', () {
    expect(typeType.validate('@root', 'FIRE').successful, true);
  });

  test('enum rejects invalid value', () {
    expect(typeType.validate('@root', 'POISON').successful, false);
  });

  group('union type', () {
    final digimonType = objectType<Object>(
      'Digimon',
      fields: [
        field('size', graphQLFloat.nonNull()),
      ],
    );

    final u = GraphQLUnionType<Object>('Monster', [pokemonType, digimonType]);

    test('any of its types returns valid', () {
      expect(u.validate('@root', {'size': 32.0}).successful, true);
      expect(
          u.validate(
              '@root', {'name': 'Charmander', 'type': 'FIRE'}).successful,
          true);
    });
  });

  group('input object', () {
    final type = inputObjectType<Object>(
      'Foo',
      fields: [
        graphQLString.nonNull().inputField('bar'),
        graphQLFloat.nonNull().inputField('baz'),
      ],
    );

    test('accept valid input', () {
      expect(type.validate('@root', {'bar': 'a', 'baz': 2.0}).value,
          {'bar': 'a', 'baz': 2.0});
    });

    test('error on missing non-null fields', () {
      expect(type.validate('@root', {'bar': 'a'}).successful, false);
    });

    test('error on unrecognized fields', () {
      expect(
          type.validate(
              '@root', {'bar': 'a', 'baz': 2.0, 'franken': 'stein'}).successful,
          false);
    });
  });
}
