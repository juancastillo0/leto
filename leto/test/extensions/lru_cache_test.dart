import 'package:leto/src/extensions/persisted_queries.dart';
import 'package:test/test.dart';

void main() {
  test('lru cache', () {
    final cache = LruCacheSimple<int, int>(3);

    cache.set(1, 1);
    expect(cache.map.length, 1);
    cache.set(2, 2);
    cache.set(3, 3);
    expect(cache.map.length, 3);
    cache.set(4, 4);
    expect(cache.map.length, 3);

    expect(cache.get(1), null);
    cache.set(1, 1);
    expect(cache.get(2), null);

    expect(cache.get(4), 4);
    cache.set(5, 5);
    expect(cache.get(3), null);

    expect(cache.get(5), 5);
    cache.delete(5);
    expect(cache.get(5), null);

    cache.clear();
    expect(cache.map.length, 0);
    expect(cache.linkedList.length, 0);
  });

  test('lru cache from map', () {
    final _map = {'1': 1, '2': 2, '3': 3, '4': 4, '5': 5};
    final cache = LruCacheSimple<String, int>.fromMap(4, _map);

    expect(cache.map.length, 4);
    expect(cache.linkedList.length, 4);

    int _notFound() {
      int notFound = 0;
      for (final e in _map.entries) {
        if (cache.get(e.key) == null) {
          notFound++;
        }
      }
      return notFound;
    }

    expect(_notFound(), 1);

    cache.set('6', 6);
    expect(cache.map.length, 4);
    expect(_notFound(), 2);

    cache.clear();
    expect(cache.map.length, 0);
    expect(cache.linkedList.length, 0);
  });
}
