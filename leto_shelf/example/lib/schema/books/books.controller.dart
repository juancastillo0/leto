import 'dart:async';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf_example/schema/stream_state_callbacks.dart';

import 'book.model.dart';
export 'book.model.dart';

class BooksController {
  BooksController({
    this.bookChangesCallbacks,
    StreamCallbacks? bookAddedCallbacks,
  }) : bookAddedCallbacks = bookAddedCallbacks ?? StreamCallbacks();

  final StreamCallbacks? bookChangesCallbacks;
  final StreamCallbacks? bookAddedCallbacks;

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

  late final _bookChangesController = StreamController<List<Book>>.broadcast(
    onListen: bookChangesCallbacks?.onListen,
    onCancel: bookChangesCallbacks?.onCancel,
  );
  Stream<List<Book>> get stream => _bookChangesController.stream;
  late final _bookAddedController = StreamController<BookAdded>.broadcast(
    onListen: bookAddedCallbacks?.onListen,
    onCancel: bookAddedCallbacks?.onCancel,
  );
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

final booksControllerRef = RefWithDefault.global(
  (_) => BooksController(),
  name: 'BooksController',
);
