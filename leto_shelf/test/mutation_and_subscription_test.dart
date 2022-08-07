import 'package:gql_link/gql_link.dart' as gql_link;
import 'package:leto/leto.dart';
import 'package:leto_shelf_example/schema/books/books.controller.dart';
import 'package:leto_shelf_example/schema/stream_state_callbacks.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'web_socket_link.dart';

Future<void> main() async {
  group('subscription', () {
    late StreamCallbacks _streamCallbacks;
    late TestGqlServer _server;

    setUp(() async {
      _streamCallbacks = StreamCallbacks();
      _server = await testServer(
        ServerConfig(
          globalVariables: ScopedMap(
            overrides: [
              booksControllerRef.override(
                (_) => BooksController(
                  bookAddedCallbacks: _streamCallbacks,
                ),
              )
            ],
          ),
        ),
      );
    });

    tearDown(() async {
      await _server.server.close();
    });

    test('apollo sub-protocol', () async {
      final link = WebSocketLink(
        _server.subscriptionsUrl.toString(),
      );
      await _testLink(_streamCallbacks, link);
    });

    // TODO: 1T use package:graphql and send PR to package:gql_web_socket_link
    // test('transport ws sub-protocol', () async {
    //   final link = GQLTransportWebSocketLink(ClientOptions(
    //     socketMaker: WebSocketMaker.url(
    //       () => _server.subscriptionsUrl.toString(),
    //     ),
    //   ));
    //   await _testLink(_streamCallbacks, link);
    // });
  });
}

Future<void> _testLink(
  StreamCallbacks _streamCallbacks,
  gql_link.Link link,
) async {
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
}
