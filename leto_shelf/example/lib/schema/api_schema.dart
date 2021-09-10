import 'dart:io';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/schema_from_json.dart';

import 'books.controller.dart';
import 'files.controller.dart';
import 'safe_json.dart';
import 'safe_json_graphql.dart';

GraphQLSchema makeApiSchema(FilesController filesController) {
  final books = BooksController();

  final _bookType = bookType();

  final mappedBooksStream = books.stream.map(booksToJson);
  final bookAddedStream = books.bookAddedStream.map(
    (event) => event.toJson(),
  );
  bookAddedStream.listen((d) {
    print('bookAddedStream $d');
  });

  final simpleError = objectType<Map<String, String>>(
    'SimpleError',
    fields: [
      graphQLString.field('code', nullable: false),
      graphQLString.field('message', nullable: false),
    ],
  );

  return graphQLSchema(
    serdeCtx: SerdeCtx()..addAll([UploadedFileMeta.serializer]),
    queryType: objectType(
      'Queries',
      fields: [
        graphqlFieldFromJson(
          fieldName: 'json',
          jsonString: jsonPayload,
        ),
        field(
          'books',
          listOf(_bookType),
          resolve: (obj, args) {
            return booksToJson(books.allBooks);
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
          'createBook',
          _bookType,
          resolve: (obj, ctx) {
            final book = Book(
              name: ctx.args['name'] as String,
              publicationDate: DateTime.now(),
              isFavourite: false,
            );
            books.add(book);
            return book.toJson();
          },
          inputs: [
            GraphQLFieldInput(
              'name',
              graphQLString.nonNullable(),
            ),
          ],
        ),
        field(
          'addFile',
          GraphQLUnionType(
            'AddFileResult',
            [fileUploadType(), simpleError],
          ),
          resolve: (obj, ctx) async {
            final upload = ctx.args['file'] as UploadedFile;
            final replace = ctx.args['replace'] as bool;
            final extra = ctx.args['extra'] as Json?;

            final meta = await upload.meta(extra: extra?.toJson());
            final result = filesController.consume(
              FileEvent.added(meta, replace: replace),
            );
            return result.match(
              (_) async {
                final bytes = await upload.readAsBytes();
                final file = File(
                  relativeToScriptPath(['files', meta.filename]),
                );
                await file.writeAsBytes(bytes);
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
              graphQLUpload.nonNullable(),
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
          'books',
          listOf(_bookType),
          resolve: (obj, args) {
            return mappedBooksStream;
          },
        ),
        field(
          'bookAdded',
          bookAddedType(_bookType),
          resolve: (obj, args) {
            return bookAddedStream;
          },
        ),
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
}

GraphQLObjectType<Book> bookType() {
  return objectType(
    'Book',
    fields: [
      graphQLString.field(
        'name',
        nullable: false,
      ),
      graphQLDate.field(
        'publicationDate',
        nullable: false,
      ),
      graphQLBoolean.field(
        'isFavourite',
        nullable: false,
      ),
    ],
  );
}

GraphQLObjectType<UploadedFileMeta>? _fileUploadType;
GraphQLObjectType<UploadedFileMeta> fileUploadType() {
  return _fileUploadType ??= objectType(
    'FileUpload',
    fields: [
      graphQLString.field(
        'filename',
        nullable: false,
      ),
      graphQLInt.field(
        'sizeInBytes',
        nullable: false,
      ),
      graphQLString.field(
        'mimeType',
        nullable: false,
      ),
      graphQLDate.field(
        'createdAt',
        nullable: false,
      ),
      graphQLString.field(
        'sha1Hash',
        nullable: false,
      ),
      graphQLJson.field('extra'),
      graphQLString.field(
        'url',
        nullable: false,
        resolve: (file, ctx) => 'http://localhost:8060/files/${file.filename}',
      ),
    ],
  );
}

GraphQLObjectType<BookAdded> bookAddedType(GraphQLObjectType book) {
  return objectType(
    'BookAdded',
    fields: [
      field(
        'book',
        book,
        resolve: (obj, args) {
          print(' BookAdded obj $obj ${obj.runtimeType} $args');
          return obj.book.toJson();
        },
      ),
    ],
  );
}

String relativeToScriptPath(List<String> pathSegments) {
  return [
    '/',
    ...Platform.script.pathSegments
        .take(Platform.script.pathSegments.length - 1),
    ...pathSegments
  ].join(Platform.pathSeparator);
}
