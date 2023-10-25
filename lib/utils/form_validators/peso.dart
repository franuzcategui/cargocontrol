import 'package:formz/formz.dart';

enum PesoValidationError { empty, invalid, notNumber }

class Peso extends FormzInput<String, PesoValidationError> {
  const Peso.pure() : super.pure('');
  const Peso.dirty([value = '']) : super.dirty(value);

  @override
  PesoValidationError? validator(String value) {
    int? intValue = int.tryParse(value);
    if (intValue == null) {
      return PesoValidationError.notNumber;
    }
    if (intValue < 0) {
      return PesoValidationError.invalid;
    } else {
      return null;
    }
  }
}
