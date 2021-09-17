part of graphql_schema.src.schema;

/// An exception that occurs during execution of a GraphQL query.
class GraphQLException implements Exception {
  /// A list of all specific errors, with text representation,
  /// that caused this exception.
  final List<GraphQLExceptionError> errors;

  const GraphQLException(this.errors);

  factory GraphQLException.fromMessage(
    String message, {
    List<Object>? path,
  }) {
    return GraphQLException([
      GraphQLExceptionError(message, path: path),
    ]);
  }

  factory GraphQLException.fromSourceSpan(
    String message,
    FileSpan span, {
    List<Object>? path,
  }) {
    return GraphQLException([
      GraphQLExceptionError(
        message,
        locations: [
          GraphQLErrorLocation.fromSourceLocation(span.start),
        ],
        path: path,
      ),
    ]);
  }

  factory GraphQLException.fromException(Exception e, List<Object> path) {
    if (e is GraphQLException) {
      return GraphQLException([
        ...e.errors.map(
          (e) => GraphQLExceptionError(
            e.message,
            locations: e.locations,
            path: e.path ?? path,
          ),
        ),
      ]);
    } else if (e is GraphQLExceptionError) {
      return GraphQLException([
        GraphQLExceptionError(
          e.message,
          locations: e.locations,
          path: e.path ?? path,
        ),
      ]);
    }
    final message = e.toString();
    return GraphQLException.fromMessage(
      message.startsWith('Exception: ') ? message.substring(11) : message,
      path: path,
    );
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
class GraphQLExceptionError implements Exception {
  /// The reason execution was halted, whether it is a syntax error,
  /// or a runtime error, or some other exception.
  final String message;

  /// An optional list of locations within the source text where
  /// this error occurred.
  ///
  /// Smart tools can use this information to show end users exactly
  /// which part of the errant query
  /// triggered an error.
  final List<GraphQLErrorLocation> locations;

  /// List of field names with aliased names or 0‐indexed integers for list
  final List<Object>? path;

  final StackTrace stackTrace;

  GraphQLExceptionError(
    this.message, {
    this.locations = const [],
    this.path,
  })
  // TODO: improve
  : stackTrace = StackTrace.current;

  Map<String, dynamic> toJson() {
    final out = <String, dynamic>{
      'message': message,
      if (path != null) 'path': path
    };
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
class GraphQLErrorLocation {
  // TODO:
  final int? line;
  final int? column;

  const GraphQLErrorLocation(
    this.line,
    this.column,
  );

  factory GraphQLErrorLocation.fromSourceLocation(SourceLocation? location) {
    return GraphQLErrorLocation(
      location?.line,
      location?.column,
    );
  }

  Map<String, Object?> toJson() {
    return {'line': line, 'column': column};
  }
}
