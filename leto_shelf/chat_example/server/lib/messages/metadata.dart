import 'dart:async';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:linkify/linkify.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

part 'metadata.freezed.dart';
part 'metadata.g.dart';

@GraphQLClass()
@freezed
class MessageMetadata with _$MessageMetadata {
  const factory MessageMetadata({
    FileMetadata? fileMetadata,
    LinksMetadata? linksMetadata,
    required DateTime computedAt,
  }) = _MessageMetadata;

  factory MessageMetadata.fromJson(Map<String, Object?> json) =>
      _$MessageMetadataFromJson(json);

  @GraphQLField(omit: true)
  static Future<MessageMetadata> fromMessage(
    String message,
    FutureOr<FileMetadata>? fileMetadata,
  ) async {
    final linksMetadata = await LinksMetadata.fromMessage(message);

    return MessageMetadata(
      computedAt: DateTime.now(),
      fileMetadata: fileMetadata == null ? null : await fileMetadata,
      linksMetadata: linksMetadata.hasLinks ? linksMetadata : null,
    );
  }
}

@GraphQLClass()
@freezed
class LinksMetadata with _$LinksMetadata {
  const factory LinksMetadata({
    required List<LinkMetadata> links,
    required List<String> emails,
    // TODO: bring user ids?
    required List<String> userTags,
  }) = _LinksMetadata;
  const LinksMetadata._();

  factory LinksMetadata.fromJson(Map<String, Object?> json) =>
      _$LinksMetadataFromJson(json);

  bool get hasLinks => <List>[links, emails, userTags].any((l) => l.isNotEmpty);

  @GraphQLField(omit: true)
  static Future<LinksMetadata> fromMessage(String message) async {
    final linkElements = linkify(
      message,
      options: const LinkifyOptions(),
      linkifiers: [
        const UrlLinkifier(),
        const EmailLinkifier(),
        const UserTagLinkifier(),
      ],
    );

    final List<Metadata?> links = await Future.wait(
      linkElements.whereType<UrlElement>().map((e) {
        return MetadataFetch.extract(e.url);
      }),
    );

    return LinksMetadata(
      emails: List.of(
        linkElements.whereType<EmailElement>().map((e) => e.emailAddress),
      ),
      userTags: List.of(
        linkElements.whereType<UserTagElement>().map((e) => e.userTag),
      ),
      links: List.of(
        links.whereType<Metadata>().map(
              (e) => LinkMetadata(
                description: e.description,
                image: e.image,
                title: e.title,
                url: e.url,
              ),
            ),
      ),
    );
  }
}

@GraphQLClass()
@freezed
class LinkMetadata with _$LinkMetadata {
  const factory LinkMetadata({
    String? title,
    String? description,
    String? image,
    String? url,
  }) = _LinkMetadata;

  factory LinkMetadata.fromJson(Map<String, Object?> json) =>
      _$LinkMetadataFromJson(json);
}

@GraphQLClass()
@freezed
class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    required int sizeInBytes,
    required String mimeType,
    required String fileName,
    required String sha1Hash,
    required String? fileHashBlur,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, Object?> json) =>
      _$FileMetadataFromJson(json);

  @GraphQLField(omit: true)
  static Future<FileMetadata> fromUpload(UploadedFile file) async {
    // TODO: filenameIfNull
    final upload = await file.meta();
    final image = img.decodeImage(await file.readAsBytes());
    final blurHash = image == null
        ? null
        : BlurHash.encode(image, numCompX: 4, numCompY: 3).hash;

    // TODO: add more image metadata?
    return FileMetadata(
      fileHashBlur: blurHash,
      fileName: upload.filename,
      mimeType: upload.mimeType,
      sha1Hash: upload.sha1Hash,
      sizeInBytes: upload.sizeInBytes,
    );
  }
}
