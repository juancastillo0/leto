part of graphql_schema.src.schema;

GraphQLType<T, S> refType<T, S>(GraphQLType<T, S> Function() ref) {
  return GraphQLRefType(ref);
}

class GraphQLRefType<T, S> extends GraphQLType<T, S> {
  final GraphQLType<T, S> Function() ref;
  const GraphQLRefType(this.ref);

  GraphQLType<T, S> innerType() {
    GraphQLType<T, S> type = ref();
    while (type is GraphQLRefType<T, S>) {
      type = type.ref();
    }
    return type;
  }

  @override
  String? get name => ref().name;

  @override
  String? get description => ref().description;

  @override
  GraphQLType<T, S> coerceToInputObject() => ref().coerceToInputObject();

  @override
  T deserialize(SerdeCtx serdeCtx, S serialized) =>
      ref().deserialize(serdeCtx, serialized);

  @override
  S serialize(T value) => ref().serialize(value);

  @override
  ValidationResult<S> validate(String key, Object? input) {
    return ref().validate(key, input);
  }

  @override
  GraphQLType<T, S> nonNullable() {
    return ref().nonNullable();
  }
}
