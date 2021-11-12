part of leto_schema.src.schema;

/// De-serialization context with [Serializer]s for creating
/// objects from serialized values
class SerdeCtx {
  /// De-serialization context with [Serializer]s for creating
  /// objects from serialized values
  SerdeCtx() {
    addAll(const [
      _SerializerIdentity<int>('int'),
      _SerializerIdentity<double>('double'),
      _SerializerIdentity<num>('num'),
      _SerializerIdentity<String>('String'),
      _SerializerIdentity<bool>('bool'),
      _SerializerUri(),
      _SerializerDateTime(),
    ]);
  }

  final Map<Type, Serializer<Object>> _map = {};
  final Map<String, Serializer<Object>> _keyedMap = {};

  /// Other context associated with this context
  ///
  /// Useful if the children wants to add [Serializer]s with out having
  /// a direct reference to the parent
  final Set<SerdeCtx> children = {};

  Map<Type, Serializer<Object>> get map => _map;

  /// Parses [json] into a value of type [T]
  T fromJson<T>(Object? json, {String? key}) {
    if (json is T) {
      return json;
    } else {
      final Serializer<T>? serializer = of<T>(key: key);
      if (serializer == null) {
        throw Exception('No serializer found for type $T.');
      }
      return serializer.fromJson(this, json);
    }
  }

  /// Parses [json] into a [Map] with keys [K] and values [V]
  Map<K, V> fromJsonMap<K, V>(Object? json) {
    if (json is Map) {
      return json.map(
        (Object? key, Object? value) => MapEntry(
          fromJson<K>(key),
          fromJson<V>(value),
        ),
      );
    }
    throw Error();
  }

  // Map<String, Object?> toJsonMap<K, V>(Map<K, V> map) {
  //   return map.map(
  //     (key, value) => MapEntry(
  //       toJson<K>(key).toString(),
  //       toJson<V>(value),
  //     ),
  //   );
  // }

  /// Parses [json] into a [List] with elements of type [V]
  List<V> fromJsonList<V>(Iterable json) {
    return json.map((Object? value) => fromJson<V>(value)).toList();
  }

  // List<Object?> toJsonList<V>(Iterable<V> list) {
  //   return list.map((value) => toJson<V>(value)).toList();
  // }

  // Object? toJson<T>(T instance) {
  //   final serializer = of<T>();
  //   if (serializer != null) {
  //     return serializer.toJson(instance);
  //   }
  //   if (instance is Map) {
  //     return instance.toJsonMap(this);
  //   } else if (instance is List || instance is Set) {
  //     return (instance as Iterable).toJsonList(this);
  //   } else if (instance == null) {
  //     return null;
  //   } else {
  //     try {
  //       // ignore: avoid_dynamic_calls
  //       return (instance as dynamic).toJson();
  //     } catch (_) {}
  //     try {
  //       // ignore: avoid_dynamic_calls
  //       return (instance as dynamic).toMap();
  //     } catch (_) {}

  //     final value = map.values
  //         .map((s) {
  //           if (s.generic.isValueOfType(instance)) {
  //             try {
  //               return _V(s.toJson(instance));
  //             } catch (_) {}
  //           }
  //           return null;
  //         })
  //         .whereType<_V>()
  //         .firstOrNull;
  //     if (value == null) {
  //       throw Exception(
  //         'Could not find a serializer of type $T for $instance.',
  //       );
  //     }
  //     return value.inner;
  //   }
  // }

  /// Adds multiple [serializers] into this context
  void addAll(Iterable<Serializer<Object>> serializers) {
    serializers.forEach(add);
  }

  /// Adds a [serializer] into this context
  void add(Serializer<Object> serializer) {
    _map[serializer.generic.type] = serializer;
    _map[serializer.generic.typeNull] = serializer;

    final listSerializer = serializer.listSerializer;
    _map[serializer.generic.listType] = listSerializer;
    _map[serializer.generic.listNullType] = listSerializer;
    _map[serializer.generic.listTypeNull] = listSerializer;
    _map[serializer.generic.listNullTypeNull] = listSerializer;

    _keyedMap.addEntries(
      serializer.keys.map((e) => MapEntry(e.replaceAll('?', ''), serializer)),
    );
    final _typeKey = serializer.generic.type.toString();
    _keyedMap[_typeKey.replaceAll('?', '')] = serializer;
  }

  // Serializer<Object>? ofValue(Type T) {
  //   return _map[T];
  // }

