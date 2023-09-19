import 'package:formz/formz.dart';

enum UserTypeOptions { administrador, coordinador, industria }

enum UserTypeError { empty }

class UserType extends FormzInput<UserTypeOptions, UserTypeError> {
  const UserType.pure() : super.pure(UserTypeOptions.administrador);
  const UserType.dirty([UserTypeOptions value = UserTypeOptions.administrador])
      : super.dirty(value);

  @override
  UserTypeError? validator(UserTypeOptions value) {
    return null;
  }
}
