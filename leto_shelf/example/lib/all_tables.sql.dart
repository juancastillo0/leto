import 'package:query_builder/query_builder.dart';

import 'dart:convert';

import 'package:query_builder/database/models/sql_values.dart';

class Chat {
  final int id;
  final String name;
  final DateTime createdAt;

  final Map<String, Object?> additionalInfo;

  const Chat({
    required this.id,
    required this.name,
    required this.createdAt,
    this.additionalInfo = const {},
  });

  SqlQuery insertShallowSql(SqlDatabase database) {
    final ctx = SqlContext(database: database, unsafe: false);
    final text = """
INSERT INTO chat(id,name,createdAt)
VALUES (${id.sql.toSql(ctx)},${name.sql.toSql(ctx)},${createdAt.sqlDateTime.toSql(ctx)});
""";

    return SqlQuery(text, ctx.variables);
  }

  Future<SqlQueryResult> insertShallow(TableConnection conn) {
    final sqlQuery = insertShallowSql(conn.database);
    return conn.query(sqlQuery.query, sqlQuery.params);
  }

  static SqlQuery selectSql({
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    required SqlDatabase database,
    bool unsafe = false,
  }) {
    final ctx = SqlContext(database: database, unsafe: unsafe);
    final query = """
SELECT id,name,createdAt

FROM chat

${where == null ? '' : 'WHERE ${where.toSql(ctx)}'}
GROUP BY id
${orderBy == null ? '' : 'ORDER BY ${orderBy.map((item) => item.toSql(ctx)).join(",")}'}
${limit == null ? '' : 'LIMIT ${limit.rowCount} ${limit.offset == null ? "" : "OFFSET ${limit.offset}"}'}
;
""";
    return SqlQuery(query, ctx.variables);
  }

  static Future<List<Chat>> select(
    TableConnection conn, {
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
  }) async {
    final query = Chat.selectSql(
      where: where,
      limit: limit,
      orderBy: orderBy,
      database: conn.database,
    );

    final result = await conn.query(query.query, query.params);
    int _refIndex = 3;

    return result.map((r) {
      return Chat(
        id: r[0] as int,
        name: r[1] as String,
        createdAt: r[2] is DateTime
            ? r[2] as DateTime
            : r[2] is int
                ? DateTime.fromMillisecondsSinceEpoch(r[2] as int)
                : DateTime.parse(r[2] as String),
      );
    }).toList();
  }

  factory Chat.fromJson(dynamic json) {
    final Map map;
    if (json is Chat) {
      return json;
    } else if (json is Map) {
      map = json;
    } else if (json is String) {
      map = jsonDecode(json) as Map;
    } else {
      throw Error();
    }

    return Chat(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String),
    );
  }

  static List<Chat>? listFromJson(dynamic _json) {
    final Object? json = _json is String ? jsonDecode(_json) : _json;

    if (json is List || json is Set) {
      return (json as Iterable).map((Object? e) => Chat.fromJson(e)).toList();
    } else if (json is Map) {
      final _jsonMap = json.cast<String, List>();
      final id = _jsonMap["id"];
      final name = _jsonMap["name"];
      final createdAt = _jsonMap["createdAt"];

      return Iterable.generate(
        (id?.length ?? name?.length ?? createdAt?.length)!,
        (_ind) {
          return Chat(
            id: (id?[_ind]) as int,
            name: (name?[_ind]) as String,
            createdAt: (createdAt?[_ind]) is DateTime
                ? (createdAt?[_ind]) as DateTime
                : (createdAt?[_ind]) is int
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (createdAt?[_ind]) as int)
                    : DateTime.parse((createdAt?[_ind]) as String),
          );
        },
      ).toList();
    } else {
      return _json as List<Chat>?;
    }
  }
}

class ChatCols {
  ChatCols(String tableAlias)
      : id = SqlValue.raw('$tableAlias.id'),
        name = SqlValue.raw('$tableAlias.name'),
        createdAt = SqlValue.raw('$tableAlias.createdAt');

