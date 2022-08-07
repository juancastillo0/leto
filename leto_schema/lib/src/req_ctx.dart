part of leto_schema.src.schema;

/// The context for a resolver in a given request. Contains the [args] passed as
/// input, the parent [object], the selected fields in [lookahead],
/// the scoped values in [scope] and other parent context such as [objectCtx]
/// and the [executionCtx] for the request.
class Ctx<P> implements ScopedHolder {
  /// The arguments passed as input
  final Map<String, Object?> args;

  /// The parent object value
  P get object => objectCtx.objectValue as P;

  @override
  ScopedMap get scope => objectCtx.scope;

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

  /// The context for a resolver in a given request. Contains the [args]
  /// passed as input, the parent [object], the selected fields in [lookahead],
  /// the scoped values in [scope] and other parent context such as [objectCtx]
  /// and the [executionCtx] for the request.
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

/// The context associated with a request it may not be validated
///
/// More information [ExecutionCtx], [ObjectExecutionCtx] and [Ctx]
class RequestCtx implements ScopedHolder {
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
  final ScopedMap scope;

  /// The context associated with a request it may not be validated
  ///
  /// More information [ExecutionCtx], [ObjectExecutionCtx] and [Ctx]
  RequestCtx({
    required this.schema,
    required this.query,
    required this.operationName,
    required this.rootValue,
    required this.rawVariableValues,
    required this.scope,
    required this.extensions,
  });
}

/// The context associated with a request that finished being validated
///
/// More information in [RequestCtx], [ObjectExecutionCtx] and [Ctx]
class ExecutionCtx implements ScopedHolder {
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
  final ScopedMap scope;

  /// The context associated with a request that finished being validated
  ///
  /// More information in [RequestCtx], [ObjectExecutionCtx] and [Ctx]
  ExecutionCtx({
    required this.requestCtx,
    required this.document,
    required this.operation,
    required this.variableValues,
    required this.scope,
  });
}

/// The context associated with an object execution
/// in a request that finished being validated
///
/// More information in [RequestCtx], [ExecutionCtx] and [Ctx]
class ObjectExecutionCtx<P> implements ScopedHolder {
  /// The context for this request
  final ExecutionCtx executionCtx;

  @override
  ScopedMap get scope => executionCtx.scope;

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

  /// The context associated with an object execution
  /// in a request that finished being validated
  ///
  /// More information in [RequestCtx], [ExecutionCtx] and [Ctx]
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

/// A wrapper around a [value] that can be mutated
///
/// Could be useful for having a mutable variable within a [ScopedMap].
/// ```dart
/// static ScopedRef<MutableValue<T>> mutable<T>(
///   T Function(ScopedMap scope) create, {
///   required bool isScoped,
///   String? name,
///   FutureOr<void> Function(T value)? dispose,
/// }) {
///   return ScopedRef(
///     (scope) => MutableValue(create(scope)),
///     isScoped: isScoped,
///     dispose: dispose == null ? null : (v) => dispose(v.value),
///     name: name,
///   );
/// }
/// ```
class MutableValue<T> {
  /// The current value
  T value;

  /// A wrapper around a [value] that can be mutated
  MutableValue(this.value);

  @override
  String toString() => 'MutableValue($value)';
}

/// A reference to a scoped value of type [T]
///
/// It can be [isScoped] (if true) or global.
/// If it's scoped, one instance will be created for
/// every scope and it's descendants.
/// If it's global ([isScoped] == false) one instance will
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
/// // TODO: 1A do not allow to access scoped from globals
class ScopedRef<T> {
  /// An optional name of the reference, useful for debugging
  final String? name;

  /// The function used to create the value for this reference
  final T Function(ScopedMap scope) create;

  /// The function used to dispose the value created for this reference
  final FutureOr<void> Function(T value)? dispose;

  /// Whether the value is scoped or global
  final bool isScoped;

  /// Whether the value is scoped or global
  bool get isGlobal => !isScoped;

