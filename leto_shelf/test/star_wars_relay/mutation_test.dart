import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/star_wars_relay/data.dart';
import 'package:test/test.dart';

/// Star Wars mutations
void main() {
  test('mutates the data set', () async {
    const document = r'''
      mutation ($input: IntroduceShipInput!) {
        introduceShip(input: $input) {
          ship {
            id
            name
          }
          faction {
            name
          }
          clientMutationId
        }
      }
    ''';
    const variableValues = {
      'input': {
        'shipName': 'B-Wing',
        'factionId': '1',
        'clientMutationId': 'abcde',
      },
    };

    final result = await GraphQL(relayStarWarsSchema).parseAndExecute(
      document,
      variableValues: variableValues,
    );

    expect(result.toJson(), {
      'data': {
        'introduceShip': {
          'ship': {
            'id': 'U2hpcDo5',
            'name': 'B-Wing',
          },
          'faction': {
            'name': 'Alliance to Restore the Republic',
          },
          'clientMutationId': 'abcde',
        },
      },
    });
  });
}
