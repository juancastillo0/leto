import 'dart:async';
import 'dart:io';

import 'package:chat_example/api/cache_link.dart';
import 'package:chat_example/api/http_auth_link.dart';
import 'package:chat_example/api/persistence.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/chat_rooms/chat_rooms_store.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

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

final clientProvider = Provider<Client>((_) => throw Error());
final httpClientProvider = Provider<Client>((_) => throw Error());

class RootStore {
  final ProviderContainer container;
  final Future<void> Function() dispose;

  RootStore({
    required this.container,
    required this.dispose,
  });
}

Future<RootStore> initClient(PersistenceStore persistence) async {
  final cache = persistence.cache;
  const url = 'http://localhost:8060/graphql';
  const wsUrl = 'ws://localhost:8060/graphql-subscription';
  final httpClient = http.Client();
  late ProviderContainer ref;

  final cacheLink = CacheTypedLink(cache);

  final link = Link.from([
    cacheLink,
    HttpAuthLink(
      () => ref.read(authStoreProv.notifier).authToken,
      () {
        final authStore = ref.read(authStoreProv.notifier);
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
      defaultHeaders: _defaultHeaders(persistence.authStorage.getDeviceId()),
    )
  ]);

  final httpGqlClient = Client(
    link: link,
    cache: cache,
    defaultFetchPolicies: _defaultFetchPolicies,
    updateCacheHandlers: _cacheHandlers,
  );

  ref = ProviderContainer(
    overrides: [
      httpClientProvider.overrideWithValue(httpGqlClient),
      clientProvider.overrideWithValue(httpGqlClient),
      authStorageProv.overrideWithValue(persistence.authStorage),
    ],
  );
  final authStore = ref.read(authStoreProv.notifier);
  if (authStore.user != null) {
    await authStore.refreshAuthToken(url: url, httpClient: httpClient);
  }
  if (authStore.user == null) {
    await authStore.signInAnnon();
  }
  final wsLink = WebSocketLink(
    wsUrl,
    serializer: const CacheRequestSerializer(),
    initialPayload: <String, Object?>{
      ..._defaultHeaders(persistence.authStorage.getDeviceId()),
      'refreshToken': authStore.state!.refreshToken,
    },
  );
  ref.dispose();

  final wsClient = Client(
    link: Link.from([cacheLink, wsLink]),
    cache: cache,
    defaultFetchPolicies: _defaultFetchPolicies,
    updateCacheHandlers: _cacheHandlers,
  );

  ref = ProviderContainer(
    overrides: [
      httpClientProvider.overrideWithValue(httpGqlClient),
      clientProvider.overrideWithValue(wsClient),
      authStorageProv.overrideWithValue(persistence.authStorage),
    ],
  );

  return RootStore(
    container: ref,
    dispose: () async {
      await wsClient.dispose();
      await httpGqlClient.dispose();
    },
  );
}

Map<String, String> _defaultHeaders(String deviceId) {
  return {
    'sgqlc-appversion': getVersion(),
    'sgqlc-platform': getPlatform(),
    'sgqlc-deviceid': deviceId,
  };
}

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
