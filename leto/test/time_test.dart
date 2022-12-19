import 'package:leto/src/types/time.dart';
import 'package:test/test.dart';

void main() {
  void _compareEq(Time t1, Time t2) {
    expect(t1, t2);
    expect(t1, equals(t2));
    expect(t1, greaterThanOrEqualTo(t2));
    expect(t1, lessThanOrEqualTo(t2));
    expect(t1.compareTo(t2), 0);
    expect(t1.toString(), equals(t2.toString()));

    expect(t1.isAtSameMomentAs(t2), true);
    expect(t1.isBefore(t2), false);
    expect(t1.isAfter(t2), false);
  }

  test('parsed time equality', () {
    final t1 = Time.parse('T134730');
    final t2 = Time.parse('T13:47:30');
    final t3 = Time.parse('13:47:30');
    final t4 = Time.parse('T134730');
    final t5 = Time(13, 47, 30);
    _compareEq(t1, t1);
    _compareEq(t1, t2);
    _compareEq(t1, t3);
    _compareEq(t1, t4);
    _compareEq(t1, t5);
    expect('T13:47:30.000', t5.toString());
  }, skip: 'TODO: Time type');

  test('time from datetime', () {
    final t1 = Time.parse('T1200');
    final t2 = Time.fromDateTime(DateTime(100, 2, 3, 12, 0));
    final t3 = Time.fromDateTime(DateTime(10220, 1, 23, 12, 0, 0));
    _compareEq(t1, t2);
    _compareEq(t1, t3);
    expect('T12:00:00.000', t1.toString());
  }, skip: 'TODO: Time type');

  test('time and durations', () {
    final t1 = Time.parse('T1200');
    const delta = Duration(hours: 1);
    final t2 = t1.add(delta);
    _compareEq(t2, Time(13));
    expect(t1, lessThan(t2));
    expect(t2, greaterThan(t1));
    expect(t1.compareTo(t2), lessThan(0));
    expect(t2.compareTo(t1), greaterThan(0));

    expect(t2.difference(t1), delta);
    expect(t1.difference(t2), -delta);
  });

  test('time toString', () {
    final t1 = Time.parse('T1200');
    expect(t1.toString(), 'T12:00:00.000');
  }, skip: 'TODO: Time type');

  test('parse times', () {
    final values = <List<Object>>[
      ['13:05:23.130', Time(13, 5, 23, 130)],
      ['T130523.130', Time(13, 5, 23, 130)],
      ['130523.130', Time(13, 5, 23, 130)],
      ['T13:05:23.130', Time(13, 5, 23, 130)],
      //
      ['03:13:59', Time(3, 13, 59)],
      ['031359', Time(3, 13, 59)],
      ['T031359', Time(3, 13, 59)],
      ['T03:13:59', Time(3, 13, 59)],
      //
      ['23:01', Time(23, 1)],
      ['2301', Time(23, 1)],
      ['T2301', Time(23, 1)],
      ['T23:01', Time(23, 1)],
      //
      ['T03', Time(3)],
    ];
    for (final tuple in values) {
      final tParsed = Time.parse(tuple[0] as String);
      final tExpected = tuple[1] as Time;

      _compareEq(tParsed, tExpected);
    }
  });

  test('parse times with decimals', () {
    final values = <List<Object>>[
      ['03:13:59.5', Time(3, 13, 59, 500)],
      ['031359,25', Time(3, 13, 59, 250)],
      ['T031359.0', Time(3, 13, 59)],
      ['T031359.05', Time(3, 13, 59, 50)],
      ['T03:13:59,2', Time(3, 13, 59, 200)],
      //
      ['23:01.5', Time(23, 1, 30)],
      ['2301,25', Time(23, 1, 15)],
      ['T2301.0', Time(23, 1)],
      ['T23:01,2', Time(23, 1, 12)],
      //
      ['03.5', Time(3, 30)],
      ['03,25', Time(3, 15)],
      ['T03.0', Time(3)],
      ['T03,2', Time(3, 12)],
    ];
    for (final tuple in values) {
      final tParsed = Time.parse(tuple[0] as String);
      final tExpected = tuple[1] as Time;

      _compareEq(tParsed, tExpected);
    }
  });

  test('time utc', () {
    final tUtc = Time.utc(12);
    final tLocal = Time(12);
    expect(tUtc, isNot(equals(tLocal)));
    expect(tUtc, equals(tLocal.toUtc()));

    final withDelta = tLocal.add(tLocal.timeZoneOffset);
    expect(tUtc, isNot(equals(withDelta)));
    expect(withDelta.isAtSameMomentAs(tUtc), true);
    expect(withDelta.isBefore(tUtc), false);
    expect(withDelta.isAfter(tUtc), false);
    expect('T12:00:00.000Z', tUtc.toString());
  }, skip: 'time comparison');
}
