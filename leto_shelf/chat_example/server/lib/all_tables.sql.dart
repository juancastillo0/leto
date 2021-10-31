import 'package:query_builder/query_builder.dart';

import 'dart:convert';

import 'package:query_builder/database/models/sql_values.dart';

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
