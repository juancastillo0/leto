// https://github.com/graphql/graphql-js/blob/2df59f18dd3f3c415eaba57d744131a674079ddf/src/__tests__/starWarsQuery-test.ts
// import { expect } from 'chai';
// import { group, it } from 'mocha';

// import { graphql } from '../graphql';

// import { StarWarsSchema as schema } from './starWarsSchema';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/star_wars/schema.dart';
import 'package:test/test.dart';

void main() {
  final server = GraphQL(starWarsSchema);
  Future<Map<String, Object?>> executeRequest(
    String source, {
    Map<String, Object?>? variableValues,
  }) async {
    final result = await server.parseAndExecute(
      source,
      variableValues: variableValues,
    );
    return result.toJson();
  }

  group('Star Wars Query Tests', () {
    group('Basic Queries', () {
      test('Correctly identifies R2-D2 as the hero of the Star Wars Saga',
          () async {
        const source = '''
        query HeroNameQuery {
          hero {
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              'name': 'R2-D2',
            },
          },
        });
      });

      test('Allows us to query for the ID and friends of R2-D2', () async {
        const source = '''
        query HeroNameAndFriendsQuery {
          hero {
            id
            name
            friends {
              name
            }
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              'id': '2001',
              'name': 'R2-D2',
              'friends': [
                {
                  'name': 'Luke Skywalker',
                },
                {
                  'name': 'Han Solo',
                },
                {
                  'name': 'Leia Organa',
                },
              ],
            },
          },
        });
      });
    });

    group('Nested Queries', () {
      test('Allows us to query for the friends of friends of R2-D2', () async {
        const source = '''
        query NestedQuery {
          hero {
            name
            friends {
              name
              appearsIn
              friends {
                name
              }
            }
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              'name': 'R2-D2',
              'friends': [
                {
                  'name': 'Luke Skywalker',
                  'appearsIn': ['NEW_HOPE', 'EMPIRE', 'JEDI'],
                  'friends': [
                    {
                      'name': 'Han Solo',
                    },
                    {
                      'name': 'Leia Organa',
                    },
                    {
                      'name': 'C-3PO',
                    },
                    {
                      'name': 'R2-D2',
                    },
                  ],
                },
                {
                  'name': 'Han Solo',
                  'appearsIn': ['NEW_HOPE', 'EMPIRE', 'JEDI'],
                  'friends': [
                    {
                      'name': 'Luke Skywalker',
                    },
                    {
                      'name': 'Leia Organa',
                    },
                    {
                      'name': 'R2-D2',
                    },
                  ],
                },
                {
                  'name': 'Leia Organa',
                  'appearsIn': ['NEW_HOPE', 'EMPIRE', 'JEDI'],
                  'friends': [
                    {
                      'name': 'Luke Skywalker',
                    },
                    {
                      'name': 'Han Solo',
                    },
                    {
                      'name': 'C-3PO',
                    },
                    {
                      'name': 'R2-D2',
                    },
                  ],
                },
              ],
            },
          },
        });
      });
    });

    group('Using IDs and query parameters to refetch objects', () {
      test('Allows us to query characters directly, using their IDs', () async {
        const source = '''
        query FetchLukeAndC3POQuery {
          human(id: "1000") {
            name
          }
          droid(id: "2000") {
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'human': {
              'name': 'Luke Skywalker',
            },
            'droid': {
              'name': 'C-3PO',
            },
          },
        });
      });

      test(
          'Allows us to create a generic query, then use it to fetch Luke Skywalker using his ID',
          () async {
        const source = r'''
        query FetchSomeIDQuery($someId: String!) {
          human(id: $someId) {
            name
          }
        }
      ''';
        const variableValues = {'someId': '1000'};

        final result =
            await executeRequest(source, variableValues: variableValues);
        expect(result, {
          'data': {
            'human': {
              'name': 'Luke Skywalker',
            },
          },
        });
      });

      test(
          'Allows us to create a generic query, then use it to fetch Han Solo using his ID',
          () async {
        const source = r'''
        query FetchSomeIDQuery($someId: String!) {
          human(id: $someId) {
            name
          }
        }
      ''';
        const variableValues = {'someId': '1002'};

        final result =
            await executeRequest(source, variableValues: variableValues);
        expect(result, {
          'data': {
            'human': {
              'name': 'Han Solo',
            },
          },
        });
      });

      test(
          'Allows us to create a generic query, then pass an invalid ID to get null back',
          () async {
        const source = r'''
        query humanQuery($id: String!) {
          human(id: $id) {
            name
          }
        }
      ''';
        const variableValues = {'id': 'not a valid id'};

        final result =
            await executeRequest(source, variableValues: variableValues);
        expect(result, {
          'data': {
            'human': null,
          },
        });
      });
    });

    group('Using aliases to change the key in the response', () {
      test('Allows us to query for Luke, changing his key with an alias',
          () async {
        const source = '''
        query FetchLukeAliased {
          luke: human(id: "1000") {
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'luke': {
              'name': 'Luke Skywalker',
            },
          },
        });
      });

      test(
          'Allows us to query for both Luke and Leia, using two root fields and an alias',
          () async {
        const source = '''
        query FetchLukeAndLeiaAliased {
          luke: human(id: "1000") {
            name
          }
          leia: human(id: "1003") {
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'luke': {
              'name': 'Luke Skywalker',
            },
            'leia': {
              'name': 'Leia Organa',
            },
          },
        });
      });
    });

    group('Uses fragments to express more complex queries', () {
      test('Allows us to query using duplicated content', () async {
        const source = '''
        query DuplicateFields {
          luke: human(id: "1000") {
            name
            homePlanet
          }
          leia: human(id: "1003") {
            name
            homePlanet
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'luke': {
              'name': 'Luke Skywalker',
              'homePlanet': 'Tatooine',
            },
            'leia': {
              'name': 'Leia Organa',
              'homePlanet': 'Alderaan',
            },
          },
        });
      });

      test('Allows us to use a fragment to avoid duplicating content',
          () async {
        const source = '''
        query UseFragment {
          luke: human(id: "1000") {
            ...HumanFragment
          }
          leia: human(id: "1003") {
            ...HumanFragment
          }
        }
        fragment HumanFragment on Human {
          name
          homePlanet
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'luke': {
              'name': 'Luke Skywalker',
              'homePlanet': 'Tatooine',
            },
            'leia': {
              'name': 'Leia Organa',
              'homePlanet': 'Alderaan',
            },
          },
        });
      });
    });

    group('Using __typename to find the type of an object', () {
      test('Allows us to verify that R2-D2 is a droid', () async {
        const source = '''
        query CheckTypeOfR2 {
          hero {
            __typename
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              '__typename': 'Droid',
              'name': 'R2-D2',
            },
          },
        });
      });

      test('Allows us to verify that Luke is a human', () async {
        const source = '''
        query CheckTypeOfLuke {
          hero(episode: EMPIRE) {
            __typename
            name
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              '__typename': 'Human',
              'name': 'Luke Skywalker',
            },
          },
        });
      });
    });

    group('Reporting errors raised in resolvers', () {
      test('Correctly reports error on accessing secretBackstory', () async {
        const source = '''
        query HeroNameQuery {
          hero {
            name
            secretBackstory
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              'name': 'R2-D2',
              'secretBackstory': null,
            },
          },
          'errors': [
            {
              'message': 'secretBackstory is secret.',
              'locations': [
                {'line': 3, 'column': 12}
              ],
              'path': ['hero', 'secretBackstory'],
            },
          ],
        });
      });

      test('Correctly reports error on accessing secretBackstory in a list',
          () async {
        const source = '''
        query HeroNameQuery {
          hero {
            name
            friends {
              name
              secretBackstory
            }
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'hero': {
              'name': 'R2-D2',
              'friends': [
                {
                  'name': 'Luke Skywalker',
                  'secretBackstory': null,
                },
                {
                  'name': 'Han Solo',
                  'secretBackstory': null,
                },
                {
                  'name': 'Leia Organa',
                  'secretBackstory': null,
                },
              ],
            },
          },
          'errors': [
            {
              'message': 'secretBackstory is secret.',
              'locations': [
                {'line': 5, 'column': 14}
              ],
              'path': ['hero', 'friends', 0, 'secretBackstory'],
            },
            {
              'message': 'secretBackstory is secret.',
              'locations': [
                {'line': 5, 'column': 14}
              ],
              'path': ['hero', 'friends', 1, 'secretBackstory'],
            },
            {
              'message': 'secretBackstory is secret.',
              'locations': [
                {'line': 5, 'column': 14}
              ],
              'path': ['hero', 'friends', 2, 'secretBackstory'],
            },
          ],
        });
      });

      test('Correctly reports error on accessing through an alias', () async {
        const source = '''
        query HeroNameQuery {
          mainHero: hero {
            name
            story: secretBackstory
          }
        }
      ''';

        final result = await executeRequest(source);
        expect(result, {
          'data': {
            'mainHero': {
              'name': 'R2-D2',
              'story': null,
            },
          },
          'errors': [
            {
              'message': 'secretBackstory is secret.',
              'locations': [
                {'line': 3, 'column': 12}
              ],
              'path': ['mainHero', 'story'],
            },
          ],
        });
      });
    });
  });
}
