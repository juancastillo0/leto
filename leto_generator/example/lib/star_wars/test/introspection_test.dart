// https://github.com/graphql/graphql-js/blob/ac9833e4358e1995729a6c54009781ea434d4354/src/__tests__/starWarsIntrospection-test.ts
// import { expect } from 'chai';
// import { describe, it } from 'mocha';

// import { graphqlSync } from '../graphql';

// import { StarWarsSchema } from './starWarsSchema';

import 'package:leto/leto.dart';
import 'package:test/test.dart';

import '../schema.dart';

void main() {
  final server = GraphQL(starWarsSchema);

  Future<Object?> queryStarWars(String query) async {
    final result = await server.parseAndExecute(query);
    expect(result.data, isMap);
    expect(result.errors.length, 0);
    return result.data;
  }

  group('Star Wars Introspection Tests', () {
    group('Basic Introspection', () {
      test('Allows querying the schema for types', () async {
        final data = await queryStarWars('''
        {
          __schema {
            types {
              name
            }
          }
        }
      ''');

        // Include all types used by StarWars schema, introspection types and
        // standard directives. For example, `Boolean` is used in `@skip`,
        // `@include` and also inside introspection types.
        expect(data, {
          '__schema': {
            'types': unorderedEquals(
              <Object>[
                {'name': 'Human'},
                {'name': 'Character'},
                {'name': 'String'},
                // TODO: 1C id wasn't there in graphql-js, but we generated for id fields
                {'name': 'ID'},
                {'name': 'Episode'},
                {'name': 'Droid'},
                {'name': 'Query'},
                {'name': 'Boolean'},
                {'name': '__Schema'},
                {'name': '__Type'},
                {'name': '__TypeKind'},
                {'name': '__Field'},
                {'name': '__InputValue'},
                {'name': '__EnumValue'},
                {'name': '__Directive'},
                {'name': '__DirectiveLocation'},
              ],
            ),
          },
        });
      });

      test('Allows querying the schema for query type', () async {
        final data = await queryStarWars('''
        {
          __schema {
            queryType {
              name
            }
          }
        }
      ''');

        expect(data, {
          '__schema': {
            'queryType': {
              'name': 'Query',
            },
          },
        });
      });

      test('Allows querying the schema for a specific type', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Droid") {
            name
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Droid',
          },
        });
      });

      test('Allows querying the schema for an object kind', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Droid") {
            name
            kind
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Droid',
            'kind': 'OBJECT',
          },
        });
      });

      test('Allows querying the schema for an interface kind', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Character") {
            name
            kind
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Character',
            'kind': 'INTERFACE',
          },
        });
      });

      test('Allows querying the schema for object fields', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Droid") {
            name
            fields {
              name
              type {
                name
                kind
              }
            }
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Droid',
            'fields': unorderedEquals(<Object>[
              {
                'name': 'id',
                'type': {'name': null, 'kind': 'NON_NULL'},
              },
              {
                'name': 'name',
                'type': {'name': 'String', 'kind': 'SCALAR'},
              },
              {
                'name': 'friends',
                'type': {'name': null, 'kind': 'LIST'},
              },
              {
                'name': 'appearsIn',
                'type': {'name': null, 'kind': 'LIST'},
              },
              {
                'name': 'secretBackstory',
                'type': {'name': 'String', 'kind': 'SCALAR'},
              },
              {
                'name': 'primaryFunction',
                'type': {'name': 'String', 'kind': 'SCALAR'},
              },
            ]),
          },
        });
      });

      test('Allows querying the schema for nested object fields', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Droid") {
            name
            fields {
              name
              type {
                name
                kind
                ofType {
                  name
                  kind
                }
              }
            }
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Droid',
            'fields': unorderedEquals(
              <Object>[
                {
                  'name': 'id',
                  'type': {
                    'name': null,
                    'kind': 'NON_NULL',
                    'ofType': {
                      'name': 'ID',
                      'kind': 'SCALAR',
                    },
                  },
                },
                {
                  'name': 'name',
                  'type': {
                    'name': 'String',
                    'kind': 'SCALAR',
                    'ofType': null,
                  },
                },
                {
                  'name': 'friends',
                  'type': {
                    'name': null,
                    'kind': 'LIST',
                    'ofType': {
                      'name': 'Character',
                      'kind': 'INTERFACE',
                    },
                  },
                },
                {
                  'name': 'appearsIn',
                  'type': {
                    'name': null,
                    'kind': 'LIST',
                    'ofType': {
                      'name': 'Episode',
                      'kind': 'ENUM',
                    },
                  },
                },
                {
                  'name': 'secretBackstory',
                  'type': {
                    'name': 'String',
                    'kind': 'SCALAR',
                    'ofType': null,
                  },
                },
                {
                  'name': 'primaryFunction',
                  'type': {
                    'name': 'String',
                    'kind': 'SCALAR',
                    'ofType': null,
                  },
                },
              ],
            ),
          },
        });
      });

      test('Allows querying the schema for field args', () async {
        final data = await queryStarWars('''
        {
          __schema {
            queryType {
              fields {
                name
                args {
                  name
                  description
                  type {
                    name
                    kind
                    ofType {
                      name
                      kind
                    }
                  }
                  defaultValue
                }
              }
            }
          }
        }
      ''');

        expect(data, {
          '__schema': {
            'queryType': {
              'fields': [
                {
                  'name': 'hero',
                  'args': [
                    {
                      'defaultValue': null,
                      'description':
                          'If omitted, returns the hero of the whole saga. If '
                              'provided, returns the hero of that particular episode.',
                      'name': 'episode',
                      'type': {
                        'kind': 'ENUM',
                        'name': 'Episode',
                        'ofType': null,
                      },
                    },
                  ],
                },
                {
                  'name': 'human',
                  'args': [
                    {
                      'name': 'id',
                      'description': 'id of the human',
                      'type': {
                        'kind': 'NON_NULL',
                        'name': null,
                        'ofType': {
                          'kind': 'SCALAR',
                          'name': 'ID',
                        },
                      },
                      'defaultValue': null,
                    },
                  ],
                },
                {
                  'name': 'droid',
                  'args': [
                    {
                      'name': 'id',
                      'description': 'id of the droid',
                      'type': {
                        'kind': 'NON_NULL',
                        'name': null,
                        'ofType': {
                          'kind': 'SCALAR',
                          'name': 'ID',
                        },
                      },
                      'defaultValue': null,
                    },
                  ],
                },
              ],
            },
          },
        });
      });

      test('Allows querying the schema for documentation', () async {
        final data = await queryStarWars('''
        {
          __type(name: "Droid") {
            name
            description
          }
        }
      ''');

        expect(data, {
          '__type': {
            'name': 'Droid',
            'description': 'A mechanical creature in the Star Wars universe.',
          },
        });
      });
    });
  });
}
