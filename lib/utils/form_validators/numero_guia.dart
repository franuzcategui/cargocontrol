import 'package:formz/formz.dart';

enum NumeroGuiaValidationError { empty, invalid }

class NumeroGuia extends FormzInput<String, NumeroGuiaValidationError> {
  const NumeroGuia.pure() : super.pure('');
  const NumeroGuia.dirty([value = '']) : super.dirty(value);

  static String _kNumeroGuiaPattern = r'^\d{5}$';

  @override
  NumeroGuiaValidationError? validator(String value) {
    if (RegExp(_kNumeroGuiaPattern).hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return NumeroGuiaValidationError.empty;
    } else {
      return NumeroGuiaValidationError.invalid;
    }
  }

  static String? showNumeroGuiaErrorMessage(NumeroGuiaValidationError? error) {
    if (error == NumeroGuiaValidationError.empty) {
      return 'Número de guia vacio';
    } else if (error == NumeroGuiaValidationError.invalid) {
      return 'Número de guía debe ser de 5 dígitos';
    } else {
      return null;
    }
  }
}
