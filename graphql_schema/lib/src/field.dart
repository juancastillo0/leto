part of graphql_schema.src.schema;

const responseHeadersCtxKey = '__response.headers';

class ReqCtx<P> {
  final Map<String, Object?> globals;
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
  Map<String, String> get headers {
    Map<String, String>? headers =
        globals[responseHeadersCtxKey] as Map<String, String>?;
    if (headers == null) {
      headers = {};
      globals[responseHeadersCtxKey] = headers;
    }
    return headers;
  }

  static Map<String, String>? headersFromGlobals(
    Map<String, Object?> globals,
  ) =>
      globals[responseHeadersCtxKey] as Map<String, String>?;
}

/// Typedef for a function that resolves the value of a [GraphQLObjectField],
///  whether asynchronously or not.
typedef GraphQLFieldResolver<Value, P> = FutureOr<Value> Function(
    P parent, ReqCtx<P> ctx);

class FieldResolver<Value, P> {
  final GraphQLFieldResolver<Value, P> resolve;

  const FieldResolver(this.resolve);

  FutureOr<Value> call(P parent, ReqCtx ctx) => resolve(parent, ctx.cast());
}

/// A field on a [GraphQLObjectType].
///
/// It can have input values and additional documentation, and explicitly
/// declares it shape within the schema.
@immutable
class GraphQLObjectField<Value, Serialized, P> implements ObjectField {
  /// The list of input values this field accepts, if any.
  final List<GraphQLFieldInput> inputs = <GraphQLFieldInput>[];

  /// The name of this field in serialized input.
  final String name;

  /// A function used to evaluate the value of this field, with
  /// respect to an arbitrary Dart value.
  final FieldResolver<Value, P>? resolve;

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
    required this.resolve,
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

  FutureOr<Serialized> serialize(Value value) {
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
