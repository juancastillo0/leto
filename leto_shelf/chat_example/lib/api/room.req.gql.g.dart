// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.req.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GcreateRoomReq> _$gcreateRoomReqSerializer =
    new _$GcreateRoomReqSerializer();
Serializer<GdeleteRoomReq> _$gdeleteRoomReqSerializer =
    new _$GdeleteRoomReqSerializer();
Serializer<GgetRoomsReq> _$ggetRoomsReqSerializer =
    new _$GgetRoomsReqSerializer();
Serializer<GsearchUserReq> _$gsearchUserReqSerializer =
    new _$GsearchUserReqSerializer();
Serializer<GaddChatRoomUserReq> _$gaddChatRoomUserReqSerializer =
    new _$GaddChatRoomUserReqSerializer();
Serializer<GdeleteChatRoomUserReq> _$gdeleteChatRoomUserReqSerializer =
    new _$GdeleteChatRoomUserReqSerializer();
Serializer<GUserChatReq> _$gUserChatReqSerializer =
    new _$GUserChatReqSerializer();
Serializer<GFullChatRoomReq> _$gFullChatRoomReqSerializer =
    new _$GFullChatRoomReqSerializer();
Serializer<GBaseChatRoomReq> _$gBaseChatRoomReqSerializer =
    new _$GBaseChatRoomReqSerializer();

