import 'package:graphql_schema/graphql_schema.dart';
import 'package:shelf_graphql/shelf_graphql.dart';

import 'books.controller.dart';

GraphQLSchema makeApiSchema() {
  final controller = BooksController();

  final _bookType = bookType();

  final mappedBooksStream = controller.stream.map(booksToJson);
  final bookAddedStream = controller.bookAddedStream.map(
    (event) => event.toJson(),
  );
  bookAddedStream.listen((d) {
    print('bookAddedStream $d');
  });

  return graphQLSchema(
    queryType: objectType(
      'Queries',
      fields: [
        field(
          'books',
          listOf(_bookType),
          resolve: (obj, args) {
            return booksToJson(controller.allBooks);
          },
        ),
      ],
    ),
    mutationType: objectType(
      'Mutations',
      fields: [
        field(
          'createBook',
          _bookType,
          resolve: (obj, args) {
            final book = Book(
              name: args['name'] as String,
              publicationDate: DateTime.now(),
              isFavourite: false,
            );
            controller.add(book);
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
          'addFileCommand',
          fileUploadType(),
          resolve: (obj, args) {
            final upload = args['file'] as UploadedFile;
            return {
              'name': upload.filename,
              'sizeInBytes': upload.sizeInBytes,
              'mimeType': upload.contentType?.mimeType,
            };
          },
          inputs: [
            GraphQLFieldInput(
              'file',
              graphQLUpload.nonNullable(),
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

GraphQLObjectType<Map<String, Object?>> fileUploadType() {
  return objectType(
    'FileUpload',
    fields: [
      graphQLString.field(
        'name',
        nullable: false,
      ),
      graphQLInt.field(
        'sizeInBytes',
        nullable: false,
      ),
      graphQLString.field(
        'mimeType',
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
