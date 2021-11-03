part of leto_schema.src.schema;

class GraphQLTypeSet {
  final Map<String, GraphQLType> types = {};

  Iterable<GraphQLType> get allTypes => types.values;

  void add(GraphQLType type) {
    final prev = types[type.toString()];
    if (prev == null) {
      types[type.toString()] = type;
    } else {
      assert(prev == type);
    }
  }
}

/// Strictly dictates the structure of some input data in a GraphQL query.
///
/// GraphQL's rigid type system is primarily implemented in Dart using
/// classes that extend from [GraphQLType].
///
/// A [GraphQLType] represents values of type [Value] as
/// values of type [Serialized]; for example, a
/// [GraphQLType] that serializes objects into `String`s.
abstract class GraphQLType<Value, Serialized> {
  const GraphQLType();

  /// The name of this type.
  ///
  /// Null for [GraphQLWrapperType] such us
  /// [GraphQLNonNullType] and [GraphQLListType].
  String? get name;

  /// The name of the this type with defaults for [GraphQLWrapperType]
  String get printableName {
    return when(
      enum_: (t) => t.name,
      scalar: (t) => t.name,
      object: (t) => t.name,
      input: (t) => t.name,
      union: (t) => t.name,
      list: (t) => '${t.ofType.printableName}List',
      nonNullable: (t) => '${t.ofType.printableName}Req',
    );
  }

  // Value? cast(Value? value) {
  //   return value;
  // }

  GraphQLListType<Value?, Serialized> list() {
    return listOf(this);
  }

  /// A description of this type, which, while optional, can be
  /// very useful in tools like GraphiQL.
  String? get description;

  /// Serializes a [value].
  Serialized serialize(Value value);

  /// Deserializes a serialized value.
  ///
  /// [serdeCtx] can be used to deserialize nested values.
  Value deserialize(SerdeCtx serdeCtx, Serialized serialized);

  // /// Attempts to cast a dynamic [value] into a [Serialized] instance.
  // Serialized convert(Object? value) => value as Serialized;

  /// Performs type coercion against an [input] value, and returns a
  /// list of errors if the validation was unsuccessful.
  ValidationResult<Serialized> validate(String key, Object? input);

  /// Creates a non-nullable type that represents this type, and enforces
  /// that a field of this type is present in input data.
  GraphQLNonNullType<Value, Serialized> nonNull();

  /// Turns this type into one suitable for being provided as an input
  /// to a [GraphQLObjectField].
  GraphQLType<Value, Serialized> coerceToInputObject();

  Serialized serializeSafe(Object? value, {bool nested = true}) {
    if (value is Serialized &&
        (!nested || value is! Map && value is! List || value is! Value)) {
      return value;
    } else if (value is! Value) {
      throw GraphQLException([
        GraphQLError(
          'Cannot convert value $value of $Value to type $Serialized.'
          ' In $name ($runtimeType)',
        )
      ]);
    } else {
      return serialize(value);
    }
  }

