library graphql_schema.src.schema;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';
import 'package:source_span/source_span.dart';

part 'argument.dart';

part 'enum.dart';

part 'field.dart';

part 'gen.dart';

part 'object_type.dart';

part 'scalar.dart';

part 'type.dart';

part 'union.dart';

part 'validation_result.dart';

part 'serde_ctx.dart';

part 'ref_type.dart';

/// The schema against which queries, mutations, and subscriptions are executed.
class GraphQLSchema {
  /// The shape which all queries against the backend must take.
  final GraphQLObjectType<void>? queryType;

  /// The shape required for any query that changes the state of the backend.
  final GraphQLObjectType<void>? mutationType;

  /// A [GraphQLObjectType] describing the form of data sent to
  /// real-time subscribers.
  ///
  /// Note that as of August 4th, 2018 (when this text was written),
  /// subscriptions are not formalized in the GraphQL specification.
  /// Therefore, any GraphQL implementation can potentially implement
  /// subscriptions in its own way.
  final GraphQLObjectType<void>? subscriptionType;

  final SerdeCtx serdeCtx;

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    this.subscriptionType,
    SerdeCtx? serdeCtx,
  }) : serdeCtx = serdeCtx ?? SerdeCtx();
}

/// A shorthand for creating a [GraphQLSchema].
GraphQLSchema graphQLSchema({
  required GraphQLObjectType<void> queryType,
  GraphQLObjectType<void>? mutationType,
  GraphQLObjectType<void>? subscriptionType,
  SerdeCtx? serdeCtx,
}) =>
    GraphQLSchema(
      queryType: queryType,
      mutationType: mutationType,
      subscriptionType: subscriptionType,
      serdeCtx: serdeCtx,
    );

/// A default resolver that always returns `null`.
Object? resolveToNull(Object? _, Object? __) => null;

/// An exception that occurs during execution of a GraphQL query.
class GraphQLException implements Exception {
  /// A list of all specific errors, with text representation,
  /// that caused this exception.
  final List<GraphQLExceptionError> errors;

  const GraphQLException(this.errors);

  factory GraphQLException.fromMessage(String message) {
    return GraphQLException([
      GraphQLExceptionError(message),
    ]);
  }

  factory GraphQLException.fromSourceSpan(String message, FileSpan span) {
    return GraphQLException([
      GraphQLExceptionError(
        message,
        locations: [
          GraphExceptionErrorLocation.fromSourceLocation(span.start),
        ],
      ),
    ]);
  }

  Map<String, List<Map<String, dynamic>>> toJson() {
    return {
      'errors': errors.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'GraphQLException(${toJson()})';
  }
}

/// One of an arbitrary number of errors that may occur during the
/// execution of a GraphQL query.
///
/// This will almost always be passed to a [GraphQLException],
///  as it is useless alone.
class GraphQLExceptionError {
  /// The reason execution was halted, whether it is a syntax error,
  /// or a runtime error, or some other exception.
  final String message;

  /// An optional list of locations within the source text where
  /// this error occurred.
  ///
  /// Smart tools can use this information to show end users exactly
  /// which part of the errant query
  /// triggered an error.
  final List<GraphExceptionErrorLocation> locations;

  final StackTrace stackTrace;

  GraphQLExceptionError(this.message, {this.locations = const []})
      // TODO: improve
      : stackTrace = StackTrace.current;

  Map<String, dynamic> toJson() {
    final out = <String, dynamic>{'message': message};
    final locationsFiltered = locations.where((l) => l.line != null);
    if (locationsFiltered.isNotEmpty) {
      out['locations'] = locationsFiltered.map((l) => l.toJson()).toList();
    }
    return out;
  }

  @override
  String toString() {
    return 'GraphQLExceptionError(${toJson()})';
  }
}

/// Information about a location in source text that caused an error during
/// the execution of a GraphQL query.
///
/// This is analogous to a [SourceLocation] from `package:source_span`.
class GraphExceptionErrorLocation {
  // TODO:
  final int? line;
  final int? column;

  const GraphExceptionErrorLocation(
    this.line,
    this.column,
  );

  factory GraphExceptionErrorLocation.fromSourceLocation(
      SourceLocation? location) {
    return GraphExceptionErrorLocation(
      location?.line,
      location?.column,
    );
  }

  Map<String, Object?> toJson() {
    return {'line': line, 'column': column};
  }
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

  /// A constant callback that returns an explicit type for the annotated field
  /// , rather than having it be assumed
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

/// The canonical instance.
const GraphQLClass graphQLClass = GraphQLClass();

/// Signifies that a class should statically generate a [GraphQLType].
@Target({TargetKind.classType, TargetKind.enumType})
class GraphQLClass {
  const GraphQLClass();
}

/// The canonical instance.
const GqlResolver graphQLResolver = GqlResolver._();

/// Signifies that a function should statically generate a [GraphQLObjectField].
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

extension GraphQLScalarTypeExt<V, S> on GraphQLScalarType<V, S> {
  GraphQLObjectField<V, S, P> field<P>(
    String name, {
    bool nullable = true,
    String? deprecationReason,
    String? description,
    GraphQLFieldResolver<V, P>? resolve,
  }) {
    return GraphQLObjectField(
      name,
      nullable ? this : nonNullable(),
      resolve: resolve == null ? null : FieldResolver(resolve),
      description: description,
      deprecationReason: deprecationReason,
    );
  }
}
