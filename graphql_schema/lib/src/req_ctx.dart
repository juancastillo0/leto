part of graphql_schema.src.schema;

class ReqCtx<P extends Object> implements GlobalsHolder {
  @override
  ScopedMap get globals => parentCtx.globals;
  final Map<String, Object?> args;
  final P object;
  ResolveCtx get baseCtx => parentCtx.base;
  final ResolveObjectCtx<Object> parentCtx;
  final GraphQLObjectField<Object, Object, Object> field;
  final String pathItem;

  List<Object> get path => [...parentCtx.path, pathItem];

  final PossibleSelections? Function() lookahead;

  const ReqCtx({
    required this.args,
    required this.object,
    required this.parentCtx,
    required this.field,
    required this.pathItem,
    required this.lookahead,
  });

  ReqCtx<T> cast<T extends Object>() {
    if (this is ReqCtx<T>) {
      return this as ReqCtx<T>;
    }
    return ReqCtx(
      args: args,
      object: object as T,
      parentCtx: parentCtx,
      pathItem: pathItem,
      field: field,
      lookahead: lookahead,
    );
  }
}

class PossibleSelections {
  final Map<String, PossibleSelectionsObject> unionMap;
  final List<FieldNode> fieldNodes;

  PossibleSelectionsObject get asObject {
    assert(!isUnion);
    return unionMap.values.first;
  }

  bool get isUnion => unionMap.length > 1;

  const PossibleSelections(
    this.unionMap,
    this.fieldNodes,
  );
}

class PossibleSelectionsObject {
  final Map<String, PossibleSelections? Function()> map;

  const PossibleSelectionsObject(this.map);

  bool contains(String fieldName) => map.containsKey(fieldName);

  PossibleSelections? nested(String fieldName) => map[fieldName]?.call();
}

class ResolveCtx implements GlobalsHolder {
  final errors = <GraphQLError>[];
  final GraphQLSchema schema;
  SerdeCtx get serdeCtx => schema.serdeCtx;
  final DocumentNode document;
  final OperationDefinitionNode operation;
  final Object rootValue;
  final Map<String, dynamic> variableValues;
  @override
  final ScopedMap globals;
  final Map<String, dynamic>? extensions;

  ResolveCtx({
    required this.schema,
    required this.document,
    required this.operation,
    required this.rootValue,
    required this.variableValues,
    required this.globals,
    required this.extensions,
  });
}

class ResolveObjectCtx<P extends Object> implements GlobalsHolder {
  final ResolveCtx base;

  SerdeCtx get serdeCtx => base.serdeCtx;
  Map<String, dynamic> get variableValues => base.variableValues;
  @override
  ScopedMap get globals => base.globals;
  DocumentNode get document => base.document;

  final GraphQLObjectType<P> objectType;
  final P objectValue;
  final ResolveObjectCtx<Object>? parent;
  final Object? pathItem;
  final Map<String, List<FieldNode>> groupedFieldSet;

  Iterable<Object> get path => parent == null
      ? [if (pathItem != null) pathItem!]
      : parent!.path.followedBy([if (pathItem != null) pathItem!]);

  ResolveObjectCtx({
    required this.pathItem,
    required this.base,
    required this.objectType,
    required this.objectValue,
    required this.parent,
    required this.groupedFieldSet,
  });

  bool _didSerialized = false;
  Map<String, dynamic>? _serializedObject;
  Map<String, Object?>? serializedObject() {
    if (!_didSerialized) {
      try {
        try {
          final serializer = serdeCtx.ofValue(objectType.generic.type);
          if (serializer != null) {
            _serializedObject =
                serializer.toJson(objectValue)! as Map<String, dynamic>;
          } else {
            _serializedObject =
                serdeCtx.toJson(objectValue)! as Map<String, dynamic>;
          }
        } catch (e) {
          _serializedObject = objectType.serializeSafe(
            objectValue,
            nested: false,
          );
        }
      } catch (_) {}
      _didSerialized = true;
    }
    return _serializedObject;
  }
}

class GlobalRef {
  final String? name;

  GlobalRef([this.name]);
}

class RefWithDefault<T> {
  final String? name;
  final T Function(GlobalsHolder holder) create;
  final bool scoped;

  RefWithDefault(this.create, {required this.scoped, this.name});
  RefWithDefault.scoped(this.create, {this.name}) : scoped = true;
  RefWithDefault.global(this.create, {this.name}) : scoped = false;

  T set(GlobalsHolder holder, T value) {
    if (scoped) {
      holder.globals.setScoped(this, value);
      return value;
    }
    holder.globals.setGlobal(this, value);
    return value;
  }

  T get(GlobalsHolder holder) {
    if (scoped) {
      return holder.globals.putScopedIfAbsent(this, () => create(holder)) as T;
    }
    return holder.globals.putGlobalIfAbsent(this, () => create(holder)) as T;
  }
}

abstract class GlobalsHolder {
  ScopedMap get globals;
}

class ScopedMap implements GlobalsHolder {
  final ScopedMap? parent;
  final Map<Object, Object?> values;

  ScopedMap(this.values, [this.parent]);

  ScopedMap child([Map<Object, Object?>? values]) =>
      ScopedMap(values ?? {}, this);

  factory ScopedMap.empty([ScopedMap? parent]) => ScopedMap({}, parent);

  bool containsScoped(Object key) => values.containsKey(key);

  bool containsGlobal(Object key) {
    final _hasScoped = containsScoped(key);
    return _hasScoped || (parent?.containsGlobal(key) ?? false);
  }

  Object? get(Object key) {
    if (containsScoped(key)) {
      return values[key];
    }
    return parent?.get(key);
  }

  Object? operator [](Object key) => get(key);

  void setScoped(Object key, Object? value) {
    values[key] = value;
  }

  void setGlobal(Object key, Object? value) {
    values[key] = value;
    parent?.setGlobal(key, value);
  }

  Object? putScopedIfAbsent(Object key, Object? Function() ifAbsent) =>
      values.putIfAbsent(key, ifAbsent);

  Object? putGlobalIfAbsent(Object key, Object? Function() ifAbsent) {
    if (containsGlobal(key)) {
      return get(key);
    }
    final value = ifAbsent();
    setGlobal(key, value);
    return value;
  }

  @override
  ScopedMap get globals => this;

  Map<String, Object?> toJson() =>
      values.map((key, value) => MapEntry(key.toString(), value));
}
