// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageMetadata _$MessageMetadataFromJson(Map<String, dynamic> json) {
  return _MessageMetadata.fromJson(json);
}

/// @nodoc
mixin _$MessageMetadata {
  FileMetadata? get fileMetadata => throw _privateConstructorUsedError;
  LinksMetadata? get linksMetadata => throw _privateConstructorUsedError;
  DateTime get computedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageMetadataCopyWith<MessageMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageMetadataCopyWith<$Res> {
  factory $MessageMetadataCopyWith(
          MessageMetadata value, $Res Function(MessageMetadata) then) =
      _$MessageMetadataCopyWithImpl<$Res, MessageMetadata>;
  @useResult
  $Res call(
      {FileMetadata? fileMetadata,
      LinksMetadata? linksMetadata,
      DateTime computedAt});

  $FileMetadataCopyWith<$Res>? get fileMetadata;
  $LinksMetadataCopyWith<$Res>? get linksMetadata;
}

/// @nodoc
class _$MessageMetadataCopyWithImpl<$Res, $Val extends MessageMetadata>
    implements $MessageMetadataCopyWith<$Res> {
  _$MessageMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileMetadata = freezed,
    Object? linksMetadata = freezed,
    Object? computedAt = null,
  }) {
    return _then(_value.copyWith(
      fileMetadata: freezed == fileMetadata
          ? _value.fileMetadata
          : fileMetadata // ignore: cast_nullable_to_non_nullable
              as FileMetadata?,
      linksMetadata: freezed == linksMetadata
          ? _value.linksMetadata
          : linksMetadata // ignore: cast_nullable_to_non_nullable
              as LinksMetadata?,
      computedAt: null == computedAt
          ? _value.computedAt
          : computedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FileMetadataCopyWith<$Res>? get fileMetadata {
    if (_value.fileMetadata == null) {
      return null;
    }

    return $FileMetadataCopyWith<$Res>(_value.fileMetadata!, (value) {
      return _then(_value.copyWith(fileMetadata: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LinksMetadataCopyWith<$Res>? get linksMetadata {
    if (_value.linksMetadata == null) {
      return null;
    }

    return $LinksMetadataCopyWith<$Res>(_value.linksMetadata!, (value) {
      return _then(_value.copyWith(linksMetadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessageMetadataCopyWith<$Res>
    implements $MessageMetadataCopyWith<$Res> {
  factory _$$_MessageMetadataCopyWith(
          _$_MessageMetadata value, $Res Function(_$_MessageMetadata) then) =
      __$$_MessageMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FileMetadata? fileMetadata,
      LinksMetadata? linksMetadata,
      DateTime computedAt});

  @override
  $FileMetadataCopyWith<$Res>? get fileMetadata;
  @override
  $LinksMetadataCopyWith<$Res>? get linksMetadata;
}

/// @nodoc
class __$$_MessageMetadataCopyWithImpl<$Res>
    extends _$MessageMetadataCopyWithImpl<$Res, _$_MessageMetadata>
    implements _$$_MessageMetadataCopyWith<$Res> {
  __$$_MessageMetadataCopyWithImpl(
      _$_MessageMetadata _value, $Res Function(_$_MessageMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileMetadata = freezed,
    Object? linksMetadata = freezed,
    Object? computedAt = null,
  }) {
    return _then(_$_MessageMetadata(
      fileMetadata: freezed == fileMetadata
          ? _value.fileMetadata
          : fileMetadata // ignore: cast_nullable_to_non_nullable
              as FileMetadata?,
      linksMetadata: freezed == linksMetadata
          ? _value.linksMetadata
          : linksMetadata // ignore: cast_nullable_to_non_nullable
              as LinksMetadata?,
      computedAt: null == computedAt
          ? _value.computedAt
          : computedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageMetadata implements _MessageMetadata {
  const _$_MessageMetadata(
      {this.fileMetadata, this.linksMetadata, required this.computedAt});

  factory _$_MessageMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_MessageMetadataFromJson(json);

  @override
  final FileMetadata? fileMetadata;
  @override
  final LinksMetadata? linksMetadata;
  @override
  final DateTime computedAt;

  @override
  String toString() {
    return 'MessageMetadata(fileMetadata: $fileMetadata, linksMetadata: $linksMetadata, computedAt: $computedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageMetadata &&
            (identical(other.fileMetadata, fileMetadata) ||
                other.fileMetadata == fileMetadata) &&
            (identical(other.linksMetadata, linksMetadata) ||
                other.linksMetadata == linksMetadata) &&
            (identical(other.computedAt, computedAt) ||
                other.computedAt == computedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fileMetadata, linksMetadata, computedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageMetadataCopyWith<_$_MessageMetadata> get copyWith =>
      __$$_MessageMetadataCopyWithImpl<_$_MessageMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageMetadataToJson(
      this,
    );
  }
}

abstract class _MessageMetadata implements MessageMetadata {
  const factory _MessageMetadata(
      {final FileMetadata? fileMetadata,
      final LinksMetadata? linksMetadata,
      required final DateTime computedAt}) = _$_MessageMetadata;

  factory _MessageMetadata.fromJson(Map<String, dynamic> json) =
      _$_MessageMetadata.fromJson;

  @override
  FileMetadata? get fileMetadata;
  @override
  LinksMetadata? get linksMetadata;
  @override
  DateTime get computedAt;
  @override
  @JsonKey(ignore: true)
  _$$_MessageMetadataCopyWith<_$_MessageMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

LinksMetadata _$LinksMetadataFromJson(Map<String, dynamic> json) {
  return _LinksMetadata.fromJson(json);
}

/// @nodoc
mixin _$LinksMetadata {
  List<LinkMetadata> get links => throw _privateConstructorUsedError;
  List<String> get emails =>
      throw _privateConstructorUsedError; // TODO: bring user ids?
  List<String> get userTags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinksMetadataCopyWith<LinksMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksMetadataCopyWith<$Res> {
  factory $LinksMetadataCopyWith(
          LinksMetadata value, $Res Function(LinksMetadata) then) =
      _$LinksMetadataCopyWithImpl<$Res, LinksMetadata>;
  @useResult
  $Res call(
      {List<LinkMetadata> links, List<String> emails, List<String> userTags});
}

/// @nodoc
class _$LinksMetadataCopyWithImpl<$Res, $Val extends LinksMetadata>
    implements $LinksMetadataCopyWith<$Res> {
  _$LinksMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? emails = null,
    Object? userTags = null,
  }) {
    return _then(_value.copyWith(
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkMetadata>,
      emails: null == emails
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userTags: null == userTags
          ? _value.userTags
          : userTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LinksMetadataCopyWith<$Res>
    implements $LinksMetadataCopyWith<$Res> {
  factory _$$_LinksMetadataCopyWith(
          _$_LinksMetadata value, $Res Function(_$_LinksMetadata) then) =
      __$$_LinksMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LinkMetadata> links, List<String> emails, List<String> userTags});
}

/// @nodoc
class __$$_LinksMetadataCopyWithImpl<$Res>
    extends _$LinksMetadataCopyWithImpl<$Res, _$_LinksMetadata>
    implements _$$_LinksMetadataCopyWith<$Res> {
  __$$_LinksMetadataCopyWithImpl(
      _$_LinksMetadata _value, $Res Function(_$_LinksMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? emails = null,
    Object? userTags = null,
  }) {
    return _then(_$_LinksMetadata(
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkMetadata>,
      emails: null == emails
          ? _value._emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userTags: null == userTags
          ? _value._userTags
          : userTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LinksMetadata extends _LinksMetadata {
  const _$_LinksMetadata(
      {required final List<LinkMetadata> links,
      required final List<String> emails,
      required final List<String> userTags})
      : _links = links,
        _emails = emails,
        _userTags = userTags,
        super._();

  factory _$_LinksMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_LinksMetadataFromJson(json);

  final List<LinkMetadata> _links;
  @override
  List<LinkMetadata> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<String> _emails;
  @override
  List<String> get emails {
    if (_emails is EqualUnmodifiableListView) return _emails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emails);
  }

// TODO: bring user ids?
  final List<String> _userTags;
// TODO: bring user ids?
  @override
  List<String> get userTags {
    if (_userTags is EqualUnmodifiableListView) return _userTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userTags);
  }

  @override
  String toString() {
    return 'LinksMetadata(links: $links, emails: $emails, userTags: $userTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LinksMetadata &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._emails, _emails) &&
            const DeepCollectionEquality().equals(other._userTags, _userTags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_emails),
      const DeepCollectionEquality().hash(_userTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LinksMetadataCopyWith<_$_LinksMetadata> get copyWith =>
      __$$_LinksMetadataCopyWithImpl<_$_LinksMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinksMetadataToJson(
      this,
    );
  }
}

abstract class _LinksMetadata extends LinksMetadata {
  const factory _LinksMetadata(
      {required final List<LinkMetadata> links,
      required final List<String> emails,
      required final List<String> userTags}) = _$_LinksMetadata;
  const _LinksMetadata._() : super._();

  factory _LinksMetadata.fromJson(Map<String, dynamic> json) =
      _$_LinksMetadata.fromJson;

  @override
  List<LinkMetadata> get links;
  @override
  List<String> get emails;
  @override // TODO: bring user ids?
  List<String> get userTags;
  @override
  @JsonKey(ignore: true)
  _$$_LinksMetadataCopyWith<_$_LinksMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

LinkMetadata _$LinkMetadataFromJson(Map<String, dynamic> json) {
  return _LinkMetadata.fromJson(json);
}

/// @nodoc
mixin _$LinkMetadata {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinkMetadataCopyWith<LinkMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkMetadataCopyWith<$Res> {
  factory $LinkMetadataCopyWith(
          LinkMetadata value, $Res Function(LinkMetadata) then) =
      _$LinkMetadataCopyWithImpl<$Res, LinkMetadata>;
  @useResult
  $Res call({String? title, String? description, String? image, String? url});
}

/// @nodoc
class _$LinkMetadataCopyWithImpl<$Res, $Val extends LinkMetadata>
    implements $LinkMetadataCopyWith<$Res> {
  _$LinkMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LinkMetadataCopyWith<$Res>
    implements $LinkMetadataCopyWith<$Res> {
  factory _$$_LinkMetadataCopyWith(
          _$_LinkMetadata value, $Res Function(_$_LinkMetadata) then) =
      __$$_LinkMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? description, String? image, String? url});
}

/// @nodoc
class __$$_LinkMetadataCopyWithImpl<$Res>
    extends _$LinkMetadataCopyWithImpl<$Res, _$_LinkMetadata>
    implements _$$_LinkMetadataCopyWith<$Res> {
  __$$_LinkMetadataCopyWithImpl(
      _$_LinkMetadata _value, $Res Function(_$_LinkMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_LinkMetadata(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LinkMetadata implements _LinkMetadata {
  const _$_LinkMetadata({this.title, this.description, this.image, this.url});

  factory _$_LinkMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_LinkMetadataFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final String? url;

  @override
  String toString() {
    return 'LinkMetadata(title: $title, description: $description, image: $image, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LinkMetadata &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, image, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LinkMetadataCopyWith<_$_LinkMetadata> get copyWith =>
      __$$_LinkMetadataCopyWithImpl<_$_LinkMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinkMetadataToJson(
      this,
    );
  }
}

abstract class _LinkMetadata implements LinkMetadata {
  const factory _LinkMetadata(
      {final String? title,
      final String? description,
      final String? image,
      final String? url}) = _$_LinkMetadata;

  factory _LinkMetadata.fromJson(Map<String, dynamic> json) =
      _$_LinkMetadata.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_LinkMetadataCopyWith<_$_LinkMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

FileMetadata _$FileMetadataFromJson(Map<String, dynamic> json) {
  return _FileMetadata.fromJson(json);
}

/// @nodoc
mixin _$FileMetadata {
  int get sizeInBytes => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get sha1Hash => throw _privateConstructorUsedError;
  String? get fileHashBlur => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileMetadataCopyWith<FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileMetadataCopyWith<$Res> {
  factory $FileMetadataCopyWith(
          FileMetadata value, $Res Function(FileMetadata) then) =
      _$FileMetadataCopyWithImpl<$Res, FileMetadata>;
  @useResult
  $Res call(
      {int sizeInBytes,
      String mimeType,
      String fileName,
      String sha1Hash,
      String? fileHashBlur});
}

/// @nodoc
class _$FileMetadataCopyWithImpl<$Res, $Val extends FileMetadata>
    implements $FileMetadataCopyWith<$Res> {
  _$FileMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sizeInBytes = null,
    Object? mimeType = null,
    Object? fileName = null,
    Object? sha1Hash = null,
    Object? fileHashBlur = freezed,
  }) {
    return _then(_value.copyWith(
      sizeInBytes: null == sizeInBytes
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      sha1Hash: null == sha1Hash
          ? _value.sha1Hash
          : sha1Hash // ignore: cast_nullable_to_non_nullable
              as String,
      fileHashBlur: freezed == fileHashBlur
          ? _value.fileHashBlur
          : fileHashBlur // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileMetadataCopyWith<$Res>
    implements $FileMetadataCopyWith<$Res> {
  factory _$$_FileMetadataCopyWith(
          _$_FileMetadata value, $Res Function(_$_FileMetadata) then) =
      __$$_FileMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sizeInBytes,
      String mimeType,
      String fileName,
      String sha1Hash,
      String? fileHashBlur});
}

/// @nodoc
class __$$_FileMetadataCopyWithImpl<$Res>
    extends _$FileMetadataCopyWithImpl<$Res, _$_FileMetadata>
    implements _$$_FileMetadataCopyWith<$Res> {
  __$$_FileMetadataCopyWithImpl(
      _$_FileMetadata _value, $Res Function(_$_FileMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sizeInBytes = null,
    Object? mimeType = null,
    Object? fileName = null,
    Object? sha1Hash = null,
    Object? fileHashBlur = freezed,
  }) {
    return _then(_$_FileMetadata(
      sizeInBytes: null == sizeInBytes
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      sha1Hash: null == sha1Hash
          ? _value.sha1Hash
          : sha1Hash // ignore: cast_nullable_to_non_nullable
              as String,
      fileHashBlur: freezed == fileHashBlur
          ? _value.fileHashBlur
          : fileHashBlur // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FileMetadata implements _FileMetadata {
  const _$_FileMetadata(
      {required this.sizeInBytes,
      required this.mimeType,
      required this.fileName,
      required this.sha1Hash,
      required this.fileHashBlur});

  factory _$_FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_FileMetadataFromJson(json);

  @override
  final int sizeInBytes;
  @override
  final String mimeType;
  @override
  final String fileName;
  @override
  final String sha1Hash;
  @override
  final String? fileHashBlur;

  @override
  String toString() {
    return 'FileMetadata(sizeInBytes: $sizeInBytes, mimeType: $mimeType, fileName: $fileName, sha1Hash: $sha1Hash, fileHashBlur: $fileHashBlur)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileMetadata &&
            (identical(other.sizeInBytes, sizeInBytes) ||
                other.sizeInBytes == sizeInBytes) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.sha1Hash, sha1Hash) ||
                other.sha1Hash == sha1Hash) &&
            (identical(other.fileHashBlur, fileHashBlur) ||
                other.fileHashBlur == fileHashBlur));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sizeInBytes, mimeType, fileName, sha1Hash, fileHashBlur);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileMetadataCopyWith<_$_FileMetadata> get copyWith =>
      __$$_FileMetadataCopyWithImpl<_$_FileMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileMetadataToJson(
      this,
    );
  }
}

abstract class _FileMetadata implements FileMetadata {
  const factory _FileMetadata(
      {required final int sizeInBytes,
      required final String mimeType,
      required final String fileName,
      required final String sha1Hash,
      required final String? fileHashBlur}) = _$_FileMetadata;

  factory _FileMetadata.fromJson(Map<String, dynamic> json) =
      _$_FileMetadata.fromJson;

  @override
  int get sizeInBytes;
  @override
  String get mimeType;
  @override
  String get fileName;
  @override
  String get sha1Hash;
  @override
  String? get fileHashBlur;
  @override
  @JsonKey(ignore: true)
  _$$_FileMetadataCopyWith<_$_FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
