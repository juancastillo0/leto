part of graphql_schema.src.schema;

/// A special [GraphQLType] that indicates that an input value may
/// be valid against one or more [possibleTypes].
///
/// All provided types must be [GraphQLObjectType]s.
class GraphQLUnionType<P> extends GraphQLType<P, Map<String, dynamic>>
    with _NonNullableMixin<P, Map<String, dynamic>> {
  /// The name of this type.
  @override
  final String name;

  /// A list of all types that conform to this union.
  final List<GraphQLObjectType> possibleTypes = [];

  @override
  final String? description;

  /// Used to provide type resolution at runtime
  ///
  /// Should return the name of the type in [possibleTypes] which is
  /// associated with the resolved result passed as parameter
  final _ResolveType<GraphQLUnionType<P>>? resolveType;

  /// When the union type is a wrapper around the real types associated to
  /// [possibleTypes], this function extracts that value from the wrapper
  final Object Function(P)? _extractInner;

  Object extractInner(P p) {
    if (_extractInner != null) {
      return _extractInner!.call(p);
    }
    return p!;
  }

  GraphQLUnionType(
    this.name,
    Iterable<GraphQLObjectType> possibleTypes, {
    this.description,
    ResolveType<GraphQLUnionType<P>>? resolveType,

    /// TODO:
    Object Function(P)? extractInner,
  })  : _extractInner = extractInner,
        resolveType = resolveType == null ? null : _ResolveType(resolveType),
        assert(
            possibleTypes.every((t) => t.whenMaybe(
                object: (obj) => !obj.isInterface, orElse: (_) => false)),
            'The member types of a Union type must all be Object base types; '
            'Scalar, Interface and Union types must not be member types '
            'of a Union. Similarly, wrapping types must not be member '
            'types of a Union.')
  //       assert(possibleTypes.isNotEmpty,
  //           'A Union type must define one or more member types.')
  {
    for (final t in possibleTypes.toSet()) {
      this.possibleTypes.add(t);
    }
  }

  @override
  GraphQLType<P, Map<String, dynamic>> coerceToInputObject() {
    throw Exception('Unions are never valid inputs.');
  }

  @override
  Map<String, dynamic> serialize(P value) {
    for (final type in possibleTypes) {
      try {
        if (type.validate('@root', value).successful) {
          return type.serialize(value);
        }
      } catch (_) {}
    }

    throw ArgumentError();
  }

  @override
  P deserialize(
    SerdeCtx serdeCtx,
    Map<String, dynamic> serialized,
  ) {
    for (final type in possibleTypes) {
      try {
        return type.deserialize(serdeCtx, serialized) as P;
      } catch (_) {}
    }

    throw ArgumentError();
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(String key, Object? input) {
    final List<String> errors = [];

    for (final type in possibleTypes) {
      final result = type.validate(key, input);

      if (result.successful) {
        return result;
      } else {
        errors.addAll(result.errors);
      }
    }

    return ValidationResult<Map<String, dynamic>>.failure(errors);
  }

  @override
  Iterable<Object?> get props => [name, description, possibleTypes];
}
