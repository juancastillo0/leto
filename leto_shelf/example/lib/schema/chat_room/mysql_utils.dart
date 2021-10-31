import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mysql1/mysql1.dart';
import 'package:query_builder/query_builder.dart';
import 'package:shelf_graphql_example/schema/chat_room/mapped_iterator.dart';

class MySqlConn extends TableConnection {
  final MySqlConnection _db;

  MySqlConn(this._db);

  @override
  SqlDatabase get database => SqlDatabase.mysql;

  @override
  Future<MySqlQueryResult> query(
    String sqlQuery, [
    List<Object?>? values,
  ]) async {
    final result = await _db.query(
      sqlQuery,
      values ?? const [],
    );

    return MySqlQueryResult(
      sqlResult: result,
      affectedRows: result.affectedRows,
      insertId: result.insertId,
    );
  }

  @override
  Future<T> transaction<T>(
    Future<T> Function(TransactionCtx) transactionFn,
  ) async {
    if (this is TransactionCtx) {
      return transactionFn(this as TransactionCtx);
    }
    T? result;
    await _db.transaction((dynamic mysqlCtx) async {
      final ctx = TransactionCtx.fromConnection(
        this,
        rollback: () {
          // TODO:
          mysqlCtx.rollback();
          throw Error();
        },
      );
      result = await transactionFn(ctx);
    });
    // TODO:
    return result as T;
  }
}

class MySqlQueryResult extends SqlQueryResult with IterableMixin<SqlRow> {
  final Results sqlResult;
  @override
  final int? affectedRows;
  @override
  final int? insertId;

  MySqlQueryResult({
    required this.sqlResult,
    required this.affectedRows,
    this.insertId,
  });

  @override
  Iterator<MySqlRow> get iterator {
    return MappedIterator<ResultRow, MySqlRow>(
      sqlResult.iterator,
      (r) => MySqlRow(r),
    );
  }
}

class MySqlRow extends SqlRow
    with UnmodifiableMapMixin<String, dynamic>, MapMixin<String, dynamic> {
  final ResultRow row;

  MySqlRow(this.row);

  @override
  Object? operator [](Object? key) {
    return row[key];
  }

  @override
  Object? columnAt(int index) {
    return row.values != null ? row.values![index] : null;
  }

  @override
  Iterable<String> get keys => row.fields.keys;

  @override
  List<Object?>? get columnsValues => row.values;

  @override
  Map<String?, Map<String, dynamic>> toTableColumnMap() {
    // TODO: implement toTableColumnMap
    throw UnimplementedError();
  }
}
