part of leto_schema.src.schema;

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
  /// You can use [GraphQLType.toString] or [GraphQLType.printableName]
  /// if you need a non-null name.
  String? get name;

  /// The name of this type with defaults for [GraphQLWrapperType].
  /// Can be used as a name of another GraphQL type,
  /// useful for composing names for generic types, for example.
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

  /// Returns a [GraphQLListType] with the inner type set to [this]
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

  /// Returns a nullable type that represents this type.
  /// If the type is [isNullable] returns itself without changes.
  GraphQLType<Value, Serialized> nullable() {
    final _this = this;
    if (_this is GraphQLNonNullType<Value, Serialized>) {
      return _this.ofType;
    }
    return this;
  }

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

  @override
  String toString() => name!;

  /// Utility for working with the [Value] Generic type
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
/// /// TODO: GraphQLWrappingType
abstract class GraphQLWrapperType {
  /// The wrapped type
  GraphQLType<Object?, Object?> get ofType;
}

/// A special [GraphQLType] that indicates that input vales should
/// be a list of another type [ofType].
abstract class GraphQLListType<Value, Serialized>
    implements GraphQLType<List<Value>, List<Serialized?>>, GraphQLWrapperType {
  @override
  GraphQLType<Value, Serialized> get ofType;
}

/// A special [GraphQLType] that indicates that input vales should
/// be a list of another non-nullable type [ofType].
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
    if (input is! List) {
      return ValidationResult.failure(
          ['Expected "$key" to be a list. Got invalid value $_input.']);
    }
    final out = <Serialized?>[];
    final List<String> errors = [];

    for (int i = 0; i < input.length; i++) {
      final k = '$key[$i]';
      final Object? v = input[i];
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
  GraphQLType<List<Value>, List<Serialized?>> coerceToInputObject() =>
      _GraphQLNonNullListType<Value, Serialized>(ofType.coerceToInputObject());
}

/// A special [GraphQLType] that indicates that input vales should
/// be a list of another nullable type [ofType].
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

  @override
  // ignore: avoid_renaming_method_parameters
  ValidationResult<List<Serialized?>> validate(String key, Object? _input) {
    final input = _input != null && _input is! List ? [_input] : _input;
    if (input is! List) {
      return ValidationResult.failure(
          ['Expected "$key" to be a list. Got invalid value $_input.']);
    }
    final out = ofType.isNullable ? <Serialized?>[] : <Serialized>[];
    final List<String> errors = [];

    for (int i = 0; i < input.length; i++) {
      final k = '$key[$i]';
      final Object? v = input[i];
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
  GraphQLType<List<Value?>, List<Serialized?>> coerceToInputObject() =>
      _GraphQLNullableListType<Value, Serialized>(ofType.coerceToInputObject());
}

/// A [GraphQLType] with nested properties
abstract class GraphQLCompositeType<P>
    extends GraphQLType<P, Map<String, dynamic>>
    implements GraphQLNamedType<P, Map<String, dynamic>> {
  /// The possible implementations for this type
  List<GraphQLObjectType> get possibleTypes;

  @override
  TypeDefinitionNode? get astNode => extra.astNode;

  @override
  GraphQLAttachments get attachments => extra.attachments;
}

/// A [GraphQLType] with non-null name.
///
/// This type will not be a [GraphQLWrapperType] like
/// [GraphQLListType] or [GraphQLNonNullType].
abstract class GraphQLNamedType<Value, Serialized>
    extends GraphQLType<Value, Serialized> implements GraphQLElement {
  @override
  String get name;

  GraphQLTypeDefinitionExtra get extra;

  @override
  TypeDefinitionNode? get astNode => extra.astNode;

  @override
  GraphQLAttachments get attachments => extra.attachments;
}

/// An element in a [GraphQLSchema]
///
/// [GraphQLNamedType], [GraphQLDirective], [GraphQLEnumValue]
/// and [ObjectField]s such as [GraphQLObjectField] and [GraphQLFieldInput]
abstract class GraphQLElement {
  /// The name of the element
  String get name;

  /// If this was parsed from an ast, the node in that ast
  Node? get astNode;

  /// Other values that may modify the execution, validation or
  /// introspection for this element
  GraphQLAttachments get attachments;
}

typedef GraphQLAttachments = List<Object>;

class GraphQLTypeDefinitionExtra<N extends TypeDefinitionNode,
    E extends TypeExtensionNode> {
  final GraphQLAttachments attachments;
  final List<E> extensionAstNodes;
  final N? astNode;

  const GraphQLTypeDefinitionExtra.ast(
    N astNode,
    this.extensionAstNodes, {
    this.attachments = const [],
  })
  // ignore: prefer_initializing_formals
  : astNode = astNode;

  const GraphQLTypeDefinitionExtra.attach(
    this.attachments,
  )   : astNode = null,
        extensionAstNodes = const [];

  Iterable<DirectiveNode> directives() {
    if (astNode != null) {
      return astNode!.directives
          .followedBy(extensionAstNodes.expand((ext) => ext.directives))
          .followedBy(attachments.whereType());
    } else {
      return attachments.whereType();
    }
  }
}

/// Extensions for [GraphQLNamedType]
extension GraphQLNamedTypeExtension<Value, Serialized>
    on GraphQLNamedType<Value, Serialized> {
  /// Executes the passed callback for the given named type of [this]
  O whenNamed<O>({
    required O Function(GraphQLEnumType<Value>) enum_,
    required O Function(GraphQLScalarType<Value, Serialized>) scalar,
    required O Function(GraphQLObjectType<Value>) object,
    required O Function(GraphQLInputObjectType<Value>) input,
    required O Function(GraphQLUnionType<Value>) union,
  }) {
    return when(
      enum_: enum_,
      scalar: scalar,
      object: object,
      input: input,
      union: union,
      list: (_) => throw Error(),
      nonNullable: (_) => throw Error(),
    );
  }
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

  const GraphQLNonNullType._(this.ofType)
      : assert(ofType is! GraphQLNonNullType);

  @override
  String? get name => null;

  @override
  String get description =>
      'A non-nullable binding to ${ofType.name ?? '(${ofType.description}).'}';

  @override
  GraphQLNonNullType<Value, Serialized> nonNull() => this;

  @override
  ValidationResult<Serialized> validate(String key, Object? input) {
    if (input == null) {
      return ValidationResult.failure(
        ['Expected "$key" to be a non-null value of type $this.'],
      );
    }
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
  GraphQLNonNullType<Value, Serialized> coerceToInputObject() {
    return ofType.coerceToInputObject().nonNull();
  }

  @override
  GraphQLListType<Value, Serialized> list() {
    return _GraphQLNonNullListType(this);
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
    FieldDefinitionNode? astNode,
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
    );
  }

  /// Shorthand for generating a [GraphQLFieldInput].
  GraphQLFieldInput<Value, Serialized> inputField(
    String name, {
    String? description,
    Value? defaultValue,
    String? deprecationReason,
    InputValueDefinitionNode? astNode,
  }) {
    return GraphQLFieldInput(
      name,
      this,
      description: description,
      deprecationReason: deprecationReason,
      defaultValue: defaultValue,
      defaultsToNull: false,
      astNode: astNode,
    );
  }
}
