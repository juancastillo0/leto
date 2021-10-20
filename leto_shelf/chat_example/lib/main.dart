import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/api/client.dart';
import 'package:chat_example/chat_rooms/chat_rooms_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final providerContainer = await initClient();
  runApp(UncontrolledProviderScope(
    container: providerContainer,
    // overrides: [
    //   clientProvider.overrideWithValue(client),
    // ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Chat Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, _) {
        final state = ref.watch(authStoreProv);
        if (!state.isLoggedIn) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const ChatsPage();
      }),
    );
  }
}
