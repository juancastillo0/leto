import 'dart:io';

import 'package:file/file.dart';
import 'package:file/local.dart' show LocalFileSystem;
import 'package:file/memory.dart' show MemoryFileSystem;
import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

final isTestingRef = RefWithDefault.global((scope) => false);
final fileSystemRef = RefWithDefault<FileSystem>.global(
  (scope) =>
      isTestingRef.get(scope) ? MemoryFileSystem() : const LocalFileSystem(),
);

Handler staticFilesHandler(GlobalsHolder globals) {
  final handler = createStaticHandler(
    pathRelativeToScript(['/']),
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  return (request) async {
    final etag = request.headers[HttpHeaders.ifNoneMatchHeader];
    String? fileHash;
    final filepath = request.params['filepath']!;
    if (filepath.startsWith('chats/')) {
      final chatController = await chatControllerRef.get(globals);

      final dbbPath = request.url.pathSegments.join('/');
      // TODO: Authorization
      final message = await chatController.messages.getByPath('/$dbbPath');
      if (message == null) {
        return Response.notFound(null);
      }
      final fileMetadata = message.metadata()?.fileMetadata;
      if (fileMetadata != null) {
        fileHash = '"${fileMetadata.sha1Hash}"';
        if (fileHash == etag) {
          return Response.notModified();
        }
      }
    }
    final response = await handler(request);
    return fileHash != null ? setEtag(response, fileHash) : response;
  };
}

String pathRelativeToScript(List<String> pathSegments) {
  return [
    '/',
    ...Platform.script.pathSegments
        .take(Platform.script.pathSegments.length - 1),
    ...pathSegments
  ].join(Platform.pathSeparator);
}
