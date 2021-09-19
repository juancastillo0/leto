// ignore_for_file: constant_identifier_names

import 'dart:convert' show utf8;

import 'package:crypto/crypto.dart' show sha256;
import 'package:gql/ast.dart' show DocumentNode;
import 'package:graphql_schema/graphql_schema.dart' show GraphQLException;
import 'package:graphql_server/src/extension.dart' show GraphQLExtension;

/// https://www.apollographql.com/docs/apollo-server/performance/apq/
class GraphQLPersistedQueries extends GraphQLExtension {
  final String Function(String query) computeHash;

  GraphQLPersistedQueries({
    this.computeHash = defaultComputeHash,
  });

  static String defaultComputeHash(String query) =>
      sha256.convert(utf8.encode(query)).toString();

  static const PERSISTED_QUERY_HASH_MISMATCH = 'PERSISTED_QUERY_HASH_MISMATCH';
  static const PERSISTED_QUERY_NOT_FOUND = 'PERSISTED_QUERY_NOT_FOUND';

  @override
  String get mapKey => 'persistedQuery';

  // TODO: LRU cache
  final Map<String, DocumentNode> persistedQueries = {};

  @override
  DocumentNode getDocumentNode(
    DocumentNode Function() next,
    String query,
    Map<Object, Object?> globals,
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
        if (persistedQueries.containsKey(sha256Hash)) {
          if (query != sha256Hash &&
              query.isNotEmpty &&
              sha256Hash != computeHash(query)) {
            throw GraphQLException.fromMessage(PERSISTED_QUERY_HASH_MISMATCH);
          }
          return persistedQueries[sha256Hash]!;
        }
        if (query.isEmpty) {
          throw GraphQLException.fromMessage(PERSISTED_QUERY_NOT_FOUND);
        }
      }
    }

    late final DocumentNode document;
    if (persistedQueries.containsKey(query)) {
      document = persistedQueries[query]!;
    } else {
      final digestHex = computeHash(query);
      if (sha256Hash != null && digestHex != sha256Hash) {
        throw GraphQLException.fromMessage(PERSISTED_QUERY_HASH_MISMATCH);
      }
      if (persistedQueries.containsKey(digestHex)) {
        document = persistedQueries[digestHex]!;
      } else {
        document = next();
        persistedQueries[digestHex] = document;
      }
    }

    return document;
  }
}
