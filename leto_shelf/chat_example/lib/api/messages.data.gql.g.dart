// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetMessagesData> _$ggetMessagesDataSerializer =
    new _$GgetMessagesDataSerializer();
Serializer<GgetMessagesData_getMessage> _$ggetMessagesDataGetMessageSerializer =
    new _$GgetMessagesData_getMessageSerializer();
Serializer<GgetMessagesData_getMessage_referencedMessage>
    _$ggetMessagesDataGetMessageReferencedMessageSerializer =
    new _$GgetMessagesData_getMessage_referencedMessageSerializer();
Serializer<GsendMessageData> _$gsendMessageDataSerializer =
    new _$GsendMessageDataSerializer();
Serializer<GsendMessageData_sendMessage>
    _$gsendMessageDataSendMessageSerializer =
    new _$GsendMessageData_sendMessageSerializer();
Serializer<GsendMessageData_sendMessage_referencedMessage>
    _$gsendMessageDataSendMessageReferencedMessageSerializer =
    new _$GsendMessageData_sendMessage_referencedMessageSerializer();
Serializer<GonMessageSentData> _$gonMessageSentDataSerializer =
    new _$GonMessageSentDataSerializer();
Serializer<GonMessageSentData_onMessageSent>
    _$gonMessageSentDataOnMessageSentSerializer =
    new _$GonMessageSentData_onMessageSentSerializer();
Serializer<GonMessageSentData_onMessageSent_referencedMessage>
    _$gonMessageSentDataOnMessageSentReferencedMessageSerializer =
    new _$GonMessageSentData_onMessageSent_referencedMessageSerializer();
Serializer<GFullMessageData> _$gFullMessageDataSerializer =
    new _$GFullMessageDataSerializer();
Serializer<GFullMessageData_referencedMessage>
    _$gFullMessageDataReferencedMessageSerializer =
    new _$GFullMessageData_referencedMessageSerializer();

