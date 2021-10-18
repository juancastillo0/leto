import 'package:query_builder/query_builder.dart';

Future<bool> migrate(
  TableConnection db,
  String tableName,
  List<String> queries,
) async {
  if (queries.isEmpty) {
    return true;
  }

  await db.query('''
    CREATE TABLE IF NOT EXISTS migration (
      tableName TEXT NOT NULL,
      queryIndex INTEGER NOT NULL,
      query TEXT NOT NULL,
      createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (tableName, queryIndex)
    );
  ''');

  final _queryIndex = await db.transaction((db) async {
    final previousResult = await db.query(
      'SELECT query from migration where tableName = ? order by queryIndex;',
      [tableName],
    );
    if (previousResult.length > queries.length) {
      throw Exception('savedQueries.length > queries.length');
    }
    int queryIndex = -1;
    final previous = previousResult.toList();
    for (final query in queries) {
      queryIndex++;
      if (queryIndex < previous.length) {
        final row = previous[queryIndex];
        final savedQuery = row.values.first! as String;
        if (savedQuery != query) {
          throw Exception('savedQuery $savedQuery != query $query');
        }
      } else {
        await db.query(query);
        await db.query(
          'INSERT INTO migration(tableName, queryIndex, query) VALUES (?, ?, ?);',
          [tableName, queryIndex, query],
        );
      }
    }
    return queryIndex;
  });

  final result = await db.query(
    'SELECT query from migration where tableName = ? and queryIndex = ?;',
    [tableName, _queryIndex],
  );
  return result.isNotEmpty;
}
