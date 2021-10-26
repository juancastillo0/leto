// ignore: depend_on_referenced_packages
import 'package:graphql_schema/graphql_schema.dart';
import 'package:server/messages/messages_table.dart';
import 'package:server/users/user_table.dart';
import 'package:server/chat_room/chat_table.dart';
import 'package:server/events/database_event.dart';
import 'package:server/chat_room/user_rooms.dart';
import 'package:server/messages/metadata.dart';

final graphqlApiSchema = GraphQLSchema(
  serdeCtx: SerdeCtx()
    ..addAll([
      messageMetadataSerializer,
      linksMetadataSerializer,
      linkMetadataSerializer,
      fileMetadataSerializer,
      chatMessageSerializer,
      chatMessageEventSerializer,
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
    ]),
  queryType: objectType(
    'Query',
    fields: [
      getMessageGraphQLField,
      getMessageLinksMetadataGraphQLField,
      searchUserGraphQLField,
      getUserGraphQLField,
      getChatRoomsGraphQLField,
      getEventsGraphQLField,
    ],
  ),
  mutationType: objectType(
    'Mutation',
    fields: [
      sendMessageGraphQLField,
      sendFileMessageGraphQLField,
      refreshAuthTokenGraphQLField,
      signUpGraphQLField,
      signInGraphQLField,
      signOutGraphQLField,
      addChatRoomUserGraphQLField,
      deleteChatRoomUserGraphQLField,
      createChatRoomGraphQLField,
      deleteChatRoomGraphQLField,
    ],
  ),
  subscriptionType: objectType(
    'Subscription',
    fields: [
      onMessageSentGraphQLField,
      onEventGraphQLField,
      onMessageEventGraphQLField,
    ],
  ),
);
