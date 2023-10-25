import 'package:formz/formz.dart';

enum PlacaValidationError { empty, invalid }

class Placa extends FormzInput<String, PlacaValidationError> {
  const Placa.pure() : super.pure('');
  const Placa.dirty([value = '']) : super.dirty(value);

  static String _kPlacaPattern = r'^\d{6}$';

  @override
  PlacaValidationError? validator(String value) {
    if (RegExp(_kPlacaPattern).hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return PlacaValidationError.empty;
    } else {
      return PlacaValidationError.invalid;
    }
  }

  static String? showPlacaErrorMessage(PlacaValidationError error) {
    if (error == PlacaValidationError.empty) {
      return "Placa vacía";
    }
    if (error == PlacaValidationError.invalid) {
      return "Placa debe tener 6 dígitos";
    } else {
      return null;
    }
  }
}