class _$GgetMessagesDataSerializer
    implements StructuredSerializer<GgetMessagesData> {
  @override
  final Iterable<Type> types = const [GgetMessagesData, _$GgetMessagesData];
  @override
  final String wireName = 'GgetMessagesData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetMessagesData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getMessage',
      serializers.serialize(object.getMessage,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GgetMessagesData_getMessage)])),
    ];

    return result;
  }

  @override
  GgetMessagesData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetMessagesDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'getMessage':
          result.getMessage.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GgetMessagesData_getMessage)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetMessagesData_getMessageSerializer
    implements StructuredSerializer<GgetMessagesData_getMessage> {
  @override
  final Iterable<Type> types = const [
    GgetMessagesData_getMessage,
    _$GgetMessagesData_getMessage
  ];
  @override
  final String wireName = 'GgetMessagesData_getMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetMessagesData_getMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];
    Object? value;
    value = object.referencedMessage;
    if (value != null) {
      result
        ..add('referencedMessage')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GgetMessagesData_getMessage_referencedMessage)));
    }
    return result;
  }

  @override
  GgetMessagesData_getMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetMessagesData_getMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'referencedMessage':
          result.referencedMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GgetMessagesData_getMessage_referencedMessage))!
              as GgetMessagesData_getMessage_referencedMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetMessagesData_getMessage_referencedMessageSerializer
    implements
        StructuredSerializer<GgetMessagesData_getMessage_referencedMessage> {
  @override
  final Iterable<Type> types = const [
    GgetMessagesData_getMessage_referencedMessage,
    _$GgetMessagesData_getMessage_referencedMessage
  ];
  @override
  final String wireName = 'GgetMessagesData_getMessage_referencedMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GgetMessagesData_getMessage_referencedMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GgetMessagesData_getMessage_referencedMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetMessagesData_getMessage_referencedMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageDataSerializer
    implements StructuredSerializer<GsendMessageData> {
  @override
  final Iterable<Type> types = const [GsendMessageData, _$GsendMessageData];
  @override
  final String wireName = 'GsendMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsendMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.sendMessage;
    if (value != null) {
      result
        ..add('sendMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GsendMessageData_sendMessage)));
    }
    return result;
  }

  @override
  GsendMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sendMessage':
          result.sendMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GsendMessageData_sendMessage))!
              as GsendMessageData_sendMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageData_sendMessageSerializer
    implements StructuredSerializer<GsendMessageData_sendMessage> {
  @override
  final Iterable<Type> types = const [
    GsendMessageData_sendMessage,
    _$GsendMessageData_sendMessage
  ];
  @override
  final String wireName = 'GsendMessageData_sendMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsendMessageData_sendMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];
    Object? value;
    value = object.referencedMessage;
    if (value != null) {
      result
        ..add('referencedMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GsendMessageData_sendMessage_referencedMessage)));
    }
    return result;
  }

  @override
  GsendMessageData_sendMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageData_sendMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'referencedMessage':
          result.referencedMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GsendMessageData_sendMessage_referencedMessage))!
              as GsendMessageData_sendMessage_referencedMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageData_sendMessage_referencedMessageSerializer
    implements
        StructuredSerializer<GsendMessageData_sendMessage_referencedMessage> {
  @override
  final Iterable<Type> types = const [
    GsendMessageData_sendMessage_referencedMessage,
    _$GsendMessageData_sendMessage_referencedMessage
  ];
  @override
  final String wireName = 'GsendMessageData_sendMessage_referencedMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GsendMessageData_sendMessage_referencedMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GsendMessageData_sendMessage_referencedMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageData_sendMessage_referencedMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GonMessageSentDataSerializer
    implements StructuredSerializer<GonMessageSentData> {
  @override
  final Iterable<Type> types = const [GonMessageSentData, _$GonMessageSentData];
  @override
  final String wireName = 'GonMessageSentData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GonMessageSentData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'onMessageSent',
      serializers.serialize(object.onMessageSent,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GonMessageSentData_onMessageSent)])),
    ];

    return result;
  }

  @override
  GonMessageSentData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GonMessageSentDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'onMessageSent':
          result.onMessageSent.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GonMessageSentData_onMessageSent)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GonMessageSentData_onMessageSentSerializer
    implements StructuredSerializer<GonMessageSentData_onMessageSent> {
  @override
  final Iterable<Type> types = const [
    GonMessageSentData_onMessageSent,
    _$GonMessageSentData_onMessageSent
  ];
  @override
  final String wireName = 'GonMessageSentData_onMessageSent';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GonMessageSentData_onMessageSent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];
    Object? value;
    value = object.referencedMessage;
    if (value != null) {
      result
        ..add('referencedMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GonMessageSentData_onMessageSent_referencedMessage)));
    }
    return result;
  }

  @override
  GonMessageSentData_onMessageSent deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GonMessageSentData_onMessageSentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'referencedMessage':
          result.referencedMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GonMessageSentData_onMessageSent_referencedMessage))!
              as GonMessageSentData_onMessageSent_referencedMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GonMessageSentData_onMessageSent_referencedMessageSerializer
    implements
        StructuredSerializer<
            GonMessageSentData_onMessageSent_referencedMessage> {
  @override
  final Iterable<Type> types = const [
    GonMessageSentData_onMessageSent_referencedMessage,
    _$GonMessageSentData_onMessageSent_referencedMessage
  ];
  @override
  final String wireName = 'GonMessageSentData_onMessageSent_referencedMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GonMessageSentData_onMessageSent_referencedMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GonMessageSentData_onMessageSent_referencedMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GonMessageSentData_onMessageSent_referencedMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GFullMessageDataSerializer
    implements StructuredSerializer<GFullMessageData> {
  @override
  final Iterable<Type> types = const [GFullMessageData, _$GFullMessageData];
  @override
  final String wireName = 'GFullMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFullMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];
    Object? value;
    value = object.referencedMessage;
    if (value != null) {
      result
        ..add('referencedMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GFullMessageData_referencedMessage)));
    }
    return result;
  }

  @override
  GFullMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullMessageDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'referencedMessage':
          result.referencedMessage.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GFullMessageData_referencedMessage))!
              as GFullMessageData_referencedMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GFullMessageData_referencedMessageSerializer
    implements StructuredSerializer<GFullMessageData_referencedMessage> {
  @override
  final Iterable<Type> types = const [
    GFullMessageData_referencedMessage,
    _$GFullMessageData_referencedMessage
  ];
  @override
  final String wireName = 'GFullMessageData_referencedMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFullMessageData_referencedMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GFullMessageData_referencedMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullMessageData_referencedMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetMessagesData extends GgetMessagesData {
  @override
  final String G__typename;
  @override
  final BuiltList<GgetMessagesData_getMessage> getMessage;

  factory _$GgetMessagesData(
          [void Function(GgetMessagesDataBuilder)? updates]) =>
      (new GgetMessagesDataBuilder()..update(updates)).build();

  _$GgetMessagesData._({required this.G__typename, required this.getMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetMessagesData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getMessage, 'GgetMessagesData', 'getMessage');
  }

  @override
  GgetMessagesData rebuild(void Function(GgetMessagesDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetMessagesDataBuilder toBuilder() =>
      new GgetMessagesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetMessagesData &&
        G__typename == other.G__typename &&
        getMessage == other.getMessage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), getMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetMessagesData')
          ..add('G__typename', G__typename)
          ..add('getMessage', getMessage))
        .toString();
  }
}

