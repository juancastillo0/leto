// https://github.com/graphql/dataloader/blob/ef6d32f97cde16aba84d96dc806c4439eaf8efae/src/index.js

/// Copyright (c) 2019-present, GraphQL Foundation
///
/// This source code is licensed under the MIT license found in the
/// LICENSE file in the root directory of this source tree.
///
/// @flow strict
///

// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:graphql_server/src/persisted_queries.dart';

// A Function, which when given an Array of keys, returns a Promise of an Array
// of values or Errors.
typedef BatchLoadFn<K, V> = Future<List<V>> Function(List<K> keys);

// Optionally turn off batching or caching or provide a cache key function or a
// custom cache instance.
class Options<K, V, C> {
  final bool? batch;
  final int? maxBatchSize;
  final void Function(void Function() callback)? batchScheduleFn;
  final bool? cache;
  final C Function(K)? cacheKeyFn;
  final Cache<C, Future<V>>? cacheMap;

  Options({
    this.batch,
    this.maxBatchSize,
    this.batchScheduleFn,
    this.cache,
    this.cacheKeyFn,
    this.cacheMap,
  });
}

// If a custom cache is provided, it must be of this type (a subset of ES6 Map).
// type CacheMap<K, V> = {
//   get(key: K): V | void;
//   set(key: K, value: V): any;
//   delete(key: K): any;
//   clear(): any;
// };

/// A `DataLoader` creates a public API for loading data from a particular
/// data back-end with unique keys such as the `id` column of a SQL table or
/// document name in a MongoDB database, given a batch loading function.
///
/// Each `DataLoader` instance contains a unique memoized cache. Use caution when
/// used in long-lived applications or those which serve many users with
/// different access permissions and consider creating a new instance per
/// web request.
class DataLoader<K extends Object, V, C> {
  DataLoader(this._batchLoadFn, [Options<K, V, C>? options])
      : _maxBatchSize = getValidMaxBatchSize(options),
        _batchScheduleFn = getValidBatchScheduleFn(options),
        _cacheKeyFn = options?.cacheKeyFn ??
            (K == C
                ? (k) => k as C
                : throw ArgumentError(
                    'Must pass options.cacheKeyFn if the'
                    ' key type K $K is different from C $C.',
                  )),
        _cacheMap = getValidCacheMap(options);
  // if (typeof batchLoadFn != 'function') {
  //   throw new TypeError(
  //     'DataLoader must be constructed with a function which accepts ' +
  //     `Array<key> and returns Promise<Array<value>>, but got: ${batchLoadFn}.`
  //   );
  // }

  static DataLoader<K, V, K> unmapped<K extends Object, V>(
    BatchLoadFn<K, V> _batchLoadFn, [
    Options<K, V, K>? options,
  ]) =>
      DataLoader(_batchLoadFn, options);

  // Private
  final BatchLoadFn<K, V> _batchLoadFn;
  final int _maxBatchSize;
  final void Function(void Function() callback) _batchScheduleFn;
  final C Function(K) _cacheKeyFn;
  final Cache<C, FutureOr<V>>? _cacheMap;
  Batch<K, V>? _batch;

  /// Loads a key, returning a `Promise` for the value represented by that key.
  Future<V> load(K key) {
    // if (key == null) {
    //   throw new TypeError(
    //     'The loader.load() function must be called with a value, ' +
    //     `but got: ${String(key)}.`
    //   );
    // }

    final batch = getCurrentBatch(this);
    final cacheMap = this._cacheMap;
    final cacheKey = this._cacheKeyFn(key);

    // If caching and there is a cache-hit, return cached Promise.
    if (cacheMap != null) {
      final cachedPromise = cacheMap.get(cacheKey);
      if (cachedPromise != null) {
        final cacheHits =
            batch.cacheHits != null ? batch.cacheHits! : (batch.cacheHits = []);
        final comp = Completer<V>();
        cacheHits.add(() {
          comp.complete(cachedPromise);
        });
        return comp.future;
      }
    }

    // Otherwise, produce a new Promise for this key, and enqueue it to be
    // dispatched along with the current batch.
    batch.keys.add(key);
    final comp = Completer<V>();
    batch.callbacks.add(comp);

    // If caching, cache this promise.
    if (cacheMap != null) {
      cacheMap.set(cacheKey, comp.future);
    }

    return comp.future;
  }

