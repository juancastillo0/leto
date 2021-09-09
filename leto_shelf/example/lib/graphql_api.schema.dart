// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:shelf_graphql_example/schema/generator_test.dart';

final graphqlApiSchema = graphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      testModelSerializer,
      testModelFreezedSerializer,
      eventUnionSerializer,
    ]),
  queryType: objectType(
    'Queries',
    fields: [],
  ),
  mutationType: objectType(
    'Mutations',
    fields: [],
  ),
  subscriptionType: objectType(
    'Subscriptions',
    fields: [],
  ),
);
