part of graphql_schema.src.schema;

/// Shorthand for generating a [GraphQLObjectType].
GraphQLObjectType<P> objectType<P extends Object>(
  String name, {
  String? description,
  bool isInterface = false,
  Iterable<GraphQLObjectField<Object, Object, P>> fields = const [],
  Map<String, GraphQLObjectField<Object, Object, P>>? fieldsMap,
  ResolveType<GraphQLObjectType<P>>? resolveType,
  IsTypeOf<P>? isTypeOf,
  Iterable<GraphQLObjectType> interfaces = const [],
}) {
  return GraphQLObjectType<P>(
    name,
    description: description,
    isInterface: isInterface,
    resolveType: resolveType,
    isTypeOf: isTypeOf,
    fields: fieldsMap == null
        ? fields
        : fieldsMap.entries
            .map((e) => copyFieldWithName(e.key, e.value))
            .followedBy(fields),
    interfaces: interfaces,
  );
}

/// Return a [GraphQLObjectField] with [name] and all other
/// properties copied from [field]
GraphQLObjectField<V, S, P>
    copyFieldWithName<V extends Object, S extends Object, P extends Object>(
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
GraphQLObjectField<T, Serialized, P>
    field<T extends Object, Serialized extends Object, P extends Object>(
  String name,
  GraphQLType<T, Serialized> type, {
  Iterable<GraphQLFieldInput<Object, Object>> inputs = const [],
  GraphQLFieldResolver<T, P>? resolve,
  GraphQLSubscriptionFieldResolver<T>? subscribe,
  String? deprecationReason,
  String? description,
}) {
  return GraphQLObjectField(
    name,
    type,
    inputs: inputs,
    resolve: resolve == null ? null : FieldResolver(resolve),
    subscribe: subscribe == null ? null : FieldSubscriptionResolver(subscribe),
    description: description,
    deprecationReason: deprecationReason,
  );
}

/// Shorthand for generating a [GraphQLInputObjectType].
GraphQLInputObjectType<T> inputObjectType<T extends Object>(
  String name, {
  String? description,
  Iterable<GraphQLFieldInput> fields = const [],
  T Function(Map<String, Object?>)? customDeserialize,
}) {
  return GraphQLInputObjectType(
    name,
    description: description,
    fields: fields,
    customDeserialize: customDeserialize,
  );
}

/// Shorthand for generating a [GraphQLFieldInput].
GraphQLFieldInput<T, Serialized>
    inputField<T extends Object, Serialized extends Object>(
  String name,
  GraphQLType<T, Serialized> type, {
  String? description,
  T? defaultValue,
  String? deprecationReason,
}) {
  return GraphQLFieldInput(
    name,
    type,
    description: description,
    defaultValue: defaultValue,
    deprecationReason: deprecationReason,
  );
}

extension GraphQLFieldTypeExt<V extends Object, S extends Object>
    on GraphQLType<V, S> {
  /// Utility for creating an [GraphQLObjectField] with [type] == [this]
  ///
  /// Improved type inference, over `field(name, type)`
  /// since [V] and [S] are already specified from [this]
  GraphQLObjectField<V, S, P> field<P extends Object>(
    String name, {
    String? deprecationReason,
    String? description,
    GraphQLFieldResolver<V, P>? resolve,
    GraphQLSubscriptionFieldResolver<V>? subscribe,
    Iterable<GraphQLFieldInput<Object, Object>> inputs = const [],
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
    );
  }

  /// Shorthand for generating a [GraphQLObjectField] without a name.
  /// Useful in combination with [objectType]'s fieldsMap parameter.
  GraphQLObjectField<V, S, P> fieldSpec<P extends Object>({
    String? deprecationReason,
    String? description,
    GraphQLFieldResolver<V, P>? resolve,
    GraphQLSubscriptionFieldResolver<V>? subscribe,
    Iterable<GraphQLFieldInput<Object, Object>> inputs = const [],
  }) {
    return GraphQLObjectField(
      '',
      this,
      inputs: inputs,
      resolve: resolve == null ? null : FieldResolver(resolve),
      subscribe:
          subscribe == null ? null : FieldSubscriptionResolver(subscribe),
      description: description,
      deprecationReason: deprecationReason,
    );
  }
}