  /// Loads multiple keys, promising an array of values:
  ///
  ///     var [ a, b ] = await myLoader.loadMany([ 'a', 'b' ]);
  ///
  /// This is similar to the more verbose:
  ///
  ///     var [ a, b ] = await Promise.all([
  ///       myLoader.load('a'),
  ///       myLoader.load('b')
  ///     ]);
  ///
  /// However it is different in the case where any load fails. Where
  /// Promise.all() would reject, loadMany() always resolves, however each result
  /// is either a value or an Error instance.
  ///
  ///     var [ a, b, c ] = await myLoader.loadMany([ 'a', 'b', 'badkey' ]);
  ///     // c instanceof Error
  ///
  Future<List<V>> loadMany(List<K> keys) {
    // if (!isArrayLike(keys)) {
    //   throw new TypeError(
    //     'The loader.loadMany() function must be called with Array<key> ' +
    //     `but got: ${(keys: any)}.`
    //   );
    // }
    // Support ArrayLike by using only minimal property access
    final loadPromises = <Future<V>>[];
    for (var i = 0; i < keys.length; i++) {
      // TODO: this.load(keys[i]).catch(error => error)
      loadPromises.add(this.load(keys[i]));
    }
    return Future.wait(loadPromises);
  }

  /// Clears the value at `key` from the cache, if it exists. Returns itself for
  /// method chaining.
  DataLoader<K, V, C> clear(K key) {
    final cacheMap = this._cacheMap;
    if (cacheMap != null) {
      final cacheKey = this._cacheKeyFn(key);
      cacheMap.delete(cacheKey);
    }
    return this;
  }

  /// Clears the entire cache. To be used when some event results in unknown
  /// invalidations across this particular `DataLoader`. Returns itself for
  /// method chaining.
  DataLoader<K, V, C> clearAll() {
    final cacheMap = this._cacheMap;
    if (cacheMap != null) {
      cacheMap.clear();
    }
    return this;
  }

  /// Adds the provided key and value to the cache. If the key already
  /// exists, no change is made. Returns itself for method chaining.
  ///
  /// To prime the cache with an error at a key, provide an Error instance.
  DataLoader<K, V, C> prime(K key, V value) {
    final cacheMap = this._cacheMap;
    if (cacheMap != null) {
      final cacheKey = this._cacheKeyFn(key);

      // Only add the key if it does not already exist.
      if (cacheMap.get(cacheKey) == null) {
        // Cache a rejected promise if the value is an Error, in order to match
        // the behavior of load(key).
        final Future<V> promise;
        // if (value instanceof Error) {
        // promise = Promise.reject(value);
        // Since this is a case where an Error is intentionally being primed
        // for a given key, we want to disable unhandled promise rejection.
        // promise.catch(() => {});
        // } else {
        promise = Future.value(value);
        // }
        cacheMap.set(cacheKey, promise);
      }
    }
    return this;
  }
}

