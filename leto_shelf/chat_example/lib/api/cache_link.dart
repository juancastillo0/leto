import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' show sha256, sha1;
import 'package:ferry/ferry.dart';
import 'package:normalize/normalize.dart';
import 'package:gql/language.dart' as gql;
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';

class CacheResponseParser extends ResponseParser {
  const CacheResponseParser();

  /// Parses the response body
  ///
  /// Extend this to add non-standard behavior
  @override
  Response parseResponse(Map<String, dynamic> body) {
    final extensions = body['extensions'] as Map<String, Object?>?;
    var data = body['data'] as Map<String, dynamic>?;
    if (data == null &&
        extensions != null &&
        extensions.containsKey('cacheResponse')) {
      // TODO: this is no longer necessary
      data = <String, dynamic>{};
    }
    return Response(
      errors: (body['errors'] as List?)
          ?.map((dynamic error) => parseError(
                error as Map<String, dynamic>,
              ))
          .toList(),
      data: data,
      context: const Context().withEntry(
        ResponseExtensions(extensions),
      ),
    );
  }
}

class CacheRequestSerializer implements RequestSerializer {
  const CacheRequestSerializer();

  /// Serializes the request
  ///
  /// Extend this to add non-standard behavior
  @override
  Map<String, dynamic> serializeRequest(Request request) {
    final RequestExtensionsThunk? thunk = request.context.entry();
    final Object? extensions = thunk?.getRequestExtensions(request);
    bool isSaved = false;
    Map<String, Object?>? extensionsMap;
    if (extensions is Map<String, Object?>) {
      final Object? persistedQuery = extensions['persistedQuery'];
      if (persistedQuery is Map<String, Object?> &&
          persistedQuery['isSaved'] == true) {
        isSaved = true;
        extensionsMap = {
          ...extensions,
          'persistedQuery': Map.fromEntries(
            persistedQuery.entries.where((e) => e.key != 'isSaved'),
          )
        };
      }
    }

    return <String, dynamic>{
      'operationName': request.operation.operationName,
      'variables': request.variables,
      'query': isSaved ? '' : gql.printNode(request.operation.document),
      if (thunk != null) 'extensions': extensionsMap ?? extensions,
    };
  }
}

class CacheTypedLink extends Link {
  final Cache cache;
  final Set<String> savedPersistedQueries = {};
  final Map<Operation, MapEntry<String, String>> savedOpResponseHash = {};

  CacheTypedLink(this.cache);

  Request transformRequest(
    Request request, {
    required String? dataHash,
    required String documentHash,
  }) {
    return request.updateContextEntry<RequestExtensionsThunk>(
      (thunk) => RequestExtensionsThunk(
        (request) {
          final prev =
              thunk?.getRequestExtensions(request) as Map<String, Object?>?;

          return <String, Object?>{
            if (prev != null) ...prev,
            'cacheResponse': {
              'hash': dataHash ?? '',
            },
            'persistedQuery': {
              'version': 1,
              'sha256Hash': documentHash,
              'isSaved': savedPersistedQueries.contains(documentHash),
            }
          };
        },
      ),
    );
  }

  @override
  Stream<Response> request(
    Request request, [
    Stream<Response> Function(Request)? forward,
  ]) {
    final json = denormalizeOperation(
      // TODO: optimistic ? optimisticReader :
      read: (dataId) => cache.store.get(dataId),
      document: request.operation.document,
      addTypename: cache.addTypename,
      operationName: request.operation.operationName,
      variables: request.variables,
      typePolicies: cache.typePolicies,
      dataIdFromObject: cache.dataIdFromObject,
    );
    final hashes = makeRequestHashes(json, request.operation);
    final _request = transformRequest(
      request,
      dataHash: hashes.dataHash,
      documentHash: hashes.documentHash,
    );

    // TODO: handle PERSISTED_QUERY_NOT_FOUND
    return forward!(_request).map((event) {
      final Object? extensions =
          event.context.entry<ResponseExtensions>()?.extensions;
      if (extensions is Map<String, Object?>) {
        final isSame = _processExtensions(
          request.operation,
          extensions,
          cachedDataHash: hashes.dataHash,
          documentHash: hashes.documentHash,
        );
        if (isSame) {
          return Response(
            context: event.context,
            data: json,
            errors: event.errors,
          );
        }
      }
      return event;
    });
  }

