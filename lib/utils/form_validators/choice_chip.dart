import 'package:formz/formz.dart';

enum ChoiceChipError { empty }

class ChoiceChip extends FormzInput<String, ChoiceChipError> {
  const ChoiceChip.pure() : super.pure('');
  const ChoiceChip.dirty([String value = '']) : super.dirty(value);

  @override
  ChoiceChipError? validator(String? value) {
    if (value == null) {
      return ChoiceChipError.empty;
    } else {
      return null;
    }
  }
}