// Private: Enqueue a Job to be executed after all "PromiseJobs" Jobs.
//
// ES6 JavaScript uses the concepts Job and JobQueue to schedule work to occur
// after the current execution context has completed:
// http://www.ecma-international.org/ecma-262/6.0/#sec-jobs-and-job-queues
//
// Node.js uses the `process.nextTick` mechanism to implement the concept of a
// Job, maintaining a global FIFO JobQueue for all Jobs, which is flushed after
// the current call stack ends.
//
// When calling `then` on a Promise, it enqueues a Job on a specific
// "PromiseJobs" JobQueue which is flushed in Node as a single Job on the
// global JobQueue.
//
// DataLoader batches all loads which occur in a single frame of execution, but
// should include in the batch all loads which occur during the flushing of the
// "PromiseJobs" JobQueue after that same execution frame.
//
// In order to avoid the DataLoader dispatch Job occuring before "PromiseJobs",
// A Promise Job is created with the sole purpose of enqueuing a global Job,
// ensuring that it always occurs after "PromiseJobs" ends.
//
// Node.js's job queue is unique. Browsers do not have an equivalent mechanism
// for enqueuing a job to be performed after promise microtasks and before the
// next macrotask. For browser environments, a macrotask is used (via
// setImmediate or setTimeout) at a potential performance penalty.
// var enqueuePostPromiseJob =
//   typeof process == 'object' && typeof process.nextTick == 'function' ?
//     function (fn) {
//       if (!resolvedPromise) {
//         resolvedPromise = Promise.resolve();
//       }
//       resolvedPromise.then(() => {
//         process.nextTick(fn);
//       });
//     } :
//     setImmediate || setTimeout;

// // Private: cached resolved Promise instance
// var resolvedPromise;

// Private: Describes a batch of requests
class Batch<K, V> {
  bool hasDispatched;
  final List<K> keys;
  final List<Completer<V>> callbacks;
  List<void Function()>? cacheHits;

  Batch({
    required this.keys,
    required this.callbacks,
    this.hasDispatched = false,
    this.cacheHits,
  });
}

// Private: Either returns the current batch, or creates and schedules a
// dispatch of a new batch for the given loader.
Batch<K, V> getCurrentBatch<K extends Object, V>(
    DataLoader<K, V, Object?> loader) {
  // If there is an existing batch which has not yet dispatched and is within
  // the limit of the batch size, then return it.
  final existingBatch = loader._batch;
  if (existingBatch != null &&
      !existingBatch.hasDispatched &&
      existingBatch.keys.length < loader._maxBatchSize &&
      (existingBatch.cacheHits == null ||
          existingBatch.cacheHits!.length < loader._maxBatchSize)) {
    return existingBatch;
  }

  // Otherwise, create a new batch for this loader.
  final newBatch = Batch<K, V>(hasDispatched: false, keys: [], callbacks: []);

  // Store it on the loader so it may be reused.
  loader._batch = newBatch;

  // Then schedule a task to dispatch this batch of requests.
  loader._batchScheduleFn(() {
    dispatchBatch(loader, newBatch);
  });

  return newBatch;
}

void dispatchBatch<K extends Object, V>(
    DataLoader<K, V, Object?> loader, Batch<K, V> batch) {
  // Mark this batch as having been dispatched.
  batch.hasDispatched = true;

  // If there's nothing to load, resolve any cache hits and return early.
  if (batch.keys.length == 0) {
    resolveCacheHits(batch);
    return;
  }

  // Call the provided batchLoadFn for this loader with the batch's keys and
  // with the loader as the `this` context.
  final batchPromise = loader._batchLoadFn(batch.keys);

  // Assert the expected response from batchLoadFn
  // if (!batchPromise || typeof batchPromise.then != 'function') {
  //   return failedDispatch(loader, batch, new TypeError(
  //     'DataLoader must be constructed with a function which accepts ' +
  //     'Array<key> and returns Promise<Array<value>>, but the function did ' +
  //     `not return a Promise: ${String(batchPromise)}.`
  //   ));
  // }

  // Await the resolution of the call to batchLoadFn.
  batchPromise.then((values) {
    // Assert the expected resolution from batchLoadFn.
    // if (!isArrayLike(values)) {
    //   throw new TypeError(
    //     'DataLoader must be constructed with a function which accepts ' +
    //     'Array<key> and returns Promise<Array<value>>, but the function did ' +
    //     `not return a Promise of an Array: ${String(values)}.`
    //   );
    // }
    if (values.length != batch.keys.length) {
      throw StateError(
          'DataLoader must be constructed with a function which accepts '
          'List<key> and returns Future<List<value>>, but the function did '
          'not return a Future of an List of the same length as the List '
          'of keys.'
          '\n\nKeys:\n${batch.keys}'
          '\n\nValues:\n$values');
    }

    // Resolve all cache hits in the same micro-task as freshly loaded values.
    resolveCacheHits(batch);

    // Step through values, resolving or rejecting each Future in the batch.
    for (var i = 0; i < batch.callbacks.length; i++) {
      final value = values[i];
      // if (value instanceof Error) {
      // batch.callbacks[i].reject(value);
      // } else {
      batch.callbacks[i].complete(value);
      // }
    }
  }).catchError((Object error) {
    failedDispatch(loader, batch, error);
  });
}

