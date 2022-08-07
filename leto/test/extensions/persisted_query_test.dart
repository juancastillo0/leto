import 'dart:convert' show json, utf8;

import 'package:crypto/crypto.dart' show sha1;
import 'package:leto/leto.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

import 'tasks_schema.dart';

Map<String, Object?> persistedQueryExtension(String? sha256Hash) {
  return {
    'persistedQuery': {'version': 1, 'sha256Hash': sha256Hash}
  };
}

void main() {
  late ScopedMap scope;
  late LruCacheSimple<String, DocumentNode> queriesCache;
  late GraphQL executor;

  setUp(() {
    scope = ScopedMap();
    queriesCache = LruCacheSimple(10);
    executor = GraphQL(
      tasksSchema,
      globalVariables: scope,
      extensions: [
        GraphQLPersistedQueries(
          returnHashInResponse: true,
          cache: queriesCache,
        ),
        CacheExtension(),
      ],
    );
  });

  Future<Map<String, Object?>> _exec(
    String query, {
    String? operationName,
    Map<String, Object?>? extensions,
  }) async {
    final result = await executor.parseAndExecute(
      query,
      operationName: operationName,
      extensions: extensions,
    );
    return json.decode(json.encode(result)) as Map<String, Object?>;
  }

  test('persisted query with cache', () async {
    final dataHash = sha1
        .convert(utf8.encode(json.encode(tasksRef.get(scope).tasks)))
        .toString();

    final jsonResp = await _exec(
      query,
      extensions: {
        ...persistedQueryExtension(queryHash),
        'cacheResponse': {
          'nested': {
            'getTasks': {
              'hash': dataHash,
            },
          },
        },
      },
    );

    expect(jsonResp, {
      'data': {
        'getTasks': null,
      },
      'extensions': {
        'persistedQuery': {
          'sha256Hash': queryHash,
        },
        'cacheResponse': {
          'hash': isA<String>(),
          'nested': {
            'getTasks': {
              'hash': dataHash,
            },
          }
        }
      }
    });
    final rootHash = ((jsonResp['extensions'] as Map)['cacheResponse']
        as Map)['hash'] as String;

    final jsonResp2 = await _exec(
      '',
      extensions: {
        ...persistedQueryExtension(queryHash),
        'cacheResponse': {
          'hash': rootHash,
        },
      },
    );

    expect(jsonResp2, {
      'data': <String, Object?>{},
      'extensions': {
        'cacheResponse': {
          'hash': rootHash,
        }
      }
    });
    expect(queriesCache.map.length, 1);

    final data = tasksRef.get(scope).tasks;

    final firstAssignedToHash =
        sha1.convert(utf8.encode(json.encode(data[0].assignedTo))).toString();
    final firstTaskHash = sha1
        .convert(utf8.encode(json.encode(
          {'id': data[0].id, 'assignedTo': data[0].assignedTo},
        )))
        .toString();

    final jsonResp3 = await _exec(
      query2,
      extensions: {
        ...persistedQueryExtension(null),
        'cacheResponse': {
          'nested': {
            'getTasks': {
              'nested': {
                '0': {
                  'hash': 'wrong-value',
                  'nested': {
                    'assignedTo': {'hash': firstAssignedToHash}
                  }
                }
              }
            },
          },
        },
      },
    );
    expect(queriesCache.map.length, 2);

    expect(jsonResp3, {
      'data': {
        'getTasks': [
          {
            'id': data[0].id,
            'assignedTo': null,
          },
          {
            'id': data[1].id,
            'assignedTo': data[1].assignedTo,
          },
        ]
      },
      'extensions': {
        'persistedQuery': {'sha256Hash': query2Hash},
        'cacheResponse': {
          'hash': isA<String>(),
          'nested': {
            'getTasks': {
              'hash': isA<String>(),
              'nested': {
                '0': {
                  'hash': firstTaskHash,
                  'nested': {
                    'assignedTo': {'hash': firstAssignedToHash}
                  }
                }
              }
            },
          },
        },
      }
    });
  });

  test('persisted queries error', () async {
    final result = await _exec(
      query,
      extensions: {
        ...persistedQueryExtension('wrong-query-hash'),
      },
    );
    expect(queriesCache.linkedList, isEmpty);
    expect(result, {
      'errors': [
        {
          'message': GraphQLPersistedQueries.PERSISTED_QUERY_HASH_MISMATCH,
        }
      ]
    });
    final result2 = await _exec(
      '',
      extensions: {
        ...persistedQueryExtension(queryHash),
      },
    );
    expect(queriesCache.linkedList, isEmpty);
    expect(result2, {
      'errors': [
        {
          'message': GraphQLPersistedQueries.PERSISTED_QUERY_NOT_FOUND,
        }
      ]
    });
    final result3 = await _exec(
      query,
      extensions: {
        ...persistedQueryExtension(queryHash),
      },
    );
    expect(queriesCache.linkedList.length, 1);
    expect(
      (result3['extensions'] as Map)['persistedQuery'],
      {'sha256Hash': queryHash},
    );
    final result4 = await _exec(
      query2,
    );
    expect(queriesCache.linkedList.length, 2);
    expect(
      result4['extensions'],
      isNull,
    );

    final result5 = await _exec(
      '$query ',
      extensions: {
        ...persistedQueryExtension(queryHash),
      },
    );
    expect(queriesCache.linkedList.length, 2);
    expect(result5, {
      'errors': [
        {
          'message': GraphQLPersistedQueries.PERSISTED_QUERY_HASH_MISMATCH,
        }
      ]
    });
  });
}
