part of leto_schema.src.schema;

/// An exception that occurs during execution of a GraphQL query.
///
/// It's a List of [GraphQLError]
class GraphQLException implements Exception {
  /// A list of all [GraphQLError]s that caused this exception.
  final List<GraphQLError> errors;

  const GraphQLException(this.errors);

  /// Creates an [GraphQLException] with a single [GraphQLError]
  /// from the given arguments. You may want to pass [sourceError] and
  /// [stackTrace] for improved error logs.
  factory GraphQLException.fromMessage(
    String message, {
    List<Object>? path,
    SourceLocation? location,
    Object? sourceError,
    StackTrace? stackTrace,
    Map<String, Object?>? extensions,
  }) {
    return GraphQLException([
      GraphQLError(
        message,
        path: path,
        locations: GraphQLErrorLocation.listFromSource(location),
        sourceError: sourceError,
        stackTrace: stackTrace,
        extensions: extensions,
      ),
    ]);
  }

  /// Utility factory for creating a [GraphQLException] from
  /// an [error] and [stackTrace].
  ///
  /// Will use [Object.toString] as a message if [error] is not
  /// a [GraphQLException], otherwise, it will override all errors
  /// with the values passed in the arguments if the given values are not
  /// already present.
  factory GraphQLException.fromException(
    Object error,
    StackTrace stackTrace,
    List<Object> path, {
    FileSpan? span,
    Map<String, Object?>? extensions,
  }) {
    if (error is GraphQLException) {
      return GraphQLException([
        ...error.errors.map(
          (e) => GraphQLError(
            e.message,
            locations: e.locations.isNotEmpty || span == null
                ? e.locations
                : [GraphQLErrorLocation.fromSourceLocation(span.start)],
            path: e.path ?? path,
            extensions: e.extensions ?? extensions,
            sourceError: e.sourceError ?? error,
            stackTrace: e.stackTrace ?? stackTrace,
          ),
        ),
      ]);
    }
    final message = error.toString();
    return GraphQLException.fromMessage(
      message,
      path: path,
      location: span?.start,
      sourceError: error,
      stackTrace: stackTrace,
      extensions: extensions,
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
/// This will almost always be passed to a [GraphQLException].
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

  /// The stack trace of the [sourceError]
  final StackTrace? stackTrace;

  /// An optional error Object to pass more information of the
  /// source of the problem for logging or other purposes
  final Object? sourceError;

  /// Extensions return to the client
  ///
  /// This could be used to send more
  /// information about the error, such as a specific error code.
  final Map<String, Object?>? extensions;

  const GraphQLError(
    this.message, {
    this.locations = const [],
    this.path,
    this.extensions,
    this.stackTrace,
    this.sourceError,
  });

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
