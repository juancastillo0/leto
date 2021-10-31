import 'dart:async';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:leto/leto.dart';
import 'package:test/test.dart';

void main() {
  final episodes = [
    {'name': 'The Phantom Menace'},
    {'name': 'Attack of the Clones'},
    {'name': 'Attack of the Clones'}
  ];
  final episodesAsData = episodes.map((ep) {
    return {
      'data': {'prequels': ep}
    };
  });

  Stream<Map<String, dynamic>> resolveEpisodes(Object? _, Object? __) =>
      Stream.fromIterable(episodes)
          .map((ep) => <String, Object?>{...ep, 'not_selected': 1337});

  final episodeType = objectType<Object>('Episode', fields: [
    field('name', graphQLString.nonNull()),
    field('not_selected', graphQLInt),
  ]);

  final schema = GraphQLSchema(
    queryType: objectType('TestQuery', fields: [
      field('episodes', graphQLInt, resolve: (_, __) => episodes),
    ]),
    subscriptionType: objectType('TestSubscription', fields: [
      field('prequels', episodeType, subscribe: resolveEpisodes),
    ]),
  );

  final graphQL = GraphQL(schema);

  test('subscribe with selection', () async {
    final result = await graphQL.parseAndExecute('''
    subscription {
      prequels {
        name
      }
    }
    ''');
    final stream = result.subscriptionStream!;

    final asList = await stream.toList();
    expect(asList.map((e) => e.toJson()), episodesAsData);
  });
}