class GgetMessagesDataBuilder
    implements Builder<GgetMessagesData, GgetMessagesDataBuilder> {
  _$GgetMessagesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GgetMessagesData_getMessage>? _getMessage;
  ListBuilder<GgetMessagesData_getMessage> get getMessage =>
      _$this._getMessage ??= new ListBuilder<GgetMessagesData_getMessage>();
  set getMessage(ListBuilder<GgetMessagesData_getMessage>? getMessage) =>
      _$this._getMessage = getMessage;

  GgetMessagesDataBuilder() {
    GgetMessagesData._initializeBuilder(this);
  }

  GgetMessagesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getMessage = $v.getMessage.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetMessagesData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetMessagesData;
  }

  @override
  void update(void Function(GgetMessagesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetMessagesData build() {
    _$GgetMessagesData _$result;
    try {
      _$result = _$v ??
          new _$GgetMessagesData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GgetMessagesData', 'G__typename'),
              getMessage: getMessage.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getMessage';
        getMessage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetMessagesData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetMessagesData_getMessage extends GgetMessagesData_getMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int chatId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final GgetMessagesData_getMessage_referencedMessage? referencedMessage;

  factory _$GgetMessagesData_getMessage(
          [void Function(GgetMessagesData_getMessageBuilder)? updates]) =>
      (new GgetMessagesData_getMessageBuilder()..update(updates)).build();

  _$GgetMessagesData_getMessage._(
      {required this.G__typename,
      required this.id,
      required this.chatId,
      required this.userId,
      required this.message,
      required this.createdAt,
      this.referencedMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetMessagesData_getMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetMessagesData_getMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GgetMessagesData_getMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GgetMessagesData_getMessage', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GgetMessagesData_getMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GgetMessagesData_getMessage', 'createdAt');
  }

  @override
  GgetMessagesData_getMessage rebuild(
          void Function(GgetMessagesData_getMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetMessagesData_getMessageBuilder toBuilder() =>
      new GgetMessagesData_getMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetMessagesData_getMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        chatId == other.chatId &&
        userId == other.userId &&
        message == other.message &&
        createdAt == other.createdAt &&
        referencedMessage == other.referencedMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                        chatId.hashCode),
                    userId.hashCode),
                message.hashCode),
            createdAt.hashCode),
        referencedMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetMessagesData_getMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('userId', userId)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('referencedMessage', referencedMessage))
        .toString();
  }
}

