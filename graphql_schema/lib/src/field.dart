part of graphql_schema.src.schema;

/// Typedef for a function that resolves the value of a [GraphQLObjectField],
/// whether asynchronously or not.
typedef GraphQLFieldResolver<Value, P extends Object> = FutureOr<Value?>
    Function(P parent, ReqCtx<P> ctx);

/// Typedef for a function that resolves the [Stream] of [Value]s
/// of a [GraphQLObjectField], whether asynchronously or not.
typedef GraphQLSubscriptionFieldResolver<Value> = FutureOr<Stream<Value?>>
    Function(Object parent, ReqCtx<Object> ctx);

/// Wrapper class for [GraphQLFieldResolver]
/// necessary for type casting.
class FieldResolver<Value, P extends Object> {
  final GraphQLFieldResolver<Value, P> resolve;

  const FieldResolver(this.resolve);

  FutureOr<Value?> call(P parent, ReqCtx ctx) => resolve(parent, ctx.cast());
}

/// Wrapper class for [GraphQLSubscriptionFieldResolver]
/// necessary for type casting.
class FieldSubscriptionResolver<Value> {
  final GraphQLSubscriptionFieldResolver<Value> subscribe;

  const FieldSubscriptionResolver(this.subscribe);

  FutureOr<Stream<Value?>> call(Object parent, ReqCtx ctx) =>
      subscribe(parent, ctx.cast());
}

/// A field on a [GraphQLObjectType].
///
/// It can have input values and additional documentation, and explicitly
/// declares it shape within the schema.
@immutable
class GraphQLObjectField<Value extends Object, Serialized extends Object,
    P extends Object> implements ObjectField {
  /// The list of input values this field accepts, if any.
  final List<GraphQLFieldInput> inputs = <GraphQLFieldInput>[];

  /// The name of this field in serialized input.
  @override
  final String name;

  /// A function used to evaluate the [Value] of this field, with
  /// respect to the parent (root) value [P] and context [ReqCtx].
  final FieldResolver<Value, P>? resolve;

  /// A function used to evaluate the [Stream] of [Value]s of this field, with
  /// respect to the parent (root) value [P] and context [ReqCtx].
  final FieldSubscriptionResolver<Value>? subscribe;

  /// The [GraphQLType] associated with values that this
  /// field's [resolve] callback returns.
  @override
  final GraphQLType<Value, Serialized> type;

  /// An optional description of this field; useful for tools like GraphiQL.
  final String? description;

  /// The reason that this field, if it is deprecated, was deprecated.
  final String? deprecationReason;

  GraphQLObjectField(
    this.name,
    this.type, {
    Iterable<GraphQLFieldInput> inputs = const <GraphQLFieldInput>[],
    this.resolve,
    this.subscribe,
    this.deprecationReason,
    this.description,
  }) {
    this.inputs.addAll(inputs);
  }

  /// Returns `true` if this field has a [deprecationReason].
  bool get isDeprecated => deprecationReason != null;

  Serialized? serialize(Value value) {
    return type.serialize(value);
  }

  FutureOr<Value>? deserialize(
    SerdeCtx serdeCtx,
    Serialized serialized, [
    Map<String, dynamic> argumentValues = const <String, dynamic>{},
  ]) {
    return type.deserialize(serdeCtx, serialized);
  }

  @override
  bool operator ==(Object other) =>
      other is GraphQLObjectField &&
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.deprecationReason == deprecationReason &&
      other.type == type &&
      const ListEquality<GraphQLFieldInput>().equals(other.inputs, inputs);

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality()
          .hash([name, deprecationReason, type, inputs]);
}
