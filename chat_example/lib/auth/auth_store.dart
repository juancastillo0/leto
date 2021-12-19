import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/persistence.dart';
import 'package:chat_example/api/user.data.gql.dart';
import 'package:chat_example/api/user.req.gql.dart';
import 'package:chat_example/api/user.var.gql.dart';
import 'package:chat_example/api_schema.schema.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// part 'auth_state.freezed.dart';

// @freezed
// class AuthState {
//   const factory AuthState({
//     required String durableToken,
//     required String refreshToken,
//     required String sessionId,
//     required int userId,
//     required String name,
//   }) = _AuthState;

//   factory AuthState.fromJson(Map<String, Object?> json) =>
//       _$AuthStateFromJson(json);
// }

final authStoreProv =
    StateNotifierProvider<AuthStore, GSTokenWithUserData?>((ref) {
  final savedState = ref.read(authStorageProv).get();
  return AuthStore(
    ref.read,
    savedState,
  );
});

final userIdProvider = Provider((ref) => ref.watch(authStoreProv)?.user.id);

class AuthStore extends StateNotifier<GSTokenWithUserData?> {
  final T Function<T>(ProviderBase<T> provider) _read;
  AuthStore(this._read, [GSTokenWithUserData? state]) : super(state) {
    addListener((state) {
      print('AuthStore state $state');
      _read(authStorageProv).set(state);
      if (state == null) {
        _read(clientProvider).cache.clear();
      }
    });
  }

  final _errorController = StreamController<String>.broadcast();
  Stream<String> get errorStream => _errorController.stream;

  bool get isLoggedIn => state != null;
  bool get isAnonymous => state?.user.name == null;
  GSTokenWithUser_user? get user => state?.user;
  String? get authToken => state?.accessToken;

  Client get _client => _read(clientProvider);

  Completer<String?>? _refreshAuthTokenComp;

