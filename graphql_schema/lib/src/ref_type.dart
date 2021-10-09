// part of graphql_schema.src.schema;

// GraphQLType<T, S> refType<T extends Object, S extends Object>(
//     GraphQLType<T, S> Function() ref) {
//   return GraphQLRefType(ref);
// }

// class GraphQLRefType<T extends Object, S extends Object>
//     extends GraphQLType<T, S> with _NonNullableMixin<T, S> {
//   final GraphQLType<T, S> Function() ref;
//   GraphQLRefType(this.ref);

//   GraphQLType<T, S>? _innerType;
//   GraphQLType<T, S> innerType() {
//     if (_innerType != null) {
//       return _innerType!;
//     }
//     _innerType = ref();
//     while (_innerType is GraphQLRefType<T, S>) {
//       _innerType = (_innerType! as GraphQLRefType<T, S>).ref();
//     }
//     return _innerType!;
//   }

//   @override
//   String? get name => innerType().name;

//   @override
//   String? get description => innerType().description;

//   @override
//   GraphQLType<T, S> coerceToInputObject() => innerType().coerceToInputObject();

//   @override
//   T deserialize(SerdeCtx serdeCtx, S serialized) =>
//       innerType().deserialize(serdeCtx, serialized);

//   @override
//   S serialize(T value) => innerType().serialize(value);

//   @override
//   ValidationResult<S> validate(String key, Object? input) {
//     return innerType().validate(key, input);
//   }

//   @override
//   Iterable<Object?> get props => [ref];
// }