  final SqlValue<SqlNumValue> id;
  final SqlValue<SqlStringValue> name;
  final SqlValue<SqlDateValue> createdAt;

  late final List<SqlValue> allColumns = [
    id,
    name,
    createdAt,
  ];
}

class Message {
  final int id;
  final int chatId;
  final String message;
  final DateTime createdAt;
  final int? referencedMessageId;

  final List<Chat>? refChat;
  final List<Message>? refMessage;

  final Map<String, Object?> additionalInfo;

  const Message({
    required this.id,
    required this.chatId,
    required this.message,
    required this.createdAt,
    this.referencedMessageId,
    this.refChat,
    this.refMessage,
    this.additionalInfo = const {},
  });

  SqlQuery insertShallowSql(SqlDatabase database) {
    final ctx = SqlContext(database: database, unsafe: false);
    final text = """
INSERT INTO message(id,chatId,message,createdAt,referencedMessageId)
VALUES (${id.sql.toSql(ctx)},${chatId.sql.toSql(ctx)},${message.sql.toSql(ctx)},${createdAt.sqlDateTime.toSql(ctx)},${(referencedMessageId?.sql ?? SqlValue.null_).toSql(ctx)});
""";

    return SqlQuery(text, ctx.variables);
  }

  Future<SqlQueryResult> insertShallow(TableConnection conn) {
    final sqlQuery = insertShallowSql(conn.database);
    return conn.query(sqlQuery.query, sqlQuery.params);
  }

  static SqlQuery selectSql({
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    required SqlDatabase database,
    bool unsafe = false,
    bool withChat = false,
    bool withMessage = false,
  }) {
    final ctx = SqlContext(database: database, unsafe: unsafe);
    final query = """
SELECT id,chatId,message,createdAt,referencedMessageId
${withChat ? ",JSON_ARRAYAGG(JSON_OBJECT('id',chat.id,'name',chat.name,'createdAt',chat.createdAt)) refChat" : ""}
${withMessage ? ",JSON_ARRAYAGG(JSON_OBJECT('id',message.id,'chatId',message.chatId,'message',message.message,'createdAt',message.createdAt,'referencedMessageId',message.referencedMessageId)) refMessage" : ""}
FROM message
${withChat ? "JOIN chat ON message.chatId=chat.id" : ""}
${withMessage ? "JOIN message ON message.referencedMessageId=message.id" : ""}
${where == null ? '' : 'WHERE ${where.toSql(ctx)}'}
GROUP BY id
${orderBy == null ? '' : 'ORDER BY ${orderBy.map((item) => item.toSql(ctx)).join(",")}'}
${limit == null ? '' : 'LIMIT ${limit.rowCount} ${limit.offset == null ? "" : "OFFSET ${limit.offset}"}'}
;
""";
    return SqlQuery(query, ctx.variables);
  }

  static Future<List<Message>> select(
    TableConnection conn, {
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    bool withChat = false,
    bool withMessage = false,
  }) async {
    final query = Message.selectSql(
      where: where,
      limit: limit,
      orderBy: orderBy,
      database: conn.database,
      withChat: withChat,
      withMessage: withMessage,
    );

    final result = await conn.query(query.query, query.params);
    int _refIndex = 5;

    return result.map((r) {
      return Message(
        id: r[0] as int,
        chatId: r[1] as int,
        message: r[2] as String,
        createdAt: r[3] is DateTime
            ? r[3] as DateTime
            : r[3] is int
                ? DateTime.fromMillisecondsSinceEpoch(r[3] as int)
                : DateTime.parse(r[3] as String),
        referencedMessageId: r[4] as int?,
        refChat: withChat ? Chat.listFromJson(r[_refIndex++]) : null,
        refMessage: withMessage ? Message.listFromJson(r[_refIndex++]) : null,
      );
    }).toList();
  }

