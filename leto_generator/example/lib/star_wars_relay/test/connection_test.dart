// import { expect } from 'chai';
// import { describe, it } from 'mocha';
// import { graphqlSync } from 'graphql';

// import { StarWarsSchema as schema } from './starWarsSchema';

import 'package:leto/leto.dart';
import 'package:test/test.dart';

import '../data.dart';

/// Star Wars connections
void main() {
  Future<Map<String, Object?>> execute(
    String document, {
    Map<String, Object?>? variableValues,
  }) async {
    final result = await GraphQL(
      relayStarWarsSchema,
      introspect: false,
    ).parseAndExecute(
      document,
      variableValues: variableValues,
    );
    return result.toJson();
  }

  test('fetches the first ship of the rebels', () async {
    const source = '''
      {
        rebels {
          name,
          ships(first: 1) {
            edges {
              node {
                name
              }
            }
          }
        }
      }
    ''';

    expect(await execute(source), {
      'data': {
        'rebels': {
          'name': 'Alliance to Restore the Republic',
          'ships': {
            'edges': [
              {
                'node': {'name': 'X-Wing'},
              },
            ],
          },
        },
      },
    });
  });

  test('fetches the first two ships of the rebels with a cursor', () async {
    const source = '''
      {
        rebels {
          name,
          ships(first: 2) {
            edges {
              cursor,
              node {
                name
              }
            }
          }
        }
      }
    ''';

    expect(await execute(source), {
      'data': {
        'rebels': {
          'name': 'Alliance to Restore the Republic',
          'ships': {
            'edges': [
              {
                'cursor': 'YXJyYXljb25uZWN0aW9uOjA=',
                'node': {'name': 'X-Wing'},
              },
              {
                'cursor': 'YXJyYXljb25uZWN0aW9uOjE=',
                'node': {'name': 'Y-Wing'},
              },
            ],
          },
        },
      },
    });
  });

  test('fetches the next three ships of the rebels with a cursor', () async {
    const source = '''
      {
        rebels {
          name,
          ships(first: 3 after: "YXJyYXljb25uZWN0aW9uOjE=") {
            edges {
              cursor,
              node {
                name
              }
            }
          }
        }
      }
    ''';

    expect(await execute(source), {
      'data': {
        'rebels': {
          'name': 'Alliance to Restore the Republic',
          'ships': {
            'edges': [
              {
                'cursor': 'YXJyYXljb25uZWN0aW9uOjI=',
                'node': {'name': 'A-Wing'},
              },
              {
                'cursor': 'YXJyYXljb25uZWN0aW9uOjM=',
                'node': {'name': 'Millennium Falcon'},
              },
              {
                'cursor': 'YXJyYXljb25uZWN0aW9uOjQ=',
                'node': {'name': 'Home One'},
              },
            ],
          },
        },
      },
    });
  });

  test('fetches no ships of the rebels at the end of connection', () async {
    const source = '''
      {
        rebels {
          name,
          ships(first: 3 after: "YXJyYXljb25uZWN0aW9uOjQ=") {
            edges {
              cursor,
              node {
                name
              }
            }
          }
        }
      }
    ''';

    expect(await execute(source), {
      'data': {
        'rebels': {
          'name': 'Alliance to Restore the Republic',
          'ships': {
            'edges': <Object>[],
          },
        },
      },
    });
  });

  test('identifies the end of the list', () async {
    const source = '''
      {
        rebels {
          name,
          originalShips: ships(first: 2) {
            edges {
              node {
                name
              }
            }
            pageInfo {
              hasNextPage
            }
          }
          moreShips: ships(first: 3 after: "YXJyYXljb25uZWN0aW9uOjE=") {
            edges {
              node {
                name
              }
            }
            pageInfo {
              hasNextPage
            }
          }
        }
      }
    ''';

    expect(await execute(source), {
      'data': {
        'rebels': {
          'name': 'Alliance to Restore the Republic',
          'originalShips': {
            'edges': [
              {
                'node': {'name': 'X-Wing'},
              },
              {
                'node': {'name': 'Y-Wing'},
              },
            ],
            'pageInfo': {'hasNextPage': true},
          },
          'moreShips': {
            'edges': [
              {
                'node': {'name': 'A-Wing'},
              },
              {
                'node': {'name': 'Millennium Falcon'},
              },
              {
                'node': {'name': 'Home One'},
              },
            ],
            'pageInfo': {'hasNextPage': false},
          },
        },
      },
    });
  });
}
