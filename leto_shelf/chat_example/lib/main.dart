import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/persistence.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/chat_rooms/chat_rooms_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  final persistence = await initPersistence();
  final userIdNotifier = ValueNotifier<int?>(null);

  ProviderContainer? providerContainer;
  Future<void> _setUp() async {
    final rootStore = await initClient(persistence);
    providerContainer = rootStore.container;
    final authStore = providerContainer!.read(authStoreProv.notifier);
    userIdNotifier.value = authStore.user!.id;
    authStore.addListener((user) async {
      if (user == null) {
        persistence.cache.clear();
        userIdNotifier.value = null;
        await rootStore.dispose();
        providerContainer!.dispose();
        providerContainer = null;
        // ignore: unawaited_futures
        _setUp();
      }
    });
  }

  // ignore: unawaited_futures
  _setUp();

  runApp(
    AnimatedBuilder(
      animation: userIdNotifier,
      builder: (context, _) {
        if (userIdNotifier.value == null || providerContainer == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UncontrolledProviderScope(
          key: ValueKey(userIdNotifier.value),
          container: providerContainer!,
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Chat Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 13,
            bottom: 12,
            left: 6,
            right: 6,
          ),
          labelStyle: TextStyle(height: 0.5),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const ChatsPage(),
      // Consumer(builder: (context, ref, _) {
      //   final state = ref.watch(authStoreProv);
      //   if (!state.isLoggedIn) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   }
      //   return const ChatsPage();
      // }),
    );
  }
}
