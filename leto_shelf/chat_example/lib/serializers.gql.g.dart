// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(GAUserData.serializer)
      ..add(GAUserReq.serializer)
      ..add(GAUserVars.serializer)
      ..add(GBaseChatRoomData.serializer)
      ..add(GBaseChatRoomReq.serializer)
      ..add(GBaseChatRoomVars.serializer)
      ..add(GChatRoomUserRole.serializer)
      ..add(GDate.serializer)
      ..add(GEventType.serializer)
      ..add(GFullChatRoomData.serializer)
      ..add(GFullChatRoomData_users.serializer)
      ..add(GFullChatRoomData_users_user.serializer)
      ..add(GFullChatRoomReq.serializer)
      ..add(GFullChatRoomVars.serializer)
      ..add(GFullMessageData.serializer)
      ..add(GFullMessageData_referencedMessage.serializer)
      ..add(GFullMessageReq.serializer)
      ..add(GFullMessageVars.serializer)
      ..add(GSTokenWithUserData.serializer)
      ..add(GSTokenWithUserData_user.serializer)
      ..add(GSTokenWithUserReq.serializer)
      ..add(GSTokenWithUserVars.serializer)
      ..add(GSignInError.serializer)
      ..add(GSignUpError.serializer)
      ..add(GUserChatData.serializer)
      ..add(GUserChatData_user.serializer)
      ..add(GUserChatReq.serializer)
      ..add(GUserChatVars.serializer)
      ..add(GaddChatRoomUserData.serializer)
      ..add(GaddChatRoomUserData_addChatRoomUser.serializer)
      ..add(GaddChatRoomUserData_addChatRoomUser_user.serializer)
      ..add(GaddChatRoomUserReq.serializer)
      ..add(GaddChatRoomUserVars.serializer)
      ..add(GcreateRoomData.serializer)
      ..add(GcreateRoomData_createChatRoom.serializer)
      ..add(GcreateRoomReq.serializer)
      ..add(GcreateRoomVars.serializer)
      ..add(GdeleteChatRoomUserData.serializer)
      ..add(GdeleteChatRoomUserReq.serializer)
      ..add(GdeleteChatRoomUserVars.serializer)
      ..add(GdeleteRoomData.serializer)
      ..add(GdeleteRoomReq.serializer)
      ..add(GdeleteRoomVars.serializer)
      ..add(GgetMessagesData.serializer)
      ..add(GgetMessagesData_getMessage.serializer)
      ..add(GgetMessagesData_getMessage_referencedMessage.serializer)
      ..add(GgetMessagesReq.serializer)
      ..add(GgetMessagesVars.serializer)
      ..add(GgetRoomsData.serializer)
      ..add(GgetRoomsData_getChatRooms.serializer)
      ..add(GgetRoomsData_getChatRooms_users.serializer)
      ..add(GgetRoomsData_getChatRooms_users_user.serializer)
      ..add(GgetRoomsReq.serializer)
      ..add(GgetRoomsVars.serializer)
      ..add(GonMessageSentData.serializer)
      ..add(GonMessageSentData_onMessageSent.serializer)
      ..add(GonMessageSentData_onMessageSent_referencedMessage.serializer)
      ..add(GonMessageSentReq.serializer)
      ..add(GonMessageSentVars.serializer)
      ..add(GrefreshAuthTokenData.serializer)
      ..add(GrefreshAuthTokenReq.serializer)
      ..add(GrefreshAuthTokenVars.serializer)
      ..add(GsearchUserData.serializer)
      ..add(GsearchUserData_searchUser.serializer)
      ..add(GsearchUserReq.serializer)
      ..add(GsearchUserVars.serializer)
      ..add(GsendMessageData.serializer)
      ..add(GsendMessageData_sendMessage.serializer)
      ..add(GsendMessageData_sendMessage_referencedMessage.serializer)
      ..add(GsendMessageReq.serializer)
      ..add(GsendMessageVars.serializer)
      ..add(GsignInData.serializer)
      ..add(GsignInData_signIn__asErrCSignInError.serializer)
      ..add(GsignInData_signIn__asTokenWithUser.serializer)
      ..add(GsignInData_signIn__asTokenWithUser_user.serializer)
      ..add(GsignInData_signIn__base.serializer)
      ..add(GsignInReq.serializer)
      ..add(GsignInVars.serializer)
      ..add(GsignOutData.serializer)
      ..add(GsignOutReq.serializer)
      ..add(GsignOutVars.serializer)
      ..add(GsignUpData.serializer)
      ..add(GsignUpData_signUp__asErrCSignUpError.serializer)
      ..add(GsignUpData_signUp__asTokenWithUser.serializer)
      ..add(GsignUpData_signUp__asTokenWithUser_user.serializer)
      ..add(GsignUpData_signUp__base.serializer)
      ..add(GsignUpReq.serializer)
      ..add(GsignUpVars.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GFullChatRoomData_users)]),
          () => new ListBuilder<GFullChatRoomData_users>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GgetMessagesData_getMessage)]),
          () => new ListBuilder<GgetMessagesData_getMessage>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GgetRoomsData_getChatRooms)]),
          () => new ListBuilder<GgetRoomsData_getChatRooms>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GgetRoomsData_getChatRooms_users)]),
          () => new ListBuilder<GgetRoomsData_getChatRooms_users>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GonMessageSentData_onMessageSent)]),
          () => new ListBuilder<GonMessageSentData_onMessageSent>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GsearchUserData_searchUser)]),
          () => new ListBuilder<GsearchUserData_searchUser>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