  Serializer<T>? of<T>({String? key}) {
    Serializer<T>? serializer = _map[T] as Serializer<T>?;
    if (serializer != null) return serializer;

    for (final _key in [key, T.toString()].whereType<String>()) {
      serializer = _keyedMap[_key] as Serializer<T>?;
      if (serializer != null) return serializer;
      serializer = _keyedMap[_key.replaceAll('?', '')] as Serializer<T>?;
      if (serializer != null) return serializer;

      if (_key.startsWith('List<')) {
        final isNullable = _key.endsWith('?');
        final _inner = of(
          key: _key.substring(5, _key.length - (isNullable ? 2 : 1)),
        );
        if (_inner != null) {
          if (isNullable) {
            return _inner.listSerializerNull as Serializer<T>;
          } else {
            return _inner.listSerializer as Serializer<T>;
          }
        }
      }
    }

    final Set<SerdeCtx> processed = {this};
    for (final child in children) {
      if (processed.contains(child)) {
        continue;
      }
      processed.add(child);
      final _serializer = child.of<T>();
      if (_serializer != null) {
        return _serializer;
      }
    }
    return _map.values.firstWhereOrNull(
      (serde) => serde.generic.isEqualToType<T>(),
    ) as Serializer<T>?;
  }

  // List<Serializer<T>> manyOf<T>() {
  //   final v = _map[T] as Serializer<T>?;
  //   if (v != null) return [v];
  //   return _map.values
  //       .where((serde) => serde.generic.isEqualToType<T>())
  //       .map((s) => s as Serializer<T>)
  //       .toList();
  // }
}

// class _V<T> {
//   final T inner;

//   _V(this.inner);
// }

// abstract class SerializableGeneric<S> {
//   S toJson();
// }

// abstract class Serializable
//     implements SerializableGeneric<Map<String, dynamic>> {
//   @override
//   Map<String, dynamic> toJson();
// }

abstract class Serializer<T> implements GenericHelpSingle<T> {
  const Serializer();

  /// Strings that can be used to reference this serializer
  List<String> get keys;

  T fromJson(SerdeCtx ctx, Object? json);
  // Object? toJson(T instance);

  @override
  GenericHelp<T> get generic => GenericHelp<T>();

  Serializer<List<T>> get listSerializer {
    return SerializerValueGen<List<T>>(
      keys: List.of(keys.map((e) => 'List<$e>')),
      fromJson: (ctx, obj) => List.of(
        (obj! as List).map(
          (Object? e) => fromJson(ctx, e),
        ),
      ),
    );
  }

  Serializer<List<T>?> get listSerializerNull {
    return SerializerValueGen(
      keys: List.of(keys.map((e) => 'List<$e>')),
      fromJson: (ctx, obj) => obj == null
          ? null
          : List.of(
              (obj as List).map(
                (Object? e) => fromJson(ctx, e),
              ),
            ),
    );
  }
}

class GenericHelpSingle<T> {
  /// Helper utilities for working with the generic type argument [T].
  final generic = GenericHelp<T>();
}

Type getType<T>() => T;

/// Helper utilities for working with the generic type argument [T].
@immutable
class GenericHelp<T> implements GenericHelpSingle<T> {
  /// [T] as a [Type] object.
  Type get type => T;
  Type get typeNull => getType<T?>();

  Type get listType => getType<List<T>>();
  Type get listNullType => getType<List<T>?>();
  Type get listTypeNull => getType<List<T?>>();
  Type get listNullTypeNull => getType<List<T?>?>();

  /// Returns true if [value] is of type [T], false otherwise.
  bool isValueOfType(Object? value) => value is T;

  /// Returns true if [O] is equal to [T], false otherwise.
  bool isEqualToType<O>() => O == T;

  /// Executes a generic callback with the generic type parameter as [T].
  /// Returns the object returned by the callback.
  O callWithType<O>(O Function<P>() callback) => callback<T>();

  @override
  GenericHelp<T> get generic => this;

  @override
  bool operator ==(Object? other) => other is GenericHelp && other.type == T;

  @override
  int get hashCode => T.hashCode;
}

@immutable
class GenericHelpWithExtends<T extends E, E> implements GenericHelpSingle<T> {
  /// [T] as a [Type] object.
  Type get type => T;

  /// [E] as a [Type] object.
  Type get extendsType => E;

  /// Returns true if [value] is of type [T], false otherwise.
  bool isValueOfType(Object? value) => value is T;

  /// Returns true if [O] is equal to [T], false otherwise.
  bool isEqualToType<O>() => O == T;

  /// Executes a generic callback with the generic type parameter as [T].
  /// Returns the object returned by the callback.
  O callWithType<O>(O Function<P extends E>() callback) => callback<T>();

  @override
  GenericHelp<T> get generic => GenericHelp<T>();

