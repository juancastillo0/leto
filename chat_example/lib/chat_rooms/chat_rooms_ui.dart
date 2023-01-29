import 'dart:math';

import 'package:built_collection/src/list.dart';
import 'package:chat_example/chat_rooms/chat_rooms_store.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/utils/custom_error_widget.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/__generated__/room.data.gql.dart';
import '../api/__generated__/room.var.gql.dart';

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
                  : ChatItemsList(value: value),
            ),
          ],
        );
      },
    );
  }
}

class ChatItemsList extends HookConsumerWidget {
  const ChatItemsList({
    Key? key,
    required this.value,
  }) : super(key: key);

  final BuiltList<GgetRoomsData_getChatRooms> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _chatId = ref.watch(selectedChatId.notifier);

    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context, index) {
        final room = value[index];
        return InkWell(
          key: ValueKey(room.id),
          onTap: () {
            _chatId.state = room.id;
          },
          child: Consumer(builder: (context, ref, _) {
            final messages = ref
                .watch(cachedChatMessages(room.id))
                .asData
                ?.value
                ?.getMessage;

            return Container(
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
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      room.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  if (messages != null && messages.isNotEmpty)
                    (() {
                      final message = messages.last;

                      String _simpleDate(String str) {
                        final split = str.split('T');
                        return '${split[0]} ${split[1].substring(0, 5)}';
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              message.message.substring(
                                0,
                                min(
                                  35,
                                  message.message.length,
                                ),
                              ),
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ),
                          Text(
                            _simpleDate(message.createdAt.value),
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ],
                      );
                    })()
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
