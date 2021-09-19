import 'dart:io';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/graphql_api.schema.dart';
import 'package:shelf_graphql_example/schema/books.schema.dart';
import 'package:shelf_graphql_example/schema/graphql_utils.dart';
import 'package:shelf_graphql_example/schema/schema_from_json.dart';
import 'package:shelf_graphql_example/schema/star_wars/schema.dart';

import 'files.controller.dart';
import 'safe_json.dart';
import 'safe_json_graphql.dart';

GraphQLSchema makeApiSchema(FilesController filesController) {
  final simpleError = objectType<Map<String, String>>(
    'SimpleError',
    fields: [
      graphQLString.nonNull().field('code'),
      graphQLString.nonNull().field('message'),
    ],
  );

  final base = graphQLSchema(
    serdeCtx: SerdeCtx()..addAll([UploadedFileMeta.serializer]),
    queryType: objectType(
      'Queries',
      fields: [
        graphqlFieldFromJson(
          fieldName: 'json',
          jsonString: jsonPayload,
        ),
        field(
          'files',
          listOf(fileUploadType()),
          resolve: (obj, args) {
            return filesController.allFiles.values;
          },
        ),
        field(
          'fileEvents',
          listOf(fileEventType()),
          resolve: (obj, ctx) {
            final filename = ctx.args['filename'] as String?;
            return filename == null
                ? filesController.history
                : filesController.history.where(
                    (element) => element.editedFilenames().contains(filename),
                  );
          },
          inputs: [
            GraphQLFieldInput(
              'filename',
              graphQLString,
            ),
          ],
        ),
      ],
    ),
    mutationType: objectType(
      'Mutations',
      fields: [
        field(
          'addFile',
          GraphQLUnionType(
            'AddFileResult',
            [fileUploadType(), simpleError],
          ),
          resolve: (obj, ctx) async {
            final isTesting = ctx.request.headers['shelf-test'] == 'true';
            final upload = ctx.args['file'] as UploadedFile;
            final replace = ctx.args['replace'] as bool;
            final extra = ctx.args['extra'] as Json?;

            final meta = await upload.meta(extra: extra?.toJson());
            final result = filesController.consume(
              FileEvent.added(meta, replace: replace),
            );
            return result.match(
              (_) async {
                if (!isTesting) {
                  final bytes = await upload.readAsBytes();
                  final file = File(
                    pathRelativeToScript(['files', meta.filename]),
                  );
                  await file.writeAsBytes(bytes);
                }
                return meta;
              },
              (err) => {
                'code': 'CANT_REPLACE',
                'message': err,
              },
            );
            // return {
            //   'name': upload.filename,
            //   'sizeInBytes': upload.sizeInBytes,
            //   'mimeType': upload.contentType?.mimeType,
            // };
          },
          inputs: [
            GraphQLFieldInput(
              'file',
              graphQLUpload.nonNull(),
            ),
            GraphQLFieldInput(
              'replace',
              graphQLBoolean,
              defaultValue: true,
            ),
            GraphQLFieldInput(
              'extra',
              graphQLJson,
            ),
          ],
        ),
      ],
    ),
    subscriptionType: objectType(
      'Subscriptions',
      fields: [
        field(
          'files',
          listOf(fileUploadType()),
          resolve: (obj, args) {
            return filesController.fileChanges.map((event) => event.values);
          },
        ),
        field(
          'fileEvents',
          fileEventType(),
          resolve: (obj, args) {
            return filesController.events;
          },
        ),
      ],
    ),
  );

  return [
    base,
    graphqlApiSchema,
    starWarsSchema,
    makeBooksSchema(),
  ].reduce(mergeGraphQLSchemas);
}

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

String pathRelativeToScript(List<String> pathSegments) {
  return [
    '/',
    ...Platform.script.pathSegments
        .take(Platform.script.pathSegments.length - 1),
    ...pathSegments
  ].join(Platform.pathSeparator);
}
