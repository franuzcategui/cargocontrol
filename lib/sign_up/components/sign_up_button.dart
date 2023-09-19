import 'package:cargocontrol/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/sign_up/controller/sign_up_controller.dart';
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpController = ref.read(signUpProvider.notifier);
    final bool isValidated = signUpState.isValid;
    return MainTextButton(
        text: 'REGISTRO',
        onTap: isValidated ? () => signUpController.signUp() : null);
  }
}
