import 'package:crypto/crypto.dart' show sha1;
import 'package:json_annotation/json_annotation.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';

part 'file_metadata.g.dart';

@JsonSerializable()
class UploadedFileMeta {
  final int sizeInBytes;
  final String mimeType;
  final String filename;
  final String sha1Hash;
  final DateTime createdAt;
  final Object? extra;

  const UploadedFileMeta({
    required this.filename,
    required this.sizeInBytes,
    required this.sha1Hash,
    required this.createdAt,
    String? mimeType,
    this.extra,
  }) : mimeType = mimeType ?? 'application/octet-stream';

  static UploadedFileMeta fromJson(Map<String, Object?> json) =>
      _$UploadedFileMetaFromJson(json);

  Map<String, Object?> toJson() => _$UploadedFileMetaToJson(this);

  static final serializer = SerializerValue(
    fromJson: (ctx, json) => UploadedFileMeta.fromJson(json),
  );

  static Future<UploadedFileMeta> fromUpload(
    Upload upload, {
    String? filenameIfNull,
    Object? extra,
  }) async {
    final digest = await sha1.bind(upload.data).single;
    final _sizeInBytes = await upload.sizeInBytes;
    return UploadedFileMeta(
      filename: (upload.filename ?? filenameIfNull)!,
      sizeInBytes: _sizeInBytes,
      createdAt: upload.createdAt,
      extra: extra,
      sha1Hash: digest.toString(),
      mimeType: upload.contentType?.mimeType,
    );
  }
}
