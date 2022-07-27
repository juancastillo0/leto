import 'dart:io';

import 'package:chat_example/api/client.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/utils/custom_error_widget.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../__generated__/api_schema.schema.gql.dart';
import '../api/__generated__/messages.data.gql.dart';
import '../api/__generated__/messages.req.gql.dart';

class MessageList extends HookConsumerWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(messageStoreProvider);
    final chat = ref.watch(selectedChat).asData?.value;
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

    Future<void> _openFileSelector() async {
      final List<XFile> files = await openFiles();
      if (files.isEmpty) {
        // Operation was canceled by the user.
        return;
      }
      final send = await showDialog<Object?>(
        context: context,
        builder: (context) => MultipleImagesDisplay(files),
      );
      if (send == true) {
        ref
            .read(messageStoreProvider)
            .sendFileMessage('', chat.id, files.first);
      }
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
                primary: false,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: MessageItem(
                      message: message,
                      key: ValueKey(message.id),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                left: 4,
                right: 4,
                top: 4,
              ),
              child: HookConsumer(
                builder: (context, ref, _) {
                  final textController = useTextEditingController();
                  final focusNode = useFocusNode();
                  useEffect(() {
                    focusNode.requestFocus();
                  });
                  useListenableEffect(
                    textController,
                    () {
                      ref
                          .read(messageStoreProvider)
                          .getMessageLinkMetadata(textController.text);
                    },
                  );
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
                        onPressed: () {
                          _openFileSelector();
                        },
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        splashRadius: 24,
                        tooltip: 'Send',
                        onPressed: () {
                          ref
                              .read(messageStoreProvider)
                              .sendMessage(textController.text, chat.id);
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}

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
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
            ),
            padding: const EdgeInsetsDirectional.all(8),
            margin: const EdgeInsetsDirectional.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (message.message.isNotEmpty) Text(message.message),
                if (message.type == GMessageType.FILE)
                  Builder(builder: (context) {
                    final fileMetadata = message.metadata?.fileMetadata;
                    if (fileMetadata == null) {
                      return const SizedBox();
                    }
                    final blurHash = fileMetadata.fileHashBlur;
                    if (blurHash != null) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxHeight: 220,
                        ),
                        child: ImageMessageView(
                          message: message,
                          blurHash: blurHash,
                        ),
                      );
                    }

                    return Container(
                      width: 250,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(fileMetadata.fileName),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.file_present_rounded),
                              const SizedBox(width: 10),
                              Text('${fileMetadata.sizeInBytes ~/ 1000} kB'),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message.createdAt.value),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageMessageView extends StatelessWidget {
  const ImageMessageView({
    Key? key,
    required this.message,
    required this.blurHash,
  }) : super(key: key);

  final GFullMessage message;
  final String blurHash;

  @override
  Widget build(BuildContext context) {
    final _blurHashWidget = SizedBox(
      height: 220,
      width: 220,
      child: BlurHash(
        hash: blurHash,
      ),
    );

    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      child: Consumer(builder: (context, ref, _) {
        return Image.network(
          'http://localhost:8060${message.fileUrl}',
          headers: {
            'Authorization': ref.read(authStoreProv)?.accessToken ?? ''
          },
          fit: BoxFit.scaleDown,
          frameBuilder: (
            BuildContext context,
            Widget child,
            int? frame,
            bool wasSynchronouslyLoaded,
          ) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: frame != null ? child : _blurHashWidget,
            );
          },
        );
      }),
    );
  }
}

void useListenableEffect(
  Listenable listenable,
  void Function() callback,
) {
  final callRef = useRef(callback);
  callRef.value = callback;
  useEffect(
    () {
      void _callback() {
        callRef.value();
      }

      listenable.addListener(_callback);
      return () => listenable.removeListener(_callback);
    },
    [listenable],
  );
}

/// Widget that displays a text file in a dialog
class MultipleImagesDisplay extends StatelessWidget {
  /// Default Constructor
  const MultipleImagesDisplay(this.files);

  /// The files containing the images
  final List<XFile> files;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selected Files'),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ...files.map(
              (file) {
                final extension = file.name.split('.').last;
                if (['jpg', 'jpeg', 'png'].contains(extension)) {
                  return kIsWeb
                      ? Image.network(file.path)
                      : Image.file(File(file.path));
                }
                return FutureBuilder<int>(
                  future: file.length(),
                  builder: (context, snapshot) {
                    final size = snapshot.data;
                    final sizeStr = size == null ? '' : '\n${size ~/ 1000} kB';
                    return Card(
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${file.name}$sizeStr',
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Send'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
