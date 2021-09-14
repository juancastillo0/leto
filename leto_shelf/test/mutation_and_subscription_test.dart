import 'package:gql/language.dart' as gql;
import 'package:gql_exec/gql_exec.dart' as gql_exec;
import 'package:gql_link/gql_link.dart' as gql_link;
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:shelf_graphql_example/schema/books.controller.dart';
import 'package:shelf_graphql_example/schema/stream_state_callbacks.dart';
import 'package:test/test.dart';

import 'common.dart';

Future<void> main() async {
  final globals = <Object, Object?>{};
  final _streamCallbacks = StreamCallbacks();

  final booksController = BooksController(bookAddedCallbacks: _streamCallbacks);
  setBooksController(globals, booksController);

  final _server = await testServer(globals);

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

extension RequestRaw on gql_link.Link {
  Stream<gql_exec.Response> requestRaw(
    String document, {
    String? operationName,
    Map<String, Object?> variables = const {},
  }) {
    return request(
      gql_exec.Request(
        operation: gql_exec.Operation(
          document: gql.parseString(document),
          operationName: operationName,
        ),
        variables: variables,
      ),
    );
  }
}
