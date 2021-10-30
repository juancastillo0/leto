part of graphql_schema.src.schema;

/// A [GraphQLType] that specifies the shape of structured data,
/// with multiple fields that can be resolved independently of one another.
class GraphQLObjectType<P extends Object>
    extends GraphQLType<P, Map<String, dynamic>>
    with _NonNullableMixin<P, Map<String, dynamic>> {
  /// The name of this type.
  @override
  final String name;

  /// An optional description of this type; useful for tools like GraphiQL.
  @override
  final String? description;

  /// The list of fields that an object of this type is expected to have.
  final List<GraphQLObjectField<Object, Object, P>> fields = [];

  /// `true` if this type should be treated as an *interface*,
  /// which child types can [inheritFrom].
  ///
  /// In GraphQL, the parent class is *aware* of
  /// all the [possibleTypes] that can implement it.
  final bool isInterface;

  final List<GraphQLObjectType> _interfaces = [];

  final List<GraphQLObjectType> _possibleTypes = [];

  /// A list of other types that this object type is known to implement.
  List<GraphQLObjectType> get interfaces =>
      List<GraphQLObjectType>.unmodifiable(_interfaces);

  /// A list of other types that implement this interface.
  List<GraphQLObjectType> get possibleTypes =>
      List<GraphQLObjectType>.unmodifiable(_possibleTypes);

  /// When this is an interface ([isInterface] == true), this function
  /// returns the name of the [GraphQLObjectType] in [possibleTypes] which
  /// implements the resolved result passed in the parameter
  final _ResolveType<GraphQLObjectType<P>>? resolveType;

  /// When provided, this function should return true for values
  /// which are associated with this object type
  final _IsTypeOf<P>? isTypeOf;

  GraphQLObjectType(
    this.name, {
    this.description,
    this.isInterface = false,
    ResolveType<GraphQLObjectType<P>>? resolveType,
    IsTypeOf<P>? isTypeOf,
    Iterable<GraphQLObjectField<Object, Object, P>> fields = const [],
    Iterable<GraphQLObjectType> interfaces = const [],
  })  : isTypeOf = isTypeOf == null ? null : _IsTypeOf(isTypeOf),
        resolveType = resolveType == null ? null : _ResolveType(resolveType) {
    this.fields.addAll(fields);

    inheritFromMany(interfaces);
  }

  @override
  GraphQLType<P, Map<String, dynamic>> coerceToInputObject() {
    return toInputObject('${name}Input', description: description);
  }

  /// Converts [this] into a [GraphQLInputObjectType].
  GraphQLInputObjectType<P> toInputObject(
    String name, {
    String? description,
    P Function(Map<String, Object?>)? customDeserialize,
  }) {
    return GraphQLInputObjectType(
      name,
      description: description ?? this.description,
      customDeserialize: customDeserialize,
      fields: fields.map(
        (f) => GraphQLFieldInput(
          f.name,
          f.type.coerceToInputObject(),
          description: f.description,
          deprecationReason: f.deprecationReason,
        ),
      ),
    );
  }

  /// Declares that this type inherits from another parent type.
  ///
  /// This also has the side effect of notifying
  /// the parent that this type is its descendant.
  void inheritFrom(GraphQLObjectType other) {
    if (!_interfaces.contains(other)) {
      _interfaces.add(other);
      other._possibleTypes.add(this);
      other._interfaces.forEach(inheritFrom);
    }
  }

  void inheritFromMany(
    Iterable<GraphQLObjectType> others, {
    Set<GraphQLObjectType>? alreadyInherited,
  }) {
    final initial = alreadyInherited == null;
    final _alreadyInherited = alreadyInherited ?? {};

    for (final other in others) {
      if (!_interfaces.contains(other)) {
        _interfaces.add(other);
        _alreadyInherited.add(other);
        inheritFromMany(other._interfaces, alreadyInherited: _alreadyInherited);
      }
    }

    if (initial) {
      for (final other in _alreadyInherited) {
        if (!other._possibleTypes.contains(this)) {
          other._possibleTypes.add(this);
        }
      }
    }
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(
    String key,
    Object? input,
  ) {
    if (input is! Map<String, Object?>)
      return ValidationResult.failure([
        'Expected "$key" to be a Map of type $this. Got invalid value $input.'
      ]);

    if (isInterface) {
      final List<String> errors = [];

      for (final type in possibleTypes) {
        final result = type.validate(key, input);

        if (result.successful) {
          return result;
        } else {
          errors.addAll(result.errors);
        }
      }

      return ValidationResult.failure(errors);
    }

    return _validateObject(this, fields, key, input);
  }

  @override
  Map<String, dynamic> serialize(P value) {
    final map = _jsonFromValue(value);
    return _gqlFromJson(map, fields);
    // return map.keys.fold(<String, dynamic>{}, (out, k) {
    //   final field = fields.firstWhereOrNull((f) => f.name == k);
    //   if (field == null)
    //     throw UnsupportedError(
    //       'Cannot serialize field "$k", which was not defined in the schema.',
    //     );
    //   return out..[k.toString()] = field.serialize(value[k]);
    // });
  }

  @override
  P deserialize(SerdeCtx serdeCtx, Map<String, Object?> serialized) {
    return _valueFromJson(serdeCtx, serialized, fields);
    // return value.keys.fold(<String, Object?>{}, (out, k) {
    //   final field = fields.firstWhereOrNull((f) => f.name == k);
    //   if (field == null)
    //     throw UnsupportedError('Unexpected field "$k" encountered in map.');
    //   return out..[k.toString()] = field.deserialize(serdeCtx, value[k]);
    // });
  }

  /// Returns `true` if this type, or any of its parents,
  /// is a direct descendant of another given [type].
  bool isImplementationOf(GraphQLObjectType type) {
    if (type == this) {
      return true;
    } else if (interfaces.contains(type)) {
      return true;
    } else if (interfaces.isNotEmpty) {
      return interfaces.any((t) => t.isImplementationOf(type));
    } else {
      return false;
    }
  }

  @override
  Iterable<Object?> get props => [
        name,
        description,
        isInterface,
        // Filter introspection fields TODO: should we do this?
        fields.where((f) => !f.name.startsWith('__')),
        interfaces,
        possibleTypes
      ];
}

typedef ResolveType<P extends GraphQLType> = String Function(
    Object, P, ResolveObjectCtx);

class _ResolveType<T extends GraphQLType<Object, Object>> {
  final ResolveType<T> func;

  const _ResolveType(this.func);

  String call(Object result, T type, ResolveObjectCtx ctx) =>
      func(result, type, ctx);
}

typedef IsTypeOf<P extends Object> = bool Function(
    Object, GraphQLObjectType<P>, ResolveObjectCtx);

class _IsTypeOf<P extends Object> {
  final IsTypeOf<P> func;

  _IsTypeOf(this.func);

  bool call(Object value, GraphQLObjectType<P> type, ResolveObjectCtx ctx) =>
      func(value, type, ctx);
}

/// A special [GraphQLType] that specifies the shape of an object that can only
/// be used as an input to a [GraphQLField].
///
/// GraphQL input object types are different from regular [GraphQLObjectType]s
/// in that they do not support resolution,
/// and are overall more limiter in utility, because their only purpose is to
/// reduce the number of parameters to a given field, and to potentially
/// reuse an input structure across multiple fields in the hierarchy.
class GraphQLInputObjectType<Value extends Object>
    extends GraphQLType<Value, Map<String, dynamic>>
    with _NonNullableMixin<Value, Map<String, dynamic>> {
  /// The name of this type.
  @override
  final String name;

  /// An optional type of this type, which is useful for tools like GraphiQL.
  @override
  final String? description;

  /// A list of the fields that an input object of this
  /// type is expected to have.
  final List<GraphQLFieldInput> fields = [];

  /// A function which parses a JSON Map into the [Value] type
  final Value Function(Map<String, Object?>)? customDeserialize;

  GraphQLInputObjectType(
    this.name, {
    this.description,
    Iterable<GraphQLFieldInput> fields = const [],
    this.customDeserialize,
  }) {
    this.fields.addAll(fields);
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(String key, Object? input) {
    return _validateObject(this, fields, key, input);
  }

  @override
  Map<String, dynamic> serialize(Value value) {
    final map = _jsonFromValue(value);
    return _gqlFromJson(map, fields);
  }

  @override
  Value deserialize(SerdeCtx serdeCtx, Map<String, Object?> serialized) {
    if (customDeserialize != null) {
      return customDeserialize!(serialized);
    } else {
      return _valueFromJson(serdeCtx, serialized, fields);
    }
    // return value.keys.fold(<String, dynamic>{}, (out, k) {
    //   final field = inputFields.firstWhereOrNull((f) => f.name == k);
    //   if (field == null)
    //     throw UnsupportedError('Unexpected field "$k" encountered in map.');
    //   return out..[k.toString()] = field.type.deserialize(value[k]);
    // });
  }

  @override
  Iterable<Object?> get props => [name, description, customDeserialize, fields];

  @override
  GraphQLType<Value, Map<String, dynamic>> coerceToInputObject() => this;
}

/// Utility interface implemented by
/// [GraphQLObjectField] and [GraphQLFieldInput]
abstract class ObjectField {
  /// The name of the field
  String get name;

  /// The type of the field
  GraphQLType<Object, Object> get type;
}

ValidationResult<Map<String, dynamic>> _validateObject(
  GraphQLType<Object, Map<String, Object?>> type,
  List<ObjectField> fields,
  String key,
  Object? input,
) {
  if (input is! Map<String, Object?>)
    return ValidationResult.failure([
      'Expected "$key" to be a Map of type $type. Got invalid value $input.'
    ]);

  final out = <String, Object?>{};
  final List<String> errors = [];

  errors.addAll(
    fields.where((f) => f.type.isNonNullable && input[f.name] == null).map(
          (field) => '$key: Field "${field.name}" of'
              ' type ${field.type} cannot be null.',
        ),
  );

  input.forEach((k, v) {
    if (v == null) {
      // already verified
      out[k] = v;
      return;
    }
    final field = fields.firstWhereOrNull((f) => f.name == k);

    if (field == null) {
      errors.add('Unexpected field "$k" encountered in $key. Accepted values on'
          ' type ${type.name}: ${fields.map((f) => f.name).toList()}');
    } else {
      final result = field.type.validate(k, v);

      if (!result.successful) {
        errors.addAll(result.errors.map((s) => '$key: $s'));
      } else {
        out[k] = result.value;
      }
    }
  });

  if (errors.isNotEmpty) {
    return ValidationResult.failure(errors);
  } else {
    return ValidationResult.ok(out);
  }
}

Value _valueFromJson<Value>(
  SerdeCtx serdeCtx,
  Map<String, Object?> map,
  List<ObjectField> fields,
) {
  if (const <String, Object?>{} is! Value) {
    return serdeCtx.fromJson(map);
  } else {
    return map.map((k, value) {
      final field = fields.firstWhere(
        (f) => f.name == k,
        orElse: () => throw UnsupportedError(
          'Unexpected field "$k" encountered in map.',
        ),
      );
      return MapEntry(
        k,
        value == null ? null : field.type.deserialize(serdeCtx, value),
      );
    }) as Value;
  }
}

Map<String, Object?> _jsonFromValue(Object value) {
  Map<String, Object?> map;
  if (value is Map) {
    map = value.cast();
  } else {
    try {
      // ignore: avoid_dynamic_calls
      map = (value as dynamic).toMap() as Map<String, Object?>;
    } catch (_) {
      // ignore: avoid_dynamic_calls
      map = (value as dynamic).toJson() as Map<String, Object?>;
    }
  }
  return map;
}

Map<String, Object?> _gqlFromJson(
  Map<String, Object?> map,
  List<ObjectField> fields,
) {
  return Map.fromEntries(map.entries.map((e) {
    final field = fields.firstWhereOrNull((f) => f.name == e.key);
    if (field == null) {
      return null;
      // TODO: serealized value can have multiple values in the map
      // some of which are not in fields
      // throw UnsupportedError(
      //   'Cannot serialize field "$key", which was not defined in the schema.',
      // );
    }
    return MapEntry(e.key, field.type.serializeSafe(e.value));
  }).whereType());
}
