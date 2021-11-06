// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:leto_generator_example/main.dart';
import 'package:leto_generator_example/generics_oxidized.dart';
import 'package:leto_generator_example/arguments.dart';
import 'package:leto_generator_example/generics.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      taskSerializer,
      userSerializer,
      inputMSerializer,
      inputMNSerializer,
      inputJsonSerdeSerializer,
      freezedSingleInputSerializer,
      unionASerializer,
      todoItemInputSerializer,
      todoItemInputNestedSerializer,
    ])
    ..children.addAll([
      inputGenSerdeCtx,
      inputGen2SerdeCtx,
    ]),
  queryType: objectType(
    'Query',
    fields: [
      getTasksGraphQLField,
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
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onAddTaskGraphQLField,
    ],
  ),
);
