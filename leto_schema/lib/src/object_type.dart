part of leto_schema.src.schema;

/// A [GraphQLType] that specifies the shape of structured data,
/// with multiple fields that can be resolved independently of one another.
class GraphQLObjectType<P> extends GraphQLCompositeType<P>
    with
        _NonNullableMixin<P, Map<String, dynamic>>,
        _GraphQLBaseNestedType<P, GraphQLObjectField<Object?, Object?, P>> {
  /// The name of this type.
  @override
  final String name;

  /// An optional description of this type; useful for tools like GraphiQL.
  @override
  final String? description;

  /// The list of fields that an object of this type is expected to have.
  @override
  final List<GraphQLObjectField<Object?, Object?, P>> fields = [];

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
      List.of(_interfaces.where((obj) => obj.isInterface));

  /// A list of other types that implement this interface.
  @override
  List<GraphQLObjectType> get possibleTypes =>
      List<GraphQLObjectType>.unmodifiable(_possibleTypes);

  /// When this is an interface ([isInterface] == true), this function
  /// returns the name of the [GraphQLObjectType] in [possibleTypes] which
  /// implements the resolved result passed in the parameter
  final ResolveTypeWrapper<GraphQLObjectType<P>>? resolveType;

  /// When provided, this function should return true for values
  /// which are associated with this object type
  final IsTypeOfWrapper<P>? isTypeOf;

  /// TODO: interface
  @override
  final GraphQLTypeDefinitionExtra<TypeDefinitionNode, TypeExtensionNode> extra;

  /// A [GraphQLType] that specifies the shape of structured data,
  /// with multiple fields that can be resolved independently of one another.
  GraphQLObjectType(
    this.name, {
    this.description,
    this.isInterface = false,
    ResolveType<GraphQLObjectType<P>>? resolveType,
    IsTypeOf<P>? isTypeOf,
    Iterable<GraphQLObjectField<Object?, Object?, P>> fields = const [],
    Iterable<GraphQLObjectType> interfaces = const [],
    this.extra = const GraphQLTypeDefinitionExtra.attach([]),
  })  : isTypeOf = isTypeOf == null ? null : IsTypeOfWrapper(isTypeOf),
        resolveType =
            resolveType == null ? null : ResolveTypeWrapper(resolveType) {
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

  /// Declares that this type inherits from other parent types.
  ///
  /// This also has the side effect of notifying
  /// the parent that this type is its descendant.
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

  /// Returns `true` if this type, or any of its parents,
  /// is a direct descendant of another given [type].
  bool isImplementationOf(GraphQLObjectType type) {
    final _interfaces = interfaces;
    if (type == this) {
      return true;
    } else if (_interfaces.contains(type)) {
      return true;
    } else {
      return _interfaces.any((t) => t.isImplementationOf(type));
    }
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(
    String key,
    Object? input,
  ) {
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

    return super.validate(key, input);
  }
}

/// A function that returns the name of one of the possible types
/// of an given abstract [type] that matches the type for [result].
typedef ResolveType<P extends GraphQLType<Object?, Object?>> = String Function(
    Object result, P type, ObjectExecutionCtx);

/// A function that returns the name of one of the possible types
/// of an given abstract [type] that matches the type for [result].
///
/// Type casting wrapper for [ResolveType]
class ResolveTypeWrapper<T extends GraphQLType<Object?, Object?>> {
  final ResolveType<T> _func;

  const ResolveTypeWrapper(this._func);

  String call(Object result, T type, ObjectExecutionCtx ctx) =>
      _func(result, type, ctx);
}

/// A function that returns true if [result]
/// is an instance of [GraphQLObjectType] [type]
typedef IsTypeOf<P> = bool Function(
    Object result, GraphQLObjectType<P> type, ObjectExecutionCtx);

/// A function that returns true if [result]
/// is an instance of [GraphQLObjectType] [type]
///
/// Type casting wrapper for [IsTypeOf]
class IsTypeOfWrapper<P> {
  final IsTypeOf<P> _func;

  const IsTypeOfWrapper(this._func);

  bool call(Object value, GraphQLObjectType<P> type, ObjectExecutionCtx ctx) =>
      _func(value, type, ctx);
}

/// A special [GraphQLType] that specifies the shape of an object that can only
/// be used as an input to a [GraphQLField].
///
/// GraphQL input object types are different from regular [GraphQLObjectType]s
/// in that they do not support resolution,
/// and are overall more limiter in utility, because their only purpose is to
/// reduce the number of parameters to a given field, and to potentially
/// reuse an input structure across multiple fields in the hierarchy.
class GraphQLInputObjectType<Value>
    extends GraphQLNamedType<Value, Map<String, dynamic>>
    with
        _NonNullableMixin<Value, Map<String, dynamic>>,
        _GraphQLBaseNestedType<Value, GraphQLFieldInput> {
  /// The name of this type.
  @override
  final String name;

  /// An optional type of this type, which is useful for tools like GraphiQL.
  @override
  final String? description;

  /// A list of the fields that an input object of this
  /// type is expected to have.
  @override
  final List<GraphQLFieldInput> fields = [];

  /// A function which parses a JSON Map into the [Value] type
  final Value Function(Map<String, Object?>)? customDeserialize;

  @override
  final GraphQLTypeDefinitionExtra<InputObjectTypeDefinitionNode,
      InputObjectTypeExtensionNode> extra;

  /// If this is true, only one of the [fields] should be non null when parsing
  final bool isOneOf;

  /// A special [GraphQLType] that specifies the shape of an object that can
  /// only be used as an input to a [GraphQLField].
  GraphQLInputObjectType(
    this.name, {
    this.description,
    Iterable<GraphQLFieldInput<Object?, Object?>> fields = const [],
    this.customDeserialize,
    this.extra = const GraphQLTypeDefinitionExtra.attach([]),
    this.isOneOf = false,
  }) {
    this.fields.addAll(fields);
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(
    String key,
    Object? input,
  ) {
    final result = super.validate(key, input);
    if (result.successful) {
      if (isOneOf) {
        final _map = input! as Map<String, dynamic>;
        return _map.length == 1 && _map.values.first != null
            ? ValidationResult.ok(_map)
            : const ValidationResult.failure(
                ['A @oneOf() input type can only have one field.'],
              );
      } else {
        final inputWithDefault = addDefaults(result.value!);
        return ValidationResult.ok(inputWithDefault);
      }
    }
    return result;
  }

  Map<String, Object?> addDefaults(Map<String, Object?> values) {
    return fields.fold(
      {},
      (map, e) {
        final hasInput = values.containsKey(e.name);
        if (!hasInput && e.defaultValue == null) {
          return map;
        }
        Object? inputValue = values[e.name];
        if (inputValue == null && (!hasInput || e.type.isNonNullable)) {
          try {
            inputValue = e.type.serialize(e.defaultValue);
          } catch (_) {
            inputValue = e.defaultValue;
          }
        }

        return map..[e.name] = inputValue;
      },
    );
  }

  @override
  Value deserialize(SerdeCtx serdeCtx, Map<String, Object?> serialized) {
    if (customDeserialize != null) {
      return customDeserialize!(serialized);
    } else {
      return super.deserialize(serdeCtx, serialized);
    }
  }

  @override
  GraphQLType<Value, Map<String, dynamic>> coerceToInputObject() => this;
}

/// A field in a [GraphQLSchema]
///
/// Utility interface implemented by
/// [GraphQLObjectField] and [GraphQLFieldInput]
abstract class ObjectField implements GraphQLElement {
  /// The name of the field
  @override
  String get name;

  /// The type of the field
  GraphQLType<Object?, Object?> get type;
}

/// A [GraphQLType] that specifies the shape of structured data,
/// with multiple fields that can be resolved independently of one another.
mixin _GraphQLBaseNestedType<P, F extends ObjectField>
    on GraphQLType<P, Map<String, Object?>> {
  /// The list of fields that an object of this type is expected to have
  List<F> get fields;

  /// Returns the field with the given [name]
  F? fieldByName(String name) {
    return fields.firstWhereOrNull((field) => field.name == name);
  }

  @override
  ValidationResult<Map<String, dynamic>> validate(
    String key,
    Object? input,
  ) {
    return _validateObject(this, fields, key, input);
  }

  @override
  Map<String, dynamic> serialize(P value) {
    final map = _jsonFromValue(value!);
    return _gqlFromJson(map, fields);
  }

  @override
  P deserialize(SerdeCtx serdeCtx, Map<String, Object?> serialized) {
    return _valueFromJson(serdeCtx, serialized, fields);
  }
}

ValidationResult<Map<String, dynamic>> _validateObject(
  GraphQLType<Object?, Map<String, Object?>> type,
  List<ObjectField> fields,
  String key,
  Object? input,
) {
  if (input is! Map<String, Object?>) {
    return ValidationResult.failure([
      'Expected "$key" to be a Map of type $type. Got invalid value $input.'
    ]);
  }

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
      //  'Cannot serialize field "$key", which was not defined in the schema.',
      // );
    }
    return MapEntry(
      e.key,
      e.value == null ? null : field.type.serializeSafe(e.value),
    );
  }).whereType());
}
