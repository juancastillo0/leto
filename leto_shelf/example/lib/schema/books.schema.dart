import 'package:shelf_graphql/shelf_graphql.dart';

import 'books.controller.dart';

GraphQLSchema makeBooksSchema() {
  BooksController books(ReqCtx<Object> ctx) => getBooksController(ctx);

  final _bookType = bookType();

  // final mappedBooksStream = books.stream.map(booksToJson);
  // final bookAddedStream = books.bookAddedStream.map(
  //   (event) => event.toJson(),
  // );
  // bookAddedStream.listen((d) {
  //   print('bookAddedStream $d');
  // });

  return graphQLSchema(
    queryType: objectType(
      'Queries',
      fields: [
        field(
          'books',
          listOf(_bookType),
          resolve: (obj, ctx) {
            return booksToJson(books(ctx).allBooks);
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
          resolve: (obj, ctx) {
            final book = Book(
              name: ctx.args['name'] as String,
              publicationDate: DateTime.now(),
              isFavourite: false,
            );
            books(ctx).add(book);
            return book.toJson();
          },
          inputs: [
            GraphQLFieldInput(
              'name',
              graphQLString.nonNullable(),
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
          resolve: (obj, ctx) => books(ctx).stream,
        ),
        field(
          'bookAdded',
          bookAddedType(_bookType),
          resolve: (obj, ctx) => books(ctx).bookAddedStream,
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

GraphQLObjectType<BookAdded> bookAddedType(GraphQLObjectType book) {
  return objectType(
    'BookAdded',
    fields: [
      field(
        'book',
        book,
        resolve: (obj, args) {
          print(' BookAdded obj $obj ${obj.runtimeType} $args');
          return obj.book;
        },
      ),
    ],
  );
}
