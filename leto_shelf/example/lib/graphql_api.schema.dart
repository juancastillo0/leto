// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf_example/quickstart_server.dart';
import 'package:leto_shelf_example/schema/generator_test.dart';
import 'package:leto_shelf_example/schema/chat_room/chat_table.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      testModelSerializer,
      eventUnionSerializer,
      dBEventSerializer,
      chatRoomSerializer,
      chatMessageSerializer,
    ])
    ..children.addAll([]),
  queryType: objectType(
    'Query',
    fields: [
      getStateGraphQLField,
      testModelsGraphQLField,
      testUnionModelsGraphQLField,
      getMessageGraphQLField,
      getChatRoomsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      setStateGraphQLField,
      addTestModelGraphQLField,
      sendMessageGraphQLField,
      createChatRoomGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onStateChangeGraphQLField,
      onMessageSentGraphQLField,
      onMessageEventGraphQLField,
    ],
  ),
);
