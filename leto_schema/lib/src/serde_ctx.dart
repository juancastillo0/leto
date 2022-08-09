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
  /// Useful if the children wants to add [Serializer]s without
  /// having a direct reference to the parent
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

  /// Adds multiple [serializers] into this context
  void addAll(Iterable<Serializer<Object>> serializers) {
    serializers.forEach(add);
  }

  /// Adds a [serializer] into this context
  void add(Serializer<Object> serializer) {
    _map[serializer.generic.type] = serializer;
    _map[serializer.generic.typeNull] = serializer;

    final listSerializer = serializer.listSerializer;
    _map[serializer.generic._listType] = listSerializer;
    _map[serializer.generic._listNullType] = listSerializer;
    _map[serializer.generic._listTypeNull] = listSerializer;
    _map[serializer.generic._listNullTypeNull] = listSerializer;

    _keyedMap.addEntries(
      serializer.keys.map((e) => MapEntry(e.replaceAll('?', ''), serializer)),
    );
    final _typeKey = serializer.generic.type.toString();
    _keyedMap[_typeKey.replaceAll('?', '')] = serializer;
  }

  /// Returns the serializer for the given type [T].
  /// If [key] is non-null it will be used to find the serializer.
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
        final _inner = of<dynamic>(
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
}

/// A class that deserializes values into types of type [T]
abstract class Serializer<T> implements GenericHelpSingle<T> {
  /// A class that deserializes values into types of type [T]
  const Serializer();

  /// Strings that can be used to reference this serializer
  List<String> get keys;

  /// Executes the deserialization of [json] into a value of type [T].
  T fromJson(SerdeCtx ctx, Object? json);

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

/// Helper utilities for working with the generic type argument [T].
class GenericHelpSingle<T> {
  /// Helper utilities for working with the generic type argument [T].
  final generic = GenericHelp<T>();
}

/// Returns the type passed as type argument
Type getType<T>() => T;

/// Helper utilities for working with the generic type argument [T].
@immutable
class GenericHelp<T> implements GenericHelpSingle<T> {
  /// [T] as a [Type] object.
  Type get type => T;

  /// [T] as a nullable [Type] object.
  Type get typeNull => getType<T?>();

  Type get _listType => getType<List<T>>();
  Type get _listNullType => getType<List<T>?>();
  Type get _listTypeNull => getType<List<T?>>();
  Type get _listNullTypeNull => getType<List<T?>?>();

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

/// Helper utilities for working with the generic type argument [T]
/// that extends [E].
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
}

/// A [Serializer] from a [fromJson] function
class SerializerValue<T> extends Serializer<T> {
  /// A [Serializer] from a [fromJson] function
  const SerializerValue({
    required T Function(SerdeCtx, Map<String, dynamic> json) fromJson,
    this.key,
  })  : _fromJson = fromJson,
        super();

  final String? key;
  @override
  List<String> get keys => [if (key != null) key!];

  final T Function(SerdeCtx, Map<String, dynamic> json) _fromJson;

  @override
  T fromJson(SerdeCtx ctx, Object? json) =>
      json is T ? json : _fromJson(ctx, json! as Map<String, dynamic>);
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
