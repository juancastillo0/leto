import 'package:leto_schema/leto_schema.dart';

import 'uploaded_file.dart';

/// The canonical [GraphQLUploadType] instance.
final GraphQLUploadType uploadGraphQLType = GraphQLUploadType();

/// A [GraphQLScalarType] that is used to read uploaded files from
/// `multipart/form-data` requests.
class GraphQLUploadType extends GraphQLScalarType<Upload, Upload> {
  @override
  String get name => 'Upload';

  @override
  String get description =>
      'Represents a file from a `multipart/form-data` request.';

  @override
  String get specifiedByURL =>
      'https://github.com/jaydenseric/graphql-multipart-request-spec';

  @override
  GraphQLType<Upload, Upload> coerceToInputObject() => this;

  @override
  Upload deserialize(SerdeCtx serdeCtx, Upload serialized) => serialized;

  @override
  Upload serialize(Upload value) => value;

  @override
  ValidationResult<Upload> validate(String key, Object? input) {
    if (input is Upload) {
      return ValidationResult.ok(input);
    }
    return ValidationResult.failure(['Expected "$key" to be an Upload.']);
  }
}