class GgetMessagesData_getMessageBuilder
    implements
        Builder<GgetMessagesData_getMessage,
            GgetMessagesData_getMessageBuilder> {
  _$GgetMessagesData_getMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GgetMessagesData_getMessage_referencedMessageBuilder? _referencedMessage;
  GgetMessagesData_getMessage_referencedMessageBuilder get referencedMessage =>
      _$this._referencedMessage ??=
          new GgetMessagesData_getMessage_referencedMessageBuilder();
  set referencedMessage(
          GgetMessagesData_getMessage_referencedMessageBuilder?
              referencedMessage) =>
      _$this._referencedMessage = referencedMessage;

  GgetMessagesData_getMessageBuilder() {
    GgetMessagesData_getMessage._initializeBuilder(this);
  }

  GgetMessagesData_getMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _chatId = $v.chatId;
      _userId = $v.userId;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _referencedMessage = $v.referencedMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetMessagesData_getMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetMessagesData_getMessage;
  }

  @override
  void update(void Function(GgetMessagesData_getMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetMessagesData_getMessage build() {
    _$GgetMessagesData_getMessage _$result;
    try {
      _$result = _$v ??
          new _$GgetMessagesData_getMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GgetMessagesData_getMessage', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GgetMessagesData_getMessage', 'id'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GgetMessagesData_getMessage', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GgetMessagesData_getMessage', 'userId'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GgetMessagesData_getMessage', 'message'),
              createdAt: createdAt.build(),
              referencedMessage: _referencedMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'referencedMessage';
        _referencedMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetMessagesData_getMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetMessagesData_getMessage_referencedMessage
    extends GgetMessagesData_getMessage_referencedMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GgetMessagesData_getMessage_referencedMessage(
          [void Function(GgetMessagesData_getMessage_referencedMessageBuilder)?
              updates]) =>
      (new GgetMessagesData_getMessage_referencedMessageBuilder()
            ..update(updates))
          .build();

  _$GgetMessagesData_getMessage_referencedMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.createdAt,
      required this.chatId,
      required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        'GgetMessagesData_getMessage_referencedMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetMessagesData_getMessage_referencedMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GgetMessagesData_getMessage_referencedMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(createdAt,
        'GgetMessagesData_getMessage_referencedMessage', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GgetMessagesData_getMessage_referencedMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GgetMessagesData_getMessage_referencedMessage', 'userId');
  }

  @override
  GgetMessagesData_getMessage_referencedMessage rebuild(
          void Function(GgetMessagesData_getMessage_referencedMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetMessagesData_getMessage_referencedMessageBuilder toBuilder() =>
      new GgetMessagesData_getMessage_referencedMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetMessagesData_getMessage_referencedMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        createdAt == other.createdAt &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    message.hashCode),
                createdAt.hashCode),
            chatId.hashCode),
        userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GgetMessagesData_getMessage_referencedMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GgetMessagesData_getMessage_referencedMessageBuilder
    implements
        Builder<GgetMessagesData_getMessage_referencedMessage,
            GgetMessagesData_getMessage_referencedMessageBuilder> {
  _$GgetMessagesData_getMessage_referencedMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GgetMessagesData_getMessage_referencedMessageBuilder() {
    GgetMessagesData_getMessage_referencedMessage._initializeBuilder(this);
  }

  GgetMessagesData_getMessage_referencedMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetMessagesData_getMessage_referencedMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetMessagesData_getMessage_referencedMessage;
  }

  @override
  void update(
      void Function(GgetMessagesData_getMessage_referencedMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetMessagesData_getMessage_referencedMessage build() {
    _$GgetMessagesData_getMessage_referencedMessage _$result;
    try {
      _$result = _$v ??
          new _$GgetMessagesData_getMessage_referencedMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  'GgetMessagesData_getMessage_referencedMessage',
                  'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GgetMessagesData_getMessage_referencedMessage', 'id'),
              message: BuiltValueNullFieldError.checkNotNull(message,
                  'GgetMessagesData_getMessage_referencedMessage', 'message'),
              createdAt: createdAt.build(),
              chatId: BuiltValueNullFieldError.checkNotNull(chatId,
                  'GgetMessagesData_getMessage_referencedMessage', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(userId,
                  'GgetMessagesData_getMessage_referencedMessage', 'userId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetMessagesData_getMessage_referencedMessage',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageData extends GsendMessageData {
  @override
  final String G__typename;
  @override
  final GsendMessageData_sendMessage? sendMessage;

  factory _$GsendMessageData(
          [void Function(GsendMessageDataBuilder)? updates]) =>
      (new GsendMessageDataBuilder()..update(updates)).build();

  _$GsendMessageData._({required this.G__typename, this.sendMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsendMessageData', 'G__typename');
  }

  @override
  GsendMessageData rebuild(void Function(GsendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageDataBuilder toBuilder() =>
      new GsendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageData &&
        G__typename == other.G__typename &&
        sendMessage == other.sendMessage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), sendMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsendMessageData')
          ..add('G__typename', G__typename)
          ..add('sendMessage', sendMessage))
        .toString();
  }
}

class GsendMessageDataBuilder
    implements Builder<GsendMessageData, GsendMessageDataBuilder> {
  _$GsendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsendMessageData_sendMessageBuilder? _sendMessage;
  GsendMessageData_sendMessageBuilder get sendMessage =>
      _$this._sendMessage ??= new GsendMessageData_sendMessageBuilder();
  set sendMessage(GsendMessageData_sendMessageBuilder? sendMessage) =>
      _$this._sendMessage = sendMessage;

  GsendMessageDataBuilder() {
    GsendMessageData._initializeBuilder(this);
  }

  GsendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendMessage = $v.sendMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageData;
  }

  @override
  void update(void Function(GsendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsendMessageData build() {
    _$GsendMessageData _$result;
    try {
      _$result = _$v ??
          new _$GsendMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GsendMessageData', 'G__typename'),
              sendMessage: _sendMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sendMessage';
        _sendMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsendMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageData_sendMessage extends GsendMessageData_sendMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int chatId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final GsendMessageData_sendMessage_referencedMessage? referencedMessage;

  factory _$GsendMessageData_sendMessage(
          [void Function(GsendMessageData_sendMessageBuilder)? updates]) =>
      (new GsendMessageData_sendMessageBuilder()..update(updates)).build();

  _$GsendMessageData_sendMessage._(
      {required this.G__typename,
      required this.id,
      required this.chatId,
      required this.userId,
      required this.message,
      required this.createdAt,
      this.referencedMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsendMessageData_sendMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GsendMessageData_sendMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GsendMessageData_sendMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GsendMessageData_sendMessage', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GsendMessageData_sendMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GsendMessageData_sendMessage', 'createdAt');
  }

  @override
  GsendMessageData_sendMessage rebuild(
          void Function(GsendMessageData_sendMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageData_sendMessageBuilder toBuilder() =>
      new GsendMessageData_sendMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageData_sendMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        chatId == other.chatId &&
        userId == other.userId &&
        message == other.message &&
        createdAt == other.createdAt &&
        referencedMessage == other.referencedMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                        chatId.hashCode),
                    userId.hashCode),
                message.hashCode),
            createdAt.hashCode),
        referencedMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsendMessageData_sendMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('userId', userId)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('referencedMessage', referencedMessage))
        .toString();
  }
}

class GsendMessageData_sendMessageBuilder
    implements
        Builder<GsendMessageData_sendMessage,
            GsendMessageData_sendMessageBuilder> {
  _$GsendMessageData_sendMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GsendMessageData_sendMessage_referencedMessageBuilder? _referencedMessage;
  GsendMessageData_sendMessage_referencedMessageBuilder get referencedMessage =>
      _$this._referencedMessage ??=
          new GsendMessageData_sendMessage_referencedMessageBuilder();
  set referencedMessage(
          GsendMessageData_sendMessage_referencedMessageBuilder?
              referencedMessage) =>
      _$this._referencedMessage = referencedMessage;

  GsendMessageData_sendMessageBuilder() {
    GsendMessageData_sendMessage._initializeBuilder(this);
  }

  GsendMessageData_sendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _chatId = $v.chatId;
      _userId = $v.userId;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _referencedMessage = $v.referencedMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageData_sendMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageData_sendMessage;
  }

  @override
  void update(void Function(GsendMessageData_sendMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsendMessageData_sendMessage build() {
    _$GsendMessageData_sendMessage _$result;
    try {
      _$result = _$v ??
          new _$GsendMessageData_sendMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GsendMessageData_sendMessage', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GsendMessageData_sendMessage', 'id'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GsendMessageData_sendMessage', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GsendMessageData_sendMessage', 'userId'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GsendMessageData_sendMessage', 'message'),
              createdAt: createdAt.build(),
              referencedMessage: _referencedMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'referencedMessage';
        _referencedMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsendMessageData_sendMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageData_sendMessage_referencedMessage
    extends GsendMessageData_sendMessage_referencedMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GsendMessageData_sendMessage_referencedMessage(
          [void Function(GsendMessageData_sendMessage_referencedMessageBuilder)?
              updates]) =>
      (new GsendMessageData_sendMessage_referencedMessageBuilder()
            ..update(updates))
          .build();

  _$GsendMessageData_sendMessage_referencedMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.createdAt,
      required this.chatId,
      required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        'GsendMessageData_sendMessage_referencedMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GsendMessageData_sendMessage_referencedMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GsendMessageData_sendMessage_referencedMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(createdAt,
        'GsendMessageData_sendMessage_referencedMessage', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GsendMessageData_sendMessage_referencedMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GsendMessageData_sendMessage_referencedMessage', 'userId');
  }

  @override
  GsendMessageData_sendMessage_referencedMessage rebuild(
          void Function(GsendMessageData_sendMessage_referencedMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageData_sendMessage_referencedMessageBuilder toBuilder() =>
      new GsendMessageData_sendMessage_referencedMessageBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageData_sendMessage_referencedMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        createdAt == other.createdAt &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    message.hashCode),
                createdAt.hashCode),
            chatId.hashCode),
        userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GsendMessageData_sendMessage_referencedMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GsendMessageData_sendMessage_referencedMessageBuilder
    implements
        Builder<GsendMessageData_sendMessage_referencedMessage,
            GsendMessageData_sendMessage_referencedMessageBuilder> {
  _$GsendMessageData_sendMessage_referencedMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GsendMessageData_sendMessage_referencedMessageBuilder() {
    GsendMessageData_sendMessage_referencedMessage._initializeBuilder(this);
  }

  GsendMessageData_sendMessage_referencedMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageData_sendMessage_referencedMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageData_sendMessage_referencedMessage;
  }

  @override
  void update(
      void Function(GsendMessageData_sendMessage_referencedMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsendMessageData_sendMessage_referencedMessage build() {
    _$GsendMessageData_sendMessage_referencedMessage _$result;
    try {
      _$result = _$v ??
          new _$GsendMessageData_sendMessage_referencedMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  'GsendMessageData_sendMessage_referencedMessage',
                  'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GsendMessageData_sendMessage_referencedMessage', 'id'),
              message: BuiltValueNullFieldError.checkNotNull(message,
                  'GsendMessageData_sendMessage_referencedMessage', 'message'),
              createdAt: createdAt.build(),
              chatId: BuiltValueNullFieldError.checkNotNull(chatId,
                  'GsendMessageData_sendMessage_referencedMessage', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(userId,
                  'GsendMessageData_sendMessage_referencedMessage', 'userId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsendMessageData_sendMessage_referencedMessage',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GonMessageSentData extends GonMessageSentData {
  @override
  final String G__typename;
  @override
  final BuiltList<GonMessageSentData_onMessageSent> onMessageSent;

  factory _$GonMessageSentData(
          [void Function(GonMessageSentDataBuilder)? updates]) =>
      (new GonMessageSentDataBuilder()..update(updates)).build();

  _$GonMessageSentData._(
      {required this.G__typename, required this.onMessageSent})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GonMessageSentData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        onMessageSent, 'GonMessageSentData', 'onMessageSent');
  }

  @override
  GonMessageSentData rebuild(
          void Function(GonMessageSentDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GonMessageSentDataBuilder toBuilder() =>
      new GonMessageSentDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GonMessageSentData &&
        G__typename == other.G__typename &&
        onMessageSent == other.onMessageSent;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), onMessageSent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GonMessageSentData')
          ..add('G__typename', G__typename)
          ..add('onMessageSent', onMessageSent))
        .toString();
  }
}

class GonMessageSentDataBuilder
    implements Builder<GonMessageSentData, GonMessageSentDataBuilder> {
  _$GonMessageSentData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GonMessageSentData_onMessageSent>? _onMessageSent;
  ListBuilder<GonMessageSentData_onMessageSent> get onMessageSent =>
      _$this._onMessageSent ??=
          new ListBuilder<GonMessageSentData_onMessageSent>();
  set onMessageSent(
          ListBuilder<GonMessageSentData_onMessageSent>? onMessageSent) =>
      _$this._onMessageSent = onMessageSent;

  GonMessageSentDataBuilder() {
    GonMessageSentData._initializeBuilder(this);
  }

  GonMessageSentDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _onMessageSent = $v.onMessageSent.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GonMessageSentData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GonMessageSentData;
  }

  @override
  void update(void Function(GonMessageSentDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GonMessageSentData build() {
    _$GonMessageSentData _$result;
    try {
      _$result = _$v ??
          new _$GonMessageSentData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GonMessageSentData', 'G__typename'),
              onMessageSent: onMessageSent.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'onMessageSent';
        onMessageSent.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GonMessageSentData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GonMessageSentData_onMessageSent
    extends GonMessageSentData_onMessageSent {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int chatId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final GonMessageSentData_onMessageSent_referencedMessage? referencedMessage;

  factory _$GonMessageSentData_onMessageSent(
          [void Function(GonMessageSentData_onMessageSentBuilder)? updates]) =>
      (new GonMessageSentData_onMessageSentBuilder()..update(updates)).build();

  _$GonMessageSentData_onMessageSent._(
      {required this.G__typename,
      required this.id,
      required this.chatId,
      required this.userId,
      required this.message,
      required this.createdAt,
      this.referencedMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GonMessageSentData_onMessageSent', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GonMessageSentData_onMessageSent', 'id');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GonMessageSentData_onMessageSent', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GonMessageSentData_onMessageSent', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GonMessageSentData_onMessageSent', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GonMessageSentData_onMessageSent', 'createdAt');
  }

  @override
  GonMessageSentData_onMessageSent rebuild(
          void Function(GonMessageSentData_onMessageSentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GonMessageSentData_onMessageSentBuilder toBuilder() =>
      new GonMessageSentData_onMessageSentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GonMessageSentData_onMessageSent &&
        G__typename == other.G__typename &&
        id == other.id &&
        chatId == other.chatId &&
        userId == other.userId &&
        message == other.message &&
        createdAt == other.createdAt &&
        referencedMessage == other.referencedMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                        chatId.hashCode),
                    userId.hashCode),
                message.hashCode),
            createdAt.hashCode),
        referencedMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GonMessageSentData_onMessageSent')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('userId', userId)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('referencedMessage', referencedMessage))
        .toString();
  }
}

class GonMessageSentData_onMessageSentBuilder
    implements
        Builder<GonMessageSentData_onMessageSent,
            GonMessageSentData_onMessageSentBuilder> {
  _$GonMessageSentData_onMessageSent? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GonMessageSentData_onMessageSent_referencedMessageBuilder? _referencedMessage;
  GonMessageSentData_onMessageSent_referencedMessageBuilder
      get referencedMessage => _$this._referencedMessage ??=
          new GonMessageSentData_onMessageSent_referencedMessageBuilder();
  set referencedMessage(
          GonMessageSentData_onMessageSent_referencedMessageBuilder?
              referencedMessage) =>
      _$this._referencedMessage = referencedMessage;

  GonMessageSentData_onMessageSentBuilder() {
    GonMessageSentData_onMessageSent._initializeBuilder(this);
  }

  GonMessageSentData_onMessageSentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _chatId = $v.chatId;
      _userId = $v.userId;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _referencedMessage = $v.referencedMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GonMessageSentData_onMessageSent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GonMessageSentData_onMessageSent;
  }

  @override
  void update(void Function(GonMessageSentData_onMessageSentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GonMessageSentData_onMessageSent build() {
    _$GonMessageSentData_onMessageSent _$result;
    try {
      _$result = _$v ??
          new _$GonMessageSentData_onMessageSent._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GonMessageSentData_onMessageSent', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GonMessageSentData_onMessageSent', 'id'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GonMessageSentData_onMessageSent', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GonMessageSentData_onMessageSent', 'userId'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GonMessageSentData_onMessageSent', 'message'),
              createdAt: createdAt.build(),
              referencedMessage: _referencedMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'referencedMessage';
        _referencedMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GonMessageSentData_onMessageSent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GonMessageSentData_onMessageSent_referencedMessage
    extends GonMessageSentData_onMessageSent_referencedMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GonMessageSentData_onMessageSent_referencedMessage(
          [void Function(
                  GonMessageSentData_onMessageSent_referencedMessageBuilder)?
              updates]) =>
      (new GonMessageSentData_onMessageSent_referencedMessageBuilder()
            ..update(updates))
          .build();

  _$GonMessageSentData_onMessageSent_referencedMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.createdAt,
      required this.chatId,
      required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        'GonMessageSentData_onMessageSent_referencedMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GonMessageSentData_onMessageSent_referencedMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(message,
        'GonMessageSentData_onMessageSent_referencedMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(createdAt,
        'GonMessageSentData_onMessageSent_referencedMessage', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GonMessageSentData_onMessageSent_referencedMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GonMessageSentData_onMessageSent_referencedMessage', 'userId');
  }

  @override
  GonMessageSentData_onMessageSent_referencedMessage rebuild(
          void Function(
                  GonMessageSentData_onMessageSent_referencedMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GonMessageSentData_onMessageSent_referencedMessageBuilder toBuilder() =>
      new GonMessageSentData_onMessageSent_referencedMessageBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GonMessageSentData_onMessageSent_referencedMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        createdAt == other.createdAt &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    message.hashCode),
                createdAt.hashCode),
            chatId.hashCode),
        userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GonMessageSentData_onMessageSent_referencedMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GonMessageSentData_onMessageSent_referencedMessageBuilder
    implements
        Builder<GonMessageSentData_onMessageSent_referencedMessage,
            GonMessageSentData_onMessageSent_referencedMessageBuilder> {
  _$GonMessageSentData_onMessageSent_referencedMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GonMessageSentData_onMessageSent_referencedMessageBuilder() {
    GonMessageSentData_onMessageSent_referencedMessage._initializeBuilder(this);
  }

  GonMessageSentData_onMessageSent_referencedMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GonMessageSentData_onMessageSent_referencedMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GonMessageSentData_onMessageSent_referencedMessage;
  }

  @override
  void update(
      void Function(GonMessageSentData_onMessageSent_referencedMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GonMessageSentData_onMessageSent_referencedMessage build() {
    _$GonMessageSentData_onMessageSent_referencedMessage _$result;
    try {
      _$result = _$v ??
          new _$GonMessageSentData_onMessageSent_referencedMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  'GonMessageSentData_onMessageSent_referencedMessage',
                  'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GonMessageSentData_onMessageSent_referencedMessage', 'id'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message,
                  'GonMessageSentData_onMessageSent_referencedMessage',
                  'message'),
              createdAt: createdAt.build(),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId,
                  'GonMessageSentData_onMessageSent_referencedMessage',
                  'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId,
                  'GonMessageSentData_onMessageSent_referencedMessage',
                  'userId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GonMessageSentData_onMessageSent_referencedMessage',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFullMessageData extends GFullMessageData {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int chatId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final GFullMessageData_referencedMessage? referencedMessage;

  factory _$GFullMessageData(
          [void Function(GFullMessageDataBuilder)? updates]) =>
      (new GFullMessageDataBuilder()..update(updates)).build();

  _$GFullMessageData._(
      {required this.G__typename,
      required this.id,
      required this.chatId,
      required this.userId,
      required this.message,
      required this.createdAt,
      this.referencedMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GFullMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GFullMessageData', 'id');
    BuiltValueNullFieldError.checkNotNull(chatId, 'GFullMessageData', 'chatId');
    BuiltValueNullFieldError.checkNotNull(userId, 'GFullMessageData', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GFullMessageData', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GFullMessageData', 'createdAt');
  }

  @override
  GFullMessageData rebuild(void Function(GFullMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullMessageDataBuilder toBuilder() =>
      new GFullMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullMessageData &&
        G__typename == other.G__typename &&
        id == other.id &&
        chatId == other.chatId &&
        userId == other.userId &&
        message == other.message &&
        createdAt == other.createdAt &&
        referencedMessage == other.referencedMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                        chatId.hashCode),
                    userId.hashCode),
                message.hashCode),
            createdAt.hashCode),
        referencedMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullMessageData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('userId', userId)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('referencedMessage', referencedMessage))
        .toString();
  }
}

class GFullMessageDataBuilder
    implements Builder<GFullMessageData, GFullMessageDataBuilder> {
  _$GFullMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GFullMessageData_referencedMessageBuilder? _referencedMessage;
  GFullMessageData_referencedMessageBuilder get referencedMessage =>
      _$this._referencedMessage ??=
          new GFullMessageData_referencedMessageBuilder();
  set referencedMessage(
          GFullMessageData_referencedMessageBuilder? referencedMessage) =>
      _$this._referencedMessage = referencedMessage;

  GFullMessageDataBuilder() {
    GFullMessageData._initializeBuilder(this);
  }

  GFullMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _chatId = $v.chatId;
      _userId = $v.userId;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _referencedMessage = $v.referencedMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullMessageData;
  }

  @override
  void update(void Function(GFullMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullMessageData build() {
    _$GFullMessageData _$result;
    try {
      _$result = _$v ??
          new _$GFullMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GFullMessageData', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GFullMessageData', 'id'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GFullMessageData', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GFullMessageData', 'userId'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GFullMessageData', 'message'),
              createdAt: createdAt.build(),
              referencedMessage: _referencedMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'referencedMessage';
        _referencedMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GFullMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFullMessageData_referencedMessage
    extends GFullMessageData_referencedMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GFullMessageData_referencedMessage(
          [void Function(GFullMessageData_referencedMessageBuilder)?
              updates]) =>
      (new GFullMessageData_referencedMessageBuilder()..update(updates))
          .build();

  _$GFullMessageData_referencedMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.createdAt,
      required this.chatId,
      required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GFullMessageData_referencedMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GFullMessageData_referencedMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GFullMessageData_referencedMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GFullMessageData_referencedMessage', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GFullMessageData_referencedMessage', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GFullMessageData_referencedMessage', 'userId');
  }

  @override
  GFullMessageData_referencedMessage rebuild(
          void Function(GFullMessageData_referencedMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullMessageData_referencedMessageBuilder toBuilder() =>
      new GFullMessageData_referencedMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullMessageData_referencedMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        createdAt == other.createdAt &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    message.hashCode),
                createdAt.hashCode),
            chatId.hashCode),
        userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullMessageData_referencedMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GFullMessageData_referencedMessageBuilder
    implements
        Builder<GFullMessageData_referencedMessage,
            GFullMessageData_referencedMessageBuilder> {
  _$GFullMessageData_referencedMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GFullMessageData_referencedMessageBuilder() {
    GFullMessageData_referencedMessage._initializeBuilder(this);
  }

  GFullMessageData_referencedMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullMessageData_referencedMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullMessageData_referencedMessage;
  }

  @override
  void update(
      void Function(GFullMessageData_referencedMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullMessageData_referencedMessage build() {
    _$GFullMessageData_referencedMessage _$result;
    try {
      _$result = _$v ??
          new _$GFullMessageData_referencedMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GFullMessageData_referencedMessage', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GFullMessageData_referencedMessage', 'id'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GFullMessageData_referencedMessage', 'message'),
              createdAt: createdAt.build(),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GFullMessageData_referencedMessage', 'chatId'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GFullMessageData_referencedMessage', 'userId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GFullMessageData_referencedMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
