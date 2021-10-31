import 'dart:async';

import 'package:collection/collection.dart';
import 'package:oxidized/oxidized.dart';
import 'package:shelf_graphql/shelf_graphql.dart' show UploadedFileMeta;

import 'file_event.dart';
export 'file_event.dart';

typedef VoidCallback = void Function();

class ValidatedEvent {
  final FileEvent event;
  final VoidCallback onSuccess;

  const ValidatedEvent(this.event, this.onSuccess);
}

class FilesController {
  final _allFiles = <String, UploadedFileMeta>{};
  Map<String, UploadedFileMeta> get allFiles => Map.unmodifiable(_allFiles);

  Stream<FileEvent> get events => _eventController.stream;
  late final Stream<Map<String, UploadedFileMeta>> fileChanges =
      events.map((event) => allFiles);
  List<FileEvent> get history => List.unmodifiable(_history);

  final _eventController = StreamController<FileEvent>.broadcast();
  final _history = <FileEvent>[];

  List<ValidatedEvent>? _transaction;

  Map<String, UploadedFileMeta> stateAt(int eventNum) {
    final _events = FileEvent.many(_history.sublist(0, eventNum));
    return (FilesController()..consume(_events))._allFiles;
  }

  Result<VoidCallback, String> consume(FileEvent event) {
    final initiated = _transaction == null;
    if (initiated) {
      _transaction = [];
    }
    try {
      final result = event.map(
        added: _onFileAdded,
        deleted: _onFileDeleted,
        many: _onFileMany,
        renamed: _onFileRenamed,
      );
      result.when(
        ok: (ok) {
          _transaction!.add(ValidatedEvent(event, ok));
          if (initiated) {
            _executeValidated(_transaction!);
          }
        },
        err: (_) {},
      );
      return result;
    } on String catch (e) {
      return Err(e);
    } catch (e, s) {
      return Err('$e $s');
    } finally {
      if (initiated) {
        _transaction = null;
      }
    }
  }

  Result<VoidCallback, String> _onFileAdded(FileEventAdded event) {
    final filename = event.fileUpload.filename;
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

  Result<VoidCallback, String> _onFileRenamed(FileEventRenamed event) {
    final filename = event.filename;
    final file = _allFiles[filename];
    if (file == null) {
      return Err('Not found $filename');
    }
    final toReplace = _allFiles[event.newFilename];
    if (toReplace != null) {
      if (event.replace) {
        consume(FileEvent.deleted(event.newFilename)).unwrap();
      } else {
        return Err("Can't replace ${event.newFilename}");
      }
    }
    consume(FileEvent.deleted(filename)).unwrap();

    return Ok(() {
      _allFiles[event.newFilename] = file;
    });
  }

  Result<VoidCallback, String> _onFileDeleted(FileEventDeleted event) {
    final contains = _allFiles.containsKey(event.filename);
    if (contains) {
      return Err('Not found ${event.filename}');
    }
    return Ok(() => _allFiles.remove(event.filename));
  }

  Result<VoidCallback, String> _onFileMany(FileEventMany many) {
    final _callbacks = <VoidCallback>[];
    final firstErr = many.events.map(consume).firstWhereOrNull((result) {
      return result.match(
        (ok) {
          _callbacks.add(ok);
          return false;
        },
        (err) => true,
      );
    });

    return firstErr ?? Ok(() => _callbacks.map((e) => e()));
  }

  void _executeValidated(List<ValidatedEvent> _transaction) {
    final events = _transaction.map((f) {
      f.onSuccess();
      return f.event;
    });
    final FileEvent event;
    if (events.length == 1) {
      event = events.first;
    } else {
      event = FileEvent.many(events.toList());
    }
    _history.add(event);
    _eventController.add(event);
  }
}
