// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:collection';
import 'dart:convert' show utf8;

import 'package:crypto/crypto.dart' show sha256;
import 'package:graphql_schema/graphql_schema.dart'
    show ScopeRef, GraphQLException, ScopedMap;
import 'package:graphql_server/graphql_server.dart'
    show GraphQLExtension, GraphQLResult, DocumentNode;

/// Save network bandwith by storing GraphQL documents on the server and
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

  GraphQLPersistedQueries({
    this.computeHash = defaultComputeHash,
    Cache<String, DocumentNode>? cache,
    this.returnHashInResponse = false,
  }) : cache = cache ?? LruCacheSimple(100);

  static String defaultComputeHash(String query) =>
      sha256.convert(utf8.encode(query)).toString();

  static const PERSISTED_QUERY_HASH_MISMATCH = 'PERSISTED_QUERY_HASH_MISMATCH';
  static const PERSISTED_QUERY_NOT_FOUND = 'PERSISTED_QUERY_NOT_FOUND';

  @override
  String get mapKey => 'persistedQuery';

  final _extensionResponseHashRef = ScopeRef<String>('extensionResponseHash');

  @override
  FutureOr<GraphQLResult> executeRequest(
    FutureOr<GraphQLResult> Function() next,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) async {
    if (!returnHashInResponse) {
      return next();
    }
    final response = await next();
    final hash = _extensionResponseHashRef.get(globals);
    if (hash != null) {
      return response.copyWithExtension(mapKey, {'sha256Hash': hash});
    }
    return response;
  }

  @override
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
    ScopedMap globals,
    Map<String, Object?>? extensions,
  ) {
    // '/graphql?extensions={"persistedQuery":{"version":1,"sha256Hash":"ecf4edb46db40b5132295c0291d62fb65d6759a9eedfa4d5d612dd5ec54a6b38"}}'
    final persistedQuery = extensions == null ? null : extensions[mapKey];

    String? sha256Hash;
    if (persistedQuery is Map<String, Object?>) {
      final _version = persistedQuery['version'];
      final version = _version is int
          ? _version
          : _version is String
              ? int.tryParse(_version)
              : null;

      if (version == 1) {
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
        _extensionResponseHashRef.setScoped(globals, digestHex);
      }
    }

    return document;
  }
}

/// Cache abstraction
///
/// Provided imeplementations [LruCacheSimple] and [MapCache].
abstract class Cache<K, T> {
  // TODO: FutureOr
  T? get(K key);
  void set(K key, T value);
  void delete(K key);
  void clear();
}

/// Simple map cache using an in memory Map for its storage
///
/// No size limit, might want to use something like [LruCacheSimple]
/// if you don't have full control over whats saved.
class MapCache<K, V> implements Cache<K, V> {
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
/// [size] is the maximum number of elements in the cache.
class LruCacheSimple<K, T> implements Cache<K, T> {
  final int size;

  final Map<K, DoubleLinkedQueueEntry<MapEntry<K, T>>> map = {};
  final linkedList = DoubleLinkedQueue<MapEntry<K, T>>();

  LruCacheSimple(this.size) : assert(size > 0);

  factory LruCacheSimple.fromMap(int size, Map<K, T> map) {
    final cache = LruCacheSimple<K, T>(size);

    for (final e in map.entries.take(size)) {
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
    } else if (map.length == size) {
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
