import 'dart:async';
import 'dart:convert';

import 'package:chat_example/api/ferry_client.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '__generated__/user.data.gql.dart';

Future<PersistenceStore> initPersistence() async {
  Hive.init('hive_data');
  await Hive.initFlutter();
  final box = await Hive.openBox<Object?>('graphql');

  final store = HiveStore(box);
  final cache = Cache(store: store);

  final sharedPreferences = await SharedPreferences.getInstance();
  final authStorage = AuthStorage(sharedPreferences);

  return PersistenceStore(
    authStorage: authStorage,
    cache: cache,
  );
}

class PersistenceStore {
  final Cache cache;
  final AuthStorage authStorage;

  PersistenceStore({
    required this.cache,
    required this.authStorage,
  });
}

final authStorageProv = Provider<AuthStorage>((_) => throw Error());

class AuthStorage {
  final SharedPreferences sharedPreferences;

  AuthStorage(this.sharedPreferences);

  String getDeviceId() {
    String? deviceId = sharedPreferences.getString('deviceId');
    if (deviceId == null) {
      deviceId = base64UrlEncode(uuid.v4obj().toBytes()).replaceAll('=', '');
      sharedPreferences.setString('deviceId', deviceId);
    }
    return deviceId;
  }

  GSTokenWithUserData? get() {
    final authStoreStateStr = sharedPreferences.getString('authStore');
    if (authStoreStateStr == null) {
      return null;
    }
    return GSTokenWithUserData.fromJson(
      jsonDecode(authStoreStateStr) as Map<String, Object?>,
    );
  }

  Future<void> set(GSTokenWithUserData? value) {
    if (value == null) {
      return sharedPreferences.remove('authStore');
    } else {
      final valueStr = jsonEncode(value.toJson());
      return sharedPreferences.setString('authStore', valueStr);
    }
  }
}
