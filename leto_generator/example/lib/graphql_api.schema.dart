// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_generator_example/star_wars/schema.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_generator_example/test/class_config_test.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:leto_generator_example/main.dart';
import 'package:leto_generator_example/generics_oxidized.dart';
import 'package:leto_generator_example/arguments.dart';
import 'package:leto_generator_example/generics.dart';
import 'package:leto_generator_example/star_wars_relay/data.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      humanSerializer,
      taskSerializer,
      userSerializer,
      inputMSerializer,
      inputMNSerializer,
      inputJsonSerdeSerializer,
      freezedSingleInputSerializer,
      unionASerializer,
      todoItemInputSerializer,
      todoItemInputNestedSerializer,
      shipSerializer,
      factionSerializer,
      connectionArgumentsSerializer,
    ])
    ..children.addAll([
      inputGenSerdeCtx,
      inputGen2SerdeCtx,
    ]),
  queryType: objectType(
    'Query',
    fields: [
      droidGraphQLField,
      getTasksGraphQLField,
      getClassConfig2GraphQLField,
      getClassConfigGraphQLField,
      testInputGenGraphQLField,
      queryMultipleParamsGraphQLField,
      returnFiveFromFreezedInputGraphQLField,
      getUnionAGraphQLField,
      getNestedInterfaceImpl3GraphQLField,
      getNestedInterfaceImpl2GraphQLField,
      getNestedInterfaceImplByIndexGraphQLField,
      getNameGraphQLField,
      resultUnionObjectGraphQLField,
      resultUnionObjectErrGraphQLField,
      resultObjectGraphQLField,
      resultObjectErrGraphQLField,
      testManyDefaultsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      addTaskGraphQLField,
      getIntGraphQLField,
      getIntReqGraphQLField,
      getIntNullGraphQLField,
      getIntInterfaceGraphQLField,
      getIntInterfaceEnumGraphQLField,
      getIntInterfaceEnumListGraphQLField,
      getIntInterfaceNEnumNullGraphQLField,
      mutationMultipleParamsOptionalPosGraphQLField,
      resultUnionObjectMutErrGraphQLField,
      resultObjectMutErrGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onAddTaskGraphQLField,
    ],
  ),
);
