// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_generator_example/star_wars/schema.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_generator_example/test/enums_test.dart';
import 'package:leto_generator_example/test/class_config_test.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_generator_example/interfaces.dart';
import 'package:leto_generator_example/resolver_class.dart';
import 'package:leto_generator_example/unions.dart';
import 'package:leto_generator_example/main.dart';
import 'package:leto_generator_example/generics_oxidized.dart';
import 'package:leto_generator_example/arguments.dart';
import 'package:leto_generator_example/attachments.dart';
import 'package:leto_generator_example/generics.dart';
import 'package:leto_generator_example/star_wars_relay/data.dart';

GraphQLSchema recreateGraphQLApiSchema() {
  HotReloadableDefinition.incrementCounter();
  _graphqlApiSchema = null;
  return graphqlApiSchema;
}

GraphQLSchema? _graphqlApiSchema;
GraphQLSchema get graphqlApiSchema => _graphqlApiSchema ??= GraphQLSchema(
      serdeCtx: SerdeCtx()
        ..addAll([
          humanSerializer,
          taskSerializer,
          userSerializer,
          inputMSerializer,
          inputMNSerializer,
          inputJsonSerdeSerializer,
          combinedObjectSerializer,
          oneOfInputSerializer,
          oneOfFreezedInputSerializer,
          dateKeySerializer,
          freezedSingleInputSerializer,
          unionASerializer,
          todoItemInputSerializer,
          todoItemInputNestedSerializer,
          shipSerializer,
          factionSerializer,
          connectionArgumentsSerializer,
          validaArgModelSerializer,
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
          enumsTestQueryGraphQLField,
          getClassConfig2GraphQLField,
          getClassConfigGraphQLField,
          testInputGenGraphQLField,
          queryMultipleParamsGraphQLField,
          combinedFromInputGraphQLField,
          combinedFromOneOfGraphQLField,
          getNestedInterfaceImpl3GraphQLField,
          getNestedInterfaceImpl2GraphQLField,
          getNestedInterfaceImplByIndexGraphQLField,
          getDateKeyGraphQLField,
          queryInClassGraphQLField,
          queryInClass2GraphQLField,
          queryInClass3GraphQLField,
          queryInClass4GraphQLField,
          queryInClass5GraphQLField,
          queryInClass6GraphQLField,
          returnFiveFromFreezedInputGraphQLField,
          getUnionAGraphQLField,
          getUnionNoFrezzedGraphQLField,
          getNameGraphQLField,
          resultUnionObjectGraphQLField,
          resultUnionObjectErrGraphQLField,
          resultObjectGraphQLField,
          resultObjectErrGraphQLField,
          testManyDefaultsGraphQLField,
          testValidaInArgsGraphQLField,
          testValidaInArgsSingleModelGraphQLField,
          getKeyedAttachmentGraphQLField,
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
          mutationInClassGraphQLField,
          resultUnionObjectMutErrGraphQLField,
          resultObjectMutErrGraphQLField,
          resultUnionInSuccessGraphQLField,
        ],
      ),
      subscriptionType: objectType(
        'Subscription',
        fields: [
          onAddTaskGraphQLField,
        ],
      ),
    );
