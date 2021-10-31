import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:leto_schema/leto_schema.dart' show GraphQLError;
import 'package:meta/meta.dart';

/// Utility for nullable values in copyWith methods
class Val<T> {
  final T inner;

  const Val(this.inner);
}

/// A result from a GraphQL request.
@immutable
class GraphQLResult {
  /// A Stream<GraphQLResult> for subscriptions
  /// or a Map<String, Object?>? for queries and mutations
  final Object? data;

  bool get isSubscription => subscriptionStream != null;
  Stream<GraphQLResult>? get subscriptionStream =>
      data is Stream<GraphQLResult> ? data! as Stream<GraphQLResult> : null;

  /// When [didExecute] is true, [data] is returned in the response
  final bool didExecute;
  final List<GraphQLError> errors;
  final Map<String, Object?>? extensions;

  /// [errors] should not be empty when [didExecute] is false
  const GraphQLResult(
    this.data, {
    // Should not be empty when [didExecute] is false
    this.errors = const [],
    this.didExecute = true,
    this.extensions,
  }) : assert(data == null || didExecute);

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

  GraphQLResult copyWithExtension(String key, Object? value) {
    final extensions = this.extensions;
    return copyWith(
        extensions: Val({
      if (extensions != null) ...extensions,
      key: value,
    }));
  }

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GraphQLResult &&
        other.data == data &&
        other.didExecute == didExecute &&
        listEquals(other.extensions, extensions) &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode =>
      data.hashCode ^
      errors.hashCode ^
      didExecute.hashCode ^
      extensions.hashCode;
}
