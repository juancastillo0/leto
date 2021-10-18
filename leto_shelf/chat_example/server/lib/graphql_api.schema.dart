// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/users/user_table.dart';
import 'package:server/chat_room/user_rooms.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      userSessionSerializer,
      userSerializer,
      tokenWithUserSerializer,
      chatRoomUserSerializer,
      dBEventSerializer,
      chatRoomSerializer,
      chatMessageSerializer,
    ]),
  queryType: objectType(
    'Query',
    fields: [
      getMessageGraphQLField,
      getChatRoomsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      refreshAuthTokenGraphQLField,
      signUpGraphQLField,
      signInGraphQLField,
      signOutGraphQLField,
      sendMessageGraphQLField,
      createChatRoomGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onMessageSentGraphQLField,
      onMessageEventGraphQLField,
    ],
  ),
);
