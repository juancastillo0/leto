// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FileEventAdded _$$FileEventAddedFromJson(Map<String, dynamic> json) =>
    _$FileEventAdded(
      UploadedFileMeta.fromJson(json['fileUpload'] as Map<String, dynamic>),
      replace: json['replace'] as bool? ?? true,
    );

Map<String, dynamic> _$$FileEventAddedToJson(_$FileEventAdded instance) =>
    <String, dynamic>{
      'fileUpload': instance.fileUpload,
      'replace': instance.replace,
    };

_$FileEventRenamed _$$FileEventRenamedFromJson(Map<String, dynamic> json) =>
    _$FileEventRenamed(
      filename: json['filename'] as String,
      newFilename: json['newFilename'] as String,
      replace: json['replace'] as bool? ?? true,
    );

Map<String, dynamic> _$$FileEventRenamedToJson(_$FileEventRenamed instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'newFilename': instance.newFilename,
      'replace': instance.replace,
    };

_$FileEventDeleted _$$FileEventDeletedFromJson(Map<String, dynamic> json) =>
    _$FileEventDeleted(
      json['filename'] as String,
    );

Map<String, dynamic> _$$FileEventDeletedToJson(_$FileEventDeleted instance) =>
    <String, dynamic>{
      'filename': instance.filename,
    };

_$FileEventMany _$$FileEventManyFromJson(Map<String, dynamic> json) =>
    _$FileEventMany(
      (json['events'] as List<dynamic>)
          .map((e) => FileEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FileEventManyToJson(_$FileEventMany instance) =>
    <String, dynamic>{
      'events': instance.events,
    };
