// https://github.com/graphql/dataloader/blob/ef6d32f97cde16aba84d96dc806c4439eaf8efae/src/__tests__/dataloader.test.js
/// Copyright (c) 2019-present, GraphQL Foundation
///
/// This source code is licensed under the MIT license found in the
/// LICENSE file in the root directory of this source tree.
///
/// @flow

import 'dart:async';

import 'package:graphql_server/src/dataloader.dart';
import 'package:graphql_server/src/persisted_queries.dart';
import 'package:test/test.dart';

_Loader<K, K> idLoader<K extends Object>([Options<K, K, K>? options]) {
  final loadCalls = <List<K>>[];
  return _Loader(
    DataLoader(
      (keys) {
        loadCalls.add(keys);
        return Future.value(keys);
      },
      options,
    ),
    loadCalls,
  );
}

_Loader<K, C> idLoaderMapped<K extends Object, C>([Options<K, K, C>? options]) {
  final loadCalls = <List<K>>[];
  return _Loader(
    DataLoader(
      (keys) {
        loadCalls.add(keys);
        return Future.value(keys);
      },
      options,
    ),
    loadCalls,
  );
}

class _Loader<K extends Object, C> {
  final DataLoader<K, K, C> identityLoader;
  final List<List<K>> loadCalls;

  _Loader(this.identityLoader, this.loadCalls);
}

