// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:server/users/user_table.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/messages/messages_table.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/events/database_event.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      userEventSerializer,
      userSessionSerializer,
      userSerializer,
      tokenWithUserSerializer,
      userChatEventSerializer,
      chatRoomUserSerializer,
      chatEventSerializer,
      chatRoomSerializer,
      dBEventDataSerializer,
      dBEventSerializer,
      chatMessageSerializer,
      chatMessageEventSerializer,
    ]),
  queryType: objectType(
    'Query',
    fields: [
      searchUserGraphQLField,
      getChatRoomsGraphQLField,
      getMessageGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      refreshAuthTokenGraphQLField,
      signUpGraphQLField,
      signInGraphQLField,
      signOutGraphQLField,
      addChatRoomUserGraphQLField,
      deleteChatRoomUserGraphQLField,
      createChatRoomGraphQLField,
      deleteChatRoomGraphQLField,
      sendMessageGraphQLField,
      sendFileMessageGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onMessageEventGraphQLField,
      onMessageSentGraphQLField,
    ],
  ),
);
