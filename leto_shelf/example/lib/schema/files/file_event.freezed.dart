// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileEvent _$FileEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'added':
      return FileEventAdded.fromJson(json);
    case 'renamed':
      return FileEventRenamed.fromJson(json);
    case 'deleted':
      return FileEventDeleted.fromJson(json);
    case 'many':
      return FileEventMany.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'FileEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$FileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFileMeta fileUpload, bool replace) added,
    required TResult Function(String filename, String newFilename, bool replace)
        renamed,
    required TResult Function(String filename) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult? Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult? Function(String filename)? deleted,
    TResult? Function(List<FileEvent> events)? many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult Function(String filename)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventRenamed value) renamed,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileEventAdded value)? added,
    TResult? Function(FileEventRenamed value)? renamed,
    TResult? Function(FileEventDeleted value)? deleted,
    TResult? Function(FileEventMany value)? many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventRenamed value)? renamed,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileEventCopyWith<$Res> {
  factory $FileEventCopyWith(FileEvent value, $Res Function(FileEvent) then) =
      _$FileEventCopyWithImpl<$Res, FileEvent>;
}

/// @nodoc
class _$FileEventCopyWithImpl<$Res, $Val extends FileEvent>
    implements $FileEventCopyWith<$Res> {
  _$FileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FileEventAddedCopyWith<$Res> {
  factory _$$FileEventAddedCopyWith(
          _$FileEventAdded value, $Res Function(_$FileEventAdded) then) =
      __$$FileEventAddedCopyWithImpl<$Res>;
  @useResult
  $Res call({UploadedFileMeta fileUpload, bool replace});
}

/// @nodoc
class __$$FileEventAddedCopyWithImpl<$Res>
    extends _$FileEventCopyWithImpl<$Res, _$FileEventAdded>
    implements _$$FileEventAddedCopyWith<$Res> {
  __$$FileEventAddedCopyWithImpl(
      _$FileEventAdded _value, $Res Function(_$FileEventAdded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileUpload = null,
    Object? replace = null,
  }) {
    return _then(_$FileEventAdded(
      null == fileUpload
          ? _value.fileUpload
          : fileUpload // ignore: cast_nullable_to_non_nullable
              as UploadedFileMeta,
      replace: null == replace
          ? _value.replace
          : replace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileEventAdded extends FileEventAdded {
  const _$FileEventAdded(this.fileUpload,
      {this.replace = true, final String? $type})
      : $type = $type ?? 'added',
        super._();

  factory _$FileEventAdded.fromJson(Map<String, dynamic> json) =>
      _$$FileEventAddedFromJson(json);

  @override
  final UploadedFileMeta fileUpload;
  @override
  @JsonKey()
  final bool replace;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileEvent.added(fileUpload: $fileUpload, replace: $replace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileEventAdded &&
            (identical(other.fileUpload, fileUpload) ||
                other.fileUpload == fileUpload) &&
            (identical(other.replace, replace) || other.replace == replace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileUpload, replace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileEventAddedCopyWith<_$FileEventAdded> get copyWith =>
      __$$FileEventAddedCopyWithImpl<_$FileEventAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFileMeta fileUpload, bool replace) added,
    required TResult Function(String filename, String newFilename, bool replace)
        renamed,
    required TResult Function(String filename) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return added(fileUpload, replace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult? Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult? Function(String filename)? deleted,
    TResult? Function(List<FileEvent> events)? many,
  }) {
    return added?.call(fileUpload, replace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult Function(String filename)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(fileUpload, replace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventRenamed value) renamed,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileEventAdded value)? added,
    TResult? Function(FileEventRenamed value)? renamed,
    TResult? Function(FileEventDeleted value)? deleted,
    TResult? Function(FileEventMany value)? many,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventRenamed value)? renamed,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileEventAddedToJson(
      this,
    );
  }
}

abstract class FileEventAdded extends FileEvent {
  const factory FileEventAdded(final UploadedFileMeta fileUpload,
      {final bool replace}) = _$FileEventAdded;
  const FileEventAdded._() : super._();

  factory FileEventAdded.fromJson(Map<String, dynamic> json) =
      _$FileEventAdded.fromJson;

  UploadedFileMeta get fileUpload;
  bool get replace;
  @JsonKey(ignore: true)
  _$$FileEventAddedCopyWith<_$FileEventAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileEventRenamedCopyWith<$Res> {
  factory _$$FileEventRenamedCopyWith(
          _$FileEventRenamed value, $Res Function(_$FileEventRenamed) then) =
      __$$FileEventRenamedCopyWithImpl<$Res>;
  @useResult
  $Res call({String filename, String newFilename, bool replace});
}

/// @nodoc
class __$$FileEventRenamedCopyWithImpl<$Res>
    extends _$FileEventCopyWithImpl<$Res, _$FileEventRenamed>
    implements _$$FileEventRenamedCopyWith<$Res> {
  __$$FileEventRenamedCopyWithImpl(
      _$FileEventRenamed _value, $Res Function(_$FileEventRenamed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? newFilename = null,
    Object? replace = null,
  }) {
    return _then(_$FileEventRenamed(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      newFilename: null == newFilename
          ? _value.newFilename
          : newFilename // ignore: cast_nullable_to_non_nullable
              as String,
      replace: null == replace
          ? _value.replace
          : replace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileEventRenamed extends FileEventRenamed {
  const _$FileEventRenamed(
      {required this.filename,
      required this.newFilename,
      this.replace = true,
      final String? $type})
      : $type = $type ?? 'renamed',
        super._();

  factory _$FileEventRenamed.fromJson(Map<String, dynamic> json) =>
      _$$FileEventRenamedFromJson(json);

  @override
  final String filename;
  @override
  final String newFilename;
  @override
  @JsonKey()
  final bool replace;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileEvent.renamed(filename: $filename, newFilename: $newFilename, replace: $replace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileEventRenamed &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.newFilename, newFilename) ||
                other.newFilename == newFilename) &&
            (identical(other.replace, replace) || other.replace == replace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, filename, newFilename, replace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileEventRenamedCopyWith<_$FileEventRenamed> get copyWith =>
      __$$FileEventRenamedCopyWithImpl<_$FileEventRenamed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFileMeta fileUpload, bool replace) added,
    required TResult Function(String filename, String newFilename, bool replace)
        renamed,
    required TResult Function(String filename) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return renamed(filename, newFilename, replace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult? Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult? Function(String filename)? deleted,
    TResult? Function(List<FileEvent> events)? many,
  }) {
    return renamed?.call(filename, newFilename, replace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult Function(String filename)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) {
    if (renamed != null) {
      return renamed(filename, newFilename, replace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventRenamed value) renamed,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return renamed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileEventAdded value)? added,
    TResult? Function(FileEventRenamed value)? renamed,
    TResult? Function(FileEventDeleted value)? deleted,
    TResult? Function(FileEventMany value)? many,
  }) {
    return renamed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventRenamed value)? renamed,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (renamed != null) {
      return renamed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileEventRenamedToJson(
      this,
    );
  }
}

abstract class FileEventRenamed extends FileEvent {
  const factory FileEventRenamed(
      {required final String filename,
      required final String newFilename,
      final bool replace}) = _$FileEventRenamed;
  const FileEventRenamed._() : super._();

  factory FileEventRenamed.fromJson(Map<String, dynamic> json) =
      _$FileEventRenamed.fromJson;

  String get filename;
  String get newFilename;
  bool get replace;
  @JsonKey(ignore: true)
  _$$FileEventRenamedCopyWith<_$FileEventRenamed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileEventDeletedCopyWith<$Res> {
  factory _$$FileEventDeletedCopyWith(
          _$FileEventDeleted value, $Res Function(_$FileEventDeleted) then) =
      __$$FileEventDeletedCopyWithImpl<$Res>;
  @useResult
  $Res call({String filename});
}

/// @nodoc
class __$$FileEventDeletedCopyWithImpl<$Res>
    extends _$FileEventCopyWithImpl<$Res, _$FileEventDeleted>
    implements _$$FileEventDeletedCopyWith<$Res> {
  __$$FileEventDeletedCopyWithImpl(
      _$FileEventDeleted _value, $Res Function(_$FileEventDeleted) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
  }) {
    return _then(_$FileEventDeleted(
      null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileEventDeleted extends FileEventDeleted {
  const _$FileEventDeleted(this.filename, {final String? $type})
      : $type = $type ?? 'deleted',
        super._();

  factory _$FileEventDeleted.fromJson(Map<String, dynamic> json) =>
      _$$FileEventDeletedFromJson(json);

  @override
  final String filename;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileEvent.deleted(filename: $filename)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileEventDeleted &&
            (identical(other.filename, filename) ||
                other.filename == filename));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, filename);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileEventDeletedCopyWith<_$FileEventDeleted> get copyWith =>
      __$$FileEventDeletedCopyWithImpl<_$FileEventDeleted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFileMeta fileUpload, bool replace) added,
    required TResult Function(String filename, String newFilename, bool replace)
        renamed,
    required TResult Function(String filename) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return deleted(filename);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult? Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult? Function(String filename)? deleted,
    TResult? Function(List<FileEvent> events)? many,
  }) {
    return deleted?.call(filename);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult Function(String filename)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(filename);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventRenamed value) renamed,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileEventAdded value)? added,
    TResult? Function(FileEventRenamed value)? renamed,
    TResult? Function(FileEventDeleted value)? deleted,
    TResult? Function(FileEventMany value)? many,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventRenamed value)? renamed,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileEventDeletedToJson(
      this,
    );
  }
}

abstract class FileEventDeleted extends FileEvent {
  const factory FileEventDeleted(final String filename) = _$FileEventDeleted;
  const FileEventDeleted._() : super._();

  factory FileEventDeleted.fromJson(Map<String, dynamic> json) =
      _$FileEventDeleted.fromJson;

  String get filename;
  @JsonKey(ignore: true)
  _$$FileEventDeletedCopyWith<_$FileEventDeleted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileEventManyCopyWith<$Res> {
  factory _$$FileEventManyCopyWith(
          _$FileEventMany value, $Res Function(_$FileEventMany) then) =
      __$$FileEventManyCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FileEvent> events});
}

/// @nodoc
class __$$FileEventManyCopyWithImpl<$Res>
    extends _$FileEventCopyWithImpl<$Res, _$FileEventMany>
    implements _$$FileEventManyCopyWith<$Res> {
  __$$FileEventManyCopyWithImpl(
      _$FileEventMany _value, $Res Function(_$FileEventMany) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
  }) {
    return _then(_$FileEventMany(
      null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<FileEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileEventMany extends FileEventMany {
  const _$FileEventMany(final List<FileEvent> events, {final String? $type})
      : _events = events,
        $type = $type ?? 'many',
        super._();

  factory _$FileEventMany.fromJson(Map<String, dynamic> json) =>
      _$$FileEventManyFromJson(json);

  final List<FileEvent> _events;
  @override
  List<FileEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileEvent.many(events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileEventMany &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_events));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileEventManyCopyWith<_$FileEventMany> get copyWith =>
      __$$FileEventManyCopyWithImpl<_$FileEventMany>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFileMeta fileUpload, bool replace) added,
    required TResult Function(String filename, String newFilename, bool replace)
        renamed,
    required TResult Function(String filename) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return many(events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult? Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult? Function(String filename)? deleted,
    TResult? Function(List<FileEvent> events)? many,
  }) {
    return many?.call(events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFileMeta fileUpload, bool replace)? added,
    TResult Function(String filename, String newFilename, bool replace)?
        renamed,
    TResult Function(String filename)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) {
    if (many != null) {
      return many(events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventRenamed value) renamed,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return many(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileEventAdded value)? added,
    TResult? Function(FileEventRenamed value)? renamed,
    TResult? Function(FileEventDeleted value)? deleted,
    TResult? Function(FileEventMany value)? many,
  }) {
    return many?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventRenamed value)? renamed,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (many != null) {
      return many(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileEventManyToJson(
      this,
    );
  }
}

abstract class FileEventMany extends FileEvent {
  const factory FileEventMany(final List<FileEvent> events) = _$FileEventMany;
  const FileEventMany._() : super._();

  factory FileEventMany.fromJson(Map<String, dynamic> json) =
      _$FileEventMany.fromJson;

  List<FileEvent> get events;
  @JsonKey(ignore: true)
  _$$FileEventManyCopyWith<_$FileEventMany> get copyWith =>
      throw _privateConstructorUsedError;
}
