import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:graphql_schema/graphql_schema.dart' show GraphQLExceptionError;
import 'package:meta/meta.dart';

@immutable
class GraphQLResult {
  /// A Stream<Map<String, Object?>?> for subscriptions or
  /// Map<String, Object?>? in queries and mutations
  final Object? data;

  /// When [didExecute] is true, [data] is returned in the response
  final bool didExecute;
  final List<GraphQLExceptionError> errors;
  final Map<String, Object?>? extensions;

  const GraphQLResult(
    this.data, {
    this.errors = const [],
    this.didExecute = true,
    this.extensions,
  }) : assert(data == null || didExecute);

  GraphQLResult copyWith({
    Object? data,
    List<GraphQLExceptionError>? errors,
    bool? didExecute,
    Map<String, Object?>? extensions,
  }) {
    return GraphQLResult(
      data ?? this.data,
      errors: errors ?? this.errors,
      didExecute: didExecute ?? this.didExecute,
      extensions: extensions ?? this.extensions,
    );
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
