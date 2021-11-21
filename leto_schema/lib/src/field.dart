part of leto_schema.src.schema;

/// A field on a [GraphQLObjectType].
///
/// It can have input values and additional documentation, and explicitly
/// declares it shape within the schema.
@immutable
class GraphQLObjectField<Value, Serialized, P> implements ObjectField {
  /// The list of input values this field accepts, if any.
  final List<GraphQLFieldInput> inputs = <GraphQLFieldInput>[];

  /// The name of this field in serialized input.
  @override
  final String name;

  /// A function used to evaluate the [Value] of this field, with
  /// respect to the parent (root) value [P] and context [Ctx].
  final FieldResolver<Value, P>? resolve;

  /// A function used to evaluate the [Stream] of [Value]s of this field, with
  /// respect to the parent (root) value [P] and context [Ctx].
  final FieldSubscriptionResolver<Value>? subscribe;

  /// The [GraphQLType] associated with values that this
  /// field's [resolve] callback returns.
  @override
  final GraphQLType<Value, Serialized> type;

  /// An optional description of this field; useful for tools like GraphiQL.
  @override
  final String? description;

  /// The reason that this field, if it is deprecated, was deprecated.
  final String? deprecationReason;

  @override
  final GraphQLAttachments attachments;

  @override
  final FieldDefinitionNode? astNode;

  /// Default GraphQL field constructor
  GraphQLObjectField(
    this.name,
    this.type, {
    Iterable<GraphQLFieldInput> inputs = const <GraphQLFieldInput>[],
    this.resolve,
    this.subscribe,
    this.deprecationReason,
    this.description,
    this.attachments = const [],
    this.astNode,
  }) : assert(
          !checkAsserts || isOutputType(type),
          'Only output types can be types in object fields, got: $type.',
        ) {
    this.inputs.addAll(inputs);
  }

  /// Returns `true` if this field has a [deprecationReason].
  bool get isDeprecated => deprecationReason != null;
}

/// Typedef for a function that resolves the value of a [GraphQLObjectField],
/// whether asynchronously or not.
typedef GraphQLFieldResolver<Value, P> = FutureOr<Value?> Function(
    P parent, Ctx<P> ctx);

/// Typedef for a function that resolves the [Stream] of [Value]s
/// of a [GraphQLObjectField], whether asynchronously or not.
typedef GraphQLSubscriptionFieldResolver<Value> = FutureOr<Stream<Value?>>
    Function(Object parent, Ctx<Object> ctx);

/// Wrapper class for [GraphQLFieldResolver]
/// necessary for type casting.
class FieldResolver<Value, P> {
  final GraphQLFieldResolver<Value, P> resolve;

  const FieldResolver(this.resolve);

  FutureOr<Value?> call(P parent, Ctx ctx) => resolve(parent, ctx.cast());
}

/// Wrapper class for [GraphQLSubscriptionFieldResolver]
/// necessary for type casting.
class FieldSubscriptionResolver<Value> {
  final GraphQLSubscriptionFieldResolver<Value> subscribe;

  const FieldSubscriptionResolver(this.subscribe);

  FutureOr<Stream<Value?>> call(Object parent, Ctx ctx) =>
      subscribe(parent, ctx.cast());
}