  factory Message.fromJson(dynamic json) {
    final Map map;
    if (json is Message) {
      return json;
    } else if (json is Map) {
      map = json;
    } else if (json is String) {
      map = jsonDecode(json) as Map;
    } else {
      throw Error();
    }

    return Message(
      id: map['id'] as int,
      chatId: map['chatId'] as int,
      message: map['message'] as String,
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String),
      referencedMessageId: map['referencedMessageId'] as int?,
      refChat: Chat.listFromJson(map["refChat"]),
      refMessage: Message.listFromJson(map["refMessage"]),
    );
  }

  static List<Message>? listFromJson(dynamic _json) {
    final Object? json = _json is String ? jsonDecode(_json) : _json;

    if (json is List || json is Set) {
      return (json as Iterable)
          .map((Object? e) => Message.fromJson(e))
          .toList();
    } else if (json is Map) {
      final _jsonMap = json.cast<String, List>();
      final id = _jsonMap["id"];
      final chatId = _jsonMap["chatId"];
      final message = _jsonMap["message"];
      final createdAt = _jsonMap["createdAt"];
      final referencedMessageId = _jsonMap["referencedMessageId"];
      final refChat = _jsonMap['refChat'];
      final refMessage = _jsonMap['refMessage'];
      return Iterable.generate(
        (id?.length ??
            chatId?.length ??
            message?.length ??
            createdAt?.length ??
            referencedMessageId?.length ??
            refChat?.length ??
            refMessage?.length)!,
        (_ind) {
          return Message(
            id: (id?[_ind]) as int,
            chatId: (chatId?[_ind]) as int,
            message: (message?[_ind]) as String,
            createdAt: (createdAt?[_ind]) is DateTime
                ? (createdAt?[_ind]) as DateTime
                : (createdAt?[_ind]) is int
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (createdAt?[_ind]) as int)
                    : DateTime.parse((createdAt?[_ind]) as String),
            referencedMessageId: (referencedMessageId?[_ind]) as int?,
            refChat: Chat.listFromJson(refChat?[_ind]),
            refMessage: Message.listFromJson(refMessage?[_ind]),
          );
        },
      ).toList();
    } else {
      return _json as List<Message>?;
    }
  }
}

class MessageCols {
  MessageCols(String tableAlias)
      : id = SqlValue.raw('$tableAlias.id'),
        chatId = SqlValue.raw('$tableAlias.chatId'),
        message = SqlValue.raw('$tableAlias.message'),
        createdAt = SqlValue.raw('$tableAlias.createdAt'),
        referencedMessageId = SqlValue.raw('$tableAlias.referencedMessageId');

  final SqlValue<SqlNumValue> id;
  final SqlValue<SqlNumValue> chatId;
  final SqlValue<SqlStringValue> message;
  final SqlValue<SqlDateValue> createdAt;
  final SqlValue<SqlNumValue> referencedMessageId;

  late final List<SqlValue> allColumns = [
    id,
    chatId,
    message,
    createdAt,
    referencedMessageId,
  ];
}

class User {
  final int id;
  final String? name;
  final String password2;
  final DateTime createdAt;

  final Map<String, Object?> additionalInfo;

  const User({
    required this.id,
    this.name,
    required this.password2,
    required this.createdAt,
    this.additionalInfo = const {},
  });

  SqlQuery insertShallowSql(SqlDatabase database) {
    final ctx = SqlContext(database: database, unsafe: false);
    final text = """
INSERT INTO user(id,name,password2,createdAt)
VALUES (${id.sql.toSql(ctx)},${(name?.sql ?? SqlValue.null_).toSql(ctx)},${password2.sql.toSql(ctx)},${createdAt.sqlDateTime.toSql(ctx)});
""";

    return SqlQuery(text, ctx.variables);
  }

  Future<SqlQueryResult> insertShallow(TableConnection conn) {
    final sqlQuery = insertShallowSql(conn.database);
    return conn.query(sqlQuery.query, sqlQuery.params);
  }

