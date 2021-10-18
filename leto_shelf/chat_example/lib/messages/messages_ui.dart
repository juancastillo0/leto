import 'package:chat_example/api/client.dart';
import 'package:chat_example/api/messages.data.gql.dart';
import 'package:chat_example/api/messages.req.gql.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/utils/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          return CustomErrorWidget(
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
