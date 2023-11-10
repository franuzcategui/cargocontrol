import 'package:formz/formz.dart';

enum PesoValidationError { empty, invalid, notNumber }

class Peso extends FormzInput<String, PesoValidationError> {
  const Peso.pure() : super.pure('');
  const Peso.dirty([value = '']) : super.dirty(value);

  @override
  PesoValidationError? validator(String value) {
    double? doubleValue = double.tryParse(value);
    if (doubleValue == null) {
      return PesoValidationError.notNumber;
    }
    if (doubleValue < 0) {
      return PesoValidationError.invalid;
    } else {
      return null;
    }
  }

  double? toDouble() {
    double? doubleValue = double.tryParse(value);
    if (doubleValue != null) {
      return doubleValue;
    } else {
      return null;
    }
  }

  static String? showPesoErrorMessage(PesoValidationError? error) {
    if (error == PesoValidationError.empty) {
      return 'Campo vacio';
    } else if (error == PesoValidationError.invalid) {
      return 'Peso invalido';
    } else if (error == PesoValidationError.notNumber) {
      return 'Peso debe ser un número';
    } else {
      return null;
    }
  }
}
