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

import 'package:leto/src/extensions/persisted_queries.dart'
    show Cache, MapCache;
export 'package:leto/src/extensions/persisted_queries.dart'
    show Cache, MapCache, LruCacheSimple;

/// A Function, which when given an Array of keys, returns a Future of an Array
/// of values or Errors.
typedef BatchLoadFn<K, V> = Future<List<V>> Function(List<K> keys);

/// [DataLoader] configuration options
class DataLoaderOptions<K, V, C> {
  /// Whether to batch
  final bool? batch;

  /// The maximum size of batches
  final int? maxBatchSize;

  /// A scheduling function
  final void Function(void Function() callback)? batchScheduleFn;

  /// Whether to cache
  final bool? cache;

  /// Optional mapper between the item key [K] and the cache key [C]
  final C Function(K)? cacheKeyFn;

  /// A custom cache implementation
  final Cache<C, Future<V>>? cacheMap;

  /// [DataLoader] configuration options.
  /// Optionally turn off batching or caching or provide a cache key function
  /// or a custom cache instance.
  DataLoaderOptions({
    this.batch,
    this.maxBatchSize,
    this.batchScheduleFn,
    this.cache,
    this.cacheKeyFn,
    this.cacheMap,
  });
}

/// A `DataLoader` creates a public API for loading data from a particular
/// data back-end with unique keys such as the `id` column of a SQL table or
/// document name in a MongoDB database, given a batch loading function.
///
/// Each `DataLoader` instance contains a unique memoized cache. Use caution
/// when used in long-lived applications or those which serve many users with
/// different access permissions and consider creating a new instance per
/// web request.
class DataLoader<K extends Object, V, C> {
  /// Main [DataLoader] constructor
  /// use [DataLoader.unmapped] if the
  /// item key [K] is equal to the cache key [C]
  DataLoader(this._batchLoadFn, [DataLoaderOptions<K, V, C>? options])
      : _maxBatchSize = _getValidMaxBatchSize(options),
        _batchScheduleFn = _getValidBatchScheduleFn(options),
        _cacheKeyFn = options?.cacheKeyFn ??
            (K == C
                ? (k) => k as C
                : throw ArgumentError(
                    'Must pass options.cacheKeyFn if the'
                    ' key type K $K is different from C $C.',
                  )),
        _cacheMap = _getValidCacheMap(options);

  /// Constructs a [DataLoader] where the
  /// item key [K] is equal to the cache key
  static DataLoader<K, V, K> unmapped<K extends Object, V>(
    BatchLoadFn<K, V> _batchLoadFn, [
    DataLoaderOptions<K, V, K>? options,
  ]) =>
      DataLoader(_batchLoadFn, options);

  // Private
  final BatchLoadFn<K, V> _batchLoadFn;
  final int _maxBatchSize;
  final void Function(void Function() callback) _batchScheduleFn;
  final C Function(K) _cacheKeyFn;
  final Cache<C, FutureOr<V>>? _cacheMap;
  _Batch<K, V>? _batch;

