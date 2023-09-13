import 'package:cargocontrol/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/sign_in/controller/signin_state.dart';
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInprovider);
    final signInController = ref.read(signInprovider.notifier);
    final bool isValidated = signInState.status.isSuccess;
    print(isValidated);
    return MainTextButton(
        text: 'INICIAR SESIÓN',
        onTap: isValidated
            ? () => signInController.signInWithEmailAndPassword()
            : null);
  }
}
