import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/messages.data.gql.dart';
import 'package:chat_example/api/messages.req.gql.dart';
import 'package:chat_example/api/messages.var.gql.dart';
import 'package:chat_example/api/room.data.gql.dart';
import 'package:chat_example/api/room.req.gql.dart';
import 'package:chat_example/api/room.var.gql.dart';
import 'package:chat_example/api_schema.schema.gql.dart';
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
  ChatRoom? chatRoom;
  List<ChatRoom> chatRooms = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafos Chat'),
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
                if (chat == null) {
                  return const Center(child: Text('Select a chat'));
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

class MessageList extends HookConsumerWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HookConsumer(
      builder: (context, ref, _) {
        final chat = ref.watch(selectedChat);
        final messages = ref.watch(selectedChatMessages);
        if (chat == null) {
          return const Center(child: Text('Select a chat'));
        }

        Widget _errorWidget(String message) {
          return ErrorWidget(
            message: message,
            refresh: () {
              ref.read(clientProvider).requestController.add(
                    // TODO: use refresh from store
                    GgetMessagesReq((b) => b..vars.chatId = chat.id),
                  );
            },
          );
        }

        return messages.map(
          error: (error) => _errorWidget(error.toString()),
          loading: (loading) => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (data) {
            final value = data.value;
            if (value.hasErrors) {
              _errorWidget(
                (value.linkException ?? value.graphqlErrors).toString(),
              );
            }
            final messages = value.data!.getMessage;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final GFullMessage message = messages[index];
                      return MessageItem(message: message);
                    },
                  ),
                ),
                HookConsumer(
                  builder: (context, ref, _) {
                    final textController = useTextEditingController();
                    final focusNode = useFocusNode();
                    useEffect(() {
                      focusNode.requestFocus();
                    });
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textController,
                            focusNode: focusNode,
                          ),
                        ),
                        IconButton(
                          splashRadius: 24,
                          tooltip: 'Attach',
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file),
                        ),
                        IconButton(
                          splashRadius: 24,
                          tooltip: 'Send',
                          onPressed: () {
                            final message = textController.text;
                            final optimisticResponse =
                                (GsendMessageData_sendMessageBuilder()
                                  ..chatId = chat.id
                                  ..message = message
                                  ..createdAt.value =
                                      DateTime.now().toIso8601String()
                                  ..id = -1);
                            ref
                                .read(clientProvider)
                                .request(
                                  GsendMessageReq(
                                    (b) => b
                                      ..vars.chatId = chat.id
                                      ..vars.message = message
                                      ..updateResult
                                      ..optimisticResponse.sendMessage =
                                          optimisticResponse,
                                  ),
                                )
                                .listen((event) {});
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          },
        );
      },
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
          return ErrorWidget(message: message, refresh: store.refresh);
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

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
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

final selectedChatId = StateProvider<int?>((ref) => null);

final selectedChat = Provider(
  (ref) {
    final chatId = ref.watch(selectedChatId).state;
    if (chatId == null) {
      return null;
    }
    return ref.read(clientProvider).cache.readFragment(
          GBaseChatRoomReq(
            (b) => b..idFields = <String, Object?>{'id': chatId},
          ),
        );
  },
);

final selectedChatMessages =
    StreamProvider<OperationResponse<GgetMessagesData, GgetMessagesVars>>(
  (ref) {
    final chat = ref.watch(selectedChat);
    if (chat == null) {
      return const Stream.empty();
    }
    return ref.read(clientProvider).request(
          // TODO:
          // ..requestId = 'getMessages'
          GgetMessagesReq((b) => b..vars.chatId = chat.id),
        );
  },
);

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final GFullMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Theme.of(context).primaryColor,
          ),
          padding: const EdgeInsetsDirectional.all(6),
          child: Column(
            children: [
              Text(message.message),
              Align(
                alignment: Alignment.centerRight,
                child: Text(message.createdAt.value),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RequestState<TData, TVars>
    extends StateNotifier<Stream<OperationResponse<TData, TVars>>> {
  RequestState(this._read, this.request)
      : super(_read(clientProvider).request(request)) {
    _setup();
  }

  OperationResponse<TData, TVars>? lastResponse;
  DateTime? lastResponseTime;

  void _setup() {
    state.map((event) {
      lastResponse = event;
      lastResponseTime = DateTime.now();
    });
  }

  final OperationRequest<TData, TVars> request;
  final T Function<T>(ProviderBase<T> provider) _read;

  void refresh() {
    _read(clientProvider).requestController.add(request);
  }
}

class UpdateCacheObj<TData, TVars> {
  final String name;
  final UpdateCacheHandler<TData, TVars> handler;

  const UpdateCacheObj(this.name, this.handler);
}

final createReviewHandler = UpdateCacheObj<GcreateRoomData, GcreateRoomVars>(
  'createReviewHandler',
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

class RoomStore {}

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
            ..updateCacheHandlerKey = createReviewHandler.name,
        ),
      );
});

class ChatRoom {
  final String code;
  final String name;
  final String ownerCode;
  final List<Peer> peers;
  final List<Message> messages;
  final DateTime createdAt;

  ChatRoom({
    required this.code,
    required this.name,
    required this.ownerCode,
    required this.peers,
    required this.messages,
    required this.createdAt,
  });
}

class Peer {
  final String code;
  final String name;

  Peer({
    required this.code,
    required this.name,
  });
}

enum MessageType {
  text,
  file,
}

class Message {
  final String code;
  final String text;
  final String? referencedMessageCode;
  final MessageType type;
  final DateTime createdAt;
  final String senderCode;

  Message({
    required this.code,
    required this.text,
    this.referencedMessageCode,
    required this.type,
    required this.createdAt,
    required this.senderCode,
  });
}
