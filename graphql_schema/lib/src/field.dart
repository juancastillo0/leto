part of graphql_schema.src.schema;

final _responseHeadersCtxKey = GlobalRef('response.headers');

class ReqCtx<P> {
  final Map<Object, Object?> globals;
  final Map<String, Object?> args;
  final P object;
  final ReqCtx<Object?>? parentCtx;

  const ReqCtx({
    required this.globals,
    required this.args,
    required this.object,
    required this.parentCtx,
  });

  ReqCtx<T> cast<T>() {
    if (this is ReqCtx<T>) {
      return this as ReqCtx<T>;
    }
    return ReqCtx(
      globals: globals,
      args: args,
      object: object as T,
      parentCtx: parentCtx,
    );
  }

  // TODO: headersAll Map<String, List<String>>
  // TODO: should we leave it to the implementors?
  Map<String, String> get responseHeaders {
    return globals.putIfAbsent(
      _responseHeadersCtxKey,
      () => <String, String>{},
    )! as Map<String, String>;
  }

  static Map<String, String>? headersFromGlobals(
    Map<Object, Object?> globals,
  ) =>
      globals[_responseHeadersCtxKey] as Map<String, String>?;
}

/// Typedef for a function that resolves the value of a [GraphQLObjectField],
/// whether asynchronously or not.
typedef GraphQLFieldResolver<Value, P> = FutureOr<Value?> Function(
    P parent, ReqCtx<P> ctx);
typedef GraphQLSubscriptionFieldResolver<Value, P> = FutureOr<Stream<Value?>>
    Function(P parent, ReqCtx<P> ctx);

/// Wrapper class for [GraphQLFieldResolver]
/// necessary for type casting.
class FieldResolver<Value, P> {
  final GraphQLFieldResolver<Value, P> resolve;

  const FieldResolver(this.resolve);

  FutureOr<Value?> call(P parent, ReqCtx ctx) => resolve(parent, ctx.cast());
}

/// Wrapper class for [GraphQLSubscriptionFieldResolver]
/// necessary for type casting.
class FieldSubscriptionResolver<Value, P> {
  final GraphQLSubscriptionFieldResolver<Value, P> subscribe;

  const FieldSubscriptionResolver(this.subscribe);

  FutureOr<Stream<Value?>> call(P parent, ReqCtx ctx) =>
      subscribe(parent, ctx.cast());
}

/// A field on a [GraphQLObjectType].
///
/// It can have input values and additional documentation, and explicitly
/// declares it shape within the schema.
@immutable
class GraphQLObjectField<Value extends Object, Serialized extends Object, P>
    implements ObjectField {
  /// The list of input values this field accepts, if any.
  final List<GraphQLFieldInput> inputs = <GraphQLFieldInput>[];

  /// The name of this field in serialized input.
  final String name;

  /// A function used to evaluate the [Value] of this field, with
  /// respect to the parent (root) value [P] and context [ReqCtx].
  final FieldResolver<Value, P>? resolve;

  /// A function used to evaluate the [Stream] of [Value]s of this field, with
  /// respect to the parent (root) value [P] and context [ReqCtx].
  final FieldSubscriptionResolver<Value, P>? subscribe;

  /// The [GraphQLType] associated with values that this
  /// field's [resolve] callback returns.
  final GraphQLType<Value, Serialized> type;

  /// An optional description of this field; useful for tools like GraphiQL.
  final String? description;

  /// The reason that this field, if it is deprecated, was deprecated.
  final String? deprecationReason;

  GraphQLObjectField(
    this.name,
    this.type, {
    Iterable<GraphQLFieldInput> arguments = const <GraphQLFieldInput>[],
    this.resolve,
    this.subscribe,
    this.deprecationReason,
    this.description,
  }) {
// :  assert(type != null, 'GraphQL fields must specify a `type`.')
//    assert(
//        resolve != null, 'GraphQL fields must specify a `resolve` callback.');
    this.inputs.addAll(arguments);
  }

  /// Returns `true` if this field has a [deprecationReason].
  bool get isDeprecated => deprecationReason?.isNotEmpty == true;

  Serialized? serialize(Value value) {
    return type.serialize(value);
  }

  FutureOr<Value>? deserialize(
    SerdeCtx serdeCtx,
    Serialized serialized, [
    Map<String, dynamic> argumentValues = const <String, dynamic>{},
  ]) {
    // TODO:
    // if (resolve != null) return resolve!(serialized, argumentValues);
    return type.deserialize(serdeCtx, serialized);
  }

  @override
  bool operator ==(Object other) =>
      other is GraphQLObjectField &&
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.deprecationReason == deprecationReason &&
      other.type == type &&
      other.resolve == resolve &&
      const ListEquality<GraphQLFieldInput>().equals(other.inputs, inputs);

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality()
          .hash([name, deprecationReason, type, resolve, inputs]);
}
