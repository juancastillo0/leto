import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:query_builder/query_builder.dart';
import 'package:shelf_graphql_example/schema/chat_room/mapped_iterator.dart';
import 'package:sqlite3/sqlite3.dart';

class SqliteConnection extends TableConnection {
  final Database _db;

  SqliteConnection(this._db);

  @override
  SqlDatabase get database => SqlDatabase.sqlite;

  @override
  Future<SqliteQueryResult> query(
    String sqlQuery, [
    List<Object?>? values,
  ]) async {
    final result = _db.select(
      sqlQuery,
      values ?? const [],
    );
    // TODO: distinguish between select and update/insert/delete
    final updated = _db.getUpdatedRows();
    final insertId = _db.lastInsertRowId;
    final isSelect = result.columnNames.isNotEmpty;

    return SqliteQueryResult(
      sqlResult: result,
      affectedRows: isSelect ? updated : null,
      insertId: isSelect ? insertId : null,
    );
  }

  @override
  Future<T> transaction<T>(
    Future<T> Function(TransactionCtx context) transactionFn,
  ) async {
    if (this is TransactionCtx) {
      return transactionFn(this as TransactionCtx);
    }
    _db.execute('BEGIN TRANSACTION');
    bool success = false;
    try {
      final ctx = TransactionCtx.fromConnection(
        this,
        rollback: () {
          _db.execute('ROLLBACK');
          throw Error();
        },
      );
      final result = await transactionFn(ctx);
      _db.execute('COMMIT');
      success = true;
      return result;
    } finally {
      if (!success) {
        _db.execute('ROLLBACK');
      }
    }
  }
}

class SqliteQueryResult extends SqlQueryResult with IterableMixin<SqlRow> {
  final ResultSet sqlResult;
  @override
  final int? affectedRows;
  @override
  final int? insertId;

  SqliteQueryResult({
    required this.sqlResult,
    required this.affectedRows,
    required this.insertId,
  });

  @override
  Iterator<SqliteRow> get iterator {
    return MappedIterator<Row, SqliteRow>(
      sqlResult.iterator,
      (r) => SqliteRow(r),
    );
  }
}

class SqliteRow extends SqlRow
    with UnmodifiableMapMixin<String, dynamic>, MapMixin<String, dynamic> {
  final Row row;

  SqliteRow(this.row);

  @override
  Object? operator [](Object? key) {
    return row[key];
  }

  @override
  Object? columnAt(int index) {
    return row.columnAt(index);
  }

  @override
  Iterable<String> get keys => row.keys;

  @override
  List<Object?>? get columnsValues =>
      Iterable.generate(row.keys.length, columnAt).toList();
}
