import 'package:chat_example/api/auth_store.dart';
import 'package:chat_example/auth_ui.dart';
import 'package:chat_example/chat_rooms/chat_rooms_ui.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/messages/messages_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafos Chat'),
        actions: [
          HookConsumer(builder: (context, ref, _) {
            return const AuthForm(smallForm: true);
          })
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                ),
                const Expanded(
                  child: ChatRoomList(),
                ),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog<Object?>(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  padding: const EdgeInsets.all(10),
                                  child: const CreateRoomForm(),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Create'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: HookConsumer(
              builder: (context, ref, _) {
                final chat = ref.watch(selectedChat);
                final state = ref.watch(authStoreProv);

                if (chat == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Select a chat'),
                        ),
                        if (state.isAnonymous)
                          const SizedBox(
                            width: 300,
                            child: AuthForm(smallForm: false),
                          ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(chat.name),
                        ),
                        IconButton(
                          splashRadius: 24,
                          tooltip: 'Delete',
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: MessageList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
