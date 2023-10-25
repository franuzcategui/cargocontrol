import 'package:cargocontrol/authentication/authentication_repository.dart';
import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cargocontrol/utils/form_validators/email.dart';
import 'package:cargocontrol/utils/form_validators/password.dart';
import 'package:cargocontrol/features/sign_in/controller/signin_state.dart';
import 'package:formz/formz.dart';

final signInprovider =
    StateNotifierProvider.autoDispose<SignInControllerNotifier, SignInState>(
        (ref) => SignInControllerNotifier(ref.watch(authRepoProvider)));

class SignInControllerNotifier extends StateNotifier<SignInState> {
  final AuthenticationRepository _authenticationRepository;
  SignInControllerNotifier(this._authenticationRepository)
      : super(const SignInState());

  void onEmailChange(String value) {
    final email = Email.dirty(value);

    state = state.copyWith(
        email: email, isValid: Formz.validate([email, state.password]));
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);

    state = state.copyWith(
        password: password, isValid: Formz.validate([state.email, password]));
  }

  void signInWithEmailAndPassword() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on SignInWithEmailAndPasswordFailure catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
      state = state.copyWith(
        email: const Email.pure(),
        password: const Password.pure(),
        status: FormzSubmissionStatus.initial,
      );
    }
  }
}