void main() {
  group('Argument errors', () {
    test('Batch function must promise an Array of correct length', () async {
      // Note: this resolves to empty array
      final badLoader = DataLoader.unmapped<int, int>((_) async => <int>[]);

      Object? caughtError;
      try {
        await badLoader.load(1);
      } catch (error) {
        caughtError = error;
      }
      expect(caughtError, const TypeMatcher<StateError>());
      expect(
          (caughtError! as StateError).message,
          'DataLoader must be constructed with a function which accepts '
          'List<key> and returns Future<List<value>>, but the function did '
          'not return a Future of an List of the same length as the List '
          'of keys.'
          '\n\nKeys:\n[1]'
          '\n\nValues:\n[]');
    });

    test('Requires a positive number for maxBatchSize', () {
      Object? caughtError;
      try {
        final _ = DataLoader<Object, Object, Object>(
            (keys) async => keys, Options(maxBatchSize: 0));
      } catch (error) {
        caughtError = error;
      }
      expect(caughtError, const TypeMatcher<ArgumentError>());
      expect((caughtError! as ArgumentError).message,
          'maxBatchSize must be a positive number: 0');
    });

    test('Requires a cacheKeyFn when the cache key is of different type', () {
      Object? caughtError;
      try {
        final _ = DataLoader<Object, Object, int>((keys) async => keys);
      } catch (error) {
        caughtError = error;
      }
      expect(caughtError, const TypeMatcher<ArgumentError>());
      expect(
        (caughtError! as ArgumentError).message,
        'Must pass options.cacheKeyFn if the'
        ' key type K $Object is different from C $int.',
      );
    });
  });

  group('Primary API', () {
    test('builds a really really simple data loader', () async {
      final identityLoader = DataLoader<int, int, int>((keys) async => keys);

      final promise1 = identityLoader.load(1);

      final value1 = await promise1;
      expect(value1, 1);
    });

    test('references the loader as "this" in the batch function', () async {
      // Object? that;
      // final loader = DataLoader<int, int, int>((keys) async {
      //   that = this;
      //   return keys;
      // });

      // // Trigger the batch function
      // await loader.load(1);

      // expect(that, loader);
    });

    test('references the loader as "this" in the cache key function', () async {
      // Object? that;
      // final loader = DataLoader<int, int, int>((keys) async => keys,
      //     Options(cacheKeyFn: (key) {
      //   that = this;
      //   return key;
      // }));

      // // Trigger the cache key function
      // await loader.load(1);

      // expect(that, loader);
    });

    test('supports loading multiple keys in one call', () async {
      final identityLoader = DataLoader<int, int, int>((keys) async => keys);

      final promiseAll = identityLoader.loadMany([1, 2]);

      final values = await promiseAll;
      expect(values, [1, 2]);

      final promiseEmpty = identityLoader.loadMany([]);

      final empty = await promiseEmpty;
      expect(empty, <Object>[]);
    });

    // test('supports loading multiple keys in one call with errors', () async {
    //   final identityLoader = DataLoader<String, String, String>((keys) =>
    //       Future.value(keys
    //           .map((key) => (key == 'bad' ? Exception('Bad Key') : key))
    //           .toList()));

    //   final promiseAll = identityLoader.loadMany(['a', 'b', 'bad']);
    //   // expect(promiseAll).toBeInstanceOf(Promise);

    //   final values = await promiseAll;
    //   expect(values, ['a', 'b', Exception('Bad Key')]);
    // });

    test('batches multiple requests', () async {
      final _loader = idLoader<int>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final promise1 = identityLoader.load(1);
      final promise2 = identityLoader.load(2);

      final values = await Future.wait<Object?>([promise1, promise2]);
      expect(values, [1, 2]);

      expect(loadCalls, [
        [1, 2]
      ]);
    });

    test('batches multiple requests with max batch sizes', () async {
      final _loader = idLoader<int>(Options(maxBatchSize: 2));
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final promise1 = identityLoader.load(1);
      final promise2 = identityLoader.load(2);
      final promise3 = identityLoader.load(3);

      final values = await Future.wait<Object?>([promise1, promise2, promise3]);
      expect(values[0], 1);
      expect(values[1], 2);
      expect(values[2], 3);

      expect(loadCalls, [
        [1, 2],
        [3]
      ]);
    });

    test('batches cached requests', () async {
      final loadCalls = <List<int>>[];
      var resolveBatch = () {};
      final identityLoader = DataLoader<int, int, int>((keys) {
        loadCalls.add(keys);
        final comp = Completer<List<int>>();
        resolveBatch = () {
          comp.complete(keys);
        };
        return comp.future;
      });

      identityLoader.prime(1, 1);

      final promise1 = identityLoader.load(1);
      final promise2 = identityLoader.load(2);

      // Track when each resolves.
      var promise1Resolved = false;
      var promise2Resolved = false;
      // ignore: unawaited_futures
      promise1.then((_) {
        promise1Resolved = true;
      });
      // ignore: unawaited_futures
      promise2.then((_) {
        promise2Resolved = true;
      });

      // Move to next macro-task (tick)
      await Future<dynamic>.delayed(Duration.zero);

      expect(promise1Resolved, false);
      expect(promise2Resolved, false);

      resolveBatch();
      // Move to next macro-task (tick)
      await Future<dynamic>.delayed(Duration.zero);

      expect(promise1Resolved, true);
      expect(promise2Resolved, true);

      final value = await Future.wait<Object?>([promise1, promise2]);
      expect(value[0], 1);
      expect(value[1], 2);

      expect(loadCalls, [
        [2]
      ]);
    });

    test('max batch size respects cached results', () async {
      final loadCalls = <List<int>>[];
      var resolveBatch = () {};
      final identityLoader = DataLoader.unmapped<int, int>((keys) {
        loadCalls.add(keys);
        final comp = Completer<List<int>>();
        resolveBatch = () {
          comp.complete(keys);
        };
        return comp.future;
      }, Options(maxBatchSize: 1));

      identityLoader.prime(1, 1);

      final promise1 = identityLoader.load(1);
      final promise2 = identityLoader.load(2);

      // Track when each resolves.
      var promise1Resolved = false;
      var promise2Resolved = false;
      // ignore: unawaited_futures
      promise1.then((_) {
        promise1Resolved = true;
      });
      // ignore: unawaited_futures
      promise2.then((_) {
        promise2Resolved = true;
      });

      // Move to next macro-task (tick)
      await Future<dynamic>.delayed(Duration.zero);

      // Promise 1 resolves first since max batch size is 1
      expect(promise1Resolved, true);
      expect(promise2Resolved, false);

      resolveBatch();
      // Move to next macro-task (tick)
      await Future<dynamic>.delayed(Duration.zero);

      expect(promise1Resolved, true);
      expect(promise2Resolved, true);

      final value = await Future.wait<Object?>([promise1, promise2]);
      expect(value[0], 1);
      expect(value[1], 2);

      expect(loadCalls, [
        [2]
      ]);
    });

    test('coalesces identical requests', () async {
      final _loader = idLoader<int>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final promise1a = identityLoader.load(1);
      final promise1b = identityLoader.load(1);

      final value1 = await Future.wait<Object?>([promise1a, promise1b]);
      expect(value1[0], 1);
      expect(value1[1], 1);

      expect(loadCalls, [
        [1]
      ]);
    });

    test('coalesces identical requests across sized batches', () async {
      final _loader = idLoader<int>(Options(maxBatchSize: 2));
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final promise1a = identityLoader.load(1);
      final promise2 = identityLoader.load(2);
      final promise1b = identityLoader.load(1);
      final promise3 = identityLoader.load(3);

      final value = await Future.wait<Object?>(
          [promise1a, promise2, promise1b, promise3]);
      expect(value[0], 1);
      expect(value[1], 2);
      expect(value[2], 1);
      expect(value[3], 3);

      expect(loadCalls, [
        [1, 2],
        [3]
      ]);
    });

    test('caches repeated requests', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final values1 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values1[0], 'A');
      expect(values1[1], 'B');

      expect(loadCalls, [
        ['A', 'B']
      ]);

      final values2 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('C')]);

      expect(values2[0], 'A');
      expect(values2[1], 'C');

      expect(loadCalls, [
        ['A', 'B'],
        ['C']
      ]);

      final values3 = await Future.wait<Object?>([
        identityLoader.load('A'),
        identityLoader.load('B'),
        identityLoader.load('C')
      ]);

      expect(values3[0], 'A');
      expect(values3[1], 'B');
      expect(values3[2], 'C');

      expect(loadCalls, [
        ['A', 'B'],
        ['C']
      ]);
    });

    test('clears single value in loader', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final values1 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values1[0], 'A');
      expect(values1[1], 'B');

      expect(loadCalls, [
        ['A', 'B']
      ]);

      identityLoader.clear('A');

      final values2 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values2[0], 'A');
      expect(values2[1], 'B');

      expect(loadCalls, [
        ['A', 'B'],
        ['A']
      ]);
    });

    test('clears all values in loader', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final values1 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values1[0], 'A');
      expect(values1[1], 'B');

      expect(loadCalls, [
        ['A', 'B']
      ]);

      identityLoader.clearAll();

      final values2 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values2[0], 'A');
      expect(values2[1], 'B');

      expect(loadCalls, [
        ['A', 'B'],
        ['A', 'B']
      ]);
    });

    test('allows priming the cache', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      identityLoader.prime('A', 'A');

      final values = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values[0], 'A');
      expect(values[1], 'B');

      expect(loadCalls, [
        ['B']
      ]);
    });

    test('does not prime keys that already exist', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      identityLoader.prime('A', 'X');

      final a1 = await identityLoader.load('A');
      final b1 = await identityLoader.load('B');
      expect(a1, 'X');
      expect(b1, 'B');

      identityLoader.prime('A', 'Y');
      identityLoader.prime('B', 'Y');

      final a2 = await identityLoader.load('A');
      final b2 = await identityLoader.load('B');
      expect(a2, 'X');
      expect(b2, 'B');

      expect(loadCalls, [
        ['B']
      ]);
    });

    test('allows forcefully priming the cache', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      identityLoader.prime('A', 'X');

      final a1 = await identityLoader.load('A');
      final b1 = await identityLoader.load('B');
      expect(a1, 'X');
      expect(b1, 'B');

      identityLoader.clear('A').prime('A', 'Y');
      identityLoader.clear('B').prime('B', 'Y');

      final a2 = await identityLoader.load('A');
      final b2 = await identityLoader.load('B');
      expect(a2, 'Y');
      expect(b2, 'Y');

      expect(loadCalls, [
        ['B']
      ]);
    });
  });

  group('Represents Errors', () {
    // test('Resolves to error to indicate failure', () async {
    //   final loadCalls = <List<int>>[];
    //   final evenLoader = DataLoader<int, int, int>((keys) {
    //     loadCalls.add(keys);
    //     return Future.value(keys
    //         .map((key) => key % 2 == 0 ? key : Exception('Odd: ${key}'))
    //         .toList());
    //   });

    //   Object? caughtError;
    //   try {
    //     await evenLoader.load(1);
    //   } catch (error) {
    //     caughtError = error;
    //   }
    //   expect(caughtError, const TypeMatcher<Exception>());
    //   expect((caughtError as dynamic).message, 'Odd: 1');

    //   final value2 = await evenLoader.load(2);
    //   expect(value2, 2);

    //   expect(loadCalls, [
    //     [1],
    //     [2]
    //   ]);
    // });

    // test('Can represent failures and successes simultaneously', () async {
    //   final loadCalls = <List<int>>[];
    //   final evenLoader = DataLoader<int, int, int>((keys) {
    //     loadCalls.add(keys);
    //     return Future.value(keys
    //         .map((key) => key % 2 == 0 ? key : Exception('Odd: ${key}'))
    //         .toList());
    //   });

    //   final promise1 = evenLoader.load(1);
    //   final promise2 = evenLoader.load(2);

    //   Object? caughtError;
    //   try {
    //     await promise1;
    //   } catch (error) {
    //     caughtError = error;
    //   }
    //   expect(caughtError, const TypeMatcher<Exception>());
    //   expect((caughtError as dynamic).message, 'Odd: 1');

    //   expect(await promise2, 2);

    //   expect(loadCalls, [
    //     [1, 2]
    //   ]);
    // });

    // test('Caches failed fetches', () async {
    //   final loadCalls = <List<int>>[];
    //   final errorLoader = DataLoader<int, int, int>((keys) {
    //     loadCalls.add(keys);
    //     return Future.value(
    //         keys.map((key) => Exception('Error: ${key}')).toList());
    //   });

    //   Object? caughtErrorA;
    //   try {
    //     await errorLoader.load(1);
    //   } catch (error) {
    //     caughtErrorA = error;
    //   }
    //   expect(caughtErrorA, const TypeMatcher<Exception>());
    //   expect((caughtErrorA as dynamic).message, 'Error: 1');

    //   Object? caughtErrorB;
    //   try {
    //     await errorLoader.load(1);
    //   } catch (error) {
    //     caughtErrorB = error;
    //   }
    //   expect(caughtErrorB, const TypeMatcher<Exception>());
    //   expect((caughtErrorB as dynamic).message, 'Error: 1');

    //   expect(loadCalls, [
    //     [1]
    //   ]);
    // });

    // test('Handles priming the cache with an error', () async {
    //   final _loader = idLoader<int>();
    //   final identityLoader = _loader.identityLoader;
    //   final loadCalls = _loader.loadCalls;

    //   identityLoader.prime(1, Exception('Error: 1'));

    //   // Wait a bit.
    //   // await Promise(setImmediate);

    //   Object? caughtErrorA;
    //   try {
    //     await identityLoader.load(1);
    //   } catch (error) {
    //     caughtErrorA = error;
    //   }
    //   expect(caughtErrorA, const TypeMatcher<Exception>());
    //   expect((caughtErrorA as dynamic).message, 'Error: 1');

    //   expect(loadCalls, <Object>[]);
    // });

    // test('Can clear values from cache after errors', () async {
    //   final loadCalls = <List<int>>[];
    //   final errorLoader = DataLoader<int, int, int>((keys) {
    //     loadCalls.add(keys);
    //     return Future.value(
    //         keys.map((key) => Exception('Error: ${key}')).toList());
    //   });

    //   Object? caughtErrorA;
    //   try {
    //     await errorLoader.load(1).catchError((Object error) {
    //       // Presumably determine if this error is transient, and only clear the
    //       // cache in that case.
    //       errorLoader.clear(1);
    //       throw error;
    //     });
    //   } catch (error) {
    //     caughtErrorA = error;
    //   }

    //   expect(caughtErrorA, const TypeMatcher<Exception>());
    //   expect((caughtErrorA as dynamic).message, 'Error: 1');

    //   Object? caughtErrorB;
    //   try {
    //     await errorLoader.load(1).catchError((Object error) {
    //       // Again, only do this if you can determine the error is transient.
    //       errorLoader.clear(1);
    //       throw error;
    //     });
    //   } catch (error) {
    //     caughtErrorB = error;
    //   }
    //   expect(caughtErrorB, const TypeMatcher<Exception>());
    //   expect((caughtErrorB as dynamic).message, 'Error: 1');

    //   expect(loadCalls, [
    //     [1],
    //     [1]
    //   ]);
    // });

    test('Propagates error to all loads', () async {
      final loadCalls = <List<int>>[];
      final failLoader = DataLoader<int, int, int>((keys) {
        loadCalls.add(keys);
        return Future.error(Exception('I am a terrible loader'));
      });

      final promise1 = failLoader.load(1);
      final promise2 = failLoader.load(2);

      Object? caughtErrorA;
      try {
        await promise1;
      } catch (error) {
        caughtErrorA = error;
      }
      expect(caughtErrorA, const TypeMatcher<Exception>());
      // ignore: avoid_dynamic_calls
      expect((caughtErrorA as dynamic).message, 'I am a terrible loader');

      Object? caughtErrorB;
      try {
        await promise2;
      } catch (error) {
        caughtErrorB = error;
      }
      expect(caughtErrorB, caughtErrorA);

      expect(loadCalls, [
        [1, 2]
      ]);
    });
  });

  group('Accepts any kind of key', () {
    test('Accepts objects as keys', () async {
      final _loader = idLoader<Set>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final Set<Object> keyA = {};
      final Set<Object> keyB = {};

      // Fetches as expected

      final values = await Future.wait<Object?>([
        identityLoader.load(keyA),
        identityLoader.load(keyB),
      ]);

      expect(values[0], keyA);
      expect(values[1], keyB);

      expect(loadCalls.length, 1);
      expect(loadCalls[0].length, 2);
      expect(loadCalls[0][0], keyA);
      expect(loadCalls[0][1], keyB);

      // Caching

      identityLoader.clear(keyA);

      final values2 = await Future.wait<Object?>([
        identityLoader.load(keyA),
        identityLoader.load(keyB),
      ]);

      expect(values2[0], keyA);
      expect(values2[1], keyB);

      expect(loadCalls.length, 2);
      expect(loadCalls[1].length, 1);
      expect(loadCalls[1][0], keyA);
    });
  });

  group('Accepts options', () {
    // Note: mirrors 'batches multiple requests' above.
    test('May disable batching', () async {
      final _loader = idLoader<int>(Options(batch: false));
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final promise1 = identityLoader.load(1);
      final promise2 = identityLoader.load(2);

      final values = await Future.wait<Object?>([promise1, promise2]);
      expect(values[0], 1);
      expect(values[1], 2);

      expect(loadCalls, [
        [1],
        [2]
      ]);
    });

    // Note: mirror's 'caches repeated requests' above.
    test('May disable caching', () async {
      final _loader = idLoader<String>(Options(cache: false));
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final values1 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('B')]);

      expect(values1[0], 'A');
      expect(values1[1], 'B');

      expect(loadCalls, [
        ['A', 'B']
      ]);

      final values2 = await Future.wait<Object?>(
          [identityLoader.load('A'), identityLoader.load('C')]);

      expect(values2[0], 'A');
      expect(values2[1], 'C');

      expect(loadCalls, [
        ['A', 'B'],
        ['A', 'C']
      ]);

      final values3 = await Future.wait<Object?>([
        identityLoader.load('A'),
        identityLoader.load('B'),
        identityLoader.load('C')
      ]);

      expect(values3[0], 'A');
      expect(values3[1], 'B');
      expect(values3[2], 'C');

      expect(loadCalls, [
        ['A', 'B'],
        ['A', 'C'],
        ['A', 'B', 'C']
      ]);
    });

    test('Keys are repeated in batch when cache disabled', () async {
      final _loader = idLoader<String>(Options(cache: false));
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      final values = await Future.wait<Object?>([
        identityLoader.load('A'),
        identityLoader.load('C'),
        identityLoader.load('D'),
        identityLoader.loadMany(['C', 'D', 'A', 'A', 'B']),
      ]);

      expect(values[0], 'A');
      expect(values[1], 'C');
      expect(values[2], 'D');
      expect(values[3], ['C', 'D', 'A', 'A', 'B']);

      expect(loadCalls, [
        ['A', 'C', 'D', 'C', 'D', 'A', 'A', 'B']
      ]);
    });

    // test('cacheMap may be set to null to disable cache', () async {
    //   final _loader = idLoader<String>(Options(cacheMap: null));
    //   final identityLoader = _loader.identityLoader;
    //   final loadCalls = _loader.loadCalls;

    //   await identityLoader.load('A');
    //   await identityLoader.load('A');

    //   expect(loadCalls, [
    //     ['A'],
    //     ['A']
    //   ]);
    // });

    test('Does not interact with a cache when cache is disabled', () {
      final promiseX = Future.value('X');

      final cacheMap = MapCache<String, Future<String>>();
      cacheMap.set('X', promiseX);
      final _loader =
          idLoader<String>(Options(cache: false, cacheMap: cacheMap));
      final identityLoader = _loader.identityLoader;
      identityLoader.prime('A', 'A');
      expect(cacheMap.get('A'), null);
      identityLoader.clear('X');
      expect(cacheMap.get('X'), promiseX);
      identityLoader.clearAll();
      expect(cacheMap.get('X'), promiseX);
    });

    test('Complex cache behavior via clearAll()', () async {
      // This loader clears its cache as soon as a batch function is dispatched.
      final loadCalls = <List<String>>[];
      late final DataLoader<String, String, String> identityLoader;
      identityLoader = DataLoader<String, String, String>((keys) {
        identityLoader.clearAll();
        loadCalls.add(keys);
        return Future.value(keys);
      });

      final values1 = await Future.wait<Object?>([
        identityLoader.load('A'),
        identityLoader.load('B'),
        identityLoader.load('A'),
      ]);

      expect(values1, ['A', 'B', 'A']);

      final values2 = await Future.wait<Object?>([
        identityLoader.load('A'),
        identityLoader.load('B'),
        identityLoader.load('A'),
      ]);

      expect(values2, ['A', 'B', 'A']);

      expect(loadCalls, [
        ['A', 'B'],
        ['A', 'B']
      ]);
    });

    group('Accepts object key in custom cacheKey function', () {
      String cacheKey(Map<String, Object?> key) {
        return (key.keys.toList()..sort()).map((k) => '$k:${key[k]}').join();
      }

      test('Accepts objects with a complex key', () async {
        final identityLoadCalls = <List<Map<String, int>>>[];
        final identityLoader =
            DataLoader<Map<String, int>, Map<String, int>, String>((keys) {
          identityLoadCalls.add(keys);
          return Future.value(keys);
        }, Options(cacheKeyFn: cacheKey));

        final key1 = {'id': 123};
        final key2 = {'id': 123};

        final value1 = await identityLoader.load(key1);
        final value2 = await identityLoader.load(key2);

        expect(identityLoadCalls, [
          [key1]
        ]);
        expect(value1, key1);
        expect(value2, key1);
      });

      test('Clears objects with complex key', () async {
        final identityLoadCalls = <List<Map<String, int>>>[];
        final identityLoader =
            DataLoader<Map<String, int>, Map<String, int>, String>((keys) {
          identityLoadCalls.add(keys);
          return Future.value(keys);
        }, Options(cacheKeyFn: cacheKey));

        final key1 = {'id': 123};
        final key2 = {'id': 123};

        final value1 = await identityLoader.load(key1);
        identityLoader.clear(key2); // clear equivalent object key
        final value2 = await identityLoader.load(key1);

        expect(identityLoadCalls, [
          [key1],
          [key1]
        ]);
        expect(value1, key1);
        expect(value2, key1);
      });

      test('Accepts objects with different order of keys', () async {
        final identityLoadCalls = <List<Map<String, int>>>[];
        final identityLoader =
            DataLoader<Map<String, int>, Map<String, int>, String>((keys) {
          identityLoadCalls.add(keys);
          return Future.value(keys);
        }, Options(cacheKeyFn: cacheKey));

        // Fetches as expected

        final keyA = {'a': 123, 'b': 321};
        final keyB = {'b': 321, 'a': 123};

        final values = await Future.wait<Object?>([
          identityLoader.load(keyA),
          identityLoader.load(keyB),
        ]);

        expect(values[0], keyA);
        expect(values[1], values[0]);

        expect(identityLoadCalls.length, 1);
        expect(identityLoadCalls[0].length, 1);
        expect(identityLoadCalls[0][0], keyA);
      });

      test('Allows priming the cache with an object key', () async {
        final _loader = idLoaderMapped<Map<String, int>, String>(
            Options(cacheKeyFn: cacheKey));

        final identityLoader = _loader.identityLoader;

        final key1 = {'id': 123};
        final key2 = {'id': 123};

        identityLoader.prime(key1, key1);

        final value1 = await identityLoader.load(key1);
        final value2 = await identityLoader.load(key2);

        expect(_loader.loadCalls, <Object>[]);
        expect(value1, key1);
        expect(value2, key1);
      });
    });

    group('Accepts custom cacheMap instance', () {
      test('Accepts a custom cache map implementation', () async {
        final aCustomMap = MapCache<String, Future<String>>();
        final identityLoadCalls = <List<String>>[];
        final identityLoader = DataLoader<String, String, String>((keys) {
          identityLoadCalls.add(keys);
          return Future.value(keys);
        }, Options(cacheMap: aCustomMap));

        // Fetches as expected

        final values1 = await Future.wait<Object?>([
          identityLoader.load('a'),
          identityLoader.load('b'),
        ]);

        expect(values1[0], 'a');
        expect(values1[1], 'b');

        expect(identityLoadCalls, [
          ['a', 'b']
        ]);
        expect(aCustomMap.stash.keys, ['a', 'b']);

        final values2 = await Future.wait<Object?>([
          identityLoader.load('c'),
          identityLoader.load('b'),
        ]);

        expect(values2[0], 'c');
        expect(values2[1], 'b');

        expect(identityLoadCalls, [
          ['a', 'b'],
          ['c']
        ]);
        expect(aCustomMap.stash.keys, ['a', 'b', 'c']);

        // Supports clear

        identityLoader.clear('b');
        final valueB3 = await identityLoader.load('b');

        expect(valueB3, 'b');
        expect(identityLoadCalls, [
          ['a', 'b'],
          ['c'],
          ['b']
        ]);
        expect(aCustomMap.stash.keys, ['a', 'c', 'b']);

        // Supports clear all

        identityLoader.clearAll();

        expect(aCustomMap.stash.keys, <Object>[]);
      });
    });
  });

  group('It allows custom schedulers', () {
    test('Supports manual dispatch', () {
      // function createScheduler() {
      var callbacks = <void Function()>[];
      // return {
      void schedule(void Function() callback) {
        callbacks.add(callback);
      }

      void dispatch() {
        for (final callback in callbacks) {
          callback();
        }
        callbacks = [];
      }
      // };
      // }

      // final { schedule, dispatch } = createScheduler();
      final _loader = idLoader<String>(Options(batchScheduleFn: schedule));

      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      identityLoader.load('A');
      identityLoader.load('B');
      dispatch();
      identityLoader.load('A');
      identityLoader.load('C');
      dispatch();
      // Note: never dispatched!
      identityLoader.load('D');

      expect(loadCalls, [
        ['A', 'B'],
        ['C']
      ]);
    });

    test('Custom batch scheduler is provided loader as this context', () {
      // var that;
      // void batchScheduleFn(void Function() callback) {
      //   that = this;
      //   callback();
      // }

      // final _loader =
      //     idLoader<String>(Options(batchScheduleFn: batchScheduleFn));

      // _loader.identityLoader.load('A');
      // expect(that, _loader.identityLoader);
    });
  });

  group('It is resilient to job queue ordering', () {
    test('batches loads occuring within promises', () async {
      final _loader = idLoader<String>();
      final identityLoader = _loader.identityLoader;
      final loadCalls = _loader.loadCalls;

      await Future.wait<Object?>([
        identityLoader.load('A'),
        Future<Object?>.value().then((_) => Future<Object?>.value()).then((_) {
          identityLoader.load('B');
          Future<Object?>.value()
              .then((_) => Future<Object?>.value())
              .then((_) {
            identityLoader.load('C');
            Future<Object?>.value()
                .then((_) => Future<Object?>.value())
                .then((_) {
              identityLoader.load('D');
            });
          });
        })
      ]);

      expect(loadCalls, [
        ['A', 'B', 'C', 'D']
      ]);
    });

    test('can call a loader from a loader', () async {
      final deepLoadCalls = <List<List<String>>>[];
      final deepLoader =
          DataLoader<List<String>, List<String>, List<String>>((keys) {
        deepLoadCalls.add(keys);
        return Future.value(keys);
      });

      final aLoadCalls = <List<String>>[];
      final aLoader = DataLoader<String, String, String>((keys) {
        aLoadCalls.add(keys);
        return deepLoader.load(keys);
      });

      final bLoadCalls = <List<String>>[];
      final bLoader = DataLoader<String, String, String>((keys) {
        bLoadCalls.add(keys);
        return deepLoader.load(keys);
      });

      final values = await Future.wait<Object?>([
        aLoader.load('A1'),
        bLoader.load('B1'),
        aLoader.load('A2'),
        bLoader.load('B2')
      ]);

      expect(values[0], 'A1');
      expect(values[1], 'B1');
      expect(values[2], 'A2');
      expect(values[3], 'B2');

      expect(aLoadCalls, [
        ['A1', 'A2']
      ]);
      expect(bLoadCalls, [
        ['B1', 'B2']
      ]);
      expect(deepLoadCalls, [
        [
          ['A1', 'A2'],
          ['B1', 'B2']
        ]
      ]);
    });
  });
}
