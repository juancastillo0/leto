// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:shelf_graphql_example/schema/chat_room.dart/chat_table.dart';
import 'package:shelf_graphql_example/schema/star_wars/schema.dart';
import 'package:shelf_graphql_example/schema/generator_test.dart';
import 'package:shelf_graphql_example/schema/star_wars_relay/data.dart';

final graphqlApiSchema = graphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      dBEventSerializer,
      chatRoomSerializer,
      chatMessageSerializer,
      humanSerializer,
      droidSerializer,
      testModelSerializer,
      testModelFreezedSerializer,
      eventUnionSerializer,
      shipSerializer,
      factionSerializer,
      connectionArgumentsSerializer,
    ]),
  queryType: objectType(
    'Queries',
    fields: [
      getMessageGraphQLField,
      getChatRoomsGraphQLField,
      droidGraphQLField,
      testModelsGraphQLField,
      testUnionModelsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutations',
    fields: [
      sendMessageGraphQLField,
      createChatRoomGraphQLField,
      addTestModelGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscriptions',
    fields: [
      onMessageSentGraphQLField,
      onMessageEventGraphQLField,
    ],
  ),
);