  static SqlQuery selectSql({
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    required SqlDatabase database,
    bool unsafe = false,
  }) {
    final ctx = SqlContext(database: database, unsafe: unsafe);
    final query = """
SELECT id,name,password2,createdAt

FROM user

${where == null ? '' : 'WHERE ${where.toSql(ctx)}'}
GROUP BY id
${orderBy == null ? '' : 'ORDER BY ${orderBy.map((item) => item.toSql(ctx)).join(",")}'}
${limit == null ? '' : 'LIMIT ${limit.rowCount} ${limit.offset == null ? "" : "OFFSET ${limit.offset}"}'}
;
""";
    return SqlQuery(query, ctx.variables);
  }

  static Future<List<User>> select(
    TableConnection conn, {
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
  }) async {
    final query = User.selectSql(
      where: where,
      limit: limit,
      orderBy: orderBy,
      database: conn.database,
    );

    final result = await conn.query(query.query, query.params);
    int _refIndex = 4;

    return result.map((r) {
      return User(
        id: r[0] as int,
        name: r[1] as String?,
        password2: r[2] as String,
        createdAt: r[3] is DateTime
            ? r[3] as DateTime
            : r[3] is int
                ? DateTime.fromMillisecondsSinceEpoch(r[3] as int)
                : DateTime.parse(r[3] as String),
      );
    }).toList();
  }

  factory User.fromJson(dynamic json) {
    final Map map;
    if (json is User) {
      return json;
    } else if (json is Map) {
      map = json;
    } else if (json is String) {
      map = jsonDecode(json) as Map;
    } else {
      throw Error();
    }

    return User(
      id: map['id'] as int,
      name: map['name'] as String?,
      password2: map['password2'] as String,
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String),
    );
  }

  static List<User>? listFromJson(dynamic _json) {
    final Object? json = _json is String ? jsonDecode(_json) : _json;

    if (json is List || json is Set) {
      return (json as Iterable).map((Object? e) => User.fromJson(e)).toList();
    } else if (json is Map) {
      final _jsonMap = json.cast<String, List>();
      final id = _jsonMap["id"];
      final name = _jsonMap["name"];
      final password2 = _jsonMap["password2"];
      final createdAt = _jsonMap["createdAt"];

      return Iterable.generate(
        (id?.length ?? name?.length ?? password2?.length ?? createdAt?.length)!,
        (_ind) {
          return User(
            id: (id?[_ind]) as int,
            name: (name?[_ind]) as String?,
            password2: (password2?[_ind]) as String,
            createdAt: (createdAt?[_ind]) is DateTime
                ? (createdAt?[_ind]) as DateTime
                : (createdAt?[_ind]) is int
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (createdAt?[_ind]) as int)
                    : DateTime.parse((createdAt?[_ind]) as String),
          );
        },
      ).toList();
    } else {
      return _json as List<User>?;
    }
  }
}

class UserCols {
  UserCols(String tableAlias)
      : id = SqlValue.raw('$tableAlias.id'),
        name = SqlValue.raw('$tableAlias.name'),
        password2 = SqlValue.raw('$tableAlias.password2'),
        createdAt = SqlValue.raw('$tableAlias.createdAt');

  final SqlValue<SqlNumValue> id;
  final SqlValue<SqlStringValue> name;
  final SqlValue<SqlStringValue> password2;
  final SqlValue<SqlDateValue> createdAt;

  late final List<SqlValue> allColumns = [
    id,
    name,
    password2,
    createdAt,
  ];
}

class UserSession {
  final String sessionCode;
  final int userId;
  final String ip;
  final String userAgent;
  final String platform;
  final String appVersion;
  final DateTime createdAt;

  final List<User>? refUser;

  final Map<String, Object?> additionalInfo;

  const UserSession({
    required this.sessionCode,
    required this.userId,
    required this.ip,
    required this.userAgent,
    required this.platform,
    required this.appVersion,
    required this.createdAt,
    this.refUser,
    this.additionalInfo = const {},
  });