  Iterable<Object?> get props;

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
            other is GraphQLType &&
                (runtimeType == other.runtimeType ||
                    this is GraphQLObjectType && other is GraphQLObjectType) &&
                const DeepCollectionEquality().equals(other.props, props)
        // || other is GraphQLType &&
        // () {
        //   final _otherReal = other.realType;
        //   final _real = realType;
        //   return identical(_otherReal, realType) ||
        //       (_otherReal.runtimeType == _real.runtimeType &&
        //           _otherReal is GraphQLTypeWrapper &&
        //           _real is GraphQLTypeWrapper &&
        //           (_otherReal as GraphQLTypeWrapper).ofType.realType ==
        //               (_real as GraphQLTypeWrapper).ofType.realType);
        // }()
        ;
  }

  static Map<String, GraphQLType>? _usedHashCodes;

  @override
  int get hashCode {
    final key = toString();
    final _used = _usedHashCodes;
    if (_used == null) {
      _usedHashCodes = {key: this};
      final value = const DeepCollectionEquality().hash(props);
      _usedHashCodes = null;
      return value;
    } else if (_used.containsKey(key)) {
      assert(
        () {
          final other = _used[key]!;
          final areEqual = other == this;
          return areEqual;
        }(),
        'GraphQLTypes with the same name are different:'
        ' $this != ${_used[key]}. $props != ${_used[key]!.props}',
      );
      return key.hashCode;
    } else {
      _used[key] = this;
    }
    return const DeepCollectionEquality().hash(props);
  }

  @override
  String toString() => name!;

  /// Utility for working with the [Value] Generic type
  // GenericHelpWithExtends<Value, Object> get generic => GenericHelpWithExtends();
  GenericHelp<Value> get generic => GenericHelp();

  /// true when the type can not be null
  bool get isNonNullable => this is GraphQLNonNullType;

  /// true when the type can be null
  bool get isNullable => !isNonNullable;

  /// Executes any of the provided function with [this] as argument.
  /// The function executed depends on the type of [this]
  O when<O>({
    required O Function(GraphQLEnumType<Value>) enum_,
    required O Function(GraphQLScalarType<Value, Serialized>) scalar,
    required O Function(GraphQLObjectType<Value>) object,
    required O Function(GraphQLInputObjectType<Value>) input,
    required O Function(GraphQLUnionType<Value>) union,
    required O Function(GraphQLListType) list,
    required O Function(GraphQLNonNullType<Value, Serialized>) nonNullable,
  }) {
    final GraphQLType type = this;

    if (type is GraphQLEnumType<Value>) {
      return enum_(type);
    } else if (type is GraphQLScalarType<Value, Serialized>) {
      return scalar(type);
    } else if (type is GraphQLObjectType<Value>) {
      return object(type);
    } else if (type is GraphQLInputObjectType<Value>) {
      return input(type);
    } else if (type is GraphQLUnionType<Value>) {
      return union(type);
    } else if (type is GraphQLListType) {
      return list(type);
    } else if (type is GraphQLNonNullType<Value, Serialized>) {
      return nonNullable(type);
    } else {
      throw Exception(
        'Could not cast $this ($runtimeType) as a typical GraphQLType.',
      );
    }
  }

  /// Similar to [when], but with optional arguments and
  /// a required default case [orElse], which is executed when none of
  /// the provided functions match [this]
  O whenMaybe<O>({
    O Function(GraphQLEnumType<Value>)? enum_,
    O Function(GraphQLScalarType<Value, Serialized>)? scalar,
    O Function(GraphQLObjectType<Value>)? object,
    O Function(GraphQLInputObjectType<Value>)? input,
    O Function(GraphQLUnionType<Value>)? union,
    O Function(GraphQLListType)? list,
    O Function(GraphQLNonNullType<Value, Serialized>)? nonNullable,
    required O Function(GraphQLType) orElse,
  }) {
    return when(
      scalar: scalar ?? orElse,
      object: object ?? orElse,
      input: input ?? orElse,
      list: list ?? orElse,
      nonNullable: nonNullable ?? orElse,
      enum_: enum_ ?? orElse,
      union: union ?? orElse,
    );
  }

  /// Similar to [when], but with optional arguments. Returns null
  /// when none of the provided functions match [this]
  O? whenOrNull<O>({
    O? Function(GraphQLEnumType<Value>)? enum_,
    O? Function(GraphQLScalarType<Value, Serialized>)? scalar,
    O? Function(GraphQLObjectType<Value>)? object,
    O? Function(GraphQLInputObjectType<Value>)? input,
    O? Function(GraphQLUnionType<Value>)? union,
    O? Function(GraphQLListType)? list,
    O? Function(GraphQLNonNullType<Value, Serialized>)? nonNullable,
  }) {
    O? orElse(GraphQLType _) {
      return null;
    }

    return when(
      scalar: scalar ?? orElse,
      object: object ?? orElse,
      input: input ?? orElse,
      list: list ?? orElse,
      nonNullable: nonNullable ?? orElse,
      enum_: enum_ ?? orElse,
      union: union ?? orElse,
    );
  }
}

