// https://github.com/graphql/graphql-js/blob/ac9833e4358e1995729a6c54009781ea434d4354/src/__tests__/starWarsValidation-test.ts
// import { expect } from 'chai';
// import { describe, it } from 'mocha';

// import { parse } from '../language/parser';
// import { Source } from '../language/source';

// import { validate } from '../validation/validate';

// import { StarWarsSchema } from './starWarsSchema';

import 'package:leto/leto.dart';
import 'package:leto_shelf_example/schema/star_wars/schema.dart';
import 'package:test/test.dart';

void main() {
  final server = GraphQL(starWarsSchema);

  ///
  /// Helper function to test a query and the expected response.
  ///
  Future<List<GraphQLError>> validationErrors(String query) async {
    final result = await server.parseAndExecute(query);
    return result.errors;
  }

  group('Star Wars Validation Tests', () {
    group('Basic Queries', () {
      test('Validates a complex but valid query', () async {
        const query = '''
        query NestedQueryWithFragment {
          hero {
            ...NameAndAppearances
            friends {
              ...NameAndAppearances
              friends {
                ...NameAndAppearances
              }
            }
          }
        }
        fragment NameAndAppearances on Character {
          name
          appearsIn
        }
      ''';
        return expect(await validationErrors(query), hasLength(0));
      });

      test('Notes that non-existent fields are invalid', () async {
        const query = '''
        query HeroSpaceshipQuery {
          hero {
            favoriteSpaceship
          }
        }
      ''';
        return expect(await validationErrors(query), hasLength(greaterThan(0)));
      });

      test('Requires fields on objects', () async {
        const query = '''
        query HeroNoFieldsQuery {
          hero
        }
      ''';
        return expect(await validationErrors(query), hasLength(greaterThan(0)));
      });

      test('Disallows fields on scalars', () async {
        const query = '''
        query HeroFieldsOnScalarQuery {
          hero {
            name {
              firstCharacterOfName
            }
          }
        }
      ''';
        return expect(await validationErrors(query), hasLength(greaterThan(0)));
      });

      test('Disallows object fields on interfaces', () async {
        const query = '''
        query DroidFieldOnCharacter {
          hero {
            name
            primaryFunction
          }
        }
      ''';
        return expect(await validationErrors(query), hasLength(greaterThan(0)));
        // TODO:
      }, skip: 'Implement fields on interfaces validation');

      test('Allows object fields in fragments', () async {
        const query = '''
        query DroidFieldInFragment {
          hero {
            name
            ...DroidFields
          }
        }
        fragment DroidFields on Droid {
          primaryFunction
        }
      ''';
        return expect(await validationErrors(query), const <Object?>[]);
      });

      test('Allows object fields in inline fragments', () async {
        const query = '''
        query DroidFieldInFragment {
          hero {
            name
            ... on Droid {
              primaryFunction
            }
          }
        }
      ''';
        return expect(await validationErrors(query), const <Object?>[]);
      });
    });
  });
}
