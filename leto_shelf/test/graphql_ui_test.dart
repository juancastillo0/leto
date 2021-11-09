import 'dart:convert';

import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

void main() {
  test('altair ui explorer models', () {
    const altair = AltairConfig(
      endpointURL: 'http://localhost:8068/graphql',
      initialHeaders: {'dw': 'cc'},
      initialEnvironments: IInitialEnvironments(
        base: InitialEnvironmentState(
          id: '1',
          title: 'env1',
          variables: {'dwd': 'v'},
        ),
      ),
    );
    final altairHtml = makeAltairHtml(altair);

    expect(
      altairHtml,
      stringContainsInOrder(
        [altair.endpointURL!, '1', 'env1', 'dwd', 'v'],
      ),
    );
    final altairMapped =
        json.decode(json.encode(altair)) as Map<String, Object?>;
    expect(
      altairMapped,
      json.decode(json.encode(AltairConfig.fromJson(altairMapped))),
    );
    expect(
      altairHtml,
      makeAltairHtml(
        AltairConfig.fromJson(altairMapped),
      ),
    );
  });

  test('graphiql ui explorer models', () {
    final graphiql = GraphiqlConfig(
      editorTheme: 'dark',
      defaultQuery: 'query main { fieldName }',
      headers: json.encode({'hh': 'daw'}),
      readOnly: false,
      operationName: 'main',
    );
    const graphiqlFetcher = GraphiqlFetcher(
      url: 'http://localhost:8060/graphql',
      subscriptionUrl: 'ws://localhost:8060/graphql-subscription',
    );

    final graphiqlMapped =
        json.decode(json.encode(graphiql)) as Map<String, Object?>;

    final graphiqlHtml = makeGraphiqlHtml(
      fetcher: graphiqlFetcher,
      config: graphiql,
    );
    expect(
      graphiqlMapped,
      json.decode(json.encode(GraphiqlConfig.fromJson(graphiqlMapped))),
    );
    expect(
      graphiqlHtml,
      makeGraphiqlHtml(
        config: GraphiqlConfig.fromJson(graphiqlMapped),
        fetcher: graphiqlFetcher,
      ),
    );
    expect(
      graphiqlHtml,
      stringContainsInOrder(
        [
          graphiqlFetcher.url,
          graphiqlFetcher.subscriptionUrl!,
          '"operationName":"${graphiql.operationName}"',
          graphiql.defaultQuery!,
          graphiql.editorTheme!,
          '"readOnly":${graphiql.readOnly}',
        ],
      ),
    );
  });

  test('playground ui explorer models', () {
    final playground = PlaygroundConfig(
      endpoint: 'http://localhost:8080/graphql',
      subscriptionEndpoint: 'ws://localhost:8080/graphql-subscription',
      title: 'Custom title',
      tabs: [
        Tab(
          endpoint: 'http://localhost:8080/graphql',
          headers: {},
          query: r'query main($input: String) {fieldName(input: $input)}',
          variables: json.encode({'input': 'value'}),
        ),
        const Tab(
          endpoint: 'http://localhost:8080/graphql',
          query: 'mutation mainMut {mutFieldName}',
        ),
      ],
    );

    final playgroundMapped =
        json.decode(json.encode(playground)) as Map<String, Object?>;

    final playgroundHtml = makePlaygroundHtml(
      config: playground,
    );
    expect(
      playgroundMapped,
      json.decode(json.encode(PlaygroundConfig.fromJson(playgroundMapped))),
    );
    expect(
      playgroundHtml,
      makePlaygroundHtml(
        config: PlaygroundConfig.fromJson(playgroundMapped),
      ),
    );
    expect(
      playgroundHtml,
      stringContainsInOrder(
        [
          playground.endpoint!,
          playground.subscriptionEndpoint!,
          '"title":"${playground.title}"',
        ],
      ),
    );
  });
}