  @override
  bool operator ==(Object? other) =>
      other is GenericHelpWithExtends &&
      other.type == T &&
      other.extendsType == E;

  @override
  int get hashCode => T.hashCode ^ E.hashCode;
}

class _SerializerIdentity<T> extends Serializer<T> {
  const _SerializerIdentity(this.key);
  final String key;

  @override
  List<String> get keys => [key];

  @override
  T fromJson(SerdeCtx ctx, Object? json) {
    return json as T;
  }

  // @override
  // Object? toJson(T instance) {
  // return instance;
  // }
}

class _SerializerDateTime extends Serializer<DateTime> {
  const _SerializerDateTime();

  @override
  List<String> get keys => ['DateTime'];

  @override
  DateTime fromJson(SerdeCtx ctx, Object? json) {
    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    } else if (json is String) {
      return DateTime.parse(json);
    }
    throw Error();
  }

  // @override
  // Object? toJson(DateTime instance) {
  // return instance.toIso8601String();
  // }
}

class _SerializerUri extends Serializer<Uri> {
  const _SerializerUri();

  @override
  List<String> get keys => ['Uri'];

  @override
  Uri fromJson(SerdeCtx ctx, Object? json) {
    if (json is String) {
      return Uri.parse(json);
    }
    throw Error();
  }

  // @override
  // Object? toJson(Uri instance) => instance.toString();
}

// class SerializerFuncGeneric<T extends SerializableGeneric<S>, S>
//     extends Serializer<T> {
//   SerializerFuncGeneric({
//     required T Function(S json) fromJson,
//   })  : _fromJson = fromJson,
//         super();

//   final T Function(S json) _fromJson;

//   @override
//   T fromJson(SerdeCtx ctx, Object? json) => _fromJson(json as S);
//   @override
//   S toJson(T instance) => instance.toJson();
// }

// class SerializerFunc<T extends Serializable> extends Serializer<T> {
//   const SerializerFunc({
//     required T Function(Map<String, dynamic> json) fromJson,
//   })  : _fromJson = fromJson,
//         super();

//   final T Function(Map<String, dynamic> json) _fromJson;

//   @override
//   T fromJson(SerdeCtx ctx, Object? json) =>
//       json is T ? json : _fromJson(json! as Map<String, dynamic>);
//   @override
//   Map<String, dynamic> toJson(T instance) => instance.toJson();
// }

// class SerializerValue<T> extends Serializer<T> {
//   const SerializerValue({
//     required T Function(Map<String, dynamic> json) fromJson,
//     // required Map<String, dynamic> Function(T value) toJson,
//   })  : _fromJson = fromJson,
//         // _toJson = toJson,
//         super();

//   final T Function(Map<String, dynamic> json) _fromJson;
//   // final Map<String, dynamic> Function(T value) _toJson;

//   @override
//   T fromJson(SerdeCtx ctx, Object? json) =>
//       json is T ? json : _fromJson(json! as Map<String, dynamic>);
//   // @override
//   // Map<String, dynamic> toJson(T instance) => _toJson(instance);
// }

class SerializerValue<T> extends Serializer<T> {
  const SerializerValue({
    required T Function(SerdeCtx, Map<String, dynamic> json) fromJson,
    this.key,
    // required Map<String, dynamic> Function(T value) toJson,
  })  : _fromJson = fromJson,
        // _toJson = toJson,
        super();
  final String? key;
  @override
  List<String> get keys => [if (key != null) key!];

  final T Function(SerdeCtx, Map<String, dynamic> json) _fromJson;
  // final Map<String, dynamic> Function(T value) _toJson;

  @override
  T fromJson(SerdeCtx ctx, Object? json) =>
      json is T ? json : _fromJson(ctx, json! as Map<String, dynamic>);
  // @override
  // Map<String, dynamic> toJson(T instance) => _toJson(instance);
}

class SerializerValueGen<T> extends Serializer<T> {
  const SerializerValueGen({
    required T Function(SerdeCtx, Object? json) fromJson,
    required this.keys,
  })  : _fromJson = fromJson,
        super();
  @override
  final List<String> keys;

  final T Function(SerdeCtx, Object? json) _fromJson;

  @override
  T fromJson(SerdeCtx ctx, Object? json) =>
      json is T ? json : _fromJson(ctx, json);
}

// extension _GenMap<K, V> on Map<K, V> {
//   Map<String, Object?> toJsonMap(SerdeCtx serdeCtx) {
//     return serdeCtx.toJsonMap(this);
//   }
// }

// extension _GenIterable<V> on Iterable<V> {
//   List<Object?> toJsonList(SerdeCtx serdeCtx) {
//     return serdeCtx.toJsonList(this);
//   }
// }
