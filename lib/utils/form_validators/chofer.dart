import 'package:formz/formz.dart';

enum ChoferValidationError { empty, invalid }

class Chofer extends FormzInput<String, ChoferValidationError> {
  const Chofer.pure() : super.pure('');
  const Chofer.dirty([value = '']) : super.dirty(value);

  @override
  ChoferValidationError? validator(String value) {
    if (value == '') {
      return ChoferValidationError.empty;
    }
    if (value.length < 5 || value.length > 30) {
      return ChoferValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showChoferErrorMessage(ChoferValidationError? error) {
    if (error == ChoferValidationError.empty) {
      return 'Campo de Chofer vacio';
    } else if (error == ChoferValidationError.invalid) {
      return 'Chofer debe tener por lo menos 5 caracteres y menos de 30 caracteres';
    } else {
      return null;
    }
  }
}
