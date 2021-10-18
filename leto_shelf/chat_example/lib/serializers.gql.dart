import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:chat_example/api/messages.data.gql.dart'
    show
        GFullMessageData,
        GFullMessageData_referencedMessage,
        GgetMessagesData,
        GgetMessagesData_getMessage,
        GgetMessagesData_getMessage_referencedMessage,
        GonMessageSentData,
        GonMessageSentData_onMessageSent,
        GonMessageSentData_onMessageSent_referencedMessage,
        GsendMessageData,
        GsendMessageData_sendMessage,
        GsendMessageData_sendMessage_referencedMessage;
import 'package:chat_example/api/messages.req.gql.dart'
    show GFullMessageReq, GgetMessagesReq, GonMessageSentReq, GsendMessageReq;
import 'package:chat_example/api/messages.var.gql.dart'
    show
        GFullMessageVars,
        GgetMessagesVars,
        GonMessageSentVars,
        GsendMessageVars;
import 'package:chat_example/api/room.data.gql.dart'
    show
        GBaseChatRoomData,
        GcreateRoomData,
        GcreateRoomData_createChatRoom,
        GgetRoomsData,
        GgetRoomsData_getChatRooms,
        GgetRoomsData_getChatRooms_messages,
        GgetRoomsData_getChatRooms_messages_referencedMessage,
        GgetRoomsData_getChatRooms_users;
import 'package:chat_example/api/room.req.gql.dart'
    show GBaseChatRoomReq, GcreateRoomReq, GgetRoomsReq;
import 'package:chat_example/api/room.var.gql.dart'
    show GBaseChatRoomVars, GcreateRoomVars, GgetRoomsVars;
import 'package:chat_example/api/user.data.gql.dart'
    show
        GsignInData_signIn,
        GsignUpData_signUp,
        GAUserData,
        GSTokenWithUserData,
        GSTokenWithUserData_user,
        GrefreshAuthTokenData,
        GsignInData,
        GsignInData_signIn__asErrCSignInError,
        GsignInData_signIn__asTokenWithUser,
        GsignInData_signIn__asTokenWithUser_user,
        GsignInData_signIn__base,
        GsignOutData,
        GsignUpData,
        GsignUpData_signUp__asErrCSignUpError,
        GsignUpData_signUp__asTokenWithUser,
        GsignUpData_signUp__asTokenWithUser_user,
        GsignUpData_signUp__base;
import 'package:chat_example/api/user.req.gql.dart'
    show
        GAUserReq,
        GSTokenWithUserReq,
        GrefreshAuthTokenReq,
        GsignInReq,
        GsignOutReq,
        GsignUpReq;
import 'package:chat_example/api/user.var.gql.dart'
    show
        GAUserVars,
        GSTokenWithUserVars,
        GrefreshAuthTokenVars,
        GsignInVars,
        GsignOutVars,
        GsignUpVars;
import 'package:chat_example/api_schema.schema.gql.dart'
    show GChatRoomUserRole, GDate, GEventType, GSignInError, GSignUpError;
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(GsignInData_signIn.serializer)
  ..add(GsignUpData_signUp.serializer)
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAUserData,
  GAUserReq,
  GAUserVars,
  GBaseChatRoomData,
  GBaseChatRoomReq,
  GBaseChatRoomVars,
  GChatRoomUserRole,
  GDate,
  GEventType,
  GFullMessageData,
  GFullMessageData_referencedMessage,
  GFullMessageReq,
  GFullMessageVars,
  GSTokenWithUserData,
  GSTokenWithUserData_user,
  GSTokenWithUserReq,
  GSTokenWithUserVars,
  GSignInError,
  GSignUpError,
  GcreateRoomData,
  GcreateRoomData_createChatRoom,
  GcreateRoomReq,
  GcreateRoomVars,
  GgetMessagesData,
  GgetMessagesData_getMessage,
  GgetMessagesData_getMessage_referencedMessage,
  GgetMessagesReq,
  GgetMessagesVars,
  GgetRoomsData,
  GgetRoomsData_getChatRooms,
  GgetRoomsData_getChatRooms_messages,
  GgetRoomsData_getChatRooms_messages_referencedMessage,
  GgetRoomsData_getChatRooms_users,
  GgetRoomsReq,
  GgetRoomsVars,
  GonMessageSentData,
  GonMessageSentData_onMessageSent,
  GonMessageSentData_onMessageSent_referencedMessage,
  GonMessageSentReq,
  GonMessageSentVars,
  GrefreshAuthTokenData,
  GrefreshAuthTokenReq,
  GrefreshAuthTokenVars,
  GsendMessageData,
  GsendMessageData_sendMessage,
  GsendMessageData_sendMessage_referencedMessage,
  GsendMessageReq,
  GsendMessageVars,
  GsignInData,
  GsignInData_signIn__asErrCSignInError,
  GsignInData_signIn__asTokenWithUser,
  GsignInData_signIn__asTokenWithUser_user,
  GsignInData_signIn__base,
  GsignInReq,
  GsignInVars,
  GsignOutData,
  GsignOutReq,
  GsignOutVars,
  GsignUpData,
  GsignUpData_signUp__asErrCSignUpError,
  GsignUpData_signUp__asTokenWithUser,
  GsignUpData_signUp__asTokenWithUser_user,
  GsignUpData_signUp__base,
  GsignUpReq,
  GsignUpVars
])
final Serializers serializers = _serializersBuilder.build();