  /// A reference to a scoped value of type [T]
  ///
  /// It can be [isScoped] (if true) or global.
  /// If it's scoped, one instance will be created for
  /// every scope and it's descendants.
  /// If it's global ([isScoped] == false) one instance will
  /// be created for every scoped and all its parents. When the reference
  /// is created, it will be set to the scoped map and to every parent's
  /// scoped map.
  ScopedRef(this.create, {required this.isScoped, this.name, this.dispose});
  ScopedRef.scoped(this.create, {this.name, this.dispose}) : isScoped = true;
  ScopedRef.global(this.create, {this.name, this.dispose}) : isScoped = false;

  /// Retrieves the value in the [holder]. If there isn't any,
  /// uses [create] to create a new value and sets it into
  /// the appropriate scope.
  T get(ScopedHolder holder) {
    return holder.scope.get(this);
  }

  /// Creates a [ScopedOverride] for this reference using the [create]
  /// function for the value that will override
  ScopedOverride<T> override(T Function(ScopedMap scope) create) =>
      ScopedOverride(create: create, ref: this);
}

/// A Object which holds a scope
///
/// Many ctx implement [ScopedHolder], for example
/// [Ctx], [ExecutionCtx], [ObjectExecutionCtx]
///
/// Usually used with a [ScopedRef] for typed values
/// with default.
abstract class ScopedHolder {
  /// The tree of values for this scope
  ScopedMap get scope;
}

/// A map with values in different scopes
///
/// Each [ScopedMap] has some scoped [values], this values
/// will be available to it's children, but not to it's [parent].
class ScopedMap implements ScopedHolder {
  /// The parent of this scope.
  /// The chain of parents and children form a tree.
  final ScopedMap? parent;
  final Map<ScopedRef, Object?> _values = {};
  final Map<ScopedRef, ScopedOverride> _overrides = {};

  /// A map with values in different scopes
  ///
  /// Each [ScopedMap] has some scoped [overrides], this values
  /// will be available to it's children, but not to it's [parent].
  ScopedMap({this.parent, List<ScopedOverride>? overrides}) {
    if (overrides != null) {
      for (final override in overrides.reversed) {
        if (!_overrides.containsKey(override.ref)) {
          _overrides[override.ref] = override;
        }
      }
    }
  }

  /// Returns a child of this scope
  ScopedMap child({List<ScopedOverride>? overrides}) =>
      ScopedMap(overrides: overrides, parent: this);

  /// Returns an iterable with all the parents of this scope
  Iterable<ScopedMap> parents() sync* {
    ScopedMap? parent = this.parent;
    while (parent != null) {
      yield parent;
      parent = parent.parent;
    }
  }

  /// Retrieves a value from itself or from its parent
  T get<T>(ScopedRef<T> ref) {
    if (_values.containsKey(ref)) {
      return _values[ref] as T;
    }

    final T value;
    if (_overrides.containsKey(ref)) {
      value = _overrides[ref]!.create(this) as T;
    } else {
      for (final p in parents()) {
        if (p._values.containsKey(ref) || p._overrides.containsKey(ref)) {
          return p.get(ref);
        }
      }
      value = ref.create(this);
    }
    _values[ref] = value;
    if (ref.isGlobal) {
      for (final p in parents()) {
        p._values[ref] = value;
      }
    }
    return value;
  }

  /// Disposes of all the values in this scope.
  /// If this is the root scope, then all the values will be disposed.
  /// If this is a child scope, then it will only dispose of the values
  /// scoped (not the global ones) and created by this scope with [get].
  /// // TODO: 1A test and set up in executor
  Future<void> dispose() {
    return Future.wait(
      _values.entries.map((e) async {
        if ((parent == null || !e.key.isGlobal) && e.key.dispose != null) {
          await e.key.dispose!(e.value);
        }
      }),
    );
  }

  @override
  ScopedMap get scope => this;
}

/// An override of [ref] with the value returned from [create].
class ScopedOverride<T> {
  /// The reference to override
  final ScopedRef<T> ref;

  /// The function that creates the value that will override the [ref].
  final T Function(ScopedMap scope) create;

  /// An override of [ref] with the value returned from [create].
  ScopedOverride({
    required this.ref,
    required this.create,
  });
}
