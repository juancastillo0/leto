import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' show sha256, sha1;
import 'package:ferry/ferry.dart';
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
    return Response(
      errors: (body['errors'] as List?)
          ?.map((dynamic error) => parseError(
                error as Map<String, dynamic>,
              ))
          .toList(),
      data: body['data'] as Map<String, dynamic>?,
      context: const Context().withEntry(
        ResponseExtensions(
          body['extensions'],
        ),
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

class CacheTypedLink extends TypedLink {
  final Cache cache;
  final Set<String> savedPersistedQueries = {};
  final Map<Operation, MapEntry<String, String>> savedOpResponseHash = {};

  CacheTypedLink(this.cache);

  Request transformRequest(
    Request request, {
    required String? cachedHash,
    required String documentHash,
    required bool isSaved,
  }) {
    return request.updateContextEntry<RequestExtensionsThunk>(
      (thunk) => RequestExtensionsThunk(
        (request) {
          final prev =
              thunk?.getRequestExtensions(request) as Map<String, Object?>?;

          return <String, Object?>{
            if (prev != null) ...prev,
            'cacheResponse': {
              'hash': cachedHash ?? '',
            },
            'persistedQuery': {
              'version': 1,
              'sha256Hash': documentHash,
              'isSaved': isSaved,
            }
          };
        },
      ),
    );
  }

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

  @override
  Stream<OperationResponse<TData, TVars>> request<TData, TVars>(
    OperationRequest<TData, TVars> request, [
    NextTypedLink<TData, TVars>? forward,
  ]) {
    final value = cache.readQuery(request);
    String? cachedDataHash = getHashFromData(value);
    final documentStr = gql.printNode(request.operation.document);
    final documentHash = sha256.convert(utf8.encode(documentStr)).toString();

    final prevResponse = savedOpResponseHash[request.operation];
    if (prevResponse != null) {
      if (cachedDataHash == prevResponse.key) {
        cachedDataHash = prevResponse.value;
      }
    }

    final newRequest = (request as dynamic).rebuild(
      (dynamic b) => b
        ..execRequest = transformRequest(
          request.execRequest,
          cachedHash: cachedDataHash,
          documentHash: documentHash,
          isSaved: savedPersistedQueries.contains(documentHash),
        ),
    ) as OperationRequest<TData, TVars>;

    return forward!(newRequest).transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final extensions = data.extensions as Map<String, Object?>?;
          if (data.dataSource != DataSource.Link || extensions == null) {
            return sink.add(data);
          }

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
              savedOpResponseHash[request.operation] =
                  MapEntry(cachedDataHash ?? '', incomingHash);
              if (incomingHash == cachedDataHash) {
                return sink.add(
                  OperationResponse(
                    operationRequest: request,
                    data: value,
                    dataSource: DataSource.Link,
                    extensions: extensions,
                    graphqlErrors: data.graphqlErrors,
                    linkException: data.linkException,
                  ),
                );
              }
            }
          }
          sink.add(data);
        },
      ),
    );
  }
}