class _$GcreateRoomReqSerializer
    implements StructuredSerializer<GcreateRoomReq> {
  @override
  final Iterable<Type> types = const [GcreateRoomReq, _$GcreateRoomReq];
  @override
  final String wireName = 'GcreateRoomReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GcreateRoomReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GcreateRoomVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GcreateRoomData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GcreateRoomReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GcreateRoomReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GcreateRoomVars))!
              as _i3.GcreateRoomVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GcreateRoomData))!
              as _i2.GcreateRoomData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GdeleteRoomReqSerializer
    implements StructuredSerializer<GdeleteRoomReq> {
  @override
  final Iterable<Type> types = const [GdeleteRoomReq, _$GdeleteRoomReq];
  @override
  final String wireName = 'GdeleteRoomReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GdeleteRoomReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GdeleteRoomVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GdeleteRoomData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GdeleteRoomReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteRoomReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GdeleteRoomVars))!
              as _i3.GdeleteRoomVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GdeleteRoomData))!
              as _i2.GdeleteRoomData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsReqSerializer implements StructuredSerializer<GgetRoomsReq> {
  @override
  final Iterable<Type> types = const [GgetRoomsReq, _$GgetRoomsReq];
  @override
  final String wireName = 'GgetRoomsReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetRoomsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GgetRoomsVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GgetRoomsData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GgetRoomsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GgetRoomsVars))!
              as _i3.GgetRoomsVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GgetRoomsData))!
              as _i2.GgetRoomsData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GsearchUserReqSerializer
    implements StructuredSerializer<GsearchUserReq> {
  @override
  final Iterable<Type> types = const [GsearchUserReq, _$GsearchUserReq];
  @override
  final String wireName = 'GsearchUserReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsearchUserReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GsearchUserVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GsearchUserData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GsearchUserReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsearchUserReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GsearchUserVars))!
              as _i3.GsearchUserVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GsearchUserData))!
              as _i2.GsearchUserData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GaddChatRoomUserReqSerializer
    implements StructuredSerializer<GaddChatRoomUserReq> {
  @override
  final Iterable<Type> types = const [
    GaddChatRoomUserReq,
    _$GaddChatRoomUserReq
  ];
  @override
  final String wireName = 'GaddChatRoomUserReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GaddChatRoomUserReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GaddChatRoomUserVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GaddChatRoomUserData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GaddChatRoomUserReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddChatRoomUserReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GaddChatRoomUserVars))!
              as _i3.GaddChatRoomUserVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GaddChatRoomUserData))!
              as _i2.GaddChatRoomUserData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GdeleteChatRoomUserReqSerializer
    implements StructuredSerializer<GdeleteChatRoomUserReq> {
  @override
  final Iterable<Type> types = const [
    GdeleteChatRoomUserReq,
    _$GdeleteChatRoomUserReq
  ];
  @override
  final String wireName = 'GdeleteChatRoomUserReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GdeleteChatRoomUserReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GdeleteChatRoomUserVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GdeleteChatRoomUserData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GdeleteChatRoomUserReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteChatRoomUserReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GdeleteChatRoomUserVars))!
              as _i3.GdeleteChatRoomUserVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation)) as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GdeleteChatRoomUserData))!
              as _i2.GdeleteChatRoomUserData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserChatReqSerializer implements StructuredSerializer<GUserChatReq> {
  @override
  final Iterable<Type> types = const [GUserChatReq, _$GUserChatReq];
  @override
  final String wireName = 'GUserChatReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserChatReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GUserChatVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUserChatReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUserChatReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GUserChatVars))!
              as _i3.GUserChatVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GFullChatRoomReqSerializer
    implements StructuredSerializer<GFullChatRoomReq> {
  @override
  final Iterable<Type> types = const [GFullChatRoomReq, _$GFullChatRoomReq];
  @override
  final String wireName = 'GFullChatRoomReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFullChatRoomReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GFullChatRoomVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GFullChatRoomReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullChatRoomReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GFullChatRoomVars))!
              as _i3.GFullChatRoomVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GBaseChatRoomReqSerializer
    implements StructuredSerializer<GBaseChatRoomReq> {
  @override
  final Iterable<Type> types = const [GBaseChatRoomReq, _$GBaseChatRoomReq];
  @override
  final String wireName = 'GBaseChatRoomReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBaseChatRoomReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GBaseChatRoomVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GBaseChatRoomReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBaseChatRoomReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GBaseChatRoomVars))!
              as _i3.GBaseChatRoomVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GcreateRoomReq extends GcreateRoomReq {
  @override
  final _i3.GcreateRoomVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GcreateRoomData? Function(
      _i2.GcreateRoomData?, _i2.GcreateRoomData?)? updateResult;
  @override
  final _i2.GcreateRoomData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GcreateRoomReq([void Function(GcreateRoomReqBuilder)? updates]) =>
      (new GcreateRoomReqBuilder()..update(updates)).build();

  _$GcreateRoomReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GcreateRoomReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GcreateRoomReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GcreateRoomReq', 'executeOnListen');
  }

  @override
  GcreateRoomReq rebuild(void Function(GcreateRoomReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GcreateRoomReqBuilder toBuilder() =>
      new GcreateRoomReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GcreateRoomReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GcreateRoomReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GcreateRoomReqBuilder
    implements Builder<GcreateRoomReq, GcreateRoomReqBuilder> {
  _$GcreateRoomReq? _$v;

  _i3.GcreateRoomVarsBuilder? _vars;
  _i3.GcreateRoomVarsBuilder get vars =>
      _$this._vars ??= new _i3.GcreateRoomVarsBuilder();
  set vars(_i3.GcreateRoomVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GcreateRoomData? Function(_i2.GcreateRoomData?, _i2.GcreateRoomData?)?
      _updateResult;
  _i2.GcreateRoomData? Function(_i2.GcreateRoomData?, _i2.GcreateRoomData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GcreateRoomData? Function(
                  _i2.GcreateRoomData?, _i2.GcreateRoomData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GcreateRoomDataBuilder? _optimisticResponse;
  _i2.GcreateRoomDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GcreateRoomDataBuilder();
  set optimisticResponse(_i2.GcreateRoomDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GcreateRoomReqBuilder() {
    GcreateRoomReq._initializeBuilder(this);
  }

  GcreateRoomReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GcreateRoomReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GcreateRoomReq;
  }

  @override
  void update(void Function(GcreateRoomReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GcreateRoomReq build() {
    _$GcreateRoomReq _$result;
    try {
      _$result = _$v ??
          new _$GcreateRoomReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GcreateRoomReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, 'GcreateRoomReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GcreateRoomReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GdeleteRoomReq extends GdeleteRoomReq {
  @override
  final _i3.GdeleteRoomVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GdeleteRoomData? Function(
      _i2.GdeleteRoomData?, _i2.GdeleteRoomData?)? updateResult;
  @override
  final _i2.GdeleteRoomData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GdeleteRoomReq([void Function(GdeleteRoomReqBuilder)? updates]) =>
      (new GdeleteRoomReqBuilder()..update(updates)).build();

  _$GdeleteRoomReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GdeleteRoomReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GdeleteRoomReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GdeleteRoomReq', 'executeOnListen');
  }

  @override
  GdeleteRoomReq rebuild(void Function(GdeleteRoomReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteRoomReqBuilder toBuilder() =>
      new GdeleteRoomReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GdeleteRoomReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteRoomReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GdeleteRoomReqBuilder
    implements Builder<GdeleteRoomReq, GdeleteRoomReqBuilder> {
  _$GdeleteRoomReq? _$v;

  _i3.GdeleteRoomVarsBuilder? _vars;
  _i3.GdeleteRoomVarsBuilder get vars =>
      _$this._vars ??= new _i3.GdeleteRoomVarsBuilder();
  set vars(_i3.GdeleteRoomVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GdeleteRoomData? Function(_i2.GdeleteRoomData?, _i2.GdeleteRoomData?)?
      _updateResult;
  _i2.GdeleteRoomData? Function(_i2.GdeleteRoomData?, _i2.GdeleteRoomData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GdeleteRoomData? Function(
                  _i2.GdeleteRoomData?, _i2.GdeleteRoomData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GdeleteRoomDataBuilder? _optimisticResponse;
  _i2.GdeleteRoomDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GdeleteRoomDataBuilder();
  set optimisticResponse(_i2.GdeleteRoomDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GdeleteRoomReqBuilder() {
    GdeleteRoomReq._initializeBuilder(this);
  }

  GdeleteRoomReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteRoomReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteRoomReq;
  }

  @override
  void update(void Function(GdeleteRoomReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteRoomReq build() {
    _$GdeleteRoomReq _$result;
    try {
      _$result = _$v ??
          new _$GdeleteRoomReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GdeleteRoomReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, 'GdeleteRoomReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GdeleteRoomReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsReq extends GgetRoomsReq {
  @override
  final _i3.GgetRoomsVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GgetRoomsData? Function(_i2.GgetRoomsData?, _i2.GgetRoomsData?)?
      updateResult;
  @override
  final _i2.GgetRoomsData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GgetRoomsReq([void Function(GgetRoomsReqBuilder)? updates]) =>
      (new GgetRoomsReqBuilder()..update(updates)).build();

  _$GgetRoomsReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GgetRoomsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GgetRoomsReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GgetRoomsReq', 'executeOnListen');
  }

  @override
  GgetRoomsReq rebuild(void Function(GgetRoomsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsReqBuilder toBuilder() => new GgetRoomsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GgetRoomsReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GgetRoomsReqBuilder
    implements Builder<GgetRoomsReq, GgetRoomsReqBuilder> {
  _$GgetRoomsReq? _$v;

  _i3.GgetRoomsVarsBuilder? _vars;
  _i3.GgetRoomsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GgetRoomsVarsBuilder();
  set vars(_i3.GgetRoomsVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GgetRoomsData? Function(_i2.GgetRoomsData?, _i2.GgetRoomsData?)?
      _updateResult;
  _i2.GgetRoomsData? Function(_i2.GgetRoomsData?, _i2.GgetRoomsData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GgetRoomsData? Function(_i2.GgetRoomsData?, _i2.GgetRoomsData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GgetRoomsDataBuilder? _optimisticResponse;
  _i2.GgetRoomsDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GgetRoomsDataBuilder();
  set optimisticResponse(_i2.GgetRoomsDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GgetRoomsReqBuilder() {
    GgetRoomsReq._initializeBuilder(this);
  }

  GgetRoomsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsReq;
  }

  @override
  void update(void Function(GgetRoomsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsReq build() {
    _$GgetRoomsReq _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GgetRoomsReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, 'GgetRoomsReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsearchUserReq extends GsearchUserReq {
  @override
  final _i3.GsearchUserVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GsearchUserData? Function(
      _i2.GsearchUserData?, _i2.GsearchUserData?)? updateResult;
  @override
  final _i2.GsearchUserData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GsearchUserReq([void Function(GsearchUserReqBuilder)? updates]) =>
      (new GsearchUserReqBuilder()..update(updates)).build();

  _$GsearchUserReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GsearchUserReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GsearchUserReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GsearchUserReq', 'executeOnListen');
  }

  @override
  GsearchUserReq rebuild(void Function(GsearchUserReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsearchUserReqBuilder toBuilder() =>
      new GsearchUserReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GsearchUserReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsearchUserReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GsearchUserReqBuilder
    implements Builder<GsearchUserReq, GsearchUserReqBuilder> {
  _$GsearchUserReq? _$v;

  _i3.GsearchUserVarsBuilder? _vars;
  _i3.GsearchUserVarsBuilder get vars =>
      _$this._vars ??= new _i3.GsearchUserVarsBuilder();
  set vars(_i3.GsearchUserVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GsearchUserData? Function(_i2.GsearchUserData?, _i2.GsearchUserData?)?
      _updateResult;
  _i2.GsearchUserData? Function(_i2.GsearchUserData?, _i2.GsearchUserData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GsearchUserData? Function(
                  _i2.GsearchUserData?, _i2.GsearchUserData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GsearchUserDataBuilder? _optimisticResponse;
  _i2.GsearchUserDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GsearchUserDataBuilder();
  set optimisticResponse(_i2.GsearchUserDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GsearchUserReqBuilder() {
    GsearchUserReq._initializeBuilder(this);
  }

  GsearchUserReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsearchUserReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsearchUserReq;
  }

  @override
  void update(void Function(GsearchUserReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsearchUserReq build() {
    _$GsearchUserReq _$result;
    try {
      _$result = _$v ??
          new _$GsearchUserReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GsearchUserReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, 'GsearchUserReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsearchUserReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GaddChatRoomUserReq extends GaddChatRoomUserReq {
  @override
  final _i3.GaddChatRoomUserVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GaddChatRoomUserData? Function(
      _i2.GaddChatRoomUserData?, _i2.GaddChatRoomUserData?)? updateResult;
  @override
  final _i2.GaddChatRoomUserData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GaddChatRoomUserReq(
          [void Function(GaddChatRoomUserReqBuilder)? updates]) =>
      (new GaddChatRoomUserReqBuilder()..update(updates)).build();

  _$GaddChatRoomUserReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GaddChatRoomUserReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GaddChatRoomUserReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GaddChatRoomUserReq', 'executeOnListen');
  }

  @override
  GaddChatRoomUserReq rebuild(
          void Function(GaddChatRoomUserReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddChatRoomUserReqBuilder toBuilder() =>
      new GaddChatRoomUserReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GaddChatRoomUserReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GaddChatRoomUserReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GaddChatRoomUserReqBuilder
    implements Builder<GaddChatRoomUserReq, GaddChatRoomUserReqBuilder> {
  _$GaddChatRoomUserReq? _$v;

  _i3.GaddChatRoomUserVarsBuilder? _vars;
  _i3.GaddChatRoomUserVarsBuilder get vars =>
      _$this._vars ??= new _i3.GaddChatRoomUserVarsBuilder();
  set vars(_i3.GaddChatRoomUserVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GaddChatRoomUserData? Function(
      _i2.GaddChatRoomUserData?, _i2.GaddChatRoomUserData?)? _updateResult;
  _i2.GaddChatRoomUserData? Function(
          _i2.GaddChatRoomUserData?, _i2.GaddChatRoomUserData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GaddChatRoomUserData? Function(
                  _i2.GaddChatRoomUserData?, _i2.GaddChatRoomUserData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GaddChatRoomUserDataBuilder? _optimisticResponse;
  _i2.GaddChatRoomUserDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GaddChatRoomUserDataBuilder();
  set optimisticResponse(_i2.GaddChatRoomUserDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GaddChatRoomUserReqBuilder() {
    GaddChatRoomUserReq._initializeBuilder(this);
  }

  GaddChatRoomUserReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddChatRoomUserReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddChatRoomUserReq;
  }

  @override
  void update(void Function(GaddChatRoomUserReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GaddChatRoomUserReq build() {
    _$GaddChatRoomUserReq _$result;
    try {
      _$result = _$v ??
          new _$GaddChatRoomUserReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GaddChatRoomUserReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, 'GaddChatRoomUserReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GaddChatRoomUserReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GdeleteChatRoomUserReq extends GdeleteChatRoomUserReq {
  @override
  final _i3.GdeleteChatRoomUserVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GdeleteChatRoomUserData? Function(
      _i2.GdeleteChatRoomUserData?, _i2.GdeleteChatRoomUserData?)? updateResult;
  @override
  final _i2.GdeleteChatRoomUserData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GdeleteChatRoomUserReq(
          [void Function(GdeleteChatRoomUserReqBuilder)? updates]) =>
      (new GdeleteChatRoomUserReqBuilder()..update(updates)).build();

  _$GdeleteChatRoomUserReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, 'GdeleteChatRoomUserReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, 'GdeleteChatRoomUserReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, 'GdeleteChatRoomUserReq', 'executeOnListen');
  }

  @override
  GdeleteChatRoomUserReq rebuild(
          void Function(GdeleteChatRoomUserReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteChatRoomUserReqBuilder toBuilder() =>
      new GdeleteChatRoomUserReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GdeleteChatRoomUserReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, vars.hashCode), operation.hashCode),
                                requestId.hashCode),
                            updateResult.hashCode),
                        optimisticResponse.hashCode),
                    updateCacheHandlerKey.hashCode),
                updateCacheHandlerContext.hashCode),
            fetchPolicy.hashCode),
        executeOnListen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteChatRoomUserReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GdeleteChatRoomUserReqBuilder
    implements Builder<GdeleteChatRoomUserReq, GdeleteChatRoomUserReqBuilder> {
  _$GdeleteChatRoomUserReq? _$v;

  _i3.GdeleteChatRoomUserVarsBuilder? _vars;
  _i3.GdeleteChatRoomUserVarsBuilder get vars =>
      _$this._vars ??= new _i3.GdeleteChatRoomUserVarsBuilder();
  set vars(_i3.GdeleteChatRoomUserVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GdeleteChatRoomUserData? Function(
          _i2.GdeleteChatRoomUserData?, _i2.GdeleteChatRoomUserData?)?
      _updateResult;
  _i2.GdeleteChatRoomUserData? Function(
          _i2.GdeleteChatRoomUserData?, _i2.GdeleteChatRoomUserData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GdeleteChatRoomUserData? Function(
                  _i2.GdeleteChatRoomUserData?, _i2.GdeleteChatRoomUserData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GdeleteChatRoomUserDataBuilder? _optimisticResponse;
  _i2.GdeleteChatRoomUserDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GdeleteChatRoomUserDataBuilder();
  set optimisticResponse(
          _i2.GdeleteChatRoomUserDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GdeleteChatRoomUserReqBuilder() {
    GdeleteChatRoomUserReq._initializeBuilder(this);
  }

  GdeleteChatRoomUserReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteChatRoomUserReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteChatRoomUserReq;
  }

  @override
  void update(void Function(GdeleteChatRoomUserReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteChatRoomUserReq build() {
    _$GdeleteChatRoomUserReq _$result;
    try {
      _$result = _$v ??
          new _$GdeleteChatRoomUserReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, 'GdeleteChatRoomUserReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen,
                  'GdeleteChatRoomUserReq',
                  'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GdeleteChatRoomUserReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserChatReq extends GUserChatReq {
  @override
  final _i3.GUserChatVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GUserChatReq([void Function(GUserChatReqBuilder)? updates]) =>
      (new GUserChatReqBuilder()..update(updates)).build();

  _$GUserChatReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GUserChatReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(document, 'GUserChatReq', 'document');
    BuiltValueNullFieldError.checkNotNull(idFields, 'GUserChatReq', 'idFields');
  }

  @override
  GUserChatReq rebuild(void Function(GUserChatReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserChatReqBuilder toBuilder() => new GUserChatReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserChatReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, vars.hashCode), document.hashCode),
            fragmentName.hashCode),
        idFields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GUserChatReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GUserChatReqBuilder
    implements Builder<GUserChatReq, GUserChatReqBuilder> {
  _$GUserChatReq? _$v;

  _i3.GUserChatVarsBuilder? _vars;
  _i3.GUserChatVarsBuilder get vars =>
      _$this._vars ??= new _i3.GUserChatVarsBuilder();
  set vars(_i3.GUserChatVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GUserChatReqBuilder() {
    GUserChatReq._initializeBuilder(this);
  }

  GUserChatReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserChatReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUserChatReq;
  }

  @override
  void update(void Function(GUserChatReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GUserChatReq build() {
    _$GUserChatReq _$result;
    try {
      _$result = _$v ??
          new _$GUserChatReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, 'GUserChatReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, 'GUserChatReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GUserChatReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFullChatRoomReq extends GFullChatRoomReq {
  @override
  final _i3.GFullChatRoomVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GFullChatRoomReq(
          [void Function(GFullChatRoomReqBuilder)? updates]) =>
      (new GFullChatRoomReqBuilder()..update(updates)).build();

  _$GFullChatRoomReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GFullChatRoomReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, 'GFullChatRoomReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, 'GFullChatRoomReq', 'idFields');
  }

  @override
  GFullChatRoomReq rebuild(void Function(GFullChatRoomReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullChatRoomReqBuilder toBuilder() =>
      new GFullChatRoomReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullChatRoomReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, vars.hashCode), document.hashCode),
            fragmentName.hashCode),
        idFields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullChatRoomReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GFullChatRoomReqBuilder
    implements Builder<GFullChatRoomReq, GFullChatRoomReqBuilder> {
  _$GFullChatRoomReq? _$v;

  _i3.GFullChatRoomVarsBuilder? _vars;
  _i3.GFullChatRoomVarsBuilder get vars =>
      _$this._vars ??= new _i3.GFullChatRoomVarsBuilder();
  set vars(_i3.GFullChatRoomVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GFullChatRoomReqBuilder() {
    GFullChatRoomReq._initializeBuilder(this);
  }

  GFullChatRoomReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullChatRoomReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullChatRoomReq;
  }

  @override
  void update(void Function(GFullChatRoomReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullChatRoomReq build() {
    _$GFullChatRoomReq _$result;
    try {
      _$result = _$v ??
          new _$GFullChatRoomReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, 'GFullChatRoomReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, 'GFullChatRoomReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GFullChatRoomReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBaseChatRoomReq extends GBaseChatRoomReq {
  @override
  final _i3.GBaseChatRoomVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GBaseChatRoomReq(
          [void Function(GBaseChatRoomReqBuilder)? updates]) =>
      (new GBaseChatRoomReqBuilder()..update(updates)).build();

  _$GBaseChatRoomReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, 'GBaseChatRoomReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, 'GBaseChatRoomReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, 'GBaseChatRoomReq', 'idFields');
  }

  @override
  GBaseChatRoomReq rebuild(void Function(GBaseChatRoomReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBaseChatRoomReqBuilder toBuilder() =>
      new GBaseChatRoomReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBaseChatRoomReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, vars.hashCode), document.hashCode),
            fragmentName.hashCode),
        idFields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GBaseChatRoomReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GBaseChatRoomReqBuilder
    implements Builder<GBaseChatRoomReq, GBaseChatRoomReqBuilder> {
  _$GBaseChatRoomReq? _$v;

  _i3.GBaseChatRoomVarsBuilder? _vars;
  _i3.GBaseChatRoomVarsBuilder get vars =>
      _$this._vars ??= new _i3.GBaseChatRoomVarsBuilder();
  set vars(_i3.GBaseChatRoomVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GBaseChatRoomReqBuilder() {
    GBaseChatRoomReq._initializeBuilder(this);
  }

  GBaseChatRoomReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBaseChatRoomReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBaseChatRoomReq;
  }

  @override
  void update(void Function(GBaseChatRoomReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GBaseChatRoomReq build() {
    _$GBaseChatRoomReq _$result;
    try {
      _$result = _$v ??
          new _$GBaseChatRoomReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, 'GBaseChatRoomReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, 'GBaseChatRoomReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GBaseChatRoomReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
