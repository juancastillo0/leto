// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:server/messages/messages_api.dart';
import 'package:server/users/user_api.dart';
import 'package:server/chat_room/chat_api.dart';
import 'package:server/events/events_api.dart';
import 'package:server/chat_room/user_rooms_api.dart';
import 'package:server/messages/metadata.dart';

GraphQLSchema recreateGraphQLApiSchema() {
  HotReloadableDefinition.incrementCounter();
  _graphqlApiSchema = null;
  return graphqlApiSchema;
}

GraphQLSchema? _graphqlApiSchema;
GraphQLSchema get graphqlApiSchema => _graphqlApiSchema ??= GraphQLSchema(
      serdeCtx: SerdeCtx()
        ..addAll([
          chatMessageSerializer,
          chatMessageEventSerializer,
          messageMetadataSerializer,
          linksMetadataSerializer,
          linkMetadataSerializer,
          fileMetadataSerializer,
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
        ])
        ..children.addAll([
          errCSerdeCtx,
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
