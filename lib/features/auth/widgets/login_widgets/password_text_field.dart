import 'package:cargocontrol/common_widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cargocontrol/features/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/utils/form_validators/password.dart';

class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInprovider);
    final bool showError =
        signInState.password.isNotValid && !signInState.password.isPure;
    final signInController = ref.read(signInprovider.notifier);
    return LoginTextField(
      hideText: true,
      hintText: 'Contraseña',
      errorText: showError
          ? Password.showPasswordErrorMessage(signInState.password.error)
          : null,
      onChanged: (password) => signInController.onPasswordChange(password),
    );
  }
}
