import 'dart:math' as math;

import 'package:meta/meta.dart';

@immutable
class Time implements Comparable<Time> {
  final int _microseconds;
  final int _timezoneMinutesOffset;

  ///
  Time(
    int hour, [
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : this._inner(
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  ///
  Time.overflow({
    required int hour,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
    int? timezoneMinutesOffset,
  }) : this.fromMicroseconds(
          microseconds: overflowMicrosecondsIntoDayRange(_computeMicroseconds(
            hour,
            minute,
            second,
            millisecond,
            microsecond,
          )),
          timezoneMinutesOffset: timezoneMinutesOffset,
        );

  static int _computeMicroseconds(
    int hour, [
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) =>
      hour * Duration.microsecondsPerHour +
      minute * Duration.microsecondsPerMinute +
      second * Duration.microsecondsPerSecond +
      millisecond * Duration.microsecondsPerMillisecond +
      microsecond;

  Time._inner(
    int hour, [
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
    int? timezoneMinutesOffset,
  ])  : _timezoneMinutesOffset =
            timezoneMinutesOffset ?? DateTime(0).timeZoneOffset.inMinutes,
        _microseconds = hour * Duration.microsecondsPerHour +
            minute * Duration.microsecondsPerMinute +
            second * Duration.microsecondsPerSecond +
            millisecond * Duration.microsecondsPerMillisecond +
            microsecond {
    final errors = [
      if (hour < 0 || hour >= 24)
        'Hour time component should be less than 24, got $hour.',
      if (minute < 0 || minute >= 60)
        'Minute time component should be less than 60, got $minute.',
      if (second < 0 || second >= 61)
        'Second time component should be less than 61, got $second.',
      if (millisecond < 0 || millisecond >= 1000)
        'Millisecond time component should be less than 1000, got $millisecond.',
      if (microsecond < 0 || microsecond >= 1000)
        'Microsecond time component should be less than 1000, got $microsecond.',
    ];
    if (errors.isNotEmpty) {
      throw FormatException(
        errors.join(' '),
        'T$hour:$minute:${second + millisecond / 1000 + microsecond / 1000000}',
      );
    }
  }

  Time.fromMicroseconds({
    required int microseconds,
    int? timezoneMinutesOffset,
  })  : _timezoneMinutesOffset =
            timezoneMinutesOffset ?? DateTime(0).timeZoneOffset.inMinutes,
        _microseconds = microseconds {
    if (_microseconds != overflowMicrosecondsIntoDayRange(_microseconds)) {
      throw ArgumentError(
        'Time.fromMicroseconds(microseconds) not in day range',
      );
    }
  }

  ///
  Time.utc(
    int hour, [
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : this._inner(
          hour,
          minute,
          second,
          millisecond,
          microsecond,
          0,
        );

  ///
  Time.named({
    required int hour,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
    int? timezoneMinutesOffset,
  }) : this._inner(
          hour,
          minute,
          second,
          millisecond,
          microsecond,
          timezoneMinutesOffset,
        );

  Time.fromDateTime(DateTime dateTime)
      : this.named(
          hour: dateTime.hour,
          minute: dateTime.minute,
          second: dateTime.second,
          millisecond: dateTime.millisecond,
          microsecond: dateTime.microsecond,
          timezoneMinutesOffset: dateTime.isUtc ? 0 : null,
        );
  Time.now() : this.fromDateTime(DateTime.now());

  static final midnight = Time(0);

  // factory Time.parse(String input) => Time.fromDateTime(
  //     DateTime.parse('0000-01-01${input.startsWith('T') ? '' : 'T'}$input'),
  //   );

  @override
  String toString() {
    final _date = DateTime.fromMicrosecondsSinceEpoch(_microseconds);
    final dateStr = _date.toIso8601String();
    return dateStr.substring(dateStr.indexOf('T'));
  }

  static Time? tryParse(String formattedString) {
    // TODO: 3T Optimize to avoid throwing.
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  static Time parse(String formattedString) {
    final Match? match = _parseFormat.firstMatch(formattedString);
    if (match == null) {
      throw FormatException('Invalid date format', formattedString);
    }
    int parseIntOrZero(int index) {
      final str = match[index];
      if (str == null) return 0;
      return int.parse(str);
    }

    int? parseIntOrNull(int index) {
      final str = match[index];
      if (str == null) return null;
      return int.parse(str);
    }

    double? parseDecOrNull(int index) {
      final str = match[index];
      if (str == null) return null;
      return int.parse(str) / math.pow(10, str.length);
    }

    // Parses fractional second digits of '.(\d+)' into the combined
    // microseconds. We only use the first 6 digits because of DateTime
    // precision of 999 milliseconds and 999 microseconds.
    // int parseMilliAndMicroseconds(String? matched) {
    //   if (matched == null) return 0;
    //   final length = matched.length;
    //   assert(length >= 1);
    //   int result = 0;
    //   for (int i = 0; i < 6; i++) {
    //     result *= 10;
    //     if (i < matched.length) {
    //       result += matched.codeUnitAt(i) ^ 0x30;
    //     }
    //   }
    //   return result;
    // }

    final int hour = parseIntOrZero(1);
    final double? hourDec = parseDecOrNull(2);
    int? minute = parseIntOrNull(3);
    final double? minuteDec = parseDecOrNull(4);
    int? second = parseIntOrNull(5);
    final double? secondDec = parseDecOrNull(6);
    int microsecond = 0;

    Never _throwDecimal() {
      throw FormatException(
        'Can only have decimals for the last time component.',
        formattedString,
      );
    }

    if (hourDec != null) {
      if (minute != null) {
        _throwDecimal();
      } else {
        microsecond = (Duration.microsecondsPerHour * hourDec).truncate();
      }
    } else if (minuteDec != null) {
      if (second != null) {
        _throwDecimal();
      } else {
        microsecond = (Duration.microsecondsPerMinute * minuteDec).truncate();
      }
    } else if (secondDec != null) {
      microsecond = (Duration.microsecondsPerSecond * secondDec).truncate();
    }

    int getPart(int? part, int microPerPart) {
      if (part != null) return part;
      if (microsecond == 0) {
        return 0;
      } else {
        final _part = microsecond ~/ microPerPart;
        microsecond -= microPerPart * _part;
        return _part;
      }
    }

    minute = getPart(minute, Duration.microsecondsPerMinute);
    second = getPart(second, Duration.microsecondsPerSecond);
    final millisecond = getPart(null, Duration.microsecondsPerMillisecond);

    final errors = [
      if (hour >= 24) 'Hour time component should be less than 24, got $hour.',
      if (minute >= 60)
        'Minute time component should be less than 60, got $minute.',
      if (second >= 61)
        'Second time component should be less than 61, got $second.',
    ];
    if (errors.isNotEmpty) {
      throw FormatException(
        errors.join(' '),
        formattedString,
      );
    }

    // final int second = parseIntOrZero(5);
    // final int milliAndMicroseconds = parseMilliAndMicroseconds(match[7]);
    // final int millisecond =
    //     milliAndMicroseconds ~/ Duration.microsecondsPerMillisecond;
    // final int microsecond =
    //     milliAndMicroseconds.remainder(Duration.microsecondsPerMillisecond);

    int? minuteDifference;
    if (match[8] != null) {
      // timezone part
      minuteDifference = 0;
      final String? tzSign = match[9];
      if (tzSign != null) {
        // timezone other than 'Z' and 'z'.
        final int sign = (tzSign == '-') ? -1 : 1;
        final int hourDifference = int.parse(match[10]!);
        minuteDifference = parseIntOrZero(11);
        minuteDifference += 60 * hourDifference;
        minuteDifference *= sign;
      }
    }
    return Time._inner(
      hour,
      minute,
      second,
      millisecond,
      microsecond,
      minuteDifference,
    );

    // int? value = _brokenDownDateToValue(years, month, day, hour, minute,
    //     second, millisecond, microsecond, isUtc);
    // if (value == null) {
    //   throw FormatException("Time out of range", formattedString);
    // }
    // return DateTime._withValue(value, isUtc: isUtc);
  }

  int get hour => _microseconds ~/ Duration.microsecondsPerHour;
  int get minute =>
      (_microseconds - hour * Duration.microsecondsPerHour) ~/
      Duration.microsecondsPerMinute;
  int get second =>
      (_microseconds - minute * Duration.microsecondsPerMinute) ~/
      Duration.microsecondsPerSecond;
  int get millisecond =>
      (_microseconds - second * Duration.microsecondsPerSecond) ~/
      Duration.microsecondsPerMillisecond;
  int get microsecond =>
      _microseconds - millisecond * Duration.microsecondsPerMillisecond;

  int get microsecondsSinceMidnight => _microseconds;

  bool get isUtc => _timezoneMinutesOffset == 0;
  Duration get timeZoneOffset => Duration(minutes: _timezoneMinutesOffset);
  Time toLocal() => Time.fromMicroseconds(
        microseconds: _microseconds,
        timezoneMinutesOffset: null,
      );
  Time toUtc() => Time.fromMicroseconds(
        microseconds: _microseconds,
        timezoneMinutesOffset: 0,
      );

  static int overflowMicrosecondsIntoDayRange(int microseconds) {
    return microseconds < 0 || microseconds >= Duration.microsecondsPerDay
        ? (microseconds.remainder(Duration.microsecondsPerDay) *
                Duration.microsecondsPerDay)
            .abs()
        : microseconds;
  }

  Time add(Duration duration) {
    final newValue = _microseconds + duration.inMicroseconds;
    return Time.fromMicroseconds(
      microseconds: overflowMicrosecondsIntoDayRange(newValue),
      timezoneMinutesOffset: _timezoneMinutesOffset,
    );
  }

  Time substract(Duration duration) => add(-duration);

  int get _utcMicroseconds =>
      microsecondsSinceMidnight - timeZoneOffset.inMicroseconds;

  Duration difference(Time other) => Duration(
        microseconds: _utcMicroseconds - other._utcMicroseconds,
      );

  bool isBefore(Time other) => toUtc() < other.toUtc();
  bool isAfter(Time other) => toUtc() > other.toUtc();
  bool isAtSameMomentAs(Time other) => toUtc() == other.toUtc();

  bool operator <(Time other) => _utcMicroseconds < other._utcMicroseconds;

  bool operator <=(Time other) => _utcMicroseconds <= other._utcMicroseconds;

  bool operator >(Time other) => _utcMicroseconds > other._utcMicroseconds;

  bool operator >=(Time other) => _utcMicroseconds >= other._utcMicroseconds;

  @override
  int compareTo(Time other) =>
      _utcMicroseconds.compareTo(other._utcMicroseconds);

  @override
  bool operator ==(Object? other) =>
      other is Time &&
      other.microsecondsSinceMidnight == microsecondsSinceMidnight &&
      other._timezoneMinutesOffset == _timezoneMinutesOffset;

  @override
  int get hashCode =>
      microsecondsSinceMidnight.hashCode ^ _timezoneMinutesOffset.hashCode;

  static const _n = r'(\d\d)(?:[.,](\d+))?';
  static final RegExp _parseFormat =
      RegExp('^(?:T?$_n(?::?$_n(?::?$_n)?)?' // Time part.
          r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$'); // Timezone part.
}

// @immutable
// class Time implements Comparable<Time> {
//   final DateTime _innerDateTime;

//   ///
//   Time(
//     int hour, [
//     int minute = 0,
//     int second = 0,
//     int millisecond = 0,
//     int microsecond = 0,
//   ]) : _innerDateTime = DateTime(
//           0,
//           1,
//           1,
//           hour,
//           minute,
//           second,
//           millisecond,
//           microsecond,
//         );

//   ///
//   Time.utc(
//     int hour, [
//     int minute = 0,
//     int second = 0,
//     int millisecond = 0,
//     int microsecond = 0,
//   ]) : _innerDateTime = DateTime.utc(
//           0,
//           1,
//           1,
//           hour,
//           minute,
//           second,
//           millisecond,
//           microsecond,
//         );

//   ///
//   Time.named({
//     required int hour,
//     int minute = 0,
//     int second = 0,
//     int millisecond = 0,
//     int microsecond = 0,
//     int? timezoneMinutesOffset,
//   }) : _innerDateTime = DateTime(
//           0,
//           1,
//           1,
//           hour,
//           minute -
//               (timezoneMinutesOffset ?? DateTime(0).timeZoneOffset.inMinutes),
//           second,
//           millisecond,
//           microsecond,
//         );

//   Time.fromDateTime(DateTime dateTime) : _innerDateTime = dateTime;
//   Time.now() : _innerDateTime = DateTime.now();

//   static final midnight = Time(0);

//   // factory Time.parse(String input) => Time.fromDateTime(
//   //     DateTime.parse('0000-01-01${input.startsWith('T') ? '' : 'T'}$input'),
//   //   );

//   static Time? tryParse(String formattedString) {
//     try {
//       return parse(formattedString);
//     } on FormatException {
//       return null;
//     }
//   }

//   static Time parse(String formattedString) {
//     final Match? match = _parseFormat.firstMatch(formattedString);
//     if (match == null) {
//       throw FormatException('Invalid date format', formattedString);
//     }
//     int parseIntOrZero(int index) {
//       final str = match[index];
//       if (str == null) return 0;
//       return int.parse(str);
//     }

//     int? parseIntOrNull(int index) {
//       final str = match[index];
//       if (str == null) return null;
//       return int.parse(str);
//     }

//     double? parseDecOrNull(int index) {
//       final str = match[index];
//       if (str == null) return null;
//       return int.parse(str) / math.pow(10, str.length);
//     }

//     // Parses fractional second digits of '.(\d+)' into the combined
//     // microseconds. We only use the first 6 digits because of DateTime
//     // precision of 999 milliseconds and 999 microseconds.
//     // int parseMilliAndMicroseconds(String? matched) {
//     //   if (matched == null) return 0;
//     //   final length = matched.length;
//     //   assert(length >= 1);
//     //   int result = 0;
//     //   for (int i = 0; i < 6; i++) {
//     //     result *= 10;
//     //     if (i < matched.length) {
//     //       result += matched.codeUnitAt(i) ^ 0x30;
//     //     }
//     //   }
//     //   return result;
//     // }

//     final int hour = parseIntOrZero(1);
//     final double? hourDec = parseDecOrNull(2);
//     int? minute = parseIntOrNull(3);
//     final double? minuteDec = parseDecOrNull(4);
//     int? second = parseIntOrNull(5);
//     final double? secondDec = parseDecOrNull(6);
//     int microsecond = 0;

//     Never _throwDecimal() {
//       throw FormatException(
//         'Can only have decimals for the last time component.',
//         formattedString,
//       );
//     }

//     if (hourDec != null) {
//       if (minute != null) {
//         _throwDecimal();
//       } else {
//         microsecond = (Duration.microsecondsPerHour * hourDec).truncate();
//       }
//     } else if (minuteDec != null) {
//       if (second != null) {
//         _throwDecimal();
//       } else {
//         microsecond = (Duration.microsecondsPerMinute * minuteDec).truncate();
//       }
//     } else if (secondDec != null) {
//       microsecond = (Duration.microsecondsPerSecond * secondDec).truncate();
//     }

//     int getPart(int? part, int microPerPart) {
//       if (part != null) return part;
//       if (microsecond == 0) {
//         return 0;
//       } else {
//         final _part = microsecond ~/ microPerPart;
//         microsecond -= microPerPart * _part;
//         return _part;
//       }
//     }

//     minute = getPart(minute, Duration.microsecondsPerMinute);
//     second = getPart(second, Duration.microsecondsPerSecond);
//     final millisecond = getPart(null, Duration.microsecondsPerMillisecond);

//     final errors = [
//       if (hour >= 24) 'Hour time component should be less than 24, got $hour.',
//       if (minute >= 60)
//         'Minute time component should be less than 60, got $minute.',
//       if (second >= 61)
//         'Second time component should be less than 61, got $second.',
//     ];
//     if (errors.isNotEmpty) {
//       throw FormatException(
//         errors.join(' '),
//         formattedString,
//       );
//     }

//     // final int second = parseIntOrZero(5);
//     // final int milliAndMicroseconds = parseMilliAndMicroseconds(match[7]);
//     // final int millisecond =
//     //     milliAndMicroseconds ~/ Duration.microsecondsPerMillisecond;
//     // final int microsecond =
//     //     milliAndMicroseconds.remainder(Duration.microsecondsPerMillisecond);
//     bool isUtc = false;
//     if (match[8] != null) {
//       // timezone part
//       isUtc = true;
//       final String? tzSign = match[9];
//       if (tzSign != null) {
//         // timezone other than 'Z' and 'z'.
//         final int sign = (tzSign == '-') ? -1 : 1;
//         final int hourDifference = int.parse(match[10]!);
//         int minuteDifference = parseIntOrZero(11);
//         minuteDifference += 60 * hourDifference;
//         minute -= sign * minuteDifference;
//       }
//     }
//     if (isUtc) {
//       return Time.utc(hour, minute, second, millisecond, microsecond);
//     } else {
//       return Time(hour, minute, second, millisecond, microsecond);
//     }
//     // int? value = _brokenDownDateToValue(years, month, day, hour, minute,
//     //     second, millisecond, microsecond, isUtc);
//     // if (value == null) {
//     //   throw FormatException("Time out of range", formattedString);
//     // }
//     // return DateTime._withValue(value, isUtc: isUtc);
//   }

//   @override
//   String toString() {
//     final dateStr = _innerDateTime.toIso8601String();
//     return dateStr.substring(dateStr.indexOf('T'));
//   }

//   int get hour => _innerDateTime.hour;
//   int get minute => _innerDateTime.minute;
//   int get second => _innerDateTime.second;
//   int get millisecond => _innerDateTime.millisecond;
//   int get microsecond => _innerDateTime.microsecond;

//   int get microsecondsSinceMidnight =>
//       hour * Duration.microsecondsPerHour +
//       minute * Duration.microsecondsPerMinute +
//       second * Duration.microsecondsPerSecond +
//       millisecond +
//       Duration.microsecondsPerMillisecond +
//       microsecond;

//   bool get isUtc => _innerDateTime.isUtc;
//   String get timeZoneName => _innerDateTime.timeZoneName;
//   Duration get timeZoneOffset => _innerDateTime.timeZoneOffset;
//   Time toLocal() => Time.fromDateTime(_innerDateTime.toLocal());
//   Time toUtc() => Time.fromDateTime(_innerDateTime.toUtc());

//   Time add(Duration duration) =>
//       Time.fromDateTime(_innerDateTime.add(duration));

//   Time substract(Duration duration) =>
//       Time.fromDateTime(_innerDateTime.subtract(duration));

//   Duration difference(Time other) => Duration(
//       microseconds:
//           microsecondsSinceMidnight - other.microsecondsSinceMidnight);

//   bool isBefore(Time other) => toUtc() < other.toUtc();
//   bool isAfter(Time other) => toUtc() > other.toUtc();
//   bool isAtSameMomentAs(Time other) => toUtc() == other.toUtc();

//   bool operator <(Time other) =>
//       microsecondsSinceMidnight < other.microsecondsSinceMidnight;

//   bool operator <=(Time other) =>
//       microsecondsSinceMidnight <= other.microsecondsSinceMidnight;

//   bool operator >(Time other) =>
//       microsecondsSinceMidnight > other.microsecondsSinceMidnight;

//   bool operator >=(Time other) =>
//       microsecondsSinceMidnight >= other.microsecondsSinceMidnight;

//   @override
//   int compareTo(Time other) =>
//       microsecondsSinceMidnight.compareTo(other.microsecondsSinceMidnight);

//   @override
//   bool operator ==(Object? other) =>
//       other is Time &&
//       other.microsecondsSinceMidnight == microsecondsSinceMidnight &&
//       other.isUtc == isUtc;

//   @override
//   int get hashCode => microsecondsSinceMidnight.hashCode ^ isUtc.hashCode;

//   static const _n = r'(\d\d)(?:[.,](\d+))?';
//   static final RegExp _parseFormat =
//       RegExp('^(?:T?$_n(?::?$_n(?::?$_n)?)?' // Time part.
//           r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$'); // Timezone part.
// }

IsoDuration parseDuration(String input) {
  final Match? match = _durFormat.firstMatch(input);
  if (match != null) {
    num parseNumOrZero(int index) {
      final matched = match[index];
      if (matched == null) return 0;
      final str = matched.substring(0, matched.length - 1);
      final decimal = match[index + 1];
      if (decimal == null) return int.parse(str);
      if (RegExp(r'^[,\.]0*$').hasMatch(decimal)) {
        return int.parse(str.split(RegExp(r'[,\.]')).first);
      }
      return double.parse(str.replaceAll(',', '.'));
    }

    final years = parseNumOrZero(1);
    final months = parseNumOrZero(3);
    final days = parseNumOrZero(5);
    final hours = parseNumOrZero(8);
    final minutes = parseNumOrZero(10);
    final seconds = parseNumOrZero(12);
    return IsoDuration(
      years: years,
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  } else {
    throw FormatException('Invalid duration format', input);
  }
}

const _n = r'-?\d+([,\.]\d*)?';
final _durFormat =
    RegExp('P(${_n}Y)?(${_n}M)?(${_n}D)?(T(${_n}H)?(${_n}M)?(${_n}S)?)?');

class IsoDuration implements Duration {
  final num years;
  final num months;
  final num days;
  final num hours;
  final num minutes;
  final num seconds;

  ///
  const IsoDuration({
    this.years = 0,
    this.months = 0,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  factory IsoDuration.parse(String input) => parseDuration(input);
  static IsoDuration? tryParse(String input) {
    try {
      return parseDuration(input);
    } on FormatException {
      return null;
    }
  }

  Duration get dartDuration {
    return Duration(
      microseconds: (years * 3.1536e+13 +
              months * 2.628e+12 +
              days * Duration.microsecondsPerDay +
              hours * Duration.microsecondsPerHour +
              minutes * Duration.microsecondsPerMinute +
              seconds * Duration.microsecondsPerSecond)
          .toInt(),
    );
  }

  @override
  String toString() {
    final p = [
      'P',
      if (years != 0) '${years}Y',
      if (months != 0) '${months}M',
      if (days != 0) '${days}D',
      'T',
      if (hours != 0) '${hours}H',
      if (minutes != 0) '${minutes}M',
      if (seconds != 0) '${seconds}S',
    ].join();
    if (p == 'PT') {
      // zero
      return 'P0Y';
    } else {
      return p;
    }
  }

  static const zero = IsoDuration();

  @override
  Duration operator *(num factor) {
    return IsoDuration(
      years: years * factor,
      months: months * factor,
      days: days * factor,
      hours: hours * factor,
      minutes: minutes * factor,
      seconds: seconds * factor,
    );
  }

  @override
  Duration operator +(Duration other) {
    if (other is IsoDuration) {
      return IsoDuration(
        years: years + other.years,
        months: months + other.months,
        days: days + other.days,
        hours: hours + other.hours,
        minutes: minutes + other.minutes,
        seconds: seconds + other.seconds,
      );
    }
    throw UnimplementedError();
  }

  @override
  Duration operator -() {
    return IsoDuration(
      years: -years,
      months: -months,
      days: -days,
      hours: -hours,
      minutes: -minutes,
      seconds: -seconds,
    );
  }

  @override
  Duration operator -(Duration other) {
    if (other is IsoDuration) {
      return IsoDuration(
        years: years - other.years,
        months: months - other.months,
        days: days - other.days,
        hours: hours - other.hours,
        minutes: minutes - other.minutes,
        seconds: seconds - other.seconds,
      );
    }
    throw UnimplementedError();
  }

  @override
  bool operator <(Duration other) => inMicroseconds < other.inMicroseconds;

  @override
  bool operator <=(Duration other) => inMicroseconds <= other.inMicroseconds;

  @override
  bool operator >(Duration other) => inMicroseconds > other.inMicroseconds;

  @override
  bool operator >=(Duration other) => inMicroseconds >= other.inMicroseconds;

  @override
  Duration abs() {
    return IsoDuration(
      years: years.abs(),
      months: months.abs(),
      days: days.abs(),
      hours: hours.abs(),
      minutes: minutes.abs(),
      seconds: seconds.abs(),
    );
  }

  @override
  int compareTo(Duration other) =>
      inMicroseconds.compareTo(other.inMicroseconds);

  @override
  int get inDays => dartDuration.inDays;

  @override
  int get inHours => dartDuration.inHours;

  @override
  int get inMicroseconds => dartDuration.inMicroseconds;

  @override
  int get inMilliseconds => dartDuration.inMilliseconds;

  @override
  int get inMinutes => dartDuration.inMinutes;

  @override
  int get inSeconds => dartDuration.inSeconds;

  @override
  bool get isNegative => dartDuration.isNegative;

  @override
  Duration operator ~/(int quotient) {
    throw UnimplementedError();
  }
}
