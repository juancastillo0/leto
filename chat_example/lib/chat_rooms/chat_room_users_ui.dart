
import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/chat_rooms/chat_rooms_store.dart';
import 'package:chat_example/utils/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../__generated__/api_schema.schema.gql.dart';
import '../api/__generated__/room.data.gql.dart';
import '../api/__generated__/user.data.gql.dart';

class ChatRoomUsers extends HookConsumerWidget {
  const ChatRoomUsers({
    Key? key,
    required this.room,
  }) : super(key: key);

  final GFullChatRoomData room;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStoreProv)!.user;

    final ownUser = room.users.firstWhere((u) => u.userId == user.id);
    final userIds = room.users.map((p0) => p0.userId).toSet();
    final canEdit = ownUser.role == GChatRoomUserRole.admin;

    void _showAddUserDialog() {
      showDialog<Object?>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 200,
              height: 300,
              padding: const EdgeInsets.all(8),
              child: SearchUser(
                buttonBuilder: (user) {
                  if (userIds.contains(user.id)) {
                    return const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text('Added'),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      ref.read(roomStoreProvider).addChatRoomUser(
                            chatId: room.id,
                            userId: user.id,
                          );
                    },
                    child: const Text('Add'),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Created: ${room.createdAt.value}',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    final confirmation = await showConfirmationDialog(
                      context,
                      text: '¿Are you sure you want to leave the chat room?',
                    );
                    if (confirmation) {
                      ref.read(roomStoreProvider).deleteChatRoomUser(
                            chatId: room.id,
                            userId: ownUser.userId,
                          );
                    }
                  },
                  child: const Text('Leave'),
                ),
                if (canEdit)
                  IconButton(
                    splashRadius: 24,
                    tooltip: 'Delete',
                    onPressed: () async {
                      final confirmation = await showConfirmationDialog(
                        context,
                        text: '¿Are you sure you want to delete the chat room?'
                            '\n\nAll messages will be lost',
                      );
                      if (confirmation) {
                        ref.read(roomStoreProvider).deleteRoom(room.id);
                      }
                    },
                    icon: const Icon(Icons.delete),
                  )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Members',
                style: Theme.of(context).textTheme.headline6,
              ),
              if (canEdit)
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: ElevatedButton.icon(
                    onPressed: _showAddUserDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Member'),
                  ),
                ),
            ],
          ),
        ),
        // if (room.users.length == 1) const Text('No Users'),
        ...room.users.map(
          (p0) => ChatRoomUser(
            user: p0,
            canEdit: canEdit && p0.userId != user.id,
          ),
        ),
      ],
    );
  }
}

class ChatRoomUser extends HookConsumerWidget {
  const ChatRoomUser({
    Key? key,
    required this.user,
    required this.canEdit,
  }) : super(key: key);

  final GUserChat user;
  final bool canEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = user.user.name ?? 'UserId: ${user.userId}';
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '- $name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                user.role.name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          if (canEdit)
            IconButton(
              splashRadius: 24,
              tooltip: 'Remove',
              onPressed: () async {
                final confirmation = await showConfirmationDialog(
                  context,
                  text: '¿Are you sure you want remove $name from the chat?',
                );
                if (confirmation) {
                  ref.read(roomStoreProvider).deleteChatRoomUser(
                        chatId: user.chatId,
                        userId: user.userId,
                      );
                }
              },
              icon: const Icon(Icons.delete),
            )
        ],
      ),
    );
  }
}

class SearchUser extends HookConsumerWidget {
  const SearchUser({
    Key? key,
    required this.buttonBuilder,
  }) : super(key: key);

  final Widget Function(GAUser user) buttonBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomStore = ref.read(roomStoreProvider);
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final isLoading = ref.watch(roomStore.loadingSearch).state;

    useEffect(() {
      focusNode.requestFocus();
      void _c() {
        roomStore.searchUser(controller.text);
      }

      controller.addListener(_c);
      return () {
        controller.removeListener(_c);
      };
    });

    return Column(
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('\\s')),
          ],
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: InkWell(
              onTap: () {
                controller.text = '';
              },
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: HookConsumer(builder: (context, ref, _) {
              final usersEntry = ref.watch(roomStore.searchedUsers).state;
              final users = usersEntry?.value;

              if (users == null) {
                return const Text('Search Users');
              } else if (users.isEmpty) {
                return Text('No users found for keyword "${usersEntry!.key}"');
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user.name ?? 'UserId: ${user.id}'),
                          ),
                          buttonBuilder(user),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 3),
        if (isLoading)
          const LinearProgressIndicator(minHeight: 3)
        else
          const SizedBox(height: 3),
      ],
    );
  }
}
