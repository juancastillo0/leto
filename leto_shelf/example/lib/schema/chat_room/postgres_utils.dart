import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';
import 'package:query_builder/query_builder.dart';
import 'package:shelf_graphql_example/schema/chat_room/mapped_iterator.dart';

class PostgresConn extends TableConnection {
  final PostgreSQLConnection _db;

  PostgresConn(this._db);

  @override
  SqlDatabase get database => SqlDatabase.postgres;

  @override
  Future<PostgresQueryResult> query(
    String sqlQuery, [
    List<Object?>? values,
  ]) async {
    final substitutionValues = values == null
        ? null
        : Map.fromEntries(
            values.mapIndexed((i, e) => MapEntry('$i', e)),
          );
    final result = await _db.query(
      sqlQuery,
      substitutionValues: substitutionValues,
    );

    return PostgresQueryResult(
      sqlResult: result,
      affectedRows: result.affectedRowCount,
      insertId: null,
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
    final Object? tResult = await _db.transaction(
      (PostgreSQLExecutionContext postgresCtx) async {
        final ctx = TransactionCtx.fromConnection(
          this,
          rollback: () {
            postgresCtx.cancelTransaction();
            throw Error();
          },
        );
        result = await transactionFn(ctx);
      },
    );
    if (tResult is PostgreSQLRollback) {}
    // TODO:
    return result as T;
  }
}

class PostgresQueryResult extends SqlQueryResult with IterableMixin<SqlRow> {
  final PostgreSQLResult sqlResult;
  @override
  final int? affectedRows;
  @override
  final int? insertId;

  PostgresQueryResult({
    required this.sqlResult,
    required this.affectedRows,
    this.insertId,
  });

  @override
  Iterator<PostgresRow> get iterator {
    return MappedIterator<PostgreSQLResultRow, PostgresRow>(
      sqlResult.iterator,
      (r) => PostgresRow(r),
    );
  }
}

class PostgresRow extends SqlRow
    with UnmodifiableMapMixin<String, dynamic>, MapMixin<String, dynamic> {
  final PostgreSQLResultRow row;

  PostgresRow(this.row);

  @override
  Object? operator [](Object? key) {
    // TODO: verify
    return row.toColumnMap()[key];
  }

  @override
  Object? columnAt(int index) {
    return row[index];
  }

  @override
  // TODO: verify
  Iterable<String> get keys => row.columnDescriptions.map((e) => e.columnName);

  @override
  List<Object?>? get columnsValues => row;
}
