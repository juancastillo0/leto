import 'package:leto/leto.dart';
import 'package:leto_shelf_example/schema/books/books.controller.dart';
import 'package:leto_shelf_example/schema/stream_state_callbacks.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'web_socket_link.dart';

Future<void> main() async {
  final _streamCallbacks = StreamCallbacks();
  final _globals = ScopedMap({
    booksControllerRef: BooksController(bookAddedCallbacks: _streamCallbacks)
  });
  final _server = await testServer(ServerConfig(
    globalVariables: _globals,
  ));

  test('subscription test', () async {
    final link = WebSocketLink(
      _server.subscriptionsUrl.toString(),
    );

    final subscriptionStream = link.requestRaw('''
subscription bookAdded {
  bookAdded {
    book {
      name
      isFavourite
      publicationDate
    }
  }
}''');
    final firstEventFut = subscriptionStream.first;

    expect(
      await _streamCallbacks.isListeningStream.first
          .timeout(const Duration(seconds: 4)),
      true,
    );

    const _bookName = 'dd1wda';
    final mutationResponse = await link.requestRaw('''
mutation add {
  createBook(name: "$_bookName") {
    name
    isFavourite
    publicationDate
  }
}''').single;
    final firstEvent = await firstEventFut;
    expect(
      mutationResponse.data!['createBook'],
      firstEvent.data!['bookAdded']['book'],
    );
    expect(mutationResponse.data!['createBook']['name'], _bookName);
    await link.dispose();

    expect(
      await _streamCallbacks.isListeningStream.first
          .timeout(const Duration(seconds: 4)),
      false,
    );
    expect(_streamCallbacks.cancelations, 1);
    print(
      'isListening ${_streamCallbacks.isListening} '
      'cancelations ${_streamCallbacks.cancelations}',
    );
  });
}
