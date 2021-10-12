// ignore_for_file: constant_identifier_names

import 'dart:collection';
import 'dart:convert' show utf8;

import 'package:crypto/crypto.dart' show sha256;
import 'package:gql/ast.dart' show DocumentNode;
import 'package:graphql_schema/graphql_schema.dart' show GraphQLException, ScopedMap;
import 'package:graphql_server/graphql_server.dart';
import 'package:graphql_server/src/extension.dart' show GraphQLExtension;

/// https://www.apollographql.com/docs/apollo-server/performance/apq/
class GraphQLPersistedQueries extends GraphQLExtension {
  final String Function(String query) computeHash;
  final Cache<String, DocumentNode> persistedQueries;

  GraphQLPersistedQueries({
    this.computeHash = defaultComputeHash,
    Cache<String, DocumentNode>? persistedQueries,
  }) : persistedQueries = persistedQueries ?? LruCacheSimple(100);

  static String defaultComputeHash(String query) =>
      sha256.convert(utf8.encode(query)).toString();

  static const PERSISTED_QUERY_HASH_MISMATCH = 'PERSISTED_QUERY_HASH_MISMATCH';
  static const PERSISTED_QUERY_NOT_FOUND = 'PERSISTED_QUERY_NOT_FOUND';

  @override
  String get mapKey => 'persistedQuery';

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
        final doc = persistedQueries.get(sha256Hash);
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

    DocumentNode? document = persistedQueries.get(query);
    if (document == null) {
      final digestHex = computeHash(query);
      if (sha256Hash != null && digestHex != sha256Hash) {
        throw GraphQLException.fromMessage(PERSISTED_QUERY_HASH_MISMATCH);
      }
      final doc = persistedQueries.get(digestHex);
      if (doc != null) {
        document = doc;
      } else {
        document = next();
        persistedQueries.set(digestHex, document);
      }
    }

    return document;
  }
}

abstract class Cache<K, T> {
  // TODO: FutureOr
  T? get(K key);
  void set(K key, T value);
  void delete(K key);
  void clear();
}

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
