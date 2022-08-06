// ignore_for_file: leading_newlines_in_multiline_strings, constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/events/events_api.dart';
import 'package:server/file_system.dart';
import 'package:server/messages/metadata.dart';
import 'package:server/users/auth.dart';
import 'package:server/utilities.dart';

part 'messages_api.freezed.dart';
part 'messages_api.g.dart';

@GraphQLEnum()
enum MessageType {
  FILE,
  TEXT,
}

@GraphQLObject()
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int chatId,
    required int userId,
    required String message,
    required MessageType type,
    String? fileUrl,
    @GraphQLField(omit: true) String? metadataJson,
    int? referencedMessageId,
    required DateTime createdAt,
  }) = _ChatMessage;
  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);

  Future<ChatMessage?> referencedMessage(Ctx ctx) async {
    if (referencedMessageId == null) {
      return null;
    }
    final controller = await chatControllerRef.get(ctx);
    // TODO: use dataloader or cached
    return controller.messages.get(referencedMessageId!);
  }

  MessageMetadata? metadata() {
    if (metadataJson == null) {
      return null;
    }
    return MessageMetadata.fromJson(
      jsonDecode(metadataJson!) as Map<String, Object?>,
    );
  }
}

@GraphQLObject()
@freezed
class ChatMessageEvent with _$ChatMessageEvent implements DBEventDataKeyed {
  const ChatMessageEvent._();
  const factory ChatMessageEvent.sent({
    required ChatMessage message,
  }) = ChatMessageSentEvent;

  const factory ChatMessageEvent.deleted({
    required int chatId,
    required int messageId,
  }) = ChatMessageDeletedEvent;

  const factory ChatMessageEvent.updated({
    required ChatMessage message,
  }) = ChatMessageUpdatedEvent;

  factory ChatMessageEvent.fromJson(Map<String, Object?> map) =>
      _$ChatMessageEventFromJson(map);

  @override
  @GraphQLField(omit: true)
  MapEntry<EventType, String> get eventKey {
    return map(
      sent: (e) => MapEntry(EventType.messageSent, '$chatId/${e.message.id}'),
      deleted: (e) =>
          MapEntry(EventType.messageDeleted, '$chatId/${e.messageId}'),
      updated: (e) =>
          MapEntry(EventType.messageUpdated, '$chatId/${e.message.id}'),
    );
  }

  int get chatId {
    return map(
      sent: (e) => e.message.chatId,
      deleted: (e) => e.chatId,
      updated: (e) => e.message.chatId,
    );
  }
}

@Mutation()
Future<ChatMessage?> sendMessage(
  Ctx ctx,
  int chatId,
  String message,
  int? referencedMessageId,
) async {
  final userClaims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  final metadata = await MessageMetadata.fromMessage(message, null);
  return controller.messages.insert(
    chatId,
    message,
    referencedMessageId: referencedMessageId,
    user: userClaims,
    metadata: metadata,
  );
}

@Mutation()
Future<ChatMessage?> sendFileMessage(
  Ctx ctx,
  int chatId,
  Upload file, {
  int? referencedMessageId,
  String message = '',
}) async {
  final claims = await getUserClaimsUnwrap(ctx);
  final controller = await chatControllerRef.get(ctx);
  await controller.messages.validateInsert(
    userId: claims.userId,
    chatId: chatId,
    referencedMessageId: referencedMessageId,
  );
  final fs = fileSystemRef.get(ctx);
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final uuid = uuidBase64Url();

  final fileName = file.filename ?? file.name ?? '';
  final filePath = //
      '/files/chats/$chatId/${claims.userId}/'
      '$timestamp-$uuid-$fileName';
  final ioFile = await fs.file('./bin$filePath').create(recursive: true);

  // TODO: sizeLimit
  final c = ioFile.openWrite();
  await c.addStream(file.data);
  await c.close();

  // TODO: should we do it eventually after insert?
  final metadata = await MessageMetadata.fromMessage(
    message,
    FileMetadata.fromUpload(file),
  );

  return controller.messages.insert(
    chatId,
    message,
    referencedMessageId: referencedMessageId,
    user: claims,
    fileUrl: filePath,
    metadata: metadata,
  );
}

@Query()
Future<List<ChatMessage>> getMessage(
  Ctx ctx,
  int? chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.getAll(chatId: chatId);
}

@Query()
Future<LinksMetadata> getMessageLinksMetadata(String message) {
  return LinksMetadata.fromMessage(message);
}

@Subscription()
Future<Stream<List<ChatMessage>>> onMessageSent(
  Ctx ctx,
  int chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  final chat = await controller.chats.get(chatId);
  if (chat == null) {
    throw GraphQLError('Chat with id $chatId not found.');
  }
  return controller.messages.controller.stream
      .where((event) => event.chatId == chatId)
      .asyncMap((event) => controller.messages.getAll(chatId: chatId));
}
