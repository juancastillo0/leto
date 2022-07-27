// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:chat_example/api/client.dart';
import 'package:chat_example/auth/auth_store.dart';
import 'package:ferry/ferry.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../api/__generated__/event.data.gql.dart';
import '../api/__generated__/event.req.gql.dart';
import '../api/__generated__/event.var.gql.dart';
import '../api/__generated__/messages.data.gql.dart';
import '../api/__generated__/messages.req.gql.dart';
import '../api/__generated__/messages.var.gql.dart';
import '../api/__generated__/room.data.gql.dart';
import '../api/__generated__/room.req.gql.dart';

part 'messages_store.freezed.dart';

final selectedChatId = StateProvider<int?>((ref) => null);

final selectedChat = StreamProvider<GFullChatRoomData?>(
  (ref) {
    final chatId = ref.watch(selectedChatId).state;
    if (chatId == null) {
      return const Stream.empty();
    }
    return ref.read(clientProvider).cache.watchFragment(
          GFullChatRoomReq(
            (b) => b..idFields = <String, Object?>{'id': chatId},
          ),
        );
  },
);

final selectedChatMessages =
    StreamProvider<OperationResponse<GgetMessagesData, GgetMessagesVars>>(
  (ref) {
    final chat = ref.watch(selectedChat);
    if (chat.asData == null || chat.value == null) {
      return const Stream.empty();
    }

    return ref.read(clientProvider).request(
          // TODO:
          // ..requestId = 'getMessages'
          GgetMessagesReq((b) => b..vars.chatId = chat.value!.id),
        );
  },
);

final cachedChatMessages = StreamProvider.family<GgetMessagesData?, int>(
  (ref, chatId) {
    final cache = ref.read(clientProvider).cache;
    return cache.watchQuery(
      // TODO:
      // ..requestId = 'getMessages'
      GgetMessagesReq((b) => b..vars.chatId = chatId),
    );
  },
);

final userEvents =
    StreamProvider<OperationResponse<GonEventData, GonEventVars>>(
  (ref) {
    ref.watch(userIdProvider);
    return ref.read(clientProvider).request(GonEventReq());
  },
);

final messageStoreProvider = Provider(
  (ref) {
    ref.watch(userIdProvider);
    return MessagesStore(ref);
  },
);

class MessagesStore {
  MessagesStore(this._ref) {
    final sub = _read(userMessagesEvents.stream).listen((event) {
      event.when(
        sent: (sent) {
          final req = GgetMessagesReq(
            (b) => b..vars.chatId = sent.message.chatId,
          );
          final data = client.cache.readQuery(req) ?? GgetMessagesData();
          client.cache.writeQuery(
            req,
            data.rebuild(
              (p0) {
                p0.getMessage.add(
                  GgetMessagesData_getMessage.fromJson(
                    sent.message.toJson(),
                  )!,
                );
                p0.getMessage.sort((a, b) => a.id - b.id);
              },
            ),
          );
        },
        deleted: (deleted) {},
        updated: (updated) {},
      );
    });

    _ref.onDispose(() {
      sub.cancel();
    });
  }

  final errorController = StreamController<String>.broadcast();

  Client get client => _read(clientProvider);
  final ProviderRef _ref;
  T Function<T>(ProviderBase<T> provider) get _read => _ref.read;

  void sendMessage(
    String message,
    int chatId,
  ) async {
    // final user = _read(authStoreProv).user!;
    // final optimisticResponse = (GsendMessageData_sendMessageBuilder()
    //   ..chatId = chatId
    //   ..message = message
    //   ..userId = user.id
    //   ..createdAt.value = DateTime.now().toIso8601String()
    //   ..id = -1);
    final req = GsendMessageReq(
      (b) => b
        ..vars.chatId = chatId
        ..vars.message = message
        ..updateResult
      // ..optimisticResponse.sendMessage = optimisticResponse
      ,
    );
    client.request(req).listen((event) {});
  }

  void sendFileMessage(
    String message,
    int chatId,
    XFile file,
  ) async {
    final sizeInBytes = await file.length();
    if (sizeInBytes > 10e6) {
      errorController.add('Maximum file size: 10MB');
      return;
    }

    final http.MultipartFile multipart;
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      multipart = http.MultipartFile.fromBytes(
        '',
        bytes,
        filename: file.name,
      );
    } else {
      multipart = await http.MultipartFile.fromPath(
        '',
        file.path,
        filename: file.name,
      );
    }
    final req = GsendFileMessageReq(
      (b) => b
        ..vars.chatId = chatId
        ..vars.message = message
        ..vars.file = multipart
      // ..optimisticResponse.sendMessage = optimisticResponse
      ,
    );
    _read(httpClientProvider).request(req).listen((event) {});
  }

  String? _lastSearchMessage;
  Timer? searchTimer;
  final messageLinks = StateProvider<
      MapEntry<String,
          GgetMessageLinksMetadataData_getMessageLinksMetadata>?>((_) => null);

  void getMessageLinkMetadata(String message) {
    if (message.isEmpty) {
      return;
    }
    // final linkElements = linkify(
    //   message,
    //   options: const LinkifyOptions(),
    //   linkifiers: [
    //     const UrlLinkifier(),
    //     const EmailLinkifier(),
    //     const UserTagLinkifier(),
    //   ],
    // );
    // if (linkElements.whereType<UrlElement>().isEmpty) {
    //   return;
    // }

    // _read(loadingSearch).state = true;
    _lastSearchMessage = message;
    searchTimer ??= Timer(const Duration(seconds: 2), () async {
      final _searchMessage = _lastSearchMessage!;
      final req = GgetMessageLinksMetadataReq(
        (b) => (b..executeOnListen = false).vars..message = _searchMessage,
      );
      final result = _read(clientProvider).request(req).firstWhere((element) {
        if (element.hasErrors) {
        } else if (element.data != null) {
          final metadata = element.data!.getMessageLinksMetadata;
          _read(messageLinks).state = MapEntry(_searchMessage, metadata);
        }
        return element.dataSource == DataSource.Link;
      });
      _read(clientProvider).requestController.add(req);
      await result;
      searchTimer = null;
      if (_searchMessage != _lastSearchMessage) {
        getMessageLinkMetadata(_lastSearchMessage!);
      } else {
        // _read(loadingSearch).state = false;
      }
    });
  }
}

final userMessagesEvents = StreamProvider<ChatMessageEvent>(
  (ref) {
    return ref
        .read(userEvents.stream)
        .map<ChatMessageEvent?>((event) {
          final data = event.data?.onEvent.data;
          if (data is GonEventData_onEvent_data__asChatMessageDBEventData) {
            final value = data.value;
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent) {
              return ChatMessageEvent.sent(value);
            }
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent) {
              return ChatMessageEvent.deleted(value);
            }
            if (value
                is GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent) {
              return ChatMessageEvent.updated(value);
            }
          }
          return null;
        })
        .where((event) => event != null)
        .cast();
  },
);

@freezed
class ChatMessageEvent with _$ChatMessageEvent {
  const factory ChatMessageEvent.sent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value) = ChatMessageSentEvent;
  const factory ChatMessageEvent.deleted(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value) = ChatMessageDeletedEvent;
  const factory ChatMessageEvent.updated(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value) = ChatMessageUpdatedEvent;
}
