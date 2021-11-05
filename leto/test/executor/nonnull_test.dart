// https://github.com/graphql/graphql-js/blob/564757fb62bfd4e2472e6e7465971baad2371805/src/execution/__tests__/nonnull-test.ts
import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart' show buildSchema;
import 'package:test/test.dart';

class _Exception implements Exception {
  final String message;

  const _Exception(this.message);

  @override
  String toString() {
    return message;
  }
}

const syncError = _Exception('sync');
const syncNonNullError = _Exception('syncNonNull');
const promiseError = _Exception('promise');
const promiseNonNullError = _Exception('promiseNonNull');

final Map<String, Object? Function()> throwingData = () {
  final Map<String, Object? Function()> throwingData = {
    'sync': () {
      throw syncError;
    },
    'syncNonNull': () {
      throw syncNonNullError;
    },
    'promise': () {
      return Future.microtask(() {
        throw promiseError;
      });
    },
    'promiseNonNull': () {
      return Future.microtask(() {
        throw promiseNonNullError;
      });
    },
  };

  throwingData.addAll({
    'syncNest': () {
      return throwingData;
    },
    'syncNonNullNest': () {
      return throwingData;
    },
    'promiseNest': () {
      return Future<Object?>.microtask(() {
        return throwingData;
      });
    },
    'promiseNonNullNest': () {
      return Future<Object?>.microtask(() {
        return throwingData;
      });
    },
  });

  return throwingData;
}();

final Map<String, Object? Function()> nullingData = () {
  final nullingData = <String, Object? Function()>{
    'sync': () {
      return null;
    },
    'syncNonNull': () {
      return null;
    },
    'promise': () {
      return Future.microtask(() {
        return null;
      });
    },
    'promiseNonNull': () {
      return Future.microtask(() {
        return null;
      });
    },
  };
  nullingData.addAll({
    'syncNest': () {
      return nullingData;
    },
    'syncNonNullNest': () {
      return nullingData;
    },
    'promiseNest': () {
      return Future.microtask(() {
        return nullingData;
      });
    },
    'promiseNonNullNest': () {
      return Future.microtask(() {
        return nullingData;
      });
    },
  });
  return nullingData;
}();

// TODO:
final schema = buildSchema('''
  type DataType {
    sync: String
    syncNonNull: String!
    promise: String
    promiseNonNull: String!
    syncNest: DataType
    syncNonNullNest: DataType!
    promiseNest: DataType
    promiseNonNullNest: DataType!
  }

  schema {
    query: DataType
  }
''');

Future<Map<String, Object?>> execute(
  GraphQLSchema schema,
  String query, {
  Map<String, Object?>? variableValues,
  Object? rootValue,
  bool validate = true,
}) async {
  final result = await GraphQL(schema, validate: validate).parseAndExecute(
    query,
    rootValue: rootValue,
    variableValues: variableValues,
  );
  return result.toJson();
}

Future<Map<String, Object?>> executeQuery(
  String query,
  Object? rootValue,
) async {
  final result = await GraphQL(schema).parseAndExecute(
    query,
    rootValue: rootValue,
  );
  return result.toJson();
}

String patch(String str) {
  return str
      .replaceAll(RegExp('\bsync\b'), 'promise')
      .replaceAll(RegExp('\bsyncNonNull\b'), 'promiseNonNull');
}

// avoids also doing any nests
Map<String, Object?> patchData(Map<String, Object?> data) {
  return jsonDecode(patch(jsonEncode(data))) as Map<String, Object?>;
}

Future<Map<String, Object?>> executeSyncAndAsync(
    String query, Object? rootValue) {
  // const syncResult = executeSync({ schema, document: parse(query), rootValue });
  // const asyncResult = await execute({
  //   schema,
  //   document: parse(patch(query)),
  //   rootValue,
  // });

  // expect(asyncResult, patchData(syncResult));
  // return syncResult;
  return executeQuery(query, rootValue);
}

