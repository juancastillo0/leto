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
  String? deprecationReason,
  String? description,
}) {
  return GraphQLObjectField(name, type,
      arguments: inputs,
      resolve: resolve == null ? null : FieldResolver(resolve),
      description: description,
      deprecationReason: deprecationReason);
}

/// Shorthand for generating a [GraphQLInputObjectType].
GraphQLInputObjectType inputObjectType(
  String name, {
  String? description,
  Iterable<GraphQLInputObjectField> inputFields = const [],
}) {
  return GraphQLInputObjectType(
    name,
    description: description,
    inputFields: inputFields,
  );
}

/// Shorthand for generating a [GraphQLInputObjectField].
GraphQLInputObjectField<T, Serialized>
    inputField<T extends Object, Serialized extends Object>(
  String name,
  GraphQLType<T, Serialized> type, {
  String? description,
  T? defaultValue,
}) {
  return GraphQLInputObjectField(
    name,
    type,
    description: description,
    defaultValue: defaultValue,
  );
}
