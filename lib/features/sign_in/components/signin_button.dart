import 'package:cargocontrol/features/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInprovider);
    final signInController = ref.read(signInprovider.notifier);
    final bool isValidated = signInState.isValid;
    return MainTextButton(
        text: 'INICIAR SESIÓN',
        onTap: isValidated
            ? () => signInController.signInWithEmailAndPassword()
            : null);
  }
}