/// Shorthand to create a [GraphQLListType].
GraphQLListType<Value?, Serialized> listOf<Value, Serialized>(
  GraphQLType<Value, Serialized> innerType,
) {
  if (innerType is GraphQLNonNullType<Value, Serialized>) {
    return _GraphQLNonNullListType(innerType);
  }
  return _GraphQLNullableListType(innerType);
}

/// A wrapper around a [GraphQLType].
///
/// Examples: [GraphQLListType] and [GraphQLNonNullType]
abstract class GraphQLWrapperType {
  GraphQLType<Object?, Object?> get ofType;
}

abstract class GraphQLListType<Value, Serialized>
    implements
        // ignore: avoid_implementing_value_types
        GraphQLType<List<Value>, List<Serialized?>>,
        GraphQLWrapperType {
  @override
  GraphQLType<Value, Serialized> get ofType;
}

/// A special [GraphQLType] that indicates that input vales should
/// be a list of another type [ofType].
class _GraphQLNonNullListType<Value, Serialized>
    extends GraphQLType<List<Value>, List<Serialized?>>
    with _NonNullableMixin<List<Value>, List<Serialized?>>
    implements GraphQLListType<Value, Serialized> {
  @override
  final GraphQLNonNullType<Value, Serialized> ofType;

  _GraphQLNonNullListType(this.ofType);

  @override
  String? get name => null;

  @override
  String get description =>
      'A list of items of type ${ofType.name ?? '(${ofType.description}).'}';

  @override
  // ignore: avoid_renaming_method_parameters
  ValidationResult<List<Serialized?>> validate(String key, Object? _input) {
    final input = _input != null && _input is! List ? [_input] : _input;
    if (input is! List)
      return ValidationResult.failure(
          ['Expected "$key" to be a list. Got invalid value $_input.']);

    final out = <Serialized?>[];
    final List<String> errors = [];

    for (int i = 0; i < input.length; i++) {
      final k = '$key[$i]';
      final v = input[i];
      final result = ofType.validate(k, v);
      if (!result.successful) {
        errors.addAll(result.errors);
      } else {
        out.add(result.value);
      }
    }

    if (errors.isNotEmpty) return ValidationResult.failure(errors);
    return ValidationResult.ok(out);
  }

  @override
  List<Value> deserialize(SerdeCtx serdeCtx, List<Object?> serialized) {
    return serialized
        .map<Value>((v) => ofType.deserialize(serdeCtx, v as Serialized))
        .toList();
  }

  @override
  List<Serialized?> serialize(List<Value?> value) {
    return value.map(ofType.serializeSafe).toList();
  }

  @override
  String toString() => '[$ofType]';

  @override
  Iterable<Object?> get props => [ofType];

  @override
  GraphQLType<List<Value>, List<Serialized?>> coerceToInputObject() =>
      _GraphQLNonNullListType<Value, Serialized>(
        ofType.coerceToInputObject() as GraphQLNonNullType<Value, Serialized>,
      );
}