  SqlQuery insertShallowSql(SqlDatabase database) {
    final ctx = SqlContext(database: database, unsafe: false);
    final text = """
INSERT INTO userSession(sessionCode,userId,ip,userAgent,platform,appVersion,createdAt)
VALUES (${sessionCode.sql.toSql(ctx)},${userId.sql.toSql(ctx)},${ip.sql.toSql(ctx)},${userAgent.sql.toSql(ctx)},${platform.sql.toSql(ctx)},${appVersion.sql.toSql(ctx)},${createdAt.sqlDateTime.toSql(ctx)});
""";

    return SqlQuery(text, ctx.variables);
  }

  Future<SqlQueryResult> insertShallow(TableConnection conn) {
    final sqlQuery = insertShallowSql(conn.database);
    return conn.query(sqlQuery.query, sqlQuery.params);
  }

  static SqlQuery selectSql({
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    required SqlDatabase database,
    bool unsafe = false,
    bool withUser = false,
  }) {
    final ctx = SqlContext(database: database, unsafe: unsafe);
    final query = """
SELECT sessionCode,userId,ip,userAgent,platform,appVersion,createdAt
${withUser ? ",JSON_ARRAYAGG(JSON_OBJECT('id',user.id,'name',user.name,'password2',user.password2,'createdAt',user.createdAt)) refUser" : ""}
FROM userSession
${withUser ? "JOIN user ON userSession.userId=user.id" : ""}
${where == null ? '' : 'WHERE ${where.toSql(ctx)}'}
GROUP BY sessionCode
${orderBy == null ? '' : 'ORDER BY ${orderBy.map((item) => item.toSql(ctx)).join(",")}'}
${limit == null ? '' : 'LIMIT ${limit.rowCount} ${limit.offset == null ? "" : "OFFSET ${limit.offset}"}'}
;
""";
    return SqlQuery(query, ctx.variables);
  }

  static Future<List<UserSession>> select(
    TableConnection conn, {
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    bool withUser = false,
  }) async {
    final query = UserSession.selectSql(
      where: where,
      limit: limit,
      orderBy: orderBy,
      database: conn.database,
      withUser: withUser,
    );

    final result = await conn.query(query.query, query.params);
    int _refIndex = 7;

    return result.map((r) {
      return UserSession(
        sessionCode: r[0] as String,
        userId: r[1] as int,
        ip: r[2] as String,
        userAgent: r[3] as String,
        platform: r[4] as String,
        appVersion: r[5] as String,
        createdAt: r[6] is DateTime
            ? r[6] as DateTime
            : r[6] is int
                ? DateTime.fromMillisecondsSinceEpoch(r[6] as int)
                : DateTime.parse(r[6] as String),
        refUser: withUser ? User.listFromJson(r[_refIndex++]) : null,
      );
    }).toList();
  }

  factory UserSession.fromJson(dynamic json) {
    final Map map;
    if (json is UserSession) {
      return json;
    } else if (json is Map) {
      map = json;
    } else if (json is String) {
      map = jsonDecode(json) as Map;
    } else {
      throw Error();
    }

    return UserSession(
      sessionCode: map['sessionCode'] as String,
      userId: map['userId'] as int,
      ip: map['ip'] as String,
      userAgent: map['userAgent'] as String,
      platform: map['platform'] as String,
      appVersion: map['appVersion'] as String,
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String),
      refUser: User.listFromJson(map["refUser"]),
    );
  }

  static List<UserSession>? listFromJson(dynamic _json) {
    final Object? json = _json is String ? jsonDecode(_json) : _json;

    if (json is List || json is Set) {
      return (json as Iterable)
          .map((Object? e) => UserSession.fromJson(e))
          .toList();
    } else if (json is Map) {
      final _jsonMap = json.cast<String, List>();
      final sessionCode = _jsonMap["sessionCode"];
      final userId = _jsonMap["userId"];
      final ip = _jsonMap["ip"];
      final userAgent = _jsonMap["userAgent"];
      final platform = _jsonMap["platform"];
      final appVersion = _jsonMap["appVersion"];
      final createdAt = _jsonMap["createdAt"];
      final refUser = _jsonMap['refUser'];
      return Iterable.generate(
        (sessionCode?.length ??
            userId?.length ??
            ip?.length ??
            userAgent?.length ??
            platform?.length ??
            appVersion?.length ??
            createdAt?.length ??
            refUser?.length)!,
        (_ind) {
          return UserSession(
            sessionCode: (sessionCode?[_ind]) as String,
            userId: (userId?[_ind]) as int,
            ip: (ip?[_ind]) as String,
            userAgent: (userAgent?[_ind]) as String,
            platform: (platform?[_ind]) as String,
            appVersion: (appVersion?[_ind]) as String,
            createdAt: (createdAt?[_ind]) is DateTime
                ? (createdAt?[_ind]) as DateTime
                : (createdAt?[_ind]) is int
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (createdAt?[_ind]) as int)
                    : DateTime.parse((createdAt?[_ind]) as String),
            refUser: User.listFromJson(refUser?[_ind]),
          );
        },
      ).toList();
    } else {
      return _json as List<UserSession>?;
    }
  }
}

