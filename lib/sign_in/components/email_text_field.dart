import 'package:cargocontrol/form_validators/email.dart';
import 'package:cargocontrol/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailTextField extends ConsumerWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInprovider);
    final bool showError = signInState.email.isNotValid;
    final signInController = ref.read(signInprovider.notifier);

    return LoginTextField(
      hintText: 'Correo electrónico',
      errorText: showError
          ? Email.showEmailErrorMessage(signInState.email.error)
          : null,
      onChanged: (email) => signInController.onEmailChange(email),
    );
  }
}
