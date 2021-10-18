import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_example/api/auth_store.dart';
import 'package:chat_example/api/http_auth_link.dart';
import 'package:chat_example/api/user.data.gql.dart';
import 'package:chat_example/chats.dart';
import 'package:flutter/foundation.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getPlatform() {
  if (kIsWeb) return 'WEB';
  if (Platform.isAndroid) return 'ANDROID';
  if (Platform.isIOS) return 'IOS';
  if (Platform.isLinux) return 'LINUX';
  if (Platform.isMacOS) return 'MACOS';
  if (Platform.isWindows) return 'WINDOWS';
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

  Future<GSTokenWithUserData?> get() async {
    final authStoreStateStr = await sharedPreferences.getString('authStore');
    if (authStoreStateStr == null) {
      return null;
    }
    state = GSTokenWithUserData.fromJson(
      jsonDecode(authStoreStateStr) as Map<String, Object?>,
    );
    return state;
  }

  Future<void> set(GSTokenWithUserData value) {
    state = value;
    final valueStr = jsonEncode(value.toJson());
    return sharedPreferences.setString('authStore', valueStr);
  }
}

Future<ProviderContainer> initClient() async {
  Hive.init('hive_data');
  await Hive.initFlutter();
  final box = await Hive.openBox<Object?>('graphql');

  final url = 'http://localhost:8060/graphql';
  final httpClient = http.Client();

  final store = HiveStore(box);
  final cache = Cache(store: store);

  final sharedPreferences = await SharedPreferences.getInstance();
  final authStorage = AuthStorage(sharedPreferences);
  final authState = await authStorage.get();
  late final ProviderContainer ref;

  final link = Link.from([
    HttpAuthLink(
      () => ref.read(authStoreProv).authToken, // authState?.accessToken,
      () {
        return ref.read(authStoreProv).refreshAuthToken(
              url: url,
              httpClient: httpClient,
            );
      },
    ),
    HttpLink(
      url,
      httpClient: httpClient,
      useGETForQueries: true,
      defaultHeaders: {
        'sgqlc-appversion': getVersion(),
        'sgqlc-platform': getPlatform(),
      },
    )
  ]);
  final wsLink = WebSocketLink(
    'ws://localhost:8060/graphql-subscription',
  );

  final _list = [createChatRoomHandler];
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

  ref = ProviderContainer(overrides: [
    clientProvider.overrideWithValue(client),
    authStorageProv.overrideWithValue(authStorage),
  ]);
  if (authState?.accessToken == null) {
    await ref.read(authStoreProv).signInAnnon();
  }

  return ref;
}

/// Created in main.dart
final clientProvider = Provider<Client>((_) => throw Error());