/// 'Execute: handles non-nullable types'
void main() {
  group('nulls a nullable field', () {
    const query = '''
      {
        sync
      }
    ''';

    test('that returns null', () async {
      final result = await executeSyncAndAsync(query, nullingData);
      expect(result, {
        'data': {'sync': null},
      });
    });

    test('that throws', () async {
      final result = await executeSyncAndAsync(query, throwingData);
      expect(result, {
        'data': {'sync': null},
        'errors': <Map<String, Object?>>[
          {
            'message': syncError.message,
            'path': ['sync'],
            'locations': [
              {'line': 1, 'column': 8}
            ],
          },
        ],
      });
    });
  });

  group('nulls a returned object that contains a non-nullable field', () {
    const query = '''
      {
        syncNest {
          syncNonNull,
        }
      }
    ''';

    test('that returns null', () async {
      final result = await executeSyncAndAsync(query, nullingData);
      expect(result, {
        'data': {'syncNest': null},
        'errors': [
          {
            // TODO: DataType object in error
            'message': stringContainsInOrder(['non-null', 'syncNonNull']),
            // 'Cannot return null for non-nullable field DataType.syncNonNull.',
            'path': ['syncNest', 'syncNonNull'],
            'locations': [
              {'line': 2, 'column': 10}
            ],
          },
        ],
      });
    });

    test('that throws', () async {
      final result = await executeSyncAndAsync(query, throwingData);
      expect(result, {
        'data': {'syncNest': null},
        'errors': <Map<String, Object?>>[
          {
            'message': syncNonNullError.message,
            'path': ['syncNest', 'syncNonNull'],
            'locations': [
              {'line': 2, 'column': 10}
            ],
          },
        ],
      });
    });
  });

  group('nulls a complex tree of nullable fields, each', () {
    const query = '''
      {
        syncNest {
          sync
          promise
          syncNest { sync promise }
          promiseNest { sync promise }
        }
        promiseNest {
          sync
          promise
          syncNest { sync promise }
          promiseNest { sync promise }
        }
      }
    ''';
    const data = {
      'syncNest': {
        'sync': null,
        'promise': null,
        'syncNest': {'sync': null, 'promise': null},
        'promiseNest': {'sync': null, 'promise': null},
      },
      'promiseNest': {
        'sync': null,
        'promise': null,
        'syncNest': {'sync': null, 'promise': null},
        'promiseNest': {'sync': null, 'promise': null},
      },
    };

    test('that returns null', () async {
      final result = await executeQuery(query, nullingData);
      expect(result, {'data': data});
    });

    test('that throws', () async {
      final result = await executeQuery(query, throwingData);
      expect(result, {
        'data': data,
        // TODO: should this be ordered?
        'errors': unorderedEquals(<Map<String, Object?>>[
          {
            'message': syncError.message,
            'path': ['syncNest', 'sync'],
            'locations': [
              {'line': 2, 'column': 10}
            ],
          },
          {
            'message': syncError.message,
            'path': ['syncNest', 'syncNest', 'sync'],
            'locations': [
              {'line': 4, 'column': 21}
            ],
          },
          {
            'message': syncError.message,
            'path': ['syncNest', 'promiseNest', 'sync'],
            'locations': [
              {'line': 5, 'column': 24}
            ],
          },
          {
            'message': syncError.message,
            'path': ['promiseNest', 'sync'],
            'locations': [
              {'line': 8, 'column': 10}
            ],
          },
          {
            'message': syncError.message,
            'path': ['promiseNest', 'syncNest', 'sync'],
            'locations': [
              {'line': 10, 'column': 21}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['syncNest', 'promise'],
            'locations': [
              {'line': 3, 'column': 10}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['syncNest', 'syncNest', 'promise'],
            'locations': [
              {'line': 4, 'column': 26}
            ],
          },
          {
            'message': syncError.message,
            'path': ['promiseNest', 'promiseNest', 'sync'],
            'locations': [
              {'line': 11, 'column': 24}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['syncNest', 'promiseNest', 'promise'],
            'locations': [
              {'line': 5, 'column': 29}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['promiseNest', 'promise'],
            'locations': [
              {'line': 9, 'column': 10}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['promiseNest', 'syncNest', 'promise'],
            'locations': [
              {'line': 10, 'column': 26}
            ],
          },
          {
            'message': promiseError.message,
            'path': ['promiseNest', 'promiseNest', 'promise'],
            'locations': [
              {'line': 11, 'column': 29}
            ],
          },
        ]),
      });
    });
  });

  group(
      'nulls the first nullable object after a field in a long chain of non-null fields',
      () {
    const query = '''
      {
        syncNest {
          syncNonNullNest {
            promiseNonNullNest {
              syncNonNullNest {
                promiseNonNullNest {
                  syncNonNull
                }
              }
            }
          }
        }
        promiseNest {
          syncNonNullNest {
            promiseNonNullNest {
              syncNonNullNest {
                promiseNonNullNest {
                  syncNonNull
                }
              }
            }
          }
        }
        anotherNest: syncNest {
          syncNonNullNest {
            promiseNonNullNest {
              syncNonNullNest {
                promiseNonNullNest {
                  promiseNonNull
                }
              }
            }
          }
        }
        anotherPromiseNest: promiseNest {
          syncNonNullNest {
            promiseNonNullNest {
              syncNonNullNest {
                promiseNonNullNest {
                  promiseNonNull
                }
              }
            }
          }
        }
      }
    ''';
    const data = {
      'syncNest': null,
      'promiseNest': null,
      'anotherNest': null,
      'anotherPromiseNest': null,
    };

    test('that returns null', () async {
      final result = await executeQuery(query, nullingData);
      expect(result, {
        'data': data,
        'errors': [
          {
            'message':
                stringContainsInOrder(['non-nullable', 'DataType.syncNonNull']),
            // 'Cannot return null for non-nullable field DataType.syncNonNull.',
            'path': [
              'syncNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNull',
            ],
            'locations': [
              {'line': 6, 'column': 18}
            ],
          },
          {
            'message':
                stringContainsInOrder(['non-nullable', 'DataType.syncNonNull']),
            // 'Cannot return null for non-nullable field DataType.syncNonNull.',
            'path': [
              'promiseNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNull',
            ],
            'locations': [
              {'line': 17, 'column': 18}
            ],
          },
          {
            'message': stringContainsInOrder(
                ['non-nullable', 'DataType.promiseNonNull']),
            // 'Cannot return null for non-nullable field DataType.promiseNonNull.',
            'path': [
              'anotherNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'promiseNonNull',
            ],
            'locations': [
              {'line': 28, 'column': 18}
            ],
          },
          {
            'message': stringContainsInOrder(
                ['non-nullable', 'DataType.promiseNonNull']),
            // 'Cannot return null for non-nullable field DataType.promiseNonNull.',
            'path': [
              'anotherPromiseNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'promiseNonNull',
            ],
            'locations': [
              {'line': 39, 'column': 18}
            ],
          },
        ],
      });
    });

    test('that throws', () async {
      final result = await executeQuery(query, throwingData);
      expect(result, {
        'data': data,
        'errors': [
          {
            'message': syncNonNullError.message,
            'path': [
              'syncNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNull',
            ],
            'locations': [
              {'line': 6, 'column': 18}
            ],
          },
          {
            'message': syncNonNullError.message,
            'path': [
              'promiseNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNull',
            ],
            'locations': [
              {'line': 17, 'column': 18}
            ],
          },
          {
            'message': promiseNonNullError.message,
            'path': [
              'anotherNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'promiseNonNull',
            ],
            'locations': [
              {'line': 28, 'column': 18}
            ],
          },
          {
            'message': promiseNonNullError.message,
            'path': [
              'anotherPromiseNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'syncNonNullNest',
              'promiseNonNullNest',
              'promiseNonNull',
            ],
            'locations': [
              {'line': 39, 'column': 18}
            ],
          },
        ],
      });
    });
  });

  group('nulls the top level if non-nullable field', () {
    const query = '''
      {
        syncNonNull
      }
    ''';

    test('that returns null', () async {
      final result = await executeSyncAndAsync(query, nullingData);
      expect(result, {
        'data': null,
        'errors': [
          {
            'message':
                stringContainsInOrder(['non-nullable', 'DataType.syncNonNull']),
            // 'Cannot return null for non-nullable field DataType.syncNonNull.',
            'path': ['syncNonNull'],
            'locations': [
              {'line': 1, 'column': 8}
            ],
          },
        ],
      });
    });

    test('that throws', () async {
      final result = await executeSyncAndAsync(query, throwingData);
      expect(result, {
        'data': null,
        'errors': [
          {
            'message': syncNonNullError.message,
            'path': ['syncNonNull'],
            'locations': [
              {'line': 1, 'column': 8}
            ],
          },
        ],
      });
    });
  });

  group('Handles non-null argument', () {
    final schemaWithNonNullArg = GraphQLSchema(
      queryType: GraphQLObjectType(
        'Query',
        fields: [
          graphQLString.field(
            'withNonNullArg',
            inputs: [
              GraphQLFieldInput('cannotBeNull', graphQLString.nonNull()),
            ],
            resolve: (_, ctx) => 'Passed: ${ctx.args['cannotBeNull']}',
          ),
        ],
      ),
    );

    test('succeeds when passed non-null literal value', () async {
      final result = await execute(
        schemaWithNonNullArg,
        '''
          query {
            withNonNullArg (cannotBeNull: "literal value")
          }
        ''',
      );

      expect(result, {
        'data': {
          'withNonNullArg': 'Passed: literal value',
        },
      });
    });

    test('succeeds when passed non-null variable value', () async {
      final result = await execute(
        schemaWithNonNullArg,
        r'''
          query ($testVar: String!) {
            withNonNullArg (cannotBeNull: $testVar)
          }
        ''',
        variableValues: {
          'testVar': 'variable value',
        },
      );

      expect(result, {
        'data': {
          'withNonNullArg': 'Passed: variable value',
        },
      });
    });

    test('succeeds when missing variable has default value', () async {
      final result = await execute(
        schemaWithNonNullArg,
        r'''
          query ($testVar: String = "default value") {
            withNonNullArg (cannotBeNull: $testVar)
          }
        ''',
        variableValues: {
          // Intentionally missing variable
        },
      );

      expect(result, {
        'data': {
          'withNonNullArg': 'Passed: default value',
        },
      });
    });

    test('field error when missing non-null arg', () async {
      // Note: validation should identify this issue first (missing args rule)
      // however execution should still protect against this.
      final result = await execute(
        schemaWithNonNullArg,
        '''
          query {
            withNonNullArg
          }
        ''',
      );

      expect(result, {
        'data': {
          'withNonNullArg': null,
        },
        'errors': [
          {
            'message': stringContainsInOrder(
                ['"cannotBeNull"', 'String!', 'withNonNullArg']),
            // 'Argument "cannotBeNull" of required type "String!" was not provided.',
            'locations': [
              {'line': 1, 'column': 12}
            ],
            'path': ['withNonNullArg'],
          },
        ],
      });
    });

    test('field error when non-null arg provided null', () async {
      // Note: validation should identify this issue first (values of correct
      // type rule) however execution should still protect against this.
      final result = await execute(
        schemaWithNonNullArg,
        '''
          query {
            withNonNullArg(cannotBeNull: null)
          }
        ''',
      );

      expect(result, {
        'data': {
          'withNonNullArg': null,
        },
        'errors': [
          {
            'message': stringContainsInOrder(
                ['"cannotBeNull"', 'String!', 'withNonNullArg']),
            // 'Argument "cannotBeNull" of non-null type "String!" must not be null.',
            'locations': [
              // TODO: point to value at column 42?
              {'line': 1, 'column': 27}
            ],
            'path': ['withNonNullArg'],
          },
        ],
      });
    });

    test('field error when non-null arg not provided variable value', () async {
      // Note: validation should identify this issue first (variables in allowed
      // position rule) however execution should still protect against this.
      final result = await execute(
        schemaWithNonNullArg,
        r'''
          query ($testVar: String) {
            withNonNullArg(cannotBeNull: $testVar)
          }
        ''',
        variableValues: {
          // Intentionally missing variable
        },
      );

      expect(result, {
        'data': {
          'withNonNullArg': null,
        },
        'errors': [
          {
            'message':
                stringContainsInOrder(['"testVar"', 'cannotBeNull', 'String!']),
            // 'Argument "cannotBeNull" of required type "String!" was provided the variable "$testVar" which was not provided a runtime value.',
            'locations': [
              {'line': 1, 'column': 27}
            ],
            'path': ['withNonNullArg'],
          },
        ],
      });
    });

    test(
        'field error when non-null arg provided variable with explicit null value',
        () async {
      final result = await execute(
        schemaWithNonNullArg,
        r'''
          query ($testVar: String = "default value") {
            withNonNullArg (cannotBeNull: $testVar)
          }
        ''',
        variableValues: {
          'testVar': null,
        },
      );

      expect(result, {
        'data': {
          'withNonNullArg': null,
        },
        'errors': [
          {
            'message': stringContainsInOrder(
                ['cannotBeNull', 'String!', 'not be null']),
            // 'Argument "cannotBeNull" of non-null type "String!" must not be null.',
            'locations': [
              {'line': 1, 'column': 28}
            ],
            'path': ['withNonNullArg'],
          },
        ],
      });
    });
  });
}
