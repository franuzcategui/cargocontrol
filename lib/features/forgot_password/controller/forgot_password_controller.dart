import 'package:cargocontrol/authentication/authentication_repository.dart';
import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/features/forgot_password/controller/forgot_password_state.dart';
import 'package:cargocontrol/utils/form_validators/email.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
        ForgotPasswordNotifier, ForgotPasswordState>(
    (ref) => ForgotPasswordNotifier(ref.watch(authRepoProvider)));

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ForgotPasswordNotifier(this._authenticationRepository)
      : super(const ForgotPasswordState());

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email, isValid: Formz.validate([email]));
  }

  void forgotPassword() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.forgotPassword(email: state.email.value);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on ForgotPasswordFailure catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
      state = state.copyWith(
          status: FormzSubmissionStatus.initial, email: const Email.pure());
    }
  }
}
