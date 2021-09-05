import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http_server/http_server.dart';
import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_graphql/src/server_utils/request_from_multipart.dart';
import 'package:shelf_graphql/src/server_utils/uploaded_file.dart';

Stream<HttpMultipartFormData> extractMultiPartStream(Request request) {
  final boundary = extractMultipartBoundary(request);
  if (boundary == null) {
    throw StateError('Not a multipart request.');
  }
  return MimeMultipartTransformer(boundary)
      .bind(request.read())
      .map(HttpMultipartFormData.parse);
}

Future<MultiPartData> extractMultiPartData(Request request) async {
  final parts = extractMultiPartStream(request);
  final _bodyFields = <String, String>{};
  final _uploadedFiles = <UploadedFile>[];

  await for (final part in parts) {
    if (part.isBinary) {
      _uploadedFiles.add(UploadedFile(part));
    } else if (part.isText &&
        // If there is no name, then don't parse it.
        part.contentDisposition.parameters.containsKey('name')) {
      final key = part.contentDisposition.parameters['name']!;
      // TODO: check for files in text parts?
      // part.contentType = text/plain
      final value = await part.join();
      _bodyFields[key] = value;
    }
  }
  return MultiPartData(_bodyFields, _uploadedFiles);
}

bool isMultipartRequest(Request request) =>
    extractMultipartBoundary(request) != null;

/// Extracts the `boundary` paramete from the content-type header, if this is
/// a multipart request.
String? extractMultipartBoundary(Request request) {
  if (!request.headers.containsKey('Content-Type')) return null;

  final contentType = MediaType.parse(request.headers['Content-Type']!);
  if (contentType.type != 'multipart') return null;

  return contentType.parameters['boundary'];
}
