part of leto_schema.src.schema;

/// Shorthand for generating a [GraphQLObjectType].
GraphQLObjectType<P> objectType<P>(
  String name, {
  String? description,
  bool isInterface = false,
  Iterable<GraphQLObjectField<Object?, Object?, P>> fields = const [],
  ResolveType<GraphQLObjectType<P>>? resolveType,
  IsTypeOf<P>? isTypeOf,
  Iterable<GraphQLObjectType> interfaces = const [],
  GraphQLTypeDefinitionExtra<TypeDefinitionNode, TypeExtensionNode> extra =
      const GraphQLTypeDefinitionExtra.attach([]),
}) {
  return GraphQLObjectType<P>(
    name,
    description: description,
    isInterface: isInterface,
    resolveType: resolveType,
    isTypeOf: isTypeOf,
    fields: fields,
    interfaces: interfaces,
    extra: extra,
  );
}

/// Return a [GraphQLObjectField] with [name] and all other
/// properties copied from [field]
GraphQLObjectField<V, S, P> copyFieldWithName<V, S, P>(
  String name,
  GraphQLObjectField<V, S, P> field,
) {
  return GraphQLObjectField(
    name,
    field.type,
    inputs: field.inputs,
    resolve: field.resolve,
    subscribe: field.subscribe,
    description: field.description,
    deprecationReason: field.deprecationReason,
  );
}

/// Shorthand for generating a [GraphQLObjectField].
GraphQLObjectField<T, Serialized, P> field<T, Serialized, P>(
  String name,
  GraphQLType<T, Serialized> type, {
  Iterable<GraphQLFieldInput<Object?, Object?>> inputs = const [],
  GraphQLFieldResolver<T, P>? resolve,
  GraphQLSubscriptionFieldResolver<T>? subscribe,
  String? deprecationReason,
  String? description,
  FieldDefinitionNode? astNode,
}) {
  return GraphQLObjectField(
    name,
    type,
    inputs: inputs,
    resolve: resolve == null ? null : FieldResolver(resolve),
    subscribe: subscribe == null ? null : FieldSubscriptionResolver(subscribe),
    description: description,
    deprecationReason: deprecationReason,
    astNode: astNode,
  );
}

/// Shorthand for generating a [GraphQLInputObjectType].
GraphQLInputObjectType<T> inputObjectType<T>(
  String name, {
  String? description,
  Iterable<GraphQLFieldInput> fields = const [],
  T Function(Map<String, Object?>)? customDeserialize,
  bool isOneOf = false,
  GraphQLTypeDefinitionExtra<InputObjectTypeDefinitionNode,
          InputObjectTypeExtensionNode>
      extra = const GraphQLTypeDefinitionExtra.attach([]),
}) {
  return GraphQLInputObjectType(
    name,
    description: description,
    fields: fields,
    customDeserialize: customDeserialize,
    isOneOf: isOneOf,
    extra: extra,
  );
}

/// Shorthand for generating a [GraphQLFieldInput].
GraphQLFieldInput<T, Serialized> inputField<T, Serialized>(
  String name,
  GraphQLType<T, Serialized> type, {
  String? description,
  T? defaultValue,
  String? deprecationReason,
  bool defaultsToNull = false,
  InputValueDefinitionNode? astNode,
}) {
  return GraphQLFieldInput(
    name,
    type,
    description: description,
    deprecationReason: deprecationReason,
    defaultValue: defaultValue,
    defaultsToNull: defaultsToNull,
    astNode: astNode,
  );
}

/// Utility extensions for creating fields in a [GraphQLSchema].
///
/// Improved type inference, over `field(name, type)` or field constructors
extension GraphQLFieldTypeExt<V, S> on GraphQLType<V, S> {
  /// Utility for creating an [GraphQLObjectField] with [type] == [this]
  ///
  /// Improved type inference, over `field(name, type)`
  /// since [V] and [S] are already specified from [this]
  GraphQLObjectField<V, S, P> field<P>(
    String name, {
    String? deprecationReason,
    String? description,
    GraphQLFieldResolver<V, P>? resolve,
    GraphQLSubscriptionFieldResolver<V>? subscribe,
    Iterable<GraphQLFieldInput<Object?, Object?>> inputs = const [],
    FieldDefinitionNode? astNode,
    GraphQLAttachments attachments = const [],
  }) {
    return GraphQLObjectField(
      name,
      this,
      inputs: inputs,
      resolve: resolve == null ? null : FieldResolver(resolve),
      subscribe:
          subscribe == null ? null : FieldSubscriptionResolver(subscribe),
      description: description,
      deprecationReason: deprecationReason,
      astNode: astNode,
      attachments: attachments,
    );
  }

  /// Shorthand for generating a [GraphQLFieldInput].
  GraphQLFieldInput<V, S> inputField(
    String name, {
    String? description,
    V? defaultValue,
    String? deprecationReason,
    bool defaultsToNull = false,
    InputValueDefinitionNode? astNode,
  }) {
    return GraphQLFieldInput(
      name,
      this,
      description: description,
      deprecationReason: deprecationReason,
      defaultValue: defaultValue,
      defaultsToNull: defaultsToNull,
      astNode: astNode,
    );
  }
}

/// Creates an instance of a cached value that should be re-instantiated
/// once [_hotReloadCounter] changes. Useful for hot reload.
class HotReloadableDefinition<T extends Object> {
  static int _hotReloadCounter = 0;

  /// Increases [_hotReloadCounter] by one, call it if you
  /// want to re-instantiated all GraphQL elements (type and field definitions)
  /// that use [HotReloadableDefinition]
  static void incrementCounter() => _hotReloadCounter++;

  /// Callback to instantiate the cached value.
  ///
  /// The parameter to [create] is a function that should be called
  /// as soon as you instantiate the value within [create],
  /// this is only necessary for cyclic value. The parameter returns the
  /// same value, useful for method chaining.
  final T Function(T Function(T) setValue) create;

  /// Creates an instance of a cached value that will be re-instantiated
  /// once [_hotReloadCounter] changes. Useful for hot reload.
  HotReloadableDefinition(this.create);

  /// Current cached value
  T? _value;

  /// If non-null, the value of [_hotReloadCounter]
  /// when [_value] was instantiated
  int? _counter;

  /// Retrieves the value if [_hotReloadCounter] is equal to [_counter],
  /// otherwise uses the provided [create] to instantiate
  /// and return the new [_value].
  T get value {
    if (_hotReloadCounter == _counter) {
      return _value!;
    }
    _setValue(create(_setValue));
    return _value!;
  }

  // ignore: use_setters_to_change_properties
  T _setValue(T newValue) {
    _counter = _hotReloadCounter;
    _value = newValue;
    return newValue;
  }
}
