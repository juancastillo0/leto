import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_example/chats.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart' as gql_link;
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PesistedQueriesTypedLink extends TypedLink {
  @override
  Stream<OperationResponse<TData, TVars>> request<TData, TVars>(
    OperationRequest<TData, TVars> request, [
    NextTypedLink<TData, TVars>? forward,
  ]) {
    return forward!(request).transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final graphqlErrors = data.graphqlErrors;
          if (graphqlErrors != null &&
              graphqlErrors.any((e) => e.message == 'REFRESH_JWT')) {
            // TODO:
            // sink.add(
            //   OperationResponse(
            //     operationRequest: request,
            //     linkException:
            //         error is LinkException ? error : TypedLinkException(error),
            //     dataSource: DataSource.None,
            //   ),
            // );
          } else {
            sink.add(data);
          }
        },
      ),
    );
  }
}

Future<Client> initClient() async {
  Hive.init('hive_data');

  await Hive.initFlutter();

  final box = await Hive.openBox<Object?>('graphql');

  final url = 'http://localhost:8060/graphql';

  final durableToken = '';

  final httpClient = http.Client();

  Future<String?> refreshAuthToken({required String durableToken}) async {
    try {
      final response = await httpClient.post(
        Uri.parse(url),
        body: {'query': r'mutation { refreshAuthToken }'},
        headers: {HttpHeaders.authorizationHeader: durableToken},
      );
      if (response.statusCode == 200) {
        final bodyMap = jsonDecode(response.body) as Map<String, Object?>;
        final data = bodyMap['data'];
        if (bodyMap['errors'] != null && data is Map<String, Object?>) {
          return data['refreshAuthToken'] as String?;
        }
      }
    } catch (e) {
      return null;
    }
  }

  final store = HiveStore(box);
  final cache = Cache(store: store);

  final link = HttpLink(url, httpClient: httpClient);
  // final link = WebSocketLink('ws://localhost:8060/graphql-subscription');

  final _list = [createReviewHandler];
  final _cacheHandlers = Map.fromEntries(
    _list.map((e) => MapEntry(e.name, e.handler)),
  );
  assert(_list.length == _cacheHandlers.length);

  final client = Client(
    link: link,
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheAndNetwork,
      OperationType.mutation: FetchPolicy.NetworkOnly,
      OperationType.subscription: FetchPolicy.CacheAndNetwork,
    },
    updateCacheHandlers: _cacheHandlers,
  );

  return client;
}

/// Created in main.dart
final clientProvider = Provider<Client>((_) => throw Error());