// Private: do not cache individual loads if the entire batch dispatch fails,
// but still reject each request so they do not hang.
void failedDispatch<K extends Object, V>(
  DataLoader<K, V, dynamic> loader,
  Batch<K, V> batch,
  Object error,
) {
  // Cache hits are resolved, even though the batch failed.
  resolveCacheHits(batch);
  for (var i = 0; i < batch.keys.length; i++) {
    loader.clear(batch.keys[i]);
    batch.callbacks[i].completeError(error);
  }
}

// Private: Resolves the Promises for any cache hits in this batch.
void resolveCacheHits(Batch<dynamic, dynamic> batch) {
  final hits = batch.cacheHits;
  if (hits != null) {
    for (var i = 0; i < hits.length; i++) {
      hits[i]();
    }
  }
}

// Private: given the DataLoader's options, produce a valid max batch size.
int getValidMaxBatchSize(Options<dynamic, dynamic, dynamic>? options) {
  final shouldBatch = options == null || options.batch != false;
  if (!shouldBatch) {
    return 1;
  }
  final maxBatchSize = options?.maxBatchSize;
  if (maxBatchSize == null) {
    // max int dart js
    return 9007199254740991;
  }
  if (maxBatchSize < 1) {
    throw ArgumentError(
        'maxBatchSize must be a positive number: $maxBatchSize');
  }
  return maxBatchSize;
}

// Private
void Function(void Function()) getValidBatchScheduleFn(
  Options<dynamic, dynamic, dynamic>? options,
) {
  final batchScheduleFn = options?.batchScheduleFn;
  if (batchScheduleFn == null) {
    // enqueuePostPromiseJob
    return (f) => Future.delayed(Duration.zero, f);
  }
  return batchScheduleFn;
}

// Private: given the DataLoader's options, produce a CacheMap to be used.
Cache<C, FutureOr<V>>? getValidCacheMap<K, V, C>(Options<K, V, C>? options) {
  final shouldCache = options == null || options.cache != false;
  if (!shouldCache) {
    return null;
  }
  final cacheMap = options?.cacheMap;
  if (cacheMap == null) {
    return MapCache();
  }
  // if (cacheMap != null) {
  //   var cacheFunctions = [ 'get', 'set', 'delete', 'clear' ];
  //   var missingFunctions = cacheFunctions
  //     .filter(fnName => cacheMap && typeof cacheMap[fnName] != 'function');
  //   if (missingFunctions.length != 0) {
  //     throw new TypeError(
  //       'Custom cacheMap missing methods: ' + missingFunctions.join(', ')
  //     );
  //   }
  // }
  return cacheMap;
}

// Private
// bool isArrayLike(Object? x) {
//   return (
//     typeof x == 'object' &&
//     x != null &&
//     typeof x.length == 'number' &&
//     (x.length == 0 ||
//       (x.length > 0 && Object.prototype.hasOwnProperty.call(x, x.length - 1)))
//   );
// }