  // @override
  // Stream<OperationResponse<TData, TVars>> request<TData, TVars>(
  //   OperationRequest<TData, TVars> request, [
  //   NextTypedLink<TData, TVars>? forward,
  // ]) {
  //   final value = cache.readQuery(request);

  //   final hashes = makeRequestHash(value, request.operation);

  //   final newRequest = (request as dynamic).rebuild(
  //     (dynamic b) => b
  //       ..execRequest = transformRequest(request.execRequest,
  //           dataHash: hashes.dataHash, documentHash: hashes.documentHash),
  //   ) as OperationRequest<TData, TVars>;

  //   return forward!(newRequest).transform(
  //     StreamTransformer.fromHandlers(
  //       handleData: (data, sink) {
  //         final extensions = data.extensions as Map<String, Object?>?;
  //         if (data.dataSource != DataSource.Link || extensions == null) {
  //           return sink.add(data);
  //         }

  //         final isSame = _processExtensions(
  //           request.operation,
  //           extensions,
  //           cachedDataHash: hashes.dataHash,
  //           documentHash: hashes.documentHash,
  //         );
  //         if (isSame) {
  //           return sink.add(
  //             OperationResponse(
  //               operationRequest: request,
  //               data: value,
  //               dataSource: DataSource.Link,
  //               extensions: extensions,
  //               graphqlErrors: data.graphqlErrors,
  //               linkException: data.linkException,
  //             ),
  //           );
  //         } else {
  //           sink.add(data);
  //         }
  //       },
  //     ),
  //   );
  // }

  String? getHashFromData(Object? value) {
    String? cachedHash;
    if (value != null) {
      try {
        final jsonString = jsonEncode(value);
        cachedHash = sha1.convert(utf8.encode(jsonString)).toString();
      } catch (_) {}
    }
    return cachedHash;
  }

  RequestHashes makeRequestHashes(Object? data, Operation operation) {
    String? cachedDataHash = getHashFromData(data);
    final documentStr = gql.printNode(operation.document);
    final documentHash = sha256.convert(utf8.encode(documentStr)).toString();

    // if (cachedDataHash != null) {
    //   hashToData[cachedDataHash] = data!;
    // }

    final prevResponse = savedOpResponseHash[operation];
    if (prevResponse != null) {
      if (cachedDataHash == prevResponse.key) {
        cachedDataHash = prevResponse.value;
      }
    }
    return RequestHashes(
      documentHash: documentHash,
      dataHash: cachedDataHash,
    );
  }

  bool _processExtensions(
    Operation operation,
    Map<String, Object?> extensions, {
    required String? cachedDataHash,
    required String documentHash,
  }) {
    final persistedQuery = extensions['persistedQuery'];
    if (persistedQuery is Map<String, Object?>) {
      final incomingDocHash = persistedQuery['sha256Hash'];
      if (documentHash == incomingDocHash) {
        savedPersistedQueries.add(documentHash);
      }
    }
    final cacheResponse = extensions['cacheResponse'];
    if (cacheResponse is Map<String, Object?>) {
      final incomingHash = cacheResponse['hash'];
      if (incomingHash is String) {
        savedOpResponseHash[operation] =
            MapEntry(cachedDataHash ?? '', incomingHash);
        return incomingHash == cachedDataHash;
      }
    }
    return false;
  }
}

class RequestHashes {
  final String documentHash;
  final String? dataHash;

  const RequestHashes({
    required this.documentHash,
    this.dataHash,
  });
}