/// A special [GraphQLType] that indicates that input vales should
/// be a list of another type [ofType].
class _GraphQLNullableListType<Value, Serialized>
    extends GraphQLType<List<Value?>, List<Serialized?>>
    with _NonNullableMixin<List<Value?>, List<Serialized?>>
    implements GraphQLListType<Value?, Serialized> {
  @override
  final GraphQLType<Value, Serialized> ofType;

  _GraphQLNullableListType(this.ofType);

  @override
  String? get name => null;

  @override
  String get description =>
      'A list of items of type ${ofType.name ?? '(${ofType.description}).'}';

  // @override
  // List<Value?>? cast(List<Value?>? value) {
  //   if (value != null && ofType.isNonNullable) {
  //     return value.cast<Value>() as List<Value>;
  //   }
  //   return value;
  // }

  @override
  // ignore: avoid_renaming_method_parameters
  ValidationResult<List<Serialized?>> validate(String key, Object? _input) {
    final input = _input != null && _input is! List ? [_input] : _input;
    if (input is! List)
      return ValidationResult.failure(
          ['Expected "$key" to be a list. Got invalid value $_input.']);

    final out = ofType.isNullable ? <Serialized?>[] : <Serialized>[];
    final List<String> errors = [];

    for (int i = 0; i < input.length; i++) {
      final k = '$key[$i]';
      final v = input[i];
      final result = ofType.validate(k, v);
      if (!result.successful) {
        if (v == null && ofType.isNullable) {
          out.add(null);
        } else {
          errors.addAll(result.errors);
        }
      } else {
        out.add(result.value);
      }
    }

    if (errors.isNotEmpty) return ValidationResult.failure(errors);
    return ValidationResult.ok(out);
  }

  @override
  List<Value?> deserialize(SerdeCtx serdeCtx, List<Object?> serialized) {
    if (ofType.isNonNullable) {
      return serialized
          .map<Value>((v) => ofType.deserialize(serdeCtx, v! as Serialized))
          .toList();
    }
    return serialized
        .map<Value?>(
          (v) =>
              v == null ? null : ofType.deserialize(serdeCtx, v as Serialized),
        )
        .toList();
  }

  @override
  List<Serialized?> serialize(List<Value?> value) {
    return value.map(ofType.serializeSafe).toList();
  }

  @override
  String toString() => '[$ofType]';

  @override
  Iterable<Object?> get props => [ofType];

  @override
  GraphQLType<List<Value?>, List<Serialized?>> coerceToInputObject() =>
      _GraphQLNullableListType<Value, Serialized>(ofType.coerceToInputObject());
}

mixin _NonNullableMixin<Value, Serialized> on GraphQLType<Value, Serialized> {
  GraphQLNonNullType<Value, Serialized>? _nonNullableCache;

  @override
  GraphQLNonNullType<Value, Serialized> nonNull() =>
      _nonNullableCache ??= GraphQLNonNullType<Value, Serialized>._(this);
}

/// A special [GraphQLType] that indicates that input values should both be
/// non-null, and be valid when asserted against another type, named [ofType].
class GraphQLNonNullType<Value, Serialized>
    extends GraphQLType<Value, Serialized> implements GraphQLWrapperType {
  @override
  final GraphQLType<Value, Serialized> ofType;

  const GraphQLNonNullType._(this.ofType);

  @override
  String? get name => null;

  @override
  String get description =>
      'A non-nullable binding to ${ofType.name ?? '(${ofType.description}).'}';

  @override
  GraphQLNonNullType<Value, Serialized> nonNull() => this;

  @override
  GraphQLListType<Value, Serialized> list() {
    return _GraphQLNonNullListType(this);
  }

  @override
  ValidationResult<Serialized> validate(String key, Object? input) {
    if (input == null)
      return ValidationResult.failure(
        ['Expected "$key" to be a non-null value of type $this.'],
      );
    return ofType.validate(key, input);
  }

  @override
  Value deserialize(SerdeCtx serdeCtx, Serialized serialized) {
    return ofType.deserialize(serdeCtx, serialized);
  }

  @override
  Serialized serialize(Value value) {
    return ofType.serialize(value);
  }

  @override
  String toString() {
    return '$ofType!';
  }

  @override
  Iterable<Object?> get props => [ofType];

  @override
  GraphQLType<Value, Serialized> coerceToInputObject() {
    return ofType.coerceToInputObject().nonNull();
  }

  /// Utility for creating an [GraphQLObjectField] with [type] == this
  ///
  /// Same as [GraphQLFieldTypeExt.field], but with [resolve] and [subscribe]
  /// Returning non-nullable [Value].
  GraphQLObjectField<Value, Serialized, P> field<P>(
    String name, {
    String? deprecationReason,
    String? description,
    FutureOr<Value> Function(P parent, ReqCtx<P> ctx)? resolve,
    FutureOr<Stream<Value>> Function(Object parent, ReqCtx<Object> ctx)?
        subscribe,
    Iterable<GraphQLFieldInput<Object?, Object?>> inputs = const [],
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
}
