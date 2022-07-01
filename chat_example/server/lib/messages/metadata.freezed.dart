// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageMetadata _$MessageMetadataFromJson(Map<String, dynamic> json) {
  return _MessageMetadata.fromJson(json);
}

/// @nodoc
class _$MessageMetadataTearOff {
  const _$MessageMetadataTearOff();

  _MessageMetadata call(
      {FileMetadata? fileMetadata,
      LinksMetadata? linksMetadata,
      required DateTime computedAt}) {
    return _MessageMetadata(
      fileMetadata: fileMetadata,
      linksMetadata: linksMetadata,
      computedAt: computedAt,
    );
  }

  MessageMetadata fromJson(Map<String, Object?> json) {
    return MessageMetadata.fromJson(json);
  }
}

/// @nodoc
const $MessageMetadata = _$MessageMetadataTearOff();

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
      _$MessageMetadataCopyWithImpl<$Res>;
  $Res call(
      {FileMetadata? fileMetadata,
      LinksMetadata? linksMetadata,
      DateTime computedAt});

  $FileMetadataCopyWith<$Res>? get fileMetadata;
  $LinksMetadataCopyWith<$Res>? get linksMetadata;
}

/// @nodoc
class _$MessageMetadataCopyWithImpl<$Res>
    implements $MessageMetadataCopyWith<$Res> {
  _$MessageMetadataCopyWithImpl(this._value, this._then);

  final MessageMetadata _value;
  // ignore: unused_field
  final $Res Function(MessageMetadata) _then;

  @override
  $Res call({
    Object? fileMetadata = freezed,
    Object? linksMetadata = freezed,
    Object? computedAt = freezed,
  }) {
    return _then(_value.copyWith(
      fileMetadata: fileMetadata == freezed
          ? _value.fileMetadata
          : fileMetadata // ignore: cast_nullable_to_non_nullable
              as FileMetadata?,
      linksMetadata: linksMetadata == freezed
          ? _value.linksMetadata
          : linksMetadata // ignore: cast_nullable_to_non_nullable
              as LinksMetadata?,
      computedAt: computedAt == freezed
          ? _value.computedAt
          : computedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $FileMetadataCopyWith<$Res>? get fileMetadata {
    if (_value.fileMetadata == null) {
      return null;
    }

    return $FileMetadataCopyWith<$Res>(_value.fileMetadata!, (value) {
      return _then(_value.copyWith(fileMetadata: value));
    });
  }

  @override
  $LinksMetadataCopyWith<$Res>? get linksMetadata {
    if (_value.linksMetadata == null) {
      return null;
    }

    return $LinksMetadataCopyWith<$Res>(_value.linksMetadata!, (value) {
      return _then(_value.copyWith(linksMetadata: value));
    });
  }
}

/// @nodoc
abstract class _$MessageMetadataCopyWith<$Res>
    implements $MessageMetadataCopyWith<$Res> {
  factory _$MessageMetadataCopyWith(
          _MessageMetadata value, $Res Function(_MessageMetadata) then) =
      __$MessageMetadataCopyWithImpl<$Res>;
  @override
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
class __$MessageMetadataCopyWithImpl<$Res>
    extends _$MessageMetadataCopyWithImpl<$Res>
    implements _$MessageMetadataCopyWith<$Res> {
  __$MessageMetadataCopyWithImpl(
      _MessageMetadata _value, $Res Function(_MessageMetadata) _then)
      : super(_value, (v) => _then(v as _MessageMetadata));

  @override
  _MessageMetadata get _value => super._value as _MessageMetadata;

  @override
  $Res call({
    Object? fileMetadata = freezed,
    Object? linksMetadata = freezed,
    Object? computedAt = freezed,
  }) {
    return _then(_MessageMetadata(
      fileMetadata: fileMetadata == freezed
          ? _value.fileMetadata
          : fileMetadata // ignore: cast_nullable_to_non_nullable
              as FileMetadata?,
      linksMetadata: linksMetadata == freezed
          ? _value.linksMetadata
          : linksMetadata // ignore: cast_nullable_to_non_nullable
              as LinksMetadata?,
      computedAt: computedAt == freezed
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
            other is _MessageMetadata &&
            const DeepCollectionEquality()
                .equals(other.fileMetadata, fileMetadata) &&
            const DeepCollectionEquality()
                .equals(other.linksMetadata, linksMetadata) &&
            const DeepCollectionEquality()
                .equals(other.computedAt, computedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fileMetadata),
      const DeepCollectionEquality().hash(linksMetadata),
      const DeepCollectionEquality().hash(computedAt));

  @JsonKey(ignore: true)
  @override
  _$MessageMetadataCopyWith<_MessageMetadata> get copyWith =>
      __$MessageMetadataCopyWithImpl<_MessageMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageMetadataToJson(this);
  }
}

abstract class _MessageMetadata implements MessageMetadata {
  const factory _MessageMetadata(
      {FileMetadata? fileMetadata,
      LinksMetadata? linksMetadata,
      required DateTime computedAt}) = _$_MessageMetadata;

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
  _$MessageMetadataCopyWith<_MessageMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

LinksMetadata _$LinksMetadataFromJson(Map<String, dynamic> json) {
  return _LinksMetadata.fromJson(json);
}

/// @nodoc
class _$LinksMetadataTearOff {
  const _$LinksMetadataTearOff();

  _LinksMetadata call(
      {required List<LinkMetadata> links,
      required List<String> emails,
      required List<String> userTags}) {
    return _LinksMetadata(
      links: links,
      emails: emails,
      userTags: userTags,
    );
  }

  LinksMetadata fromJson(Map<String, Object?> json) {
    return LinksMetadata.fromJson(json);
  }
}

/// @nodoc
const $LinksMetadata = _$LinksMetadataTearOff();

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
      _$LinksMetadataCopyWithImpl<$Res>;
  $Res call(
      {List<LinkMetadata> links, List<String> emails, List<String> userTags});
}

/// @nodoc
class _$LinksMetadataCopyWithImpl<$Res>
    implements $LinksMetadataCopyWith<$Res> {
  _$LinksMetadataCopyWithImpl(this._value, this._then);

  final LinksMetadata _value;
  // ignore: unused_field
  final $Res Function(LinksMetadata) _then;

  @override
  $Res call({
    Object? links = freezed,
    Object? emails = freezed,
    Object? userTags = freezed,
  }) {
    return _then(_value.copyWith(
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkMetadata>,
      emails: emails == freezed
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userTags: userTags == freezed
          ? _value.userTags
          : userTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$LinksMetadataCopyWith<$Res>
    implements $LinksMetadataCopyWith<$Res> {
  factory _$LinksMetadataCopyWith(
          _LinksMetadata value, $Res Function(_LinksMetadata) then) =
      __$LinksMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<LinkMetadata> links, List<String> emails, List<String> userTags});
}

/// @nodoc
class __$LinksMetadataCopyWithImpl<$Res>
    extends _$LinksMetadataCopyWithImpl<$Res>
    implements _$LinksMetadataCopyWith<$Res> {
  __$LinksMetadataCopyWithImpl(
      _LinksMetadata _value, $Res Function(_LinksMetadata) _then)
      : super(_value, (v) => _then(v as _LinksMetadata));

  @override
  _LinksMetadata get _value => super._value as _LinksMetadata;

  @override
  $Res call({
    Object? links = freezed,
    Object? emails = freezed,
    Object? userTags = freezed,
  }) {
    return _then(_LinksMetadata(
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkMetadata>,
      emails: emails == freezed
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userTags: userTags == freezed
          ? _value.userTags
          : userTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LinksMetadata extends _LinksMetadata {
  const _$_LinksMetadata(
      {required this.links, required this.emails, required this.userTags})
      : super._();

  factory _$_LinksMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_LinksMetadataFromJson(json);

  @override
  final List<LinkMetadata> links;
  @override
  final List<String> emails;
  @override // TODO: bring user ids?
  final List<String> userTags;

  @override
  String toString() {
    return 'LinksMetadata(links: $links, emails: $emails, userTags: $userTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LinksMetadata &&
            const DeepCollectionEquality().equals(other.links, links) &&
            const DeepCollectionEquality().equals(other.emails, emails) &&
            const DeepCollectionEquality().equals(other.userTags, userTags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(links),
      const DeepCollectionEquality().hash(emails),
      const DeepCollectionEquality().hash(userTags));

  @JsonKey(ignore: true)
  @override
  _$LinksMetadataCopyWith<_LinksMetadata> get copyWith =>
      __$LinksMetadataCopyWithImpl<_LinksMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinksMetadataToJson(this);
  }
}

abstract class _LinksMetadata extends LinksMetadata {
  const factory _LinksMetadata(
      {required List<LinkMetadata> links,
      required List<String> emails,
      required List<String> userTags}) = _$_LinksMetadata;
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
  _$LinksMetadataCopyWith<_LinksMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

LinkMetadata _$LinkMetadataFromJson(Map<String, dynamic> json) {
  return _LinkMetadata.fromJson(json);
}

/// @nodoc
class _$LinkMetadataTearOff {
  const _$LinkMetadataTearOff();

  _LinkMetadata call(
      {String? title, String? description, String? image, String? url}) {
    return _LinkMetadata(
      title: title,
      description: description,
      image: image,
      url: url,
    );
  }

  LinkMetadata fromJson(Map<String, Object?> json) {
    return LinkMetadata.fromJson(json);
  }
}

/// @nodoc
const $LinkMetadata = _$LinkMetadataTearOff();

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
      _$LinkMetadataCopyWithImpl<$Res>;
  $Res call({String? title, String? description, String? image, String? url});
}

/// @nodoc
class _$LinkMetadataCopyWithImpl<$Res> implements $LinkMetadataCopyWith<$Res> {
  _$LinkMetadataCopyWithImpl(this._value, this._then);

  final LinkMetadata _value;
  // ignore: unused_field
  final $Res Function(LinkMetadata) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LinkMetadataCopyWith<$Res>
    implements $LinkMetadataCopyWith<$Res> {
  factory _$LinkMetadataCopyWith(
          _LinkMetadata value, $Res Function(_LinkMetadata) then) =
      __$LinkMetadataCopyWithImpl<$Res>;
  @override
  $Res call({String? title, String? description, String? image, String? url});
}

/// @nodoc
class __$LinkMetadataCopyWithImpl<$Res> extends _$LinkMetadataCopyWithImpl<$Res>
    implements _$LinkMetadataCopyWith<$Res> {
  __$LinkMetadataCopyWithImpl(
      _LinkMetadata _value, $Res Function(_LinkMetadata) _then)
      : super(_value, (v) => _then(v as _LinkMetadata));

  @override
  _LinkMetadata get _value => super._value as _LinkMetadata;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? url = freezed,
  }) {
    return _then(_LinkMetadata(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
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
            other is _LinkMetadata &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$LinkMetadataCopyWith<_LinkMetadata> get copyWith =>
      __$LinkMetadataCopyWithImpl<_LinkMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinkMetadataToJson(this);
  }
}

abstract class _LinkMetadata implements LinkMetadata {
  const factory _LinkMetadata(
      {String? title,
      String? description,
      String? image,
      String? url}) = _$_LinkMetadata;

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
  _$LinkMetadataCopyWith<_LinkMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

FileMetadata _$FileMetadataFromJson(Map<String, dynamic> json) {
  return _FileMetadata.fromJson(json);
}

/// @nodoc
class _$FileMetadataTearOff {
  const _$FileMetadataTearOff();

  _FileMetadata call(
      {required int sizeInBytes,
      required String mimeType,
      required String fileName,
      required String sha1Hash,
      required String? fileHashBlur}) {
    return _FileMetadata(
      sizeInBytes: sizeInBytes,
      mimeType: mimeType,
      fileName: fileName,
      sha1Hash: sha1Hash,
      fileHashBlur: fileHashBlur,
    );
  }

  FileMetadata fromJson(Map<String, Object?> json) {
    return FileMetadata.fromJson(json);
  }
}

/// @nodoc
const $FileMetadata = _$FileMetadataTearOff();

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
      _$FileMetadataCopyWithImpl<$Res>;
  $Res call(
      {int sizeInBytes,
      String mimeType,
      String fileName,
      String sha1Hash,
      String? fileHashBlur});
}

/// @nodoc
class _$FileMetadataCopyWithImpl<$Res> implements $FileMetadataCopyWith<$Res> {
  _$FileMetadataCopyWithImpl(this._value, this._then);

  final FileMetadata _value;
  // ignore: unused_field
  final $Res Function(FileMetadata) _then;

  @override
  $Res call({
    Object? sizeInBytes = freezed,
    Object? mimeType = freezed,
    Object? fileName = freezed,
    Object? sha1Hash = freezed,
    Object? fileHashBlur = freezed,
  }) {
    return _then(_value.copyWith(
      sizeInBytes: sizeInBytes == freezed
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      sha1Hash: sha1Hash == freezed
          ? _value.sha1Hash
          : sha1Hash // ignore: cast_nullable_to_non_nullable
              as String,
      fileHashBlur: fileHashBlur == freezed
          ? _value.fileHashBlur
          : fileHashBlur // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$FileMetadataCopyWith<$Res>
    implements $FileMetadataCopyWith<$Res> {
  factory _$FileMetadataCopyWith(
          _FileMetadata value, $Res Function(_FileMetadata) then) =
      __$FileMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {int sizeInBytes,
      String mimeType,
      String fileName,
      String sha1Hash,
      String? fileHashBlur});
}

/// @nodoc
class __$FileMetadataCopyWithImpl<$Res> extends _$FileMetadataCopyWithImpl<$Res>
    implements _$FileMetadataCopyWith<$Res> {
  __$FileMetadataCopyWithImpl(
      _FileMetadata _value, $Res Function(_FileMetadata) _then)
      : super(_value, (v) => _then(v as _FileMetadata));

  @override
  _FileMetadata get _value => super._value as _FileMetadata;

  @override
  $Res call({
    Object? sizeInBytes = freezed,
    Object? mimeType = freezed,
    Object? fileName = freezed,
    Object? sha1Hash = freezed,
    Object? fileHashBlur = freezed,
  }) {
    return _then(_FileMetadata(
      sizeInBytes: sizeInBytes == freezed
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      sha1Hash: sha1Hash == freezed
          ? _value.sha1Hash
          : sha1Hash // ignore: cast_nullable_to_non_nullable
              as String,
      fileHashBlur: fileHashBlur == freezed
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
            other is _FileMetadata &&
            const DeepCollectionEquality()
                .equals(other.sizeInBytes, sizeInBytes) &&
            const DeepCollectionEquality().equals(other.mimeType, mimeType) &&
            const DeepCollectionEquality().equals(other.fileName, fileName) &&
            const DeepCollectionEquality().equals(other.sha1Hash, sha1Hash) &&
            const DeepCollectionEquality()
                .equals(other.fileHashBlur, fileHashBlur));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(sizeInBytes),
      const DeepCollectionEquality().hash(mimeType),
      const DeepCollectionEquality().hash(fileName),
      const DeepCollectionEquality().hash(sha1Hash),
      const DeepCollectionEquality().hash(fileHashBlur));

  @JsonKey(ignore: true)
  @override
  _$FileMetadataCopyWith<_FileMetadata> get copyWith =>
      __$FileMetadataCopyWithImpl<_FileMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileMetadataToJson(this);
  }
}

abstract class _FileMetadata implements FileMetadata {
  const factory _FileMetadata(
      {required int sizeInBytes,
      required String mimeType,
      required String fileName,
      required String sha1Hash,
      required String? fileHashBlur}) = _$_FileMetadata;

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
  _$FileMetadataCopyWith<_FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
