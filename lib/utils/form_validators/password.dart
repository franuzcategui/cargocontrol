import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.length > 5) {
      return null;
    }
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else {
      return PasswordValidationError.invalid;
    }
  }

  static String? showPasswordErrorMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Contraseña vacia';
    } else if (error == PasswordValidationError.invalid) {
      return 'Contraseña debe ser de al menos 4 caracteres';
    } else {
      return null;
    }
  }
}
