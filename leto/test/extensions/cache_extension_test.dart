import 'dart:convert' show json;

import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:leto/leto.dart';
import 'package:leto/src/extensions/persisted_queries.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

import 'tasks_schema.dart';

void main() {
  final scope = ScopedMap();
  final cache = LruCacheSimple<String, CacheEntry>(10);
  final executor = GraphQL(
    tasksSchema,
    globalVariables: scope,
    extensions: [
      CacheExtension(cache: cache),
    ],
  );

  const query = '''
{ getTasks {
  id
  name
  description
  image
  weight
  extra
  createdTimestamp
  assignedTo {
    id
    name
  }
} }
''';

  Future<Map<String, Object?>> _exec(
    String query, {
    String? operationName,
    Map<String, Object?>? extensions,
  }) async {
    final result = await executor.parseAndExecute(
      query,
      operationName: operationName,
      extensions: extensions,
    );
    return json.decode(json.encode(result)) as Map<String, Object?>;
  }

  /// Runs a callback using FakeAsync.run while continually pumping the
  /// microtask queue. This avoids a deadlock when tests `await` a Future
  /// which queues a microtask that will not be processed unless the queue
  /// is flushed.
  Future<T> runFakeAsync<T>(Future<T> Function(FakeAsync time) f) async {
    return FakeAsync().run((FakeAsync time) async {
      bool pump = true;
      final Future<T> future = f(time).whenComplete(() => pump = false);
      while (pump) {
        time.flushMicrotasks();
      }
      return future;
    });
  }

  test('cache root value', () {
    return runFakeAsync((async) async {
      final before = clock.now();

      expect(cache.linkedList.length, 0);
      async.elapse(const Duration(seconds: 1));
      final result = await _exec(query, extensions: {
        'cacheResponse': {'maxAgeSeconds': 100}
      });
      final rootKey = '$queryHash:::';

      expect(result['errors'], isNull);
      expect(cache.linkedList.length, 1);
      final cached1 = cache.get(rootKey)!;
      expect(cached1.cachedAt.isAfter(before), true);
      expect(cache.get(rootKey)?.data, result['data']);
      expect((cache.get(rootKey)?.data as Map)['getTasks'].length, 2);

      tasksRef.get(scope).tasks.removeLast();

      async.elapse(const Duration(seconds: 1));
      final result2 = await _exec(query, extensions: {
        'cacheResponse': {'maxAgeSeconds': 100}
      });
      expect(result2['errors'], isNull);
      expect(cache.get(rootKey), cached1);
      expect(cache.get(rootKey)?.data, result2['data']);

      async.elapse(const Duration(seconds: 101));
      final result3 = await _exec(query, extensions: {
        'cacheResponse': {'maxAgeSeconds': 100}
      });
      expect(cache.linkedList.length, 1);
      expect(result3['errors'], isNull);
      final cachedAt2 = cache.get(rootKey)!.cachedAt;
      expect(cachedAt2.isAfter(cached1.cachedAt), true);
      expect(cache.get(rootKey)?.data, result3['data']);
      expect((cache.get(rootKey)?.data as Map)['getTasks'].length, 1);
    });
  });
}
