import 'package:chat_example/auth/sessions_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends HookConsumerWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionStore = ref.watch(sessionStoreProvider);
    final user = ref.watch(sessionStore.user).state;

    useEffect(() {
      Future.delayed(Duration.zero, () {
        sessionStore.getSessions();
      });
    }, [sessionStore]);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Sessions',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final isLoading = ref.watch(sessionStore.isLoading).state;
          return isLoading
              ? const LinearProgressIndicator(minHeight: 3)
              : const SizedBox(height: 3);
        }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(220),
                1: FixedColumnWidth(60),
                2: FixedColumnWidth(120),
                3: FixedColumnWidth(95),
                4: FixedColumnWidth(80),
                5: FixedColumnWidth(160),
              },
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.05),
                  ),
                  children: const [
                    Text('ID'),
                    Text('State'),
                    Text('Ended At'),
                    Text('App Version'),
                    Text('Platform'),
                    Text('User Agent'),
                    Text('Created At'),
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 6,
                            ),
                            child: e,
                          ))
                      .toList(),
                ),
                ...user.sessions.map((session) {
                  return TableRow(
                    children: [
                      Text(session.id),
                      Text(session.isActive ? 'Active' : 'Ended'),
                      Text(session.endedAt?.value ?? 'N/A'),
                      Text(session.appVersion ?? 'Unknown'),
                      Text(session.platform ?? 'Unknown'),
                      Text(session.userAgent ?? 'Unknown'),
                      Text(session.createdAt.value),
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
                              child: e,
                            ))
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        )
      ],
    );
  }
}
