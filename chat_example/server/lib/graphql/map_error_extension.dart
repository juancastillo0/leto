import 'package:leto/leto.dart';

class MapErrorExtension extends GraphQLExtension {
  final GraphQLException? Function(ThrownError) mapError;

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
