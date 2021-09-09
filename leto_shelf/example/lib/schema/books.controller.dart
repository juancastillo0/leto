import 'dart:async';

import 'book.model.dart';
export 'book.model.dart';

class BooksController {
  List<Book> allBooks = [
    Book(
      name: 'fesf',
      publicationDate: DateTime.now(),
      isFavourite: true,
    ),
    Book(
      name: 'fesf not fav',
      publicationDate: DateTime.now().subtract(
        const Duration(days: 2),
      ),
      isFavourite: false,
    ),
  ];

  final _bookChangesController = StreamController<List<Book>>.broadcast();
  Stream<List<Book>> get stream => _bookChangesController.stream;
  final _bookAddedController = StreamController<BookAdded>.broadcast();
  Stream<BookAdded> get bookAddedStream => _bookAddedController.stream;

  void add(Book book) {
    _update((books) {
      books.add(book);
    });
    _bookAddedController.add(BookAdded(book: book));
  }

  void _update(void Function(List<Book>) callback) {
    callback(allBooks);
    _bookChangesController.add(allBooks);
  }
}

List<Map<String, Object?>> booksToJson(List<Book> books) {
  return books.map((e) => e.toJson()).toList();
}
