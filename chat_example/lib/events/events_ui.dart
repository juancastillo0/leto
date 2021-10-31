import 'package:chat_example/events/events_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserEventList extends HookConsumerWidget {
  const UserEventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiEventStore = ref.watch(apiEventStoreProvider);
    final events = ref.watch(apiEventStore.events).state;
    final scrollController = useScrollController();

    useEffect(() {
      Future.delayed(Duration.zero, () {
        apiEventStore.getApiEvents();
      });
    }, [apiEventStore]);

    useEffect(() {
      void _c() {
        if (!apiEventStore.canFetchMore) {
          return scrollController.removeListener(_c);
        }
        if (scrollController.hasClients &&
            !ref.read(apiEventStore.isLoading).state) {
          final position = scrollController.position;
          final pixels = position.pixels;
          if (pixels > position.maxScrollExtent * 0.9) {
            apiEventStore.getApiEvents();
          }
        }
      }

      Future.delayed(Duration.zero, () {
        _c();
      });

      scrollController.addListener(_c);
      return () => scrollController.removeListener(_c);
    }, [scrollController]);

    if (events == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Events',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final isLoading = ref.watch(apiEventStore.isLoading).state;
          return isLoading
              ? const LinearProgressIndicator(minHeight: 3)
              : const SizedBox(height: 3);
        }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: events.isEmpty
                ? const Center(
                    child: Text('No Events'),
                  )
                : ListView.builder(
                    controller: scrollController,
                    primary: false,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: Card(
                            elevation: 1.5,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Wrap(
                                    children: List.of([
                                      SelectableText('ID: ${event.id}'),
                                      SelectableText(
                                          'Type: ${event.type.name}'),
                                      SelectableText(
                                          'Session: ${event.sessionId}'),
                                      SelectableText(event.createdAt.value),
                                    ].map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: e,
                                      ),
                                    )),
                                  ),
                                  SelectableText(
                                    event.data.toJson().toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
