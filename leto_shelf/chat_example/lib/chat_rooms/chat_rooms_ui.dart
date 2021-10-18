import 'package:chat_example/api/api_utils.dart';
import 'package:chat_example/api/auth_store.dart';
import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/room.data.gql.dart';
import 'package:chat_example/api/room.req.gql.dart';
import 'package:chat_example/api/room.var.gql.dart';
import 'package:chat_example/auth_ui.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/messages/messages_ui.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class CreateRoomForm extends StatelessWidget {
  const CreateRoomForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookConsumer(
      builder: (context, ref, _) {
        final response = useState<
            Future<OperationResponse<GcreateRoomData, GcreateRoomVars>>?>(null);
        final error = useState('');
        final textController = useTextEditingController();
        final focusNode = useFocusNode();
        useEffect(() {
          focusNode.requestFocus();
        });

        return Column(
          children: [
            TextField(
              controller: textController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: error.value.isNotEmpty
                  ? Card(
                      color: Theme.of(context).errorColor,
                      child: Text(error.value),
                    )
                  : const SizedBox(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final name = textController.text.trim();
                    if (name.isEmpty) {
                      error.value = 'Name should not be empty.';
                      return;
                    }
                    response.value = ref.read(createRoomProvider)(name).first;
                    response.value!.then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                  child: response.value == null
                      ? const Text('Create')
                      : const SizedBox(
                          height: 14,
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class ChatRoomList extends StatelessWidget {
  const ChatRoomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookConsumer(
      builder: (context, ref, _) {
        final store = ref.read(roomsProvider.notifier);
        final roomsStream = ref.watch(roomsProvider);
        final roomsStreamValue = useStream(roomsStream);

        Widget _errorWidget(String message) {
          return CustomErrorWidget(message: message, refresh: store.refresh);
        }

        final error = roomsStreamValue.error;
        if (error != null) {
          return _errorWidget('Error $error');
        }

        final result = roomsStreamValue.data;
        if (result != null && result.hasErrors == true) {
          return _errorWidget(
            'Error ${result.linkException ?? result.graphqlErrors}',
          );
        }
        if (result == null || result.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final value = result.data!.getChatRooms;

        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                splashRadius: 24,
                tooltip: 'Refresh',
                onPressed: () {
                  store.refresh();
                },
                icon: const Icon(Icons.refresh),
              ),
            ),
            Expanded(
              child: value.isEmpty
                  ? const Text('Empty')
                  : HookConsumer(
                      builder: (context, ref, _) {
                        final _chatId = ref.watch(selectedChatId);

                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            final room = value[index];
                            return InkWell(
                              onTap: () {
                                _chatId.state = room.id;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2.5,
                                      color: _chatId.state == room.id
                                          ? Colors.black
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(room.name),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.message,
    required this.refresh,
  }) : super(key: key);

  final String message;
  final void Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message),
        ElevatedButton.icon(
          onPressed: () {
            refresh();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
        )
      ],
    );
  }
}

final createChatRoomHandler = UpdateCacheObj<GcreateRoomData, GcreateRoomVars>(
  'createChatRoomHandler',
  (
    proxy,
    response,
  ) {
    final data = response.data?.createChatRoom;
    if (data == null) {
      return;
    }
    final reviews = proxy.readQuery(GgetRoomsReq()) ?? GgetRoomsData();

    proxy.writeQuery(
      GgetRoomsReq(),
      reviews.rebuild(
        (b) => b
          ..getChatRooms.add(
            GgetRoomsData_getChatRooms.fromJson(
              data.toJson(),
            )!,
          ),
      ),
    );
  },
);

final roomsProvider = StateNotifierProvider<
    RequestState<GgetRoomsData, GgetRoomsVars>,
    Stream<OperationResponse<GgetRoomsData, GgetRoomsVars>>>((ref) {
  // final client = ref.read(clientProvider);
  return RequestState(ref.read, GgetRoomsReq());
});

final roomsStreamProvider = StreamProvider((ref) {
  final client = ref.read(clientProvider);
  final _req = GgetRoomsReq((b) => b..executeOnListen = false);
  final stream = client.request(_req);
  client.requestController.add(_req);
  return stream;
});

final createRoomProvider = Provider((ref) {
  final client = ref.read(clientProvider);
  return (String name) => client.request(
        GcreateRoomReq(
          (b) => b
            ..vars.name = name
            ..updateCacheHandlerKey = createChatRoomHandler.name,
        ),
      );
});
