// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
import 'package:server/chat_room/chat_api.dart';
import 'package:server/messages/messages_api.dart';
import 'package:server/users/user_api.dart';
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
          messageMetadataSerializer,
          linksMetadataSerializer,
          linkMetadataSerializer,
          fileMetadataSerializer,
          chatEventSerializer,
          chatRoomSerializer,
          userChatEventSerializer,
          chatRoomUserSerializer,
          chatMessageSerializer,
          chatMessageEventSerializer,
          userEventSerializer,
          userSessionSerializer,
          userSerializer,
          tokenWithUserSerializer,
          dBEventDataSerializer,
          dBEventSerializer,
        ])
        ..children.addAll([
          errCSerdeCtx,
        ]),
      queryType: objectType(
        'Query',
        fields: [
          getChatRoomsGraphQLField,
          getMessageGraphQLField,
          getMessageLinksMetadataGraphQLField,
          searchUserGraphQLField,
          getUserGraphQLField,
          getEventsGraphQLField,
        ],
      ),
      mutationType: objectType(
        'Mutation',
        fields: [
          createChatRoomGraphQLField,
          deleteChatRoomGraphQLField,
          addChatRoomUserGraphQLField,
          deleteChatRoomUserGraphQLField,
          sendMessageGraphQLField,
          sendFileMessageGraphQLField,
          refreshAuthTokenGraphQLField,
          signUpGraphQLField,
          signInGraphQLField,
          signOutGraphQLField,
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
