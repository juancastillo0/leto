import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf_example/schema/files/file_metadata.dart';
import 'package:leto_shelf_example/types/safe_json_graphql.dart';

GraphQLObjectType<UploadedFileMeta>? _fileUploadType;
GraphQLObjectType<UploadedFileMeta> fileUploadType() {
  return _fileUploadType ??= objectType(
    'FileUpload',
    fields: [
      graphQLString.nonNull().field('filename'),
      graphQLInt.nonNull().field('sizeInBytes'),
      graphQLString.nonNull().field('mimeType'),
      graphQLDate.nonNull().field('createdAt'),
      graphQLString.nonNull().field('sha1Hash'),
      jsonGraphQLType.field('extra'),
      graphQLString.nonNull().field(
        'url',
        resolve: (file, ctx) {
          return 'http://localhost:8060/files/${file.filename}';
        },
      ),
    ],
  );
}