class UserSessionCols {
  UserSessionCols(String tableAlias)
      : sessionCode = SqlValue.raw('$tableAlias.sessionCode'),
        userId = SqlValue.raw('$tableAlias.userId'),
        ip = SqlValue.raw('$tableAlias.ip'),
        userAgent = SqlValue.raw('$tableAlias.userAgent'),
        platform = SqlValue.raw('$tableAlias.platform'),
        appVersion = SqlValue.raw('$tableAlias.appVersion'),
        createdAt = SqlValue.raw('$tableAlias.createdAt');

  final SqlValue<SqlStringValue> sessionCode;
  final SqlValue<SqlNumValue> userId;
  final SqlValue<SqlStringValue> ip;
  final SqlValue<SqlStringValue> userAgent;
  final SqlValue<SqlStringValue> platform;
  final SqlValue<SqlStringValue> appVersion;
  final SqlValue<SqlDateValue> createdAt;

  late final List<SqlValue> allColumns = [
    sessionCode,
    userId,
    ip,
    userAgent,
    platform,
    appVersion,
    createdAt,
  ];
}

class ChatRoomUser {
  final int userId;
  final int chatId;
  final DateTime createdAt;

  final List<User>? refUser;
  final List<Chat>? refChat;

  final Map<String, Object?> additionalInfo;

  const ChatRoomUser({
    required this.userId,
    required this.chatId,
    required this.createdAt,
    this.refUser,
    this.refChat,
    this.additionalInfo = const {},
  });

  SqlQuery insertShallowSql(SqlDatabase database) {
    final ctx = SqlContext(database: database, unsafe: false);
    final text = """
INSERT INTO chatRoomUser(userId,chatId,createdAt)
VALUES (${userId.sql.toSql(ctx)},${chatId.sql.toSql(ctx)},${createdAt.sqlDateTime.toSql(ctx)});
""";

    return SqlQuery(text, ctx.variables);
  }

  Future<SqlQueryResult> insertShallow(TableConnection conn) {
    final sqlQuery = insertShallowSql(conn.database);
    return conn.query(sqlQuery.query, sqlQuery.params);
  }

  static SqlQuery selectSql({
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    required SqlDatabase database,
    bool unsafe = false,
    bool withUser = false,
    bool withChat = false,
  }) {
    final ctx = SqlContext(database: database, unsafe: unsafe);
    final query = """
SELECT userId,chatId,createdAt
${withUser ? ",JSON_ARRAYAGG(JSON_OBJECT('id',user.id,'name',user.name,'password2',user.password2,'createdAt',user.createdAt)) refUser" : ""}
${withChat ? ",JSON_ARRAYAGG(JSON_OBJECT('id',chat.id,'name',chat.name,'createdAt',chat.createdAt)) refChat" : ""}
FROM chatRoomUser
${withUser ? "JOIN user ON chatRoomUser.userId=user.id" : ""}
${withChat ? "JOIN chat ON chatRoomUser.chatId=chat.id" : ""}
${where == null ? '' : 'WHERE ${where.toSql(ctx)}'}
GROUP BY userId,chatId
${orderBy == null ? '' : 'ORDER BY ${orderBy.map((item) => item.toSql(ctx)).join(",")}'}
${limit == null ? '' : 'LIMIT ${limit.rowCount} ${limit.offset == null ? "" : "OFFSET ${limit.offset}"}'}
;
""";
    return SqlQuery(query, ctx.variables);
  }

