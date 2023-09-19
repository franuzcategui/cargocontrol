import 'package:cargocontrol/authentication/authentication_repository.dart';
import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/form_validators/email.dart';
import 'package:cargocontrol/form_validators/password.dart';
import 'package:cargocontrol/form_validators/user_type.dart';
import 'package:cargocontrol/sign_up/controller/sign_up_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpControllerNotifier, SignUpState>(
        (ref) => SignUpControllerNotifier(ref.watch(authRepoProvider)));

class SignUpControllerNotifier extends StateNotifier<SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpControllerNotifier(this._authenticationRepository)
      : super(const SignUpState());

  void onUserTypeChange(UserTypeOptions value) {
    final userType = UserType.dirty(value);

    state = state.copyWith(
        userType: userType,
        isValid: Formz.validate([
          userType,
          state.email,
          state.password,
        ]));
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);

    state = state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.userType,
        ]));
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);

    state = state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
          state.userType,
        ]));
  }

  void signUp() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
          userType: state.userType.value.name);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on SignUpFailure catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
      state = state.copyWith(
        email: const Email.pure(),
        password: const Password.pure(),
        userType: const UserType.pure(),
        status: FormzSubmissionStatus.initial,
      );
    }
  }
}
