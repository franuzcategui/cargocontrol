import 'package:cargocontrol/authentication/authentication_repository.dart';
import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cargocontrol/form_validators/email.dart';
import 'package:cargocontrol/form_validators/password.dart';
import 'package:cargocontrol/sign_in/controller/signin_state.dart';
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
      email: email,
      status: Formz.validate([email, state.password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);

    state = state.copyWith(
      password: password,
      status: Formz.validate([state.email, password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    );
  }

  void signInWithEmailAndPassword() async {
    if (!state.status.isSuccess) return;
    print('llegie');
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on SignInWithEmailAndPasswordFailure catch (e) {
      print(e.code);
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
    }
  }
}
