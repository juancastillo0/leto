// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedFileMeta _$UploadedFileMetaFromJson(Map<String, dynamic> json) =>
    UploadedFileMeta(
      filename: json['filename'] as String,
      sizeInBytes: json['sizeInBytes'] as int,
      sha1Hash: json['sha1Hash'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      mimeType: json['mimeType'] as String?,
      extra: json['extra'],
    );

Map<String, dynamic> _$UploadedFileMetaToJson(UploadedFileMeta instance) =>
    <String, dynamic>{
      'sizeInBytes': instance.sizeInBytes,
      'mimeType': instance.mimeType,
      'filename': instance.filename,
      'sha1Hash': instance.sha1Hash,
      'createdAt': instance.createdAt.toIso8601String(),
      'extra': instance.extra,
    };
