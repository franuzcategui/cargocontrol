import 'package:cargocontrol/utils/form_validators/email.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ForgotPasswordState extends Equatable {
  final FormzSubmissionStatus status;
  final bool isValid;
  final Email email;
  final String? errorMessage;

  const ForgotPasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    Email? email,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, isValid, email, errorMessage];
}
