import 'package:graphql_schema/graphql_schema.dart';

import 'uploaded_file.dart';

/// The canonical [GraphQLUploadType] instance.
final GraphQLUploadType graphQLUpload = GraphQLUploadType();

/// A [GraphQLScalarType] that is used to read uploaded files from
/// `multipart/form-data` requests.
class GraphQLUploadType extends GraphQLScalarType<UploadedFile, UploadedFile> {
  @override
  String get name => 'Upload';

  @override
  String get description =>
      'Represents a file from a `multipart/form-data` request.';

  @override
  String get specifiedByURL =>
      'https://github.com/jaydenseric/graphql-multipart-request-spec';

  @override
  GraphQLType<UploadedFile, UploadedFile> coerceToInputObject() => this;

  @override
  UploadedFile deserialize(SerdeCtx serdeCtx, UploadedFile serialized) =>
      serialized;

  @override
  UploadedFile serialize(UploadedFile value) => value;

  @override
  ValidationResult<UploadedFile> validate(String key, Object? input) {
    if (input is UploadedFile) {
      return ValidationResult.ok(input);
    }
    return ValidationResult.failure(['Expected "$key" to be an Upload.']);
  }

  @override
  Iterable<Object?> get props => [];
}
