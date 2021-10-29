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
  /// a Map from a [GraphQLObjectType]'s name to it's selections
  ///
  /// If this selection is for an object it will have only one entry.
  /// If it's for an union it will have as many entries as
  /// [GraphQLUnionType.possibleTypes] there are in the union.
  final Map<String, PossibleSelectionsObject> unionMap;

  /// The selection field nodes which reference this selection
  ///
  /// Since [PossibleSelectionsObject] has its fields un-alised,
  /// this could be used in cases where you require aliased fields.
  final List<FieldNode> fieldNodes;

  /// Same as [unionMap.values.first], useful when you know
  /// this selection is for an object an not an union
  PossibleSelectionsObject get forObject {
    assert(!isUnion);
    return unionMap.values.first;
  }

  /// Whether this selection is for an union with one
  /// [PossibleSelectionsObject] in [unionMap]
  /// for every [GraphQLUnionType.possibleTypes].
  bool get isUnion => unionMap.length > 1;

  const PossibleSelections(
    this.unionMap,
    this.fieldNodes,
  );
}

class PossibleSelectionsObject {
  /// A map of un-alised fields to a function which calculates
  /// the selected properties for that field.
  final Map<String, PossibleSelections? Function()> map;

  const PossibleSelectionsObject(this.map);

  /// true if [fieldName] was selected for this object
  bool contains(String fieldName) => map.containsKey(fieldName);

  /// Returns the nested selections for [fieldName]
  ///
  /// Can be null when [fieldName] was not selected or if [fieldName]
  /// is not an Object or Union type (or list of those).
  ///
  /// If it's a scalar or an enum, for example, it would not have
  /// any selections, so this functions returns null even if they are selected.
  /// Use [contains] in this case.
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

class ScopeRef<T> {
  final String? name;

  ScopeRef([this.name]);

  T? get(GlobalsHolder scope) => scope.globals.get(this) as T?;

  void setScoped(GlobalsHolder scope, T value) =>
      scope.globals.setScoped(this, value);
}

/// A reference to a scoped value of type [T]
///
/// It can be [scoped] (if true) or global.
/// If it's scoped, one instace will be created for
/// every scope and it's descendants.
/// If it's global ([scoped] == false) one instace will
/// be created for every scoped and all its parents. When the refence
/// is created, it will be set to the scoped map and to every parent's
/// scoped map.
///
/// ```dart
///
/// final valueRef = RefWithDefault<String>(
///   (ScopedMap scope) => 'Value'
/// );
///
/// /// [ctx] can be anything that implemnts [GlobalsHolder]
/// /// For example, any of [ReqCtx], [ResolveCtx] or [ResolveObjectCtx]
/// void makeAction(GlobalsHolder ctx) {
///   final String value = valueRef.get(ctx);
/// }
/// ```
class RefWithDefault<T> {
  final String? name;
  final T Function(ScopedMap scope) create;
  final bool scoped;

  RefWithDefault(this.create, {required this.scoped, this.name});
  RefWithDefault.scoped(this.create, {this.name}) : scoped = true;
  RefWithDefault.global(this.create, {this.name}) : scoped = false;

  /// Set (overrides if present) the value in the [holder]'s
  /// [ScopedMap] in the appropiate scope.
  T set(GlobalsHolder holder, T value) {
    if (scoped) {
      holder.globals.setScoped(this, value);
      return value;
    } else {
      holder.globals.setGlobal(this, value);
      return value;
    }
  }

  /// Retrieves the value in the [holder]. If there aren't any
  /// uses [create] to create a new one and set it into
  /// the appropiate scope.
  T get(GlobalsHolder holder) {
    if (scoped) {
      return holder.globals.putScopedIfAbsent(
        this,
        () => create(holder.globals),
      ) as T;
    } else {
      return holder.globals.putGlobalIfAbsent(
        this,
        () => create(holder.globals),
      ) as T;
    }
  }
}

/// A Object which holds a scope
///
/// Many ctx implement [GlobalsHolder], for example
/// [ReqCtx], [ResolveCtx], [ResolveObjectCtx]
///
/// Usually used with a [RefWithDefault] for typed values
/// with default or a simple [ScopeRef]
abstract class GlobalsHolder {
  /// The tree of values for this scope
  ScopedMap get globals;
}

/// A map with values in different scopes
///
/// Each [ScopedMap] has some scoped [values], this values
/// will be available to it's children, but not to it's [parent].
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

  /// Retrieves a value from itself or from its parent
  Object? get(Object key) {
    if (containsScoped(key)) {
      return values[key];
    }
    return parent?.get(key);
  }

  /// Same as [get], retrieves a value from itself or from its parent
  Object? operator [](Object key) => get(key);

  /// Set a value which will be available to itself and to its children
  void setScoped(Object key, Object? value) {
    values[key] = value;
  }

  /// Set a value which will be available to every [ScopedMap] in the tree
  void setGlobal(Object key, Object? value) {
    values[key] = value;
    parent?.setGlobal(key, value);
  }

  /// Puts a value for the [key] in the scope if there isn't any.
  /// Returns the value if present or sets the value returned by [ifAbsent]
  /// for [key] and returns that new value.
  Object? putScopedIfAbsent(Object key, Object? Function() ifAbsent) =>
      values.putIfAbsent(key, ifAbsent);

  /// Puts a value for the [key] in the tree if there isn't any.
  /// Returns the value if present in the tree or sets the value
  /// returned by [ifAbsent] for [key] and returns that new value.
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
