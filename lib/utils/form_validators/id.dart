import 'package:formz/formz.dart';

enum IdValidationError { empty, invalid }

class Id extends FormzInput<String, IdValidationError> {
  const Id.pure() : super.pure('');
  const Id.dirty([value = '']) : super.dirty(value);

  final String _kIdPattern = r'^\d{9,12}$';

  @override
  IdValidationError? validator(String value) {
    if (RegExp(_kIdPattern).hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return IdValidationError.empty;
    } else {
      return IdValidationError.invalid;
    }
  }

  static String? showIdErrorMessage(IdValidationError? error) {
    if (error == IdValidationError.empty) {
      return 'Id vacio';
    } else if (error == IdValidationError.invalid) {
      return 'Id debe ser de 9 a 12 dígitos y sólo números';
    } else {
      return null;
    }
  }
}
