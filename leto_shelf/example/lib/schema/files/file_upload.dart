import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/types/safe_json_graphql.dart';

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
      graphQLJson.field('extra'),
      graphQLString.nonNull().field(
        'url',
        resolve: (file, ctx) {
          return 'http://localhost:8060/files/${file.filename}';
        },
      ),
    ],
  );
}