  static Future<List<ChatRoomUser>> select(
    TableConnection conn, {
    SqlValue<SqlBoolValue>? where,
    List<SqlOrderItem>? orderBy,
    SqlLimit? limit,
    bool withUser = false,
    bool withChat = false,
  }) async {
    final query = ChatRoomUser.selectSql(
      where: where,
      limit: limit,
      orderBy: orderBy,
      database: conn.database,
      withUser: withUser,
      withChat: withChat,
    );

    final result = await conn.query(query.query, query.params);
    int _refIndex = 3;

    return result.map((r) {
      return ChatRoomUser(
        userId: r[0] as int,
        chatId: r[1] as int,
        createdAt: r[2] is DateTime
            ? r[2] as DateTime
            : r[2] is int
                ? DateTime.fromMillisecondsSinceEpoch(r[2] as int)
                : DateTime.parse(r[2] as String),
        refUser: withUser ? User.listFromJson(r[_refIndex++]) : null,
        refChat: withChat ? Chat.listFromJson(r[_refIndex++]) : null,
      );
    }).toList();
  }

  factory ChatRoomUser.fromJson(dynamic json) {
    final Map map;
    if (json is ChatRoomUser) {
      return json;
    } else if (json is Map) {
      map = json;
    } else if (json is String) {
      map = jsonDecode(json) as Map;
    } else {
      throw Error();
    }

    return ChatRoomUser(
      userId: map['userId'] as int,
      chatId: map['chatId'] as int,
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String),
      refUser: User.listFromJson(map["refUser"]),
      refChat: Chat.listFromJson(map["refChat"]),
    );
  }

  static List<ChatRoomUser>? listFromJson(dynamic _json) {
    final Object? json = _json is String ? jsonDecode(_json) : _json;

    if (json is List || json is Set) {
      return (json as Iterable)
          .map((Object? e) => ChatRoomUser.fromJson(e))
          .toList();
    } else if (json is Map) {
      final _jsonMap = json.cast<String, List>();
      final userId = _jsonMap["userId"];
      final chatId = _jsonMap["chatId"];
      final createdAt = _jsonMap["createdAt"];
      final refUser = _jsonMap['refUser'];
      final refChat = _jsonMap['refChat'];
      return Iterable.generate(
        (userId?.length ??
            chatId?.length ??
            createdAt?.length ??
            refUser?.length ??
            refChat?.length)!,
        (_ind) {
          return ChatRoomUser(
            userId: (userId?[_ind]) as int,
            chatId: (chatId?[_ind]) as int,
            createdAt: (createdAt?[_ind]) is DateTime
                ? (createdAt?[_ind]) as DateTime
                : (createdAt?[_ind]) is int
                    ? DateTime.fromMillisecondsSinceEpoch(
                        (createdAt?[_ind]) as int)
                    : DateTime.parse((createdAt?[_ind]) as String),
            refUser: User.listFromJson(refUser?[_ind]),
            refChat: Chat.listFromJson(refChat?[_ind]),
          );
        },
      ).toList();
    } else {
      return _json as List<ChatRoomUser>?;
    }
  }
}

class ChatRoomUserCols {
  ChatRoomUserCols(String tableAlias)
      : userId = SqlValue.raw('$tableAlias.userId'),
        chatId = SqlValue.raw('$tableAlias.chatId'),
        createdAt = SqlValue.raw('$tableAlias.createdAt');

  final SqlValue<SqlNumValue> userId;
  final SqlValue<SqlNumValue> chatId;
  final SqlValue<SqlDateValue> createdAt;

  late final List<SqlValue> allColumns = [
    userId,
    chatId,
    createdAt,
  ];
}
