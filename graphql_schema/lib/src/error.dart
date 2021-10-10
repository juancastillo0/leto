part of graphql_schema.src.schema;

/// An exception that occurs during execution of a GraphQL query.
class GraphQLException implements Exception {
  /// A list of all specific errors, with text representation,
  /// that caused this exception.
  final List<GraphQLError> errors;

  const GraphQLException(this.errors);

  factory GraphQLException.fromMessage(
    String message, {
    List<Object>? path,
    SourceLocation? location,
  }) {
    return GraphQLException([
      GraphQLError(
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
      GraphQLError(
        message,
        locations: [
          GraphQLErrorLocation.fromSourceLocation(span.start),
        ],
        path: path,
      ),
    ]);
  }

  factory GraphQLException.fromException(
    Object e,
    List<Object> path, {
    FileSpan? span,
  }) {
    if (e is GraphQLException) {
      return GraphQLException([
        ...e.errors.map(
          (e) => GraphQLError(
            e.message,
            locations: e.locations.isNotEmpty || span == null
                ? e.locations
                : [GraphQLErrorLocation.fromSourceLocation(span.start)],
            path: e.path ?? path,
            extensions: e.extensions,
          ),
        ),
      ]);
    } else if (e is GraphQLError) {
      return GraphQLException([
        GraphQLError(
          e.message,
          locations: e.locations.isNotEmpty || span == null
              ? e.locations
              : [GraphQLErrorLocation.fromSourceLocation(span.start)],
          path: e.path ?? path,
          extensions: e.extensions,
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

  Map<String, Object?> toJson() {
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
class GraphQLError implements Exception, GraphQLException {
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

  final Map<String, Object?>? extensions;

  GraphQLError(
    this.message, {
    this.locations = const [],
    this.path,
    this.extensions,
  }) : stackTrace = StackTrace.current;

  @override
  Map<String, Object?> toJson() {
    return {
      'message': message,
      if (path != null) 'path': path,
      if (locations.isNotEmpty)
        'locations': locations.map((l) => l.toJson()).toList(),
      if (extensions != null) 'extensions': extensions,
    };
  }

  @override
  String toString() {
    return 'GraphQLExceptionError(${toJson()})';
  }

  @override
  List<GraphQLError> get errors => [this];
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
