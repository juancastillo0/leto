import 'package:leto/leto.dart';

/// A simple extension for mapping resolver errors
class MapErrorExtension extends GraphQLExtension {
  /// Called for every [ThrownError] found during the execution of resolvers
  ///
  /// Return null if you don't want to override the [GraphQLException],
  /// by default, the error is mapped by executing
  /// [GraphQLExtension.mapException] for other extensions
  /// and then [GraphQLException.fromException] if there weren't
  /// any extension which returned a [GraphQLException]
  final GraphQLException? Function(ThrownError) mapError;

  /// A simple extension for mapping resolver errors
  MapErrorExtension(this.mapError);

  @override
  String get mapKey => 'leto.mapError';

  @override
  GraphQLException mapException(
    GraphQLException Function() next,
    ThrownError error,
  ) {
    final mapped = mapError(error);
    if (mapped != null) {
      return mapped;
    }
    return next();
  }
}
