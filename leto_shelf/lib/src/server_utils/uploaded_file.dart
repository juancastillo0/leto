import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:http_server/http_server.dart';

import 'graphql_upload.dart';

export 'graphql_upload.dart';

/// Reads information about a binary chunk uploaded to the server.
class Upload {
  /// The underlying `form-data` item.
  final HttpMultipartFormData formData;
  DateTime createdAt;

  Upload(this.formData, {DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();

  List<List<int>>? _buffer;

  /// Returns the binary stream from [formData].
  Stream<List<int>> get data {
    if (_buffer == null) {
      _buffer = [];

      return formData.cast<List<int>>().map((event) {
        _buffer!.add(event);
        return event;
      });
    }
    return Stream.fromIterable(_buffer!);
  }

  /// The filename associated with the data on the user's system.
  /// Returns null if not present.
  String? get filename => formData.contentDisposition.parameters['filename'];

  /// The name of the field associated with this data.
  /// Returns null if not present.
  String? get name => formData.contentDisposition.parameters['name'];

  MediaType? _contentType;

  /// The parsed Content-Type header of the [HttpMultipartFormData].
  /// Returns null if not present.
  MediaType? get contentType => _contentType ??= formData.contentType == null
      ? null
      : MediaType.parse(formData.contentType.toString());

  /// The parsed Content-Transfer-Encoding header of the
  /// [HttpMultipartFormData]. This field is used to determine how to decode
  /// the data. Returns nullÎ if not present.
  HeaderValue? get contentTransferEncoding => formData.contentTransferEncoding;

  FutureOr<int>? _sizeInBytes;

  FutureOr<int> get sizeInBytes {
    if (_sizeInBytes != null) {
      return _sizeInBytes!;
    }

    _sizeInBytes ??= readAsBytes().then((value) => value.lengthInBytes);
    return _sizeInBytes!;
  }

  /// Reads the contents of the file into a single linear buffer.
  ///
  /// Note that this leads to holding the whole file in memory, which might
  /// not be ideal for large files.
  Future<Uint8List> readAsBytes() {
    return data
        .fold<BytesBuilder>(BytesBuilder(), (bb, out) => bb..add(out))
        .then((bb) => bb.takeBytes());
  }

  /// Reads the contents of the file as [String], using the given [encoding].
  Future<String> readAsString({Encoding encoding = utf8}) {
    return encoding.decoder.bind(data).join();
  }

  static GraphQLUploadType graphQLType = uploadGraphQLType;
}
