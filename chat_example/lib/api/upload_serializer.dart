import 'package:built_value/serializer.dart';
import 'package:http/http.dart' show MultipartFile;

class UploadSerializer extends PrimitiveSerializer<MultipartFile> {
  @override
  MultipartFile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    assert(
      serialized is List<int>,
      "FileSerializer expected 'Uint8List' but got ${serialized.runtimeType}",
    );
    return MultipartFile.fromBytes('field', serialized as List<int>);
  }

  @override
  Object serialize(
    Serializers serializers,
    MultipartFile file, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      file;

  @override
  Iterable<Type> get types => [MultipartFile];

  @override
  String get wireName => 'Upload';
}
