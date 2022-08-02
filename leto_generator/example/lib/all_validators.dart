import 'package:valida/valida.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_generator_example/star_wars_relay/data.dart';
import 'package:leto_generator_example/arguments.dart';
import 'package:leto_generator_example/attachments.dart';

// ignore: avoid_classes_with_only_static_members
class Validators {
  static const typeMap = <Type, Validator>{
    InputM: validatorInputM,
    ConnectionArguments: validatorConnectionArguments,
    ValidaArgModel: validatorValidaArgModel,
    KeyedAttachment: validatorKeyedAttachment,
  };

  static const validatorInputM = Validator(InputMValidation.fromValue);
  static const validatorConnectionArguments =
      Validator(ConnectionArgumentsValidation.fromValue);
  static const validatorValidaArgModel =
      Validator(ValidaArgModelValidation.fromValue);
  static const validatorKeyedAttachment =
      Validator(KeyedAttachmentValidation.fromValue);

  static Validator<T, Validation<T, Object>>? validator<T>() {
    final validator = typeMap[T];
    return validator as Validator<T, Validation<T, Object>>?;
  }

  static Validation<T, Object>? validate<T>(T value) {
    final validator = typeMap[T];
    return validator?.validate(value) as Validation<T, Object>?;
  }
}
