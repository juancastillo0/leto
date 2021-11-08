import 'package:valida/valida.dart';
import 'package:leto_generator_example/star_wars_relay/data.dart';

// ignore: avoid_classes_with_only_static_members
class Validators {
  static const typeMap = <Type, Validator>{
    ConnectionArguments: validatorConnectionArguments,
  };

  static const validatorConnectionArguments =
      Validator(validateConnectionArguments);

  static Validator<T, Validation<T, Object>>? validator<T>() {
    final validator = typeMap[T];
    return validator as Validator<T, Validation<T, Object>>?;
  }

  static Validation<T, Object>? validate<T>(T value) {
    final validator = typeMap[T];
    return validator?.validate(value) as Validation<T, Object>?;
  }
}
