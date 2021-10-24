import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_example/api/cache_link.dart';
import 'package:chat_example/api/ferry_client.dart';
import 'package:chat_example/api/http_auth_link.dart';
import 'package:chat_example/api/user.data.gql.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/chat_rooms/chat_rooms_store.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String getPlatform() {
  if (kIsWeb) return 'WEB';
  if (Platform.isAndroid) return 'ANDROID';
  if (Platform.isIOS) return 'IOS';
  if (Platform.isLinux) return 'LINUX';
  if (Platform.isMacOS) return 'MACOS';
  if (Platform.isWindows) return 'WINDOWS';
  if (Platform.isFuchsia) return 'FUCHSIA';
  return 'OTHER';
}

String getVersion() {
  return '0.0.1+1';
}

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

final authStorageProv = Provider<AuthStorage>((_) => throw Error());

class AuthStorage {
  final SharedPreferences sharedPreferences;

  GSTokenWithUserData? state;

  AuthStorage(this.sharedPreferences);

  GSTokenWithUserData? get() {
    final authStoreStateStr = sharedPreferences.getString('authStore');
    if (authStoreStateStr == null) {
      return null;
    }
    // ignore: join_return_with_assignment
    state = GSTokenWithUserData.fromJson(
      jsonDecode(authStoreStateStr) as Map<String, Object?>,
    );
    return state;
  }

  Future<void> set(GSTokenWithUserData? value) {
    state = value;
    if (value == null) {
      return sharedPreferences.remove('authStore');
    } else {
      final valueStr = jsonEncode(value.toJson());
      return sharedPreferences.setString('authStore', valueStr);
    }
  }
}

final _defaultHeaders = {
  'sgqlc-appversion': getVersion(),
  'sgqlc-platform': getPlatform(),
};

const _defaultFetchPolicies = {
  OperationType.query: FetchPolicy.CacheAndNetwork,
  OperationType.mutation: FetchPolicy.NetworkOnly,
  OperationType.subscription: FetchPolicy.CacheAndNetwork,
};

final _cacheHandlers = (() {
  final _list = [
    createChatRoomHandler,
    deleteChatRoomHandler,
    addChatRoomUserHandler,
    deleteChatRoomUserHandler,
  ];
  final _cacheHandlers = Map.fromEntries(
    _list.map((e) => MapEntry<String, Function>(e.name, e.rawHandler)),
  );
  assert(_list.length == _cacheHandlers.length);
  return _cacheHandlers;
})();

Future<ProviderContainer> initClient() async {
  Hive.init('hive_data');
  await Hive.initFlutter();
  final box = await Hive.openBox<Object?>('graphql');

  const url = 'http://localhost:8060/graphql';
  const wsUrl = 'ws://localhost:8060/graphql-subscription';
  final httpClient = http.Client();

  final store = HiveStore(box);
  final cache = Cache(store: store);

  final sharedPreferences = await SharedPreferences.getInstance();
  final authStorage = AuthStorage(sharedPreferences);
  final authState = authStorage.get();
  late ProviderContainer ref;

  final link = Link.from([
    CacheTypedLink(cache),
    HttpAuthLink(
      () => ref.read(authStoreProv).authToken,
      () {
        final authStore = ref.read(authStoreProv);
        return authStore.refreshAuthToken(
          url: url,
          httpClient: httpClient,
        );
      },
    ),
    HttpLink(
      url,
      httpClient: httpClient,
      useGETForQueries: true,
      serializer: const CacheRequestSerializer(),
      defaultHeaders: _defaultHeaders,
    )
  ]);

  final httpGqlClient = Client(
    link: link,
    cache: cache,
    defaultFetchPolicies: _defaultFetchPolicies,
    updateCacheHandlers: _cacheHandlers,
  );

  ref = ProviderContainer(overrides: [
    httpClientProvider.overrideWithValue(httpGqlClient),
    clientProvider.overrideWithValue(httpGqlClient),
    authStorageProv.overrideWithValue(authStorage),
  ]);
  final authStore = ref.read(authStoreProv);
  if (authState?.accessToken == null) {
    await authStore.signInAnnon();
  }
  final wsLink = WebSocketLink(
    wsUrl,
    serializer: const CacheRequestSerializer(),
    parser: const CacheResponseParser(),
    initialPayload: <String, Object?>{
      ..._defaultHeaders,
      'refreshToken': authStore.state!.refreshToken,
    },
  );
  ref.dispose();

  // ignore: join_return_with_assignment
  ref = ProviderContainer(overrides: [
    httpClientProvider.overrideWithValue(httpGqlClient),
    clientProvider.overrideWithValue(Client(
      link: Link.from([CacheTypedLink(cache), wsLink]),
      cache: cache,
      defaultFetchPolicies: _defaultFetchPolicies,
      updateCacheHandlers: _cacheHandlers,
    )),
    authStorageProv.overrideWithValue(authStorage),
  ]);

  return ref;
}

final clientProvider = Provider<Client>((_) => throw Error());
final httpClientProvider = Provider<Client>((_) => throw Error());
