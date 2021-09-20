import 'dart:async';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/stream_state_callbacks.dart';

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

final booksControllerRef = RefWithDefault(
  'BooksController',
  (_) => BooksController(),
);

class RefWithDefault<T> {
  final GlobalRef ref;
  final T Function(Map<Object, Object?> globals) create;

  RefWithDefault(String name, this.create) : ref = GlobalRef(name);

  T set(
    Map<Object, Object?> globals,
    T controller,
  ) {
    return globals[ref] = controller;
  }

  T getFromGlobals(Map<Object, Object?> globals) {
    return globals.putIfAbsent(ref, () => create(globals))! as T;
  }

  T get(ReqCtx ctx) {
    return getFromGlobals(ctx.globals);
  }
}

abstract class GlobalsHolder {
  GlobalsHolder();

  Map<Object, Object?> get globals;

  factory GlobalsHolder.fromMap(Map<Object, Object?> map) = GlobalsHolderValue;
  factory GlobalsHolder.empty() => GlobalsHolderValue({});
}

class GlobalsHolderValue extends GlobalsHolder {
  @override
  final Map<Object, Object?> globals;

  GlobalsHolderValue(this.globals);
}
