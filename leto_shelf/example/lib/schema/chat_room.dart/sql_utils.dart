// class DbCtx {
//   static Future<DbCtx> create() {
//      final x = ;

//   }
// }

import 'package:sqlite3/sqlite3.dart';

bool migrate(Database db, String tableName, List<String> queries) {
  if (queries.isEmpty) {
    return true;
  }
  db.execute('''
    CREATE TABLE IF NOT EXISTS migration (
      tableName TEXT NOT NULL,
      queryIndex INTEGER NOT NULL,
      query TEXT NOT NULL,
      createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (tableName, queryIndex)
    );
  ''');

  db.execute('BEGIN TRANSACTION;');
  final previous = db.select(
    'SELECT query from migration where tableName = ? order by queryIndex;',
    [tableName],
  );
  if (previous.length > queries.length) {
    throw Exception('savedQueries.length > queries.length');
  }

  int queryIndex = -1;
  for (final query in queries) {
    queryIndex++;
    if (queryIndex < previous.length) {
      final row = previous.rows[queryIndex];
      final savedQuery = row.first! as String;
      if (savedQuery != query) {
        throw Exception('savedQuery $savedQuery != query $query');
      }
    } else {
      db.execute(query);
      db.execute(
        'INSERT INTO migration(tableName, queryIndex, query) VALUES (?, ?, ?);',
        [tableName, queryIndex, query],
      );
    }
  }
  db.execute('COMMIT;');

  final result = db.select(
    'SELECT query from migration where tableName = ? and queryIndex = ?;',
    [tableName, queryIndex],
  );
  return result.isNotEmpty;
}
