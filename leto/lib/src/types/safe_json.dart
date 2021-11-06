import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:oxidized/oxidized.dart';

import 'safe_json_graphql.dart';

export 'safe_json_graphql.dart';

abstract class Json {
  const Json._();
  const factory Json.map(Map<String, Json> value) = JsonMap;
  const factory Json.list(List<Json> value) = JsonList;
  const factory Json.number(num value) = JsonNumber;
  // ignore: avoid_positional_boolean_parameters
  const factory Json.boolean(bool value) = JsonBoolean;
  const factory Json.str(String value) = JsonStr;
  const factory Json.none() = JsonNone;

  Object? get value;

  static const null_ = JsonNone();

  T when<T>({
    required T Function(Map<String, Json>) map,
    required T Function(List<Json>) list,
    required T Function(num) number,
    required T Function(bool) boolean,
    required T Function(String) str,
    required T Function(Null) none,
  }) {
    final v = this;
    if (v is JsonMap) {
      return map(v.value);
    } else if (v is JsonList) {
      return list(v.value);
    } else if (v is JsonNumber) {
      return number(v.value);
    } else if (v is JsonBoolean) {
      return boolean(v.value);
    } else if (v is JsonStr) {
      return str(v.value);
    } else if (v is JsonNone) {
      return none(null);
    }
    throw Error();
  }

  Object? toJson({bool shallow = false}) {
    final v = this;
    if (v is JsonNone) {
      return null;
    }
    if (shallow) {
      return value;
    } else {
      return when(
        map: (map) => map.map(
          (key, value) => MapEntry(key, value.toJson()),
        ),
        list: (list) => list.map((e) => e.toJson()).toList(),
        number: (n) => n,
        str: (str) => str,
        boolean: (b) => b,
        none: (_) => null,
      );
    }
  }

  Object? toJsonShallow() {
    return toJson(shallow: true);
  }

  factory Json.fromJson(Object? value) {
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

  static GraphQLJsonType get graphQLType => jsonGraphQLType;
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

class JsonMap extends Json {
  @override
  final Map<String, Json> value;
  const JsonMap(this.value) : super._();
}

class JsonList extends Json {
  @override
  final List<Json> value;
  const JsonList(this.value) : super._();
}

class JsonNumber extends Json {
  @override
  final num value;
  const JsonNumber(this.value) : super._();
}

class JsonBoolean extends Json {
  @override
  final bool value;
  // ignore: avoid_positional_boolean_parameters
  const JsonBoolean(this.value) : super._();
}

class JsonStr extends Json {
  @override
  final String value;
  const JsonStr(this.value) : super._();
}

class JsonNone extends Json {
  @override
  Object? get value => null;
  const JsonNone() : super._();
}
