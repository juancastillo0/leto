import 'package:leto_schema/leto_schema.dart' show GraphQLError;

/// Utility for nullable values in copyWith methods
class Val<T> {
  /// The inner value
  final T inner;

  /// Utility for nullable values in copyWith methods
  const Val(this.inner);
}

/// A result from a GraphQL request.
class GraphQLResult {
  /// A Stream<GraphQLResult> for subscriptions
  /// or a Map<String, Object?>? for queries and mutations
  final Object? data;

  /// Whether this result is for a subscription
  bool get isSubscription => subscriptionStream != null;

  /// The stream of [GraphQLResult] if this result is for a subscription
  Stream<GraphQLResult>? get subscriptionStream =>
      data is Stream<GraphQLResult> ? data! as Stream<GraphQLResult> : null;

  /// When [didExecute] is true, [data] is returned in the response
  final bool didExecute;

  /// The [GraphQLError]s found during processing of the request
  final List<GraphQLError> errors;

  /// A serializable map containing custom values which
  /// give additional information to the client
  final Map<String, Object?>? extensions;

  /// [errors] should not be empty when [didExecute] is false
  const GraphQLResult(
    this.data, {
    // Should not be empty when [didExecute] is false
    this.errors = const [],
    this.didExecute = true,
    this.extensions,
  }) : assert(data == null || didExecute);

  /// Copies [this] overriding the values passes as arguments
  GraphQLResult copyWith({
    Val<Object?>? data,
    List<GraphQLError>? errors,
    bool? didExecute,
    Val<Map<String, Object?>?>? extensions,
  }) {
    return GraphQLResult(
      data != null ? data.inner : this.data,
      errors: errors ?? this.errors,
      didExecute: didExecute ?? this.didExecute,
      extensions: extensions != null ? extensions.inner : this.extensions,
    );
  }

  /// Copies [this] and assigns [value] for the [key]
  /// in the [extensions] Map if the new [GraphQLResult].
  GraphQLResult copyWithExtension(String key, Object? value) {
    final extensions = this.extensions;
    return copyWith(
      extensions: Val({
        if (extensions != null) ...extensions,
        key: value,
      }),
    );
  }

  /// Returns a Json Map following https://spec.graphql.org/October2021/#sec-Response
  Map<String, Object?> toJson() {
    return {
      if (errors.isNotEmpty) 'errors': errors.map((x) => x.toJson()).toList(),
      if (didExecute) 'data': data,
      if (extensions != null) 'extensions': extensions,
    };
  }

  @override
  String toString() => 'GraphQLResult(data: $data, errors: $errors, '
      'didExecute: $didExecute, extensions: $extensions)';
}