  Future<String?> refreshAuthToken({
    required String url,
    required http.Client httpClient,
  }) async {
    if (_refreshAuthTokenComp != null) {
      return _refreshAuthTokenComp!.future;
    }
    _refreshAuthTokenComp = Completer();

    final refreshToken = state?.refreshToken;
    if (refreshToken == null) {
      return null;
    }
    String? authToken;
    bool success = false;
    try {
      final response = await httpClient.post(
        Uri.parse(url),
        body: jsonEncode({'query': 'mutation { refreshAuthToken }'}),
        headers: {
          HttpHeaders.authorizationHeader: refreshToken,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final bodyMap = jsonDecode(response.body) as Map<String, Object?>;
        final data = bodyMap['data'];
        if (bodyMap['errors'] == null && data is Map<String, Object?>) {
          authToken = data['refreshAuthToken'] as String?;
          success = true;
        }
      }
    } catch (e) {}
    if (authToken != null) {
      state = state!.rebuild((p0) => p0..accessToken = authToken);
    } else if (success) {
      state = null;
    }
    _refreshAuthTokenComp!.complete(authToken);
    _refreshAuthTokenComp = null;
    return authToken;
  }

  // StreamSubscription? _refreshAuthTokenSub;
  // void refreshAuthToken() {
  //   final refreshToken = state?.refreshToken;
  //   if (refreshToken == null) {
  //     return;
  //   }
  //   _refreshAuthTokenSub ??= _read(clientProvider)
  //       .request(GrefreshAuthTokenReq(
  //     (b) => b.vars..refreshToken = refreshToken,
  //   ))
  //       .listen(
  //     (event) {
  //       if (event.hasErrors) {
  //         _processCustomError(event);
  //         return;
  //       }

  //       final data = event.data!.signIn;
  //       if (data is GsignInData_signIn__asErrCSignInError) {
  //         switch (data.value) {
  //           case GSignInError.alreadySignedIn:
  //             alreadySignedError(data.message);
  //             break;

  //           case GSignInError.unknown:
  //             unknownError(data.message);
  //             break;

  //           case GSignInError.wrong:
  //             wrongNameOrPasswordError(data.message);
  //             break;
  //         }
  //       } else if (data is GsignInData_signIn__asTokenWithUser) {
  //         state = data;
  //       }
  //       _signInSub!.cancel();
  //     },
  //     onDone: () async {
  //       await _signInSub!.cancel();
  //       _signInSub = null;
  //     },
  //   );
  // }

  Future<void> signInAnnon() {
    final comp = Completer<void>();
    final cancel = addListener(
      (state) {
        if (state != null && !comp.isCompleted) {
          comp.complete();
        }
      },
      fireImmediately: false,
    );
    signIn(name: null, password: null);
    return comp.future.then((_) => cancel());
  }

  void _onSingIn(OperationResponse<GsignInData, GsignInVars> event) {
    if (event.hasErrors) {
      _processCustomError(event);
      return;
    }
    final data = event.data!.signIn;
    if (data is GsignInData_signIn__asErrCSignInErrorReq) {
      switch (data.value) {
        case GSignInError.alreadySignedIn:
          alreadySignedError(data.message);
          break;
        case GSignInError.wrong:
          wrongNameOrPasswordError(data.message);
          break;
      }
    } else if (data is GsignInData_signIn__asTokenWithUser) {
      state = GSTokenWithUserData.fromJson(data.toJson());
    }
  }

  final signInLoading = ValueNotifier(false);
  StreamSubscription? _signInSub;
  void signIn({
    required String? name,
    required String? password,
  }) {
    if (signInLoading.value) {
      return;
    }
    signInLoading.value = true;
    final _req = GsignInReq(
      (b) => (b..executeOnListen = false).vars
        ..name = name
        ..password = password,
    );
    _signInSub = _client.request(_req).listen(
      (event) {
        _onSingIn(event);
        _signInSub!.cancel();
        _signInSub = null;
        signInLoading.value = false;
      },
    );
    _client.requestController.add(_req);
  }

  StreamSubscription? _signUpSub;
  void signUp({required String name, required String password}) {
    _signUpSub ??= _read(clientProvider)
        .request(GsignUpReq((b) => b.vars
          ..name = name
          ..password = password))
        .listen(
      (event) {
        if (event.hasErrors) {
          _processCustomError(event);
          return;
        }

        final data = event.data!.signUp;
        if (data is GsignUpData_signUp__asErrCSignUpErrorReq) {
          switch (data.value) {
            case GSignUpError.alreadySignedUp:
              alreadySignedError(data.message);
              break;

            case GSignUpError.unknown:
              unknownError(data.message);
              break;

            case GSignUpError.nameTaken:
              nameTakenError(data.message);
              break;
          }
        } else if (data is GsignUpData_signUp__asTokenWithUser) {
          state = GSTokenWithUserData.fromJson(data.toJson());
        }
        _signUpSub!.cancel();
      },
      onDone: () async {
        await _signUpSub!.cancel();
        _signUpSub = null;
      },
    );
  }

  StreamSubscription? _signOutSub;
  void signOut() {
    _signOutSub ??= _read(clientProvider).request(GsignOutReq()).listen(
      (event) async {
        if (event.hasErrors) {
          _processCustomError(event);
          return;
        }

        final signOutError = event.data!.signOut;
        if (signOutError != null) {
          _errorController.add(signOutError);
        } else {
          state = null;
          // await signInAnnon();
        }

        await _signOutSub!.cancel();
        _signOutSub = null;
      },
      onDone: () async {
        await _signOutSub!.cancel();
        _signOutSub = null;
      },
    );
  }

  void nameTakenError([String? msg]) {
    _errorController.add('Name taken.');
  }

  void wrongNameOrPasswordError([String? msg]) {
    _errorController.add('Wrong name and password combination.');
  }

  void unknownError([String? msg]) {
    _errorController.add('Unknown error');
  }

  void alreadySignedError([String? msg]) {
    _errorController.add('alreadySignedError');
  }

  void _processCustomError(OperationResponse event) {
    final linkException = event.linkException;
    if (linkException != null) {
      print(linkException);
    } else {
      final graphqlErrors = event.graphqlErrors!;
      print(graphqlErrors);
    }
    unknownError();
  }
}
