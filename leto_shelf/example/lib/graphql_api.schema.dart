// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:shelf_graphql_example/schema/star_wars/schema.dart';
import 'package:shelf_graphql_example/schema/generator_test.dart';

final graphqlApiSchema = graphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      humanSerializer,
      droidSerializer,
      testModelSerializer,
      testModelFreezedSerializer,
      eventUnionSerializer,
    ]),
  queryType: objectType(
    'Queries',
    fields: [
      droidGraphQLField,
      testModelsGraphQLField,
      testUnionModelsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutations',
    fields: [
      addTestModelGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscriptions',
    fields: [],
  ),
);
