import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

const String _kPasswordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _regex = RegExp(_kPasswordPattern);

  @override
  PasswordValidationError? validator(String value) {
    if (_regex.hasMatch(value)) {
      return null;
    }
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else {
      return PasswordValidationError.invalid;
    }
  }

  static String? showEmailErrorMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Contraseña vacia';
    } else if (error == PasswordValidationError.invalid) {
      return 'Contraseña debe ser de al menos 8 caracteres, con un caracter en Mayúscula, un caracter en minúscula, un número y un caracter especial';
    } else {
      return null;
    }
  }
}
