part of graphql_schema.src.schema;

/// The canonical instance.
const GraphQLClass graphQLClass = GraphQLClass();

class GraphQLObjectDec {
  const GraphQLObjectDec();
}

/// Signifies that a class should statically generate a [GraphQLInputObjectType]
@Target({TargetKind.classType})
class GraphQLInput extends GraphQLObjectDec {
  const GraphQLInput();
}

/// Signifies that a class should statically generate a [GraphQLType].
/// [GraphQLObjectType] for classes
/// [GraphQLObjectType] with [isInterface] == true for abstract classes
/// TODO: should we always require [GraphQLInput]? pass the input name as argument?
/// [GraphQLInputObjectType] for classes
/// [GraphQLEnumType] for enums
@Target({TargetKind.classType, TargetKind.enumType})
class GraphQLClass extends GraphQLObjectDec {
  const GraphQLClass({
    this.interfaces = const [],
    this.omit,
    this.nullable,
  });
  final List<String> interfaces;
  final bool? omit;
  final bool? nullable;
}

class GraphQLArg {
  const GraphQLArg({this.inline = false});
  final bool inline;
}

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
/// ```dart
/// @Mutation()
/// String? someAction(ReqCtx ctx, {int? argSize}) {
///    final value = ctx.globals[argSize];
///    return value is String ? value : null;
/// }
/// /// @Subscription()
/// Stream<String> performedActions(ReqCtx ctx, {int? argSize}) {
///    final value = ctx.globals[argSize];
///    return value is String ? value : null;
/// }
/// ```
@Target({TargetKind.function, TargetKind.method})
class GqlResolver {
  const GqlResolver._();
}

class Mutation extends GqlResolver {
  const Mutation() : super._();
}

class Query extends GqlResolver {
  const Query() : super._();
}

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
