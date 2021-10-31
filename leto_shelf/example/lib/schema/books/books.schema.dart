import 'package:shelf_graphql/shelf_graphql.dart';

import 'books.controller.dart';

GraphQLSchema makeBooksSchema() {
  BooksController books(ReqCtx ctx) => booksControllerRef.get(ctx);

  final _bookType = bookType();

  // final mappedBooksStream = books.stream.map(booksToJson);
  // final bookAddedStream = books.bookAddedStream.map(
  //   (event) => event.toJson(),
  // );
  // bookAddedStream.listen((d) {
  //   print('bookAddedStream $d');
  // });

  return GraphQLSchema(
    queryType: objectType(
      'Queries',
      fields: [
        listOf(_bookType).nonNull().field(
          'books',
          resolve: (obj, ctx) {
            return books(ctx).allBooks;
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
              graphQLString.nonNull(),
            ),
          ],
        ),
      ],
    ),
    subscriptionType: objectType(
      'Subscriptions',
      fields: [
        listOf(_bookType).field(
          'books',
          subscribe: (obj, ctx) => books(ctx).stream,
        ),
        bookAddedType(_bookType).nonNull().field(
          'bookAdded',
          subscribe: (obj, ctx) {
            return books(ctx).bookAddedStream;
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
      graphQLString.nonNull().field('name'),
      graphQLDate.nonNull().field('publicationDate'),
      graphQLBoolean.nonNull().field('isFavourite'),
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
