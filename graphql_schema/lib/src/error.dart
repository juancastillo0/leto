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
    SourceLocation? location,
  }) {
    return GraphQLException([
      GraphQLExceptionError(
        message,
        path: path,
        locations: GraphQLErrorLocation.listFromSource(location),
      ),
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

  factory GraphQLException.fromException(
    Exception e,
    List<Object> path, {
    FileSpan? span,
  }) {
    if (e is GraphQLException) {
      return GraphQLException([
        ...e.errors.map(
          (e) => GraphQLExceptionError(
            e.message,
            locations: e.locations.isNotEmpty || span == null
                ? e.locations
                : [GraphQLErrorLocation.fromSourceLocation(span.start)],
            path: e.path ?? path,
          ),
        ),
      ]);
    } else if (e is GraphQLExceptionError) {
      return GraphQLException([
        GraphQLExceptionError(
          e.message,
          locations: e.locations.isNotEmpty || span == null
              ? e.locations
              : [GraphQLErrorLocation.fromSourceLocation(span.start)],
          path: e.path ?? path,
        ),
      ]);
    }
    final message = e.toString();
    return GraphQLException.fromMessage(
      message,
      path: path,
      location: span?.start,
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
  }) : stackTrace = StackTrace.current;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (path != null) 'path': path,
      if (locations.isNotEmpty)
        'locations': locations.map((l) => l.toJson()).toList(),
    };
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
@immutable
class GraphQLErrorLocation {
  final int line;
  final int column;

  const GraphQLErrorLocation(
    this.line,
    this.column,
  );

  static List<GraphQLErrorLocation> listFromSource(SourceLocation? location) {
    if (location == null) {
      return const [];
    }
    return [
      GraphQLErrorLocation(
        location.line,
        location.column,
      )
    ];
  }

  factory GraphQLErrorLocation.fromSourceLocation(SourceLocation location) {
    return GraphQLErrorLocation(
      location.line,
      location.column,
    );
  }

  Map<String, Object?> toJson() {
    return {'line': line, 'column': column};
  }

  GraphQLErrorLocation copyWith({
    int? line,
    int? column,
  }) {
    return GraphQLErrorLocation(
      line ?? this.line,
      column ?? this.column,
    );
  }

  @override
  String toString() => 'GraphQLErrorLocation(line: $line, column: $column)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphQLErrorLocation &&
        other.line == line &&
        other.column == column;
  }

  @override
  int get hashCode => line.hashCode ^ column.hashCode;
}
