// https://github.com/graphql/graphql-js/blob/0c7165a5d0a7054cac4f2a0898ace19ca9d67f76/src/execution/__tests__/directives-test.ts

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';

final schema = GraphQLSchema(
  queryType: GraphQLObjectType(
    'TestType',
    fields: [
      field('a', graphQLString),
      field('b', graphQLString),
    ],
  ),
);

final rootValue = {
  'a': () {
    return 'a';
  },
  'b': () {
    return 'b';
  },
};

Future<Map<String, Object?>> executeTestQuery(String document) {
  return GraphQL(schema)
      .parseAndExecute(document, initialValue: rootValue)
      .then((r) => r.toJson());
}

/// 'Execute: handles directives',
void main() {
  group('works without directives', () {
    test('basic query works', () async {
      final result = await executeTestQuery('{ a, b }');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });
  });

  group('works on scalars', () {
    test('if true includes scalar', () async {
      final result = await executeTestQuery('{ a, b @include(if: true) }');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });

    test('if false omits on scalar', () async {
      final result = await executeTestQuery('{ a, b @include(if: false) }');

      expect(result, {
        'data': {'a': 'a'},
      });
    });

    test('unless false includes scalar', () async {
      final result = await executeTestQuery('{ a, b @skip(if: false) }');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });

    test('unless true omits scalar', () async {
      final result = await executeTestQuery('{ a, b @skip(if: true) }');

      expect(result, {
        'data': {'a': 'a'},
      });
    });
  });

  group('works on fragment spreads', () {
    test('if false omits fragment spread', () async {
      final result = await executeTestQuery('''
        query {
          a
          ...Frag @include(if: false)
        }
        fragment Frag on TestType {
          b
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });

    test('if true includes fragment spread', () async {
      final result = await executeTestQuery('''
        query {
          a
          ...Frag @include(if: true)
        }
        fragment Frag on TestType {
          b
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });

    test('unless false includes fragment spread', () async {
      final result = await executeTestQuery('''
        query {
          a
          ...Frag @skip(if: false)
        }
        fragment Frag on TestType {
          b
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });

    test('unless true omits fragment spread', () async {
      final result = await executeTestQuery('''
        query {
          a
          ...Frag @skip(if: true)
        }
        fragment Frag on TestType {
          b
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });
  });

  group('works on inline fragment', () {
    test('if false omits inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... on TestType @include(if: false) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });

    test('if true includes inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... on TestType @include(if: true) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });
    test('unless false includes inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... on TestType @skip(if: false) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });
    test('unless true includes inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... on TestType @skip(if: true) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });
  });

  group('works on anonymous inline fragment', () {
    test('if false omits anonymous inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... @include(if: false) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });

    test('if true includes anonymous inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... @include(if: true) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });
    test('unless false includes anonymous inline fragment', () async {
      final result = await executeTestQuery('''
        query Q {
          a
          ... @skip(if: false) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });
    test('unless true includes anonymous inline fragment', () async {
      final result = await executeTestQuery('''
        query {
          a
          ... @skip(if: true) {
            b
          }
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });
  });

  group('works with skip and include directives', () {
    test('include and no skip', () async {
      final result = await executeTestQuery('''
        {
          a
          b @include(if: true) @skip(if: false)
        }
      ''');

      expect(result, {
        'data': {'a': 'a', 'b': 'b'},
      });
    });

    test('include and skip', () async {
      final result = await executeTestQuery('''
        {
          a
          b @include(if: true) @skip(if: true)
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });

    test('no include or skip', () async {
      final result = await executeTestQuery('''
        {
          a
          b @include(if: false) @skip(if: false)
        }
      ''');

      expect(result, {
        'data': {'a': 'a'},
      });
    });
  });
}
