part of graphql_schema.src.schema;

/// Shorthand for generating a [GraphQLObjectType].
GraphQLObjectType<P> objectType<P extends Object>(
  String name, {
  String? description,
  bool isInterface = false,
  Iterable<GraphQLObjectField<Object, Object, P>> fields = const [],
  Iterable<GraphQLObjectType> interfaces = const [],
}) {
  final obj = GraphQLObjectType<P>(name, description, isInterface: isInterface)
    ..fields.addAll(fields);

  if (interfaces.isNotEmpty) {
    for (final i in interfaces) {
      obj.inheritFrom(i);
    }
  }

  return obj;
}

/// Shorthand for generating a [GraphQLObjectField].
GraphQLObjectField<T, Serialized, P>
    field<T extends Object, Serialized extends Object, P>(
  String name,
  GraphQLType<T, Serialized> type, {
  Iterable<GraphQLFieldInput<Object, Object>> inputs = const [],
  GraphQLFieldResolver<T, P>? resolve,
  GraphQLSubscriptionFieldResolver<T, P>? subscribe,
  String? deprecationReason,
  String? description,
}) {
  return GraphQLObjectField(
    name,
    type,
    arguments: inputs,
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
  Iterable<GraphQLFieldInput> inputFields = const [],
}) {
  return GraphQLInputObjectType(
    name,
    description: description,
    inputFields: inputFields,
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
  GraphQLObjectField<V, S, P> field<P>(
    String name, {
    String? deprecationReason,
    String? description,
    GraphQLFieldResolver<V, P>? resolve,
    GraphQLSubscriptionFieldResolver<V, P>? subscribe,
    Iterable<GraphQLFieldInput<Object, Object>> inputs = const [],
  }) {
    return GraphQLObjectField(
      name,
      this,
      resolve: resolve == null ? null : FieldResolver(resolve),
      subscribe:
          subscribe == null ? null : FieldSubscriptionResolver(subscribe),
      description: description,
      deprecationReason: deprecationReason,
      arguments: inputs,
    );
  }
}
