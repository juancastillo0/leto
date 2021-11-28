import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

class CustomError implements ErrorExtensions {
  final int code;

  CustomError(this.code);

  @override
  String get errorMessage => 'Custom error message';

  @override
  Map<String, Object?> errorExtensions() {
    return {
      'CustomError': {'code': code}
    };
  }
}

void main() {
  test('error implements GraphQLException', () {
    void _t() {
      throw GraphQLError('error message');
    }

    GraphQLException? exception;
    try {
      _t();
    } on GraphQLException catch (e) {
      exception = e;
    }

    expect(exception, isNotNull);
    expect(exception!.errors, hasLength(1));
    expect(exception.errors.first.message, 'error message');
    expect(
      exception.toString(),
      startsWith(
        'GraphQLExceptionError({message: error message, stackTrace: #0',
      ),
    );
  });

  test('custom error implements ErrorExtensions', () {
    void _t() {
      throw CustomError(12);
    }

    late final GraphQLException exception;
    try {
      _t();
    } catch (e, s) {
      exception = GraphQLException.fromException(e, s, ['de']);
    }

    expect(exception, isNotNull);
    expect(exception.errors, hasLength(1));
    expect(exception.errors.first.message, 'Custom error message');
    expect(
      exception.toString(),
      startsWith(
        // ignore: missing_whitespace_between_adjacent_strings
        'GraphQLException({errors: [GraphQLExceptionError({'
        'message: Custom error message,'
        ' path: [de], extensions: {CustomError: {code: 12}},'
        // ignore: avoid_escaping_inner_quotes
        ' sourceError: Instance of \'CustomError\', stackTrace: #0',
      ),
    );
    expect(exception.errors.first.extensions, {
      'CustomError': {'code': 12}
    });
  });
}
