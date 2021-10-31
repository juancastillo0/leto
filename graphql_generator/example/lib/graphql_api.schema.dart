// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:graphql_generator_example/inputs.dart';
import 'package:graphql_generator_example/main.dart';
import 'package:graphql_generator_example/generics.dart';
import 'package:graphql_generator_example/unions.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      inputMSerializer,
      inputMNSerializer,
      inputJsonSerdeSerializer,
      unionSingleInputSerializer,
      todoItemInputSerializer,
      todoItemInputSSerializer,
      todoItemInputNestedSerializer,
    ])
    ..children.addAll([
      inputGenSerdeCtx,
    ]),
  queryType: objectType(
    'Query',
    fields: [
      testInputGenGraphQLField,
      getNameGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      getIntGraphQLField,
      getIntReqGraphQLField,
      getIntNullGraphQLField,
      getIntInterfaceGraphQLField,
      getIntInterfaceEnumGraphQLField,
      getIntInterfaceEnumListGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [],
  ),
);