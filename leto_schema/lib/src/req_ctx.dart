part of leto_schema.src.schema;

class Ctx<P> implements GlobalsHolder {
  /// The arguments passed as input
  final Map<String, Object?> args;

  /// The parent object value
  P get object => objectCtx.objectValue as P;

  @override
  ScopedMap get globals => objectCtx.globals;

  /// The parent object context
  final ObjectExecutionCtx<Object?> objectCtx;

  /// The field associated with this resolve context
  final GraphQLObjectField<Object?, Object?, Object?> field;

  /// The complete path to this field in the GraphQL request
  List<Object> get path => [...objectCtx.path, pathItem];

  /// The alias or field name
  final String pathItem;

  /// Function that computes the selected fields of the object or union
  /// associated with this context
  final PossibleSelections? Function() lookahead;

  /// The execution context for this request
  ExecutionCtx get executionCtx => objectCtx.executionCtx;

  const Ctx({
    required this.args,
    required this.objectCtx,
    required this.field,
    required this.pathItem,
    required this.lookahead,
  });

  /// Cast the [P] parent type into a generic [T]
  Ctx<T> cast<T>() {
    if (this is Ctx<T>) {
      return this as Ctx<T>;
    }
    return Ctx(
      args: args,
      objectCtx: objectCtx,
      pathItem: pathItem,
      field: field,
      lookahead: lookahead,
    );
  }
}

class RequestCtx implements GlobalsHolder {
  /// The schema used to execute the operation
  final GraphQLSchema schema;

  /// The document String containing the operation to execute
  final String query;

  /// The operation name
  final String? operationName;

  /// The value passed as root value in the execution of the request
  final Object rootValue;

  /// The unparsed variables passes as arguments
  /// to the parameters in the [query]
  final Map<String, Object?>? rawVariableValues;

  /// this map contains custom values passed in the GraphQL request
  final Map<String, Object?>? extensions;

  @override
  final ScopedMap globals;

  RequestCtx({
    required this.schema,
    required this.query,
    required this.operationName,
    required this.rootValue,
    required this.rawVariableValues,
    required this.globals,
    required this.extensions,
  });
}

class ExecutionCtx implements GlobalsHolder {
  /// The errors populated throughout the processing of a GraphQL request
  final errors = <GraphQLError>[];

  /// The schema used to execute the operation
  GraphQLSchema get schema => requestCtx.schema;

  /// The GraphQL document of the GraphQL request
  final DocumentNode document;

  /// The specific operation from the [document] of the GraphQL request
  final OperationDefinitionNode operation;

  /// Base context of the request
  final RequestCtx requestCtx;

  /// The parsed variables passes as arguments to
  /// the parameters in the [operation]
  final Map<String, dynamic> variableValues;

  @override
  final ScopedMap globals;

  ExecutionCtx({
    required this.requestCtx,
    required this.document,
    required this.operation,
    required this.variableValues,
    required this.globals,
  });
}

class ObjectExecutionCtx<P> implements GlobalsHolder {
  /// The context for this request
  final ExecutionCtx executionCtx;

  @override
  ScopedMap get globals => executionCtx.globals;

  /// The type associated with this resolve context
  final GraphQLObjectType<P> objectType;

  /// The resolved value for this object's context
  final P objectValue;

  /// The parent object context if any
  final ObjectExecutionCtx<Object?>? parent;

  /// The item of this object in [path]
  final Object? pathItem;

  /// Aliased selections for this object
  final Map<String, List<FieldNode>> groupedFieldSet;

  /// The path of execution including this object
  Iterable<Object> get path => [
        if (parent != null) ...parent!.path,
        if (pathItem != null) pathItem!,
      ];

  ObjectExecutionCtx({
    required this.pathItem,
    required this.executionCtx,
    required this.objectType,
    required this.objectValue,
    required this.parent,
    required this.groupedFieldSet,
  });

  bool _didSerialized = false;
  Map<String, dynamic>? _serializedObject;

  /// The serialized value of this object, using `toJson` or `toMap`
  ///
  /// Used as last tool if the [objectType] have some fields with no resolvers
  /// they may be resolved if the object is first serialized as a map.
  Map<String, Object?>? serializedObject() {
    if (!_didSerialized) {
      try {
        try {
          _serializedObject =
              // ignore: avoid_dynamic_calls
              (objectValue as dynamic).toMap() as Map<String, Object?>;
        } catch (_) {
          _serializedObject =
              // ignore: avoid_dynamic_calls
              (objectValue as dynamic).toJson() as Map<String, Object?>;
        }
      } catch (_) {}
      _didSerialized = true;
    }
    return _serializedObject;
  }
}

/// A reference to a value of type [T] in a [ScopedMap]
class ScopeRef<T> {
  /// A name primarily used for debugging
  final String? name;

  ScopeRef([this.name]);

  T? get(GlobalsHolder scope) => scope.globals.get(this) as T?;

  void setScoped(GlobalsHolder scope, T value) =>
      scope.globals.setScoped(this, value);
}

/// A reference to a scoped value of type [T]
///
/// It can be [scoped] (if true) or global.
/// If it's scoped, one instance will be created for
/// every scope and it's descendants.
/// If it's global ([scoped] == false) one instance will
/// be created for every scoped and all its parents. When the reference
/// is created, it will be set to the scoped map and to every parent's
/// scoped map.
///
/// ```dart
///
/// final valueRef = RefWithDefault<String>(
///   (ScopedMap scope) => 'Value'
/// );
///
/// /// [ctx] can be anything that implements [GlobalsHolder]
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
  /// [ScopedMap] in the appropriate scope.
  T set(GlobalsHolder holder, T value) {
    if (scoped) {
      holder.globals.setScoped(this, value);
      return value;
    } else {
      holder.globals.setGlobal(this, value);
      return value;
    }
  }

  /// Retrieves the value in the [holder]. If there isn't any,
  /// uses [create] to create a new value and sets it into
  /// the appropriate scope.
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
/// [Ctx], [ExecutionCtx], [ObjectExecutionCtx]
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
}
