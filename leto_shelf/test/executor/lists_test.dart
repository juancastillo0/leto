// https://github.com/graphql/graphql-js/blob/564757fb62bfd4e2472e6e7465971baad2371805/src/execution/__tests__/lists-test.ts
import 'package:graphql_schema/utilities.dart' show buildSchema;
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';

///
void main() {
  group('Execute: Accepts any iterable as list value', () {
    Future<Map<String, Object?>> complete(Object? listValue) async {
      final result =
          await GraphQL(buildSchema('type Query { listField: [String] }'))
              .parseAndExecute(
        '{ listField }',
        rootValue: {'listField': listValue},
      );

      return result.toJson();
    }

    test('Accepts a Set as a List value', () async {
      final listField =
          Set<String>.from(<String>['apple', 'banana', 'apple', 'coconut']);

      expect(await complete(listField), {
        'data': {
          'listField': ['apple', 'banana', 'coconut']
        },
      });
    });

    test('Accepts an Generator function as a List value', () async {
      Iterable<Object> listField() sync* {
        yield 'one';
        // TODO: allow numbers or boolean as String?
        yield '2';
        yield 'true';
      }

      expect(await complete(listField), {
        'data': {
          'listField': ['one', '2', 'true']
        },
      });
    });

    test('Accepts function arguments as a List value', () async {
      // function getArgs(..._args: ReadonlyArray<string>) {
      //   return arguments;
      // }
      // const listField = getArgs('one', 'two');

      // expect(complete({ listField }), {
      //   data: { listField: ['one', 'two'] },
      // });
    });

    test('Does not accept (Iterable) String-literal as a List value', () async {
      const listField = 'Singular';

      expect(await complete(listField), {
        'data': {'listField': null},
        'errors': [
          {
            'message':
                stringContainsInOrder(['listField', 'iterable', 'Singular']),
            // 'Expected Iterable, but did not find one for field "Query.listField".',
            'locations': [
              {'line': 0, 'column': 2}
            ],
            'path': ['listField'],
          },
        ],
      });
    });
  });

  group('Execute: Handles list nullability', () {
    Future<Map<String, Object?>> complete(
      Object? listField, {
      required String as_,
    }) async {
      final schema = buildSchema('type Query { listField: $as_ }');
      const document = '{ listField }';

      Future<Map<String, Object?>> executeQuery(Object? listValue) {
        return GraphQL(schema).parseAndExecute(
          document,
          rootValue: {
            'listField': listValue,
          },
        ).then((v) => v.toJson());
      }

      Future<Object?> promisify(Object? value) {
        return value is Exception ? Future.error(value) : Future.value(value);
      }

      final result = await executeQuery(listField);
      // Promise<Array<T>> === Array<T>
      expect(await executeQuery(promisify(listField)), result);
      if (listField is List) {
        final listOfPromises = listField.map(promisify);

        // Array<Promise<T>> === Array<T>
        expect(await executeQuery(listOfPromises), result);
        // Promise<Array<Promise<T>>> === Array<T>
        expect(
          await executeQuery(promisify(listOfPromises)),
          result,
        );
      }

      return result;
    }

    test('Contains values', () async {
      const listField = [1, 2];

      expect(await complete(listField, as_: '[Int]'), {
        'data': {
          'listField': [1, 2]
        },
      });
      expect(await complete(listField, as_: '[Int]!'), {
        'data': {
          'listField': [1, 2]
        },
      });
      expect(await complete(listField, as_: '[Int!]'), {
        'data': {
          'listField': [1, 2]
        },
      });
      expect(await complete(listField, as_: '[Int!]!'), {
        'data': {
          'listField': [1, 2]
        },
      });
    });

    test('Contains null', () async {
      const listField = [1, null, 2];
      final errors = [
        {
          'message': stringContainsInOrder(['non-null', 'Query.listField']),
          // 'Cannot return null for non-nullable field Query.listField.',
          'locations': [
            {'line': 0, 'column': 2}
          ],
          'path': ['listField', 1],
        },
      ];

      expect(await complete(listField, as_: '[Int]'), {
        'data': {
          'listField': [1, null, 2]
        },
      });
      expect(await complete(listField, as_: '[Int]!'), {
        'data': {
          'listField': [1, null, 2]
        },
      });
      expect(await complete(listField, as_: '[Int!]'), {
        'data': {'listField': null},
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]!'), {
        'data': null,
        'errors': errors,
      });
    });

    test('Returns null', () async {
      const Object? listField = null;
      final errors = [
        {
          'message': stringContainsInOrder(['non-null', 'Query.listField']),
          // 'Cannot return null for non-nullable field Query.listField.',
          'locations': [
            {'line': 0, 'column': 2}
          ],
          'path': ['listField'],
        },
      ];

      expect(await complete(listField, as_: '[Int]'), {
        'data': {'listField': null},
      });
      expect(await complete(listField, as_: '[Int]!'), {
        'data': null,
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]'), {
        'data': {'listField': null},
      });
      expect(await complete(listField, as_: '[Int!]!'), {
        'data': null,
        'errors': errors,
      });
    });

    test('Contains error', () async {
      final listField = [1, () => throw GraphQLError('bad'), 2];
      const errors = [
        {
          'message': 'bad',
          'locations': [
            {'line': 0, 'column': 2}
          ],
          'path': ['listField', 1],
        },
      ];

      expect(await complete(listField, as_: '[Int]'), {
        'data': {
          'listField': [1, null, 2]
        },
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int]!'), {
        'data': {
          'listField': [1, null, 2]
        },
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]'), {
        'data': {'listField': null},
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]!'), {
        'data': null,
        'errors': errors,
      });
    });

    test('Results in error', () async {
      final listField = () => throw GraphQLError('bad');
      const errors = [
        {
          'message': 'bad',
          'locations': [
            {'line': 0, 'column': 2}
          ],
          'path': ['listField'],
        },
      ];

      expect(await complete(listField, as_: '[Int]'), {
        'data': {'listField': null},
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int]!'), {
        'data': null,
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]'), {
        'data': {'listField': null},
        'errors': errors,
      });
      expect(await complete(listField, as_: '[Int!]!'), {
        'data': null,
        'errors': errors,
      });
    });
  });
}
