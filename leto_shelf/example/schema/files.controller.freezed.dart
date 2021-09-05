// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'files.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FileEventTearOff {
  const _$FileEventTearOff();

  FileEventAdded added(UploadedFile fileUpload, {bool replace = true}) {
    return FileEventAdded(
      fileUpload,
      replace: replace,
    );
  }

  FileEventDeleted deleted(String fileName) {
    return FileEventDeleted(
      fileName,
    );
  }

  FileEventMany many(List<FileEvent> events) {
    return FileEventMany(
      events,
    );
  }
}

/// @nodoc
const $FileEvent = _$FileEventTearOff();

/// @nodoc
mixin _$FileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFile fileUpload, bool replace) added,
    required TResult Function(String fileName) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileEventCopyWith<$Res> {
  factory $FileEventCopyWith(FileEvent value, $Res Function(FileEvent) then) =
      _$FileEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$FileEventCopyWithImpl<$Res> implements $FileEventCopyWith<$Res> {
  _$FileEventCopyWithImpl(this._value, this._then);

  final FileEvent _value;
  // ignore: unused_field
  final $Res Function(FileEvent) _then;
}

/// @nodoc
abstract class $FileEventAddedCopyWith<$Res> {
  factory $FileEventAddedCopyWith(
          FileEventAdded value, $Res Function(FileEventAdded) then) =
      _$FileEventAddedCopyWithImpl<$Res>;
  $Res call({UploadedFile fileUpload, bool replace});
}

/// @nodoc
class _$FileEventAddedCopyWithImpl<$Res> extends _$FileEventCopyWithImpl<$Res>
    implements $FileEventAddedCopyWith<$Res> {
  _$FileEventAddedCopyWithImpl(
      FileEventAdded _value, $Res Function(FileEventAdded) _then)
      : super(_value, (v) => _then(v as FileEventAdded));

  @override
  FileEventAdded get _value => super._value as FileEventAdded;

  @override
  $Res call({
    Object? fileUpload = freezed,
    Object? replace = freezed,
  }) {
    return _then(FileEventAdded(
      fileUpload == freezed
          ? _value.fileUpload
          : fileUpload // ignore: cast_nullable_to_non_nullable
              as UploadedFile,
      replace: replace == freezed
          ? _value.replace
          : replace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FileEventAdded implements FileEventAdded {
  const _$FileEventAdded(this.fileUpload, {this.replace = true});

  @override
  final UploadedFile fileUpload;
  @JsonKey(defaultValue: true)
  @override
  final bool replace;

  @override
  String toString() {
    return 'FileEvent.added(fileUpload: $fileUpload, replace: $replace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileEventAdded &&
            (identical(other.fileUpload, fileUpload) ||
                const DeepCollectionEquality()
                    .equals(other.fileUpload, fileUpload)) &&
            (identical(other.replace, replace) ||
                const DeepCollectionEquality().equals(other.replace, replace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(fileUpload) ^
      const DeepCollectionEquality().hash(replace);

  @JsonKey(ignore: true)
  @override
  $FileEventAddedCopyWith<FileEventAdded> get copyWith =>
      _$FileEventAddedCopyWithImpl<FileEventAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFile fileUpload, bool replace) added,
    required TResult Function(String fileName) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return added(fileUpload, replace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
  }) {
    return added?.call(fileUpload, replace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
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
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class FileEventAdded implements FileEvent {
  const factory FileEventAdded(UploadedFile fileUpload, {bool replace}) =
      _$FileEventAdded;

  UploadedFile get fileUpload => throw _privateConstructorUsedError;
  bool get replace => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileEventAddedCopyWith<FileEventAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileEventDeletedCopyWith<$Res> {
  factory $FileEventDeletedCopyWith(
          FileEventDeleted value, $Res Function(FileEventDeleted) then) =
      _$FileEventDeletedCopyWithImpl<$Res>;
  $Res call({String fileName});
}

/// @nodoc
class _$FileEventDeletedCopyWithImpl<$Res> extends _$FileEventCopyWithImpl<$Res>
    implements $FileEventDeletedCopyWith<$Res> {
  _$FileEventDeletedCopyWithImpl(
      FileEventDeleted _value, $Res Function(FileEventDeleted) _then)
      : super(_value, (v) => _then(v as FileEventDeleted));

  @override
  FileEventDeleted get _value => super._value as FileEventDeleted;

  @override
  $Res call({
    Object? fileName = freezed,
  }) {
    return _then(FileEventDeleted(
      fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FileEventDeleted implements FileEventDeleted {
  const _$FileEventDeleted(this.fileName);

  @override
  final String fileName;

  @override
  String toString() {
    return 'FileEvent.deleted(fileName: $fileName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileEventDeleted &&
            (identical(other.fileName, fileName) ||
                const DeepCollectionEquality()
                    .equals(other.fileName, fileName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fileName);

  @JsonKey(ignore: true)
  @override
  $FileEventDeletedCopyWith<FileEventDeleted> get copyWith =>
      _$FileEventDeletedCopyWithImpl<FileEventDeleted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFile fileUpload, bool replace) added,
    required TResult Function(String fileName) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return deleted(fileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
  }) {
    return deleted?.call(fileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(fileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileEventAdded value) added,
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class FileEventDeleted implements FileEvent {
  const factory FileEventDeleted(String fileName) = _$FileEventDeleted;

  String get fileName => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileEventDeletedCopyWith<FileEventDeleted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileEventManyCopyWith<$Res> {
  factory $FileEventManyCopyWith(
          FileEventMany value, $Res Function(FileEventMany) then) =
      _$FileEventManyCopyWithImpl<$Res>;
  $Res call({List<FileEvent> events});
}

/// @nodoc
class _$FileEventManyCopyWithImpl<$Res> extends _$FileEventCopyWithImpl<$Res>
    implements $FileEventManyCopyWith<$Res> {
  _$FileEventManyCopyWithImpl(
      FileEventMany _value, $Res Function(FileEventMany) _then)
      : super(_value, (v) => _then(v as FileEventMany));

  @override
  FileEventMany get _value => super._value as FileEventMany;

  @override
  $Res call({
    Object? events = freezed,
  }) {
    return _then(FileEventMany(
      events == freezed
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<FileEvent>,
    ));
  }
}

/// @nodoc

class _$FileEventMany implements FileEventMany {
  const _$FileEventMany(this.events);

  @override
  final List<FileEvent> events;

  @override
  String toString() {
    return 'FileEvent.many(events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileEventMany &&
            (identical(other.events, events) ||
                const DeepCollectionEquality().equals(other.events, events)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(events);

  @JsonKey(ignore: true)
  @override
  $FileEventManyCopyWith<FileEventMany> get copyWith =>
      _$FileEventManyCopyWithImpl<FileEventMany>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadedFile fileUpload, bool replace) added,
    required TResult Function(String fileName) deleted,
    required TResult Function(List<FileEvent> events) many,
  }) {
    return many(events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
    TResult Function(List<FileEvent> events)? many,
  }) {
    return many?.call(events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadedFile fileUpload, bool replace)? added,
    TResult Function(String fileName)? deleted,
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
    required TResult Function(FileEventDeleted value) deleted,
    required TResult Function(FileEventMany value) many,
  }) {
    return many(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
  }) {
    return many?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileEventAdded value)? added,
    TResult Function(FileEventDeleted value)? deleted,
    TResult Function(FileEventMany value)? many,
    required TResult orElse(),
  }) {
    if (many != null) {
      return many(this);
    }
    return orElse();
  }
}

abstract class FileEventMany implements FileEvent {
  const factory FileEventMany(List<FileEvent> events) = _$FileEventMany;

  List<FileEvent> get events => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileEventManyCopyWith<FileEventMany> get copyWith =>
      throw _privateConstructorUsedError;
}
