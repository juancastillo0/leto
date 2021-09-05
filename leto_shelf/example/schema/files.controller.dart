import 'dart:async';
import 'dart:html';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:shelf_graphql/shelf_graphql.dart' show UploadedFile;

part 'files.controller.freezed.dart';

@freezed
class FileEvent with _$FileEvent {
  const factory FileEvent.added(
    UploadedFile fileUpload, {
    @Default(true) bool replace,
  }) = FileEventAdded;
  const factory FileEvent.deleted(
    String fileName,
  ) = FileEventDeleted;

  const factory FileEvent.many(
    List<FileEvent> events,
  ) = FileEventMany;
}

class FilesController {
  final _allFiles = <String, UploadedFile>{};
  Map<String, UploadedFile> get allFiles => Map.unmodifiable(_allFiles);

  Stream<FileEvent> get events => _eventController.stream;
  Stream<Map<String, UploadedFile>> get fileChanges =>
      _eventController.stream.map((event) => _allFiles);

  final _eventController = StreamController<FileEvent>.broadcast();

  List<FileEvent>? _transaction;

  Result<VoidCallback, String> consume(FileEvent event) {
    bool initiated = _transaction == null;
    if (initiated) {
      _transaction = [];
    }
    try {
      final result = event.map(
        added: _onFileAdded,
        deleted: _onFileDeleted,
        many: _onFileMany,
      );
      result.when(
        ok: (ok) {
          return ok();
        },
        err: (err) => err,
      );
      return result;
    } catch (e, s) {
      return Err('$e $s');
    } finally {
      if (initiated) {
        _transaction = null;
      }
    }
  }

  Result<VoidCallback, String> _onFileAdded(FileEventAdded event) {
    final filename = event.fileUpload.filename!;
    final previous = _allFiles[filename];
    if (previous != null) {
      if (event.replace) {
        consume(FileEvent.deleted(filename)).unwrap();
      } else {
        return Err("Can't replace $filename");
      }
    }

    return Ok(() => _allFiles[filename] = event.fileUpload);
  }

  Result<VoidCallback, String> _onFileDeleted(FileEventDeleted event) {
    final contains = _allFiles.containsKey(event.fileName);
    if (contains) {
      return Err('Not found ${event.fileName}');
    }
    return Ok(() => _allFiles.remove(event.fileName));
  }

  Result<VoidCallback, String> _onFileMany(FileEventMany many) {
    final _callbacks = <VoidCallback>[];
    final firstErr = many.events.map(consume).firstWhereOrNull(
      (element) {
        return element.match(
          (ok) {
            _callbacks.add(ok);
            return false;
          },
          (err) => true,
        );
      },
    );

    return firstErr ?? Ok(() => _callbacks.map((e) => e()));
  }
}
