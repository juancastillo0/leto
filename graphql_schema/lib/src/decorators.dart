part of graphql_schema.src.schema;

/// Base object decorator.
///
/// Use [GraphQLInput] or [GraphQLClass]
class GraphQLObjectDec {
  const GraphQLObjectDec();
}

/// Signifies that a class should statically generate a [GraphQLInputObjectType]
@Target({TargetKind.classType})
class GraphQLInput extends GraphQLObjectDec {
  const GraphQLInput();
}

/// Signifies that a class should statically generate a [GraphQLType].
///
/// Generates a [GraphQLObjectType] for classes with
/// [isInterface] == true for abstract classes,
/// a [GraphQLEnumType] for enums
/// and a [GraphQLUnionType] for freezed unions.
///
/// if [omitFields] is true, omits all fields by default, you would need to
/// decorate explicitly with [GraphQLField]. No need to pass `omit: false`
/// in [GraphQLField]'s constructor.
/// [interfaces] are the getters of [GraphQLObjectType]
/// implemented by this object.
@Target({TargetKind.classType, TargetKind.enumType})
class GraphQLClass extends GraphQLObjectDec {
  const GraphQLClass({
    this.interfaces = const [],
    this.omitFields,
    this.nullableFields,
  });
  final List<String> interfaces;
  final bool? omitFields;
  final bool? nullableFields;
}

/// An annotation for configuring a [GraphQLFieldInput] within a resolver
///
/// if [inline] is true, the properties of a [GraphQLInputObjectType] will be
/// inlined into a resolver inputs.
class GraphQLArg {
  const GraphQLArg({this.inline = false});
  final bool inline;
}

/// An annotation for configuring a GraphQL field
///
/// if [omit] is true, this field will be omited.
/// if [nullable] is true, the type will be nullable even when the
/// Dart type is non-nullable.
/// [name] is the name of the [GraphQLObjectField].
/// [type] is a String containing a getter for the [GraphQLType].
class GraphQLField {
  const GraphQLField({
    this.name,
    this.omit,
    this.nullable,
    this.type,
  });
  final String? name;
  final bool? omit;
  final bool? nullable;
  final String? type;
}

/// Signifies that a function should statically generate a [GraphQLObjectField].
///
/// Use [Mutation], [Query] and [Subscription]
@Target({TargetKind.function, TargetKind.method})
class GqlResolver {
  const GqlResolver._();
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the mutation type of a [GraphQLSchema].
///
/// ```dart
/// @Mutation()
/// String? someAction(ReqCtx ctx, {required DateTime createdAt}) {
///    final value = ctx.globals[argSize];
///    return value is String ? value : null;
/// }
/// ```
class Mutation extends GqlResolver {
  const Mutation() : super._();
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the query type of a [GraphQLSchema].
///
/// ```dart
/// @Query()
/// Future<String> getName(ReqCtx ctx, {List<int>? ids}) {
///    final value = ctx.globals[argSize];
///    return value is String ? value : null;
/// }
/// ```
class Query extends GqlResolver {
  const Query() : super._();
}

/// Signifies that a function should statically generate
/// a [GraphQLObjectField] within the subscription type of a [GraphQLSchema].
///
/// ```dart
/// /// @Subscription()
/// Stream<String> onActionsPerformed(ReqCtx ctx, int? argSize) {
///    final value = ctx.globals[argSize];
///    return value is String ? value : null;
/// }
/// ```
class Subscription extends GqlResolver {
  const Subscription() : super._();
}

typedef GraphDocumentationTypeProvider = GraphQLType Function();

/// A metadata annotation used to provide documentation to
/// `package:graphql_server`.
class GraphQLDocumentation {
  /// The description of the annotated class, field, or enum value, to be
  /// displayed in tools like GraphiQL.
  final String? description;

  /// The reason the annotated field or enum value was deprecated, if any.
  final String? deprecationReason;

  /// A constant callback that returns an explicit type for the annotated field,
  /// rather than having it be assumed
  /// via `dart:mirrors`.
  final GraphDocumentationTypeProvider? type;

  /// The name of an explicit type for the annotated field, rather than
  /// having it be assumed.
  final Symbol? typeName;

  const GraphQLDocumentation({
    this.description,
    this.deprecationReason,
    this.type,
    this.typeName,
  });
}
