// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final messageMetadataSerializer = SerializerValue<MessageMetadata>(
  fromJson: _$$_MessageMetadataFromJson,
  toJson: (m) => _$$_MessageMetadataToJson(m as _$_MessageMetadata),
);
GraphQLObjectType<MessageMetadata>? _messageMetadataGraphQlType;

/// Auto-generated from [MessageMetadata].
GraphQLObjectType<MessageMetadata> get messageMetadataGraphQlType {
  final __name = 'MessageMetadata';
  if (_messageMetadataGraphQlType != null)
    return _messageMetadataGraphQlType! as GraphQLObjectType<MessageMetadata>;

  final __messageMetadataGraphQlType = objectType<MessageMetadata>(
      'MessageMetadata',
      isInterface: false,
      interfaces: [],
      description: null);
  _messageMetadataGraphQlType = __messageMetadataGraphQlType;
  __messageMetadataGraphQlType.fields.addAll(
    [
      field('fileMetadata', fileMetadataGraphQlType,
          resolve: (obj, ctx) => obj.fileMetadata,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('linksMetadata', linksMetadataGraphQlType,
          resolve: (obj, ctx) => obj.linksMetadata,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('computedAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.computedAt,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __messageMetadataGraphQlType;
}

final linksMetadataSerializer = SerializerValue<LinksMetadata>(
  fromJson: _$$_LinksMetadataFromJson,
  toJson: (m) => _$$_LinksMetadataToJson(m as _$_LinksMetadata),
);
GraphQLObjectType<LinksMetadata>? _linksMetadataGraphQlType;

/// Auto-generated from [LinksMetadata].
GraphQLObjectType<LinksMetadata> get linksMetadataGraphQlType {
  final __name = 'LinksMetadata';
  if (_linksMetadataGraphQlType != null)
    return _linksMetadataGraphQlType! as GraphQLObjectType<LinksMetadata>;

  final __linksMetadataGraphQlType = objectType<LinksMetadata>('LinksMetadata',
      isInterface: false, interfaces: [], description: null);
  _linksMetadataGraphQlType = __linksMetadataGraphQlType;
  __linksMetadataGraphQlType.fields.addAll(
    [
      field('links', listOf(linkMetadataGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.links,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('emails', listOf(graphQLString.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.emails,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userTags', listOf(graphQLString.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.userTags,
          inputs: [],
          description: 'TODO: bring user ids?',
          deprecationReason: null),
      field('hasLinks', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasLinks,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __linksMetadataGraphQlType;
}

final linkMetadataSerializer = SerializerValue<LinkMetadata>(
  fromJson: _$$_LinkMetadataFromJson,
  toJson: (m) => _$$_LinkMetadataToJson(m as _$_LinkMetadata),
);
GraphQLObjectType<LinkMetadata>? _linkMetadataGraphQlType;

/// Auto-generated from [LinkMetadata].
GraphQLObjectType<LinkMetadata> get linkMetadataGraphQlType {
  final __name = 'LinkMetadata';
  if (_linkMetadataGraphQlType != null)
    return _linkMetadataGraphQlType! as GraphQLObjectType<LinkMetadata>;

  final __linkMetadataGraphQlType = objectType<LinkMetadata>('LinkMetadata',
      isInterface: false, interfaces: [], description: null);
  _linkMetadataGraphQlType = __linkMetadataGraphQlType;
  __linkMetadataGraphQlType.fields.addAll(
    [
      field('title', graphQLString,
          resolve: (obj, ctx) => obj.title,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('image', graphQLString,
          resolve: (obj, ctx) => obj.image,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('url', graphQLString,
          resolve: (obj, ctx) => obj.url,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __linkMetadataGraphQlType;
}

final fileMetadataSerializer = SerializerValue<FileMetadata>(
  fromJson: _$$_FileMetadataFromJson,
  toJson: (m) => _$$_FileMetadataToJson(m as _$_FileMetadata),
);
GraphQLObjectType<FileMetadata>? _fileMetadataGraphQlType;

/// Auto-generated from [FileMetadata].
GraphQLObjectType<FileMetadata> get fileMetadataGraphQlType {
  final __name = 'FileMetadata';
  if (_fileMetadataGraphQlType != null)
    return _fileMetadataGraphQlType! as GraphQLObjectType<FileMetadata>;

  final __fileMetadataGraphQlType = objectType<FileMetadata>('FileMetadata',
      isInterface: false, interfaces: [], description: null);
  _fileMetadataGraphQlType = __fileMetadataGraphQlType;
  __fileMetadataGraphQlType.fields.addAll(
    [
      field('sizeInBytes', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.sizeInBytes,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('mimeType', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.mimeType,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('fileName', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.fileName,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('sha1Hash', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.sha1Hash,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('fileHashBlur', graphQLString,
          resolve: (obj, ctx) => obj.fileHashBlur,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __fileMetadataGraphQlType;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageMetadata _$$_MessageMetadataFromJson(Map<String, dynamic> json) =>
    _$_MessageMetadata(
      fileMetadata: json['fileMetadata'] == null
          ? null
          : FileMetadata.fromJson(json['fileMetadata'] as Map<String, dynamic>),
      linksMetadata: json['linksMetadata'] == null
          ? null
          : LinksMetadata.fromJson(
              json['linksMetadata'] as Map<String, dynamic>),
      computedAt: DateTime.parse(json['computedAt'] as String),
    );

Map<String, dynamic> _$$_MessageMetadataToJson(_$_MessageMetadata instance) =>
    <String, dynamic>{
      'fileMetadata': instance.fileMetadata,
      'linksMetadata': instance.linksMetadata,
      'computedAt': instance.computedAt.toIso8601String(),
    };

_$_LinksMetadata _$$_LinksMetadataFromJson(Map<String, dynamic> json) =>
    _$_LinksMetadata(
      links: (json['links'] as List<dynamic>)
          .map((e) => LinkMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      emails:
          (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
      userTags:
          (json['userTags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_LinksMetadataToJson(_$_LinksMetadata instance) =>
    <String, dynamic>{
      'links': instance.links,
      'emails': instance.emails,
      'userTags': instance.userTags,
    };

_$_LinkMetadata _$$_LinkMetadataFromJson(Map<String, dynamic> json) =>
    _$_LinkMetadata(
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$_LinkMetadataToJson(_$_LinkMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'url': instance.url,
    };

_$_FileMetadata _$$_FileMetadataFromJson(Map<String, dynamic> json) =>
    _$_FileMetadata(
      sizeInBytes: json['sizeInBytes'] as int,
      mimeType: json['mimeType'] as String,
      fileName: json['fileName'] as String,
      sha1Hash: json['sha1Hash'] as String,
      fileHashBlur: json['fileHashBlur'] as String?,
    );

Map<String, dynamic> _$$_FileMetadataToJson(_$_FileMetadata instance) =>
    <String, dynamic>{
      'sizeInBytes': instance.sizeInBytes,
      'mimeType': instance.mimeType,
      'fileName': instance.fileName,
      'sha1Hash': instance.sha1Hash,
      'fileHashBlur': instance.fileHashBlur,
    };
