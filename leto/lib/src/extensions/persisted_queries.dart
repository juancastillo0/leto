// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:collection';
import 'dart:convert' show utf8;

import 'package:crypto/crypto.dart' show sha256;
import 'package:leto/leto.dart'
    show GraphQLExtension, GraphQLResult, DocumentNode;
import 'package:leto_schema/leto_schema.dart'
    show GraphQLException, ResolveBaseCtx, ScopeRef;

/// Save network bandwidth by storing GraphQL documents on the server and
/// not requiring the client to send the full document String on each request.
///
/// More information: https://www.apollographql.com/docs/apollo-server/performance/apq/
class GraphQLPersistedQueries extends GraphQLExtension {
  /// Computes the sha256 hash of the document
  final String Function(String query) computeHash;

  /// Cache for persisted queries
  ///
  /// Provided implementations [MapCache] and [LruCacheSimple].
  final Cache<String, DocumentNode> cache;

  /// Whether to return the sha256 hash in the response extensions map
  /// for new saved documents.
  ///
  /// Helpful for the client to know whether the document was saved
  /// on the server and probably doesn't need to send the whole document
  /// String again.
  final bool returnHashInResponse;

  /// Extension for caching documents on the server side
  ///
  /// Provide a custom [computeHash] function, a [cache]
  /// (default: [LruCacheSimple] with max size 100)
  /// and configure whether you want to return the hash in the response
  GraphQLPersistedQueries({
    this.computeHash = defaultComputeHash,
    Cache<String, DocumentNode>? cache,
    this.returnHashInResponse = false,
  }) : cache = cache ?? LruCacheSimple(100);

  /// Uses package:crypto for computing the sha256 for [query]
  static String defaultComputeHash(String query) =>
      sha256.convert(utf8.encode(query)).toString();

  /// Error message sent when the hash in the incoming extension map is
  /// different from the computed locally in the server from the query
  static const PERSISTED_QUERY_HASH_MISMATCH = 'PERSISTED_QUERY_HASH_MISMATCH';

  /// Error message sent when the hash in the incoming extension
  /// isn't saved in [cache].
  static const PERSISTED_QUERY_NOT_FOUND = 'PERSISTED_QUERY_NOT_FOUND';

  @override
  String get mapKey => 'persistedQuery';

  final _extensionResponseHashRef = ScopeRef<String>('extensionResponseHash');

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ResolveBaseCtx ctx,
  ) async {
    if (!returnHashInResponse) {
      return next();
    }
    final response = await next();
    final hash = _extensionResponseHashRef.get(ctx);
    if (hash != null) {
      return response.copyWithExtension(mapKey, {'sha256Hash': hash});
    }
    return response;
  }

  @override
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    ResolveBaseCtx ctx,
  ) {
    final query = ctx.query;
    final extensions = ctx.extensions;
    // '/graphql?extensions={"persistedQuery":{"version":1,"sha256Hash":"ecf4edb46db40b5132295c0291d62fb65d6759a9eedfa4d5d612dd5ec54a6b38"}}'
    final persistedQuery = extensions == null ? null : extensions[mapKey];

    String? sha256Hash;
    if (persistedQuery is Map<String, Object?>) {
      final version = persistedQuery['version'];

      if (version == 1 && persistedQuery['sha256Hash'] is String) {
        sha256Hash = persistedQuery['sha256Hash']! as String;
        final doc = cache.get(sha256Hash);
        if (doc != null) {
          if (query != sha256Hash &&
              query.isNotEmpty &&
              sha256Hash != computeHash(query)) {
            throw GraphQLException.fromMessage(PERSISTED_QUERY_HASH_MISMATCH);
          }
          return doc;
        }
        if (query.isEmpty) {
          throw GraphQLException.fromMessage(PERSISTED_QUERY_NOT_FOUND);
        }
      }
    }

    DocumentNode? document = cache.get(query);
    if (document == null) {
      final digestHex = computeHash(query);
      if (sha256Hash != null && digestHex != sha256Hash) {
        throw GraphQLException.fromMessage(PERSISTED_QUERY_HASH_MISMATCH);
      }
      final doc = cache.get(digestHex);
      if (doc != null) {
        document = doc;
      } else {
        document = next();
        cache.set(digestHex, document);
      }
      if (returnHashInResponse && persistedQuery is Map<String, Object?>) {
        _extensionResponseHashRef.setScoped(ctx, digestHex);
      }
    }

    return document;
  }
}

/// Cache abstraction
///
/// Provided implementations [LruCacheSimple] and [MapCache].
abstract class Cache<K, T> {
  // TODO: FutureOr

  /// Returns the cached value for the [key], may be null
  /// if it isn't in the cache
  T? get(K key);

  /// Sets the [value] in the cache for the [key].
  /// May delete other values from the cache, depending on the implementation
  void set(K key, T value);

  /// Removes the value in the cache for the [key].
  void delete(K key);

  /// Clears all values from the cache
  void clear();
}

/// Simple map cache using an in memory Map for its storage
///
/// No size limit, might want to use something like [LruCacheSimple]
/// if you don't have full control over whats saved.
class MapCache<K, V> implements Cache<K, V> {
  /// Inner map for saving the cached values
  final Map<K, V> stash = {};

  @override
  V? get(K key) => stash[key];

  @override
  void set(K key, V value) => stash[key] = value;

  @override
  void delete(K key) => stash.remove(key);

  @override
  void clear() => stash.clear();
}

/// Least Recently Used (LRU) cache implementation.
///
/// Implemented with the usual linked list with map.
class LruCacheSimple<K, T> implements Cache<K, T> {
  /// The maximum number of elements in the cache.
  final int maxSize;

  /// Map from keys to [linkedList] entries
  final Map<K, DoubleLinkedQueueEntry<MapEntry<K, T>>> map = {};

  /// Linked list with the cached values, ordered from
  /// most recently used to least recently used
  final linkedList = DoubleLinkedQueue<MapEntry<K, T>>();

  /// Empty LruCache with a maximum size of [maxSize]
  LruCacheSimple(this.maxSize) : assert(maxSize > 0);

  /// Creates a [LruCacheSimple] from a [map].
  /// If [map] contains more than [maxSize] elements, some elements will not
  /// be saved
  factory LruCacheSimple.fromMap(int maxSize, Map<K, T> map) {
    final cache = LruCacheSimple<K, T>(maxSize);

    for (final e in map.entries.take(maxSize)) {
      cache.addFirst(e.key, e.value);
    }

    return cache;
  }

  @override
  T? get(K key) {
    final entry = map[key];
    if (entry == null) {
      return null;
    }
    final kv = entry.element;
    if (entry.previousEntry() != null) {
      // move it to the first position in the list (most recently used)
      entry.remove();
      addFirst(key, kv.value);
    }
    return kv.value;
  }

  @override
  void set(K key, T value) {
    final entry = map[key];
    if (entry != null) {
      if (entry.previousEntry() == null) {
        // is the first in the list (most recently used), just update the value
        entry.element = MapEntry(key, value);
        return;
      }
      entry.remove();
    } else if (map.length == maxSize) {
      // cache is full, remove least recently used
      final last = linkedList.removeLast();
      map.remove(last.key);
    }
    addFirst(key, value);
  }

  /// Adds a value into the first position of the queue (most recently used)
  void addFirst(K key, T value) {
    linkedList.addFirst(MapEntry(key, value));
    map[key] = linkedList.firstEntry()!;
  }

  @override
  void clear() {
    map.clear();
    linkedList.clear();
  }

  @override
  void delete(K key) {
    final value = map.remove(key);
    if (value != null) {
      value.remove();
    }
  }
}
