// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:leto_shelf_example/quickstart_server.dart';
import 'package:leto_shelf_example/schema/star_wars/schema.dart';
import 'package:leto_shelf_example/schema/generator_test.dart';
import 'package:leto_shelf_example/schema/chat_room/chat_table.dart';
import 'package:leto_shelf_example/schema/star_wars_relay/data.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      humanSerializer,
      testModelSerializer,
      eventUnionSerializer,
      shipSerializer,
      factionSerializer,
      connectionArgumentsSerializer,
      dBEventSerializer,
      chatRoomSerializer,
      chatMessageSerializer,
    ])
    ..children.addAll([]),
  queryType: objectType(
    'Query',
    fields: [
      getStateGraphQLField,
      droidGraphQLField,
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