  /// Loads a key, returning a [Future] for the value represented by that key.
  Future<V> load(K key) {
    final batch = _getCurrentBatch(this);
    final cacheMap = this._cacheMap;
    final cacheKey = this._cacheKeyFn(key);

    // If caching and there is a cache-hit, return cached Future.
    if (cacheMap != null) {
      final cachedFuture = cacheMap.get(cacheKey);
      if (cachedFuture != null) {
        final cacheHits =
            batch.cacheHits != null ? batch.cacheHits! : (batch.cacheHits = []);
        final comp = Completer<V>();
        cacheHits.add(() {
          comp.complete(cachedFuture);
        });
        return comp.future;
      }
    }

    // Otherwise, produce a new Future for this key, and enqueue it to be
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
  /// ```dart
  /// final loadedItems = await myLoader.loadMany([ 'a', 'b' ]);
  /// ```
  ///
  /// This is similar to the more verbose:
  ///
  /// ```dart
  /// final loadedItems = await Future.wait([
  ///       myLoader.load('a'),
  ///       myLoader.load('b')
  ///     ]);
  /// ```
  ///
  Future<List<V>> loadMany(List<K> keys) {
    // Support ArrayLike by using only minimal property access
    final loadFutures = <Future<V>>[];
    for (var i = 0; i < keys.length; i++) {
      // TODO: 3E this.load(keys[i]).catch(error => error)
      /// However it is different in the case where any load fails. Where
      /// Future.all() would reject, loadMany() always resolves, however each
      /// result is either a value or an Error instance.
      ///
      ///     var [ a, b, c ] = await myLoader.loadMany([ 'a', 'b', 'badkey' ]);
      ///     // c instanceof Error
      ///
      loadFutures.add(this.load(keys[i]));
    }
    return Future.wait(loadFutures);
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
  DataLoader<K, V, C> prime(K key, V value) {
    final cacheMap = this._cacheMap;
    if (cacheMap != null) {
      final cacheKey = this._cacheKeyFn(key);

      // Only add the key if it does not already exist.
      if (cacheMap.get(cacheKey) == null) {
        // Cache a rejected promise if the value is an Error, in order to match
        // the behavior of load(key).
        final Future<V> promise;
        promise = Future.value(value);
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
class _Batch<K, V> {
  bool hasDispatched;
  final List<K> keys;
  final List<Completer<V>> callbacks;
  List<void Function()>? cacheHits;

  _Batch({
    required this.keys,
    required this.callbacks,
    this.hasDispatched = false,
    this.cacheHits,
  });
}

// Private: Either returns the current batch, or creates and schedules a
// dispatch of a new batch for the given loader.
_Batch<K, V> _getCurrentBatch<K extends Object, V>(
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
  final newBatch = _Batch<K, V>(hasDispatched: false, keys: [], callbacks: []);

  // Store it on the loader so it may be reused.
  loader._batch = newBatch;

  // Then schedule a task to dispatch this batch of requests.
  loader._batchScheduleFn(() {
    dispatchBatch(loader, newBatch);
  });

  return newBatch;
}

void dispatchBatch<K extends Object, V>(
  DataLoader<K, V, Object?> loader,
  _Batch<K, V> batch,
) {
  // Mark this batch as having been dispatched.
  batch.hasDispatched = true;

  // If there's nothing to load, resolve any cache hits and return early.
  if (batch.keys.isEmpty) {
    _resolveCacheHits(batch);
    return;
  }

  // Call the provided batchLoadFn for this loader with the batch's keys and
  // with the loader as the `this` context.
  final batchFuture = loader._batchLoadFn(batch.keys);

  // Await the resolution of the call to batchLoadFn.
  batchFuture.then((values) {
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
    _resolveCacheHits(batch);

    // Step through values, resolving or rejecting each Future in the batch.
    for (var i = 0; i < batch.callbacks.length; i++) {
      final value = values[i];
      batch.callbacks[i].complete(value);
    }
  }).catchError((Object error, StackTrace stackTrace) {
    _failedDispatch(loader, batch, error, stackTrace);
  });
}

// Private: do not cache individual loads if the entire batch dispatch fails,
// but still reject each request so they do not hang.
void _failedDispatch<K extends Object, V>(
  DataLoader<K, V, dynamic> loader,
  _Batch<K, V> batch,
  Object error,
  StackTrace stackTrace,
) {
  // Cache hits are resolved, even though the batch failed.
  _resolveCacheHits(batch);
  for (var i = 0; i < batch.keys.length; i++) {
    loader.clear(batch.keys[i]);
    batch.callbacks[i].completeError(error, stackTrace);
  }
}

// Private: Resolves the Futures for any cache hits in this batch.
void _resolveCacheHits(_Batch<dynamic, dynamic> batch) {
  final hits = batch.cacheHits;
  if (hits != null) {
    for (var i = 0; i < hits.length; i++) {
      hits[i]();
    }
  }
}

// Private: given the DataLoader's options, produce a valid max batch size.
int _getValidMaxBatchSize(
    DataLoaderOptions<dynamic, dynamic, dynamic>? options) {
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
void Function(void Function()) _getValidBatchScheduleFn(
  DataLoaderOptions<dynamic, dynamic, dynamic>? options,
) {
  final batchScheduleFn = options?.batchScheduleFn;
  if (batchScheduleFn == null) {
    // enqueuePostPromiseJob
    return (f) => Future.delayed(Duration.zero, f);
  }
  return batchScheduleFn;
}

// Private: given the DataLoader's options, produce a CacheMap to be used.
Cache<C, FutureOr<V>>? _getValidCacheMap<K, V, C>(
    DataLoaderOptions<K, V, C>? options) {
  final shouldCache = options == null || options.cache != false;
  if (!shouldCache) {
    return null;
  }
  final cacheMap = options?.cacheMap;
  if (cacheMap == null) {
    return MapCache();
  }
  return cacheMap;
}
