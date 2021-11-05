import 'dart:convert';
import 'dart:io';

import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:leto_shelf/leto_shelf.dart';
import 'package:leto_shelf_example/graphql_api.schema.dart';
import 'package:leto_shelf_example/schema/books/books.schema.dart';
import 'package:leto_shelf_example/schema/files/file_metadata.dart';
import 'package:leto_shelf_example/schema/graphql_utils.dart';
import 'package:leto_shelf_example/schema/schema_from_json.dart';
import 'package:leto_shelf_example/schema/star_wars/schema.dart';
import 'package:leto_shelf_example/schema/star_wars_relay/data.dart';

import 'files/file_upload.dart';
import 'files/files.controller.dart';

GraphQLSchema makeApiSchema(FilesController filesController) {
  final simpleError = objectType<Map<String, String>>(
    'SimpleError',
    fields: [
      graphQLString.nonNull().field('code'),
      graphQLString.nonNull().field('message'),
    ],
  );

  String? _schemaString;

  final base = GraphQLSchema(
    serdeCtx: SerdeCtx()..addAll([UploadedFileMeta.serializer]),
    queryType: objectType(
      'Queries',
      fields: [
        graphQLString.nonNull().field(
          'apiSchema',
          description: "The api's GraphQL schema in the"
              ' GraphQL Schema Definition Language (SDL).',
          resolve: (obj, ctx) {
            return _schemaString ??= printSchema(ctx.baseCtx.schema);
          },
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
            final upload = ctx.args['file'] as Upload;
            final replace = ctx.args['replace'] as bool;
            final extra = ctx.args['extra'] as Json?;

            final meta = await UploadedFileMeta.fromUpload(
              upload,
              extra: extra?.toJson(),
            );
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
              uploadGraphQLType.nonNull(),
            ),
            GraphQLFieldInput(
              'replace',
              graphQLBoolean,
              defaultValue: true,
            ),
            GraphQLFieldInput(
              'extra',
              jsonGraphQLType,
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
    relayStarWarsSchema,
    schemaFromJson(
      fieldName: 'JsonTest',
      jsonString: jsonPayload,
      idFields: {
        'JsonTest': {'id'}
      },
    ),
    schemaFromJson(
      fieldName: 'TodoJsonTest',
      jsonString: jsonEncode({
        'Todo1': [
          {
            'code': 'pso1',
            'name': 'ba',
            'assigned': null,
            'done': false,
            'created': DateTime.now().toIso8601String(),
          },
          {
            'code': 'pso2',
            'name': 'ba',
            'assigned': '@ref:User1:apoxaw',
            'done': true,
            'created': DateTime.now()
                .subtract(const Duration(hours: 2))
                .toIso8601String(),
          },
        ],
      }),
      idFields: {
        'Todo1': {'code'}
      },
    ),
  ].reduce(mergeGraphQLSchemas);
}

String pathRelativeToScript(List<String> pathSegments) {
  return [
    '/',
    ...Platform.script.pathSegments
        .take(Platform.script.pathSegments.length - 1),
    ...pathSegments
  ].join(Platform.pathSeparator);
}
