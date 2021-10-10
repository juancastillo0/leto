import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';

part 'safe_json.freezed.dart';

@freezed
class Json with _$Json {
  const Json._();
  const factory Json.map(Map<String, Json> value) = JsonMap;
  const factory Json.list(List<Json> value) = JsonList;
  const factory Json.number(num value) = JsonNumber;
  // ignore: avoid_positional_boolean_parameters
  const factory Json.boolean(bool value) = JsonBoolean;
  const factory Json.str(String value) = JsonStr;
  const factory Json.none() = JsonNone;

  static const null_ = JsonNone();

  Object? toJson({bool shallow = false}) {
    final v = this;
    if (v is JsonNone) {
      return null;
    }
    if (shallow) {
      // ignore: avoid_dynamic_calls
      return (v as dynamic).value;
    } else {
      return when(
        map: (map) => map.map(
          (key, value) => MapEntry(key, value.toJson()),
        ),
        list: (list) => list.map((e) => e.toJson()).toList(),
        number: (n) => n,
        str: (str) => str,
        boolean: (b) => b,
        none: () => null,
      );
    }
  }

  Object? toJsonShallow() {
    return toJson(shallow: true);
  }

  static Json fromJson(Object? value) {
    final result = fromJsonChecked(value);

    return result.match(
      (ok) => ok,
      (err) => throw Exception(err),
    );
  }

  static Result<Json, String> fromJsonChecked(
    Object? value, {
    String? getter,
    bool isRoot = true,
  }) {
    final _errPrefix = getter == null
        ? 'value'
        : isRoot
            ? getter
            : '[$getter]';
    return resultCtx(
      (rctx) {
        if (value == null) {
          return const JsonNone();
        } else if (value is Map<String, Object?>) {
          return Json.map(value.map(
            (key, value) => MapEntry(
              key,
              rctx.unwrap(fromJsonChecked(
                value,
                getter: key,
                isRoot: false,
              )),
            ),
          ));
        } else if (value is List<Object?>) {
          return Json.list(
            value
                .mapIndexed((index, value) => rctx.unwrap(
                      fromJsonChecked(
                        value,
                        getter: index.toString(),
                        isRoot: false,
                      ),
                    ))
                .toList(),
          );
        } else if (value is Json) {
          return value;
        } else if (value is num) {
          return Json.number(value);
        } else if (value is bool) {
          return Json.boolean(value);
        } else if (value is String) {
          if (isRoot) {
            try {
              final Object? decoded = jsonDecode(value);
              return rctx.unwrap(fromJsonChecked(
                decoded,
                getter: getter,
                isRoot: false,
              ));
            } catch (_) {}
          }
          return Json.str(value);
        } else {
          rctx.throwErr(' = $value is not a valid JSON');
        }
      },
      mapErr: (err) => '$_errPrefix$err',
    );
  }
}

Result<T, E> resultCtx<T extends Object, E extends Object>(
  T Function(ResultCtx<T, E>) fn, {
  E Function(E)? mapErr,
}) {
  try {
    final ctx = ResultCtx<T, E>();
    final ok = fn(ctx);
    return Ok(ok);
  } on E catch (e) {
    final err = mapErr == null ? e : mapErr(e);
    return Err(err);
  }
}

class ResultCtx<T extends Object, E extends Object> {
  T unwrap(Result<T, E> result) {
    if (result.isOk()) {
      return result.unwrap();
    }
    throw result.unwrapErr();
  }

  Never throwErr(E err) {
    throw err;
  }
}
