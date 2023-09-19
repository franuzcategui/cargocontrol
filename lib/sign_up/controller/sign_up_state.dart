import 'package:cargocontrol/form_validators/email.dart';
import 'package:cargocontrol/form_validators/password.dart';
import 'package:cargocontrol/form_validators/user_type.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final UserType userType;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const SignUpState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.userType = const UserType.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.isValid = false,
      this.errorMessage});

  SignUpState copyWith({
    Email? email,
    Password? password,
    UserType? userType,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [email, password, userType, status, isValid, errorMessage];
}
