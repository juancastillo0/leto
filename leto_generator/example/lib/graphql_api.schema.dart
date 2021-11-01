// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:leto_generator_example/main.dart';
import 'package:leto_generator_example/generics.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      inputMSerializer,
      inputMNSerializer,
      inputJsonSerdeSerializer,
      freezedSingleInputSerializer,
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
      returnFiveFromFreezedInputGraphQLField,
      getUnionAGraphQLField,
      getNestedInterfaceImpl3GraphQLField,
      getNestedInterfaceImpl2GraphQLField,
      getNestedInterfaceImplByIndexGraphQLField,
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
      getIntInterfaceNEnumNullGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [],
  ),
);
