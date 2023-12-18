// import 'package:cargocontrol/features/forgot_password/controller/forgot_password_controller.dart';
// import 'package:cargocontrol/utils/form_validators/email.dart';
// import 'package:cargocontrol/common_widgets/login_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ForgotPasswordTextField extends ConsumerWidget {
//   const ForgotPasswordTextField({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final forgotPasswordState = ref.watch(forgotPasswordProvider);
//     final bool showError = forgotPasswordState.email.isNotValid &&
//         !forgotPasswordState.email.isPure;
//     final forgotPasswordController = ref.read(forgotPasswordProvider.notifier);
//     return LoginTextField(
//         hintText: 'Correo electrónico',
//         errorText: showError
//             ? Email.showEmailErrorMessage(forgotPasswordState.email.error)
//             : null,
//         onChanged: (email) => forgotPasswordController.onEmailChange(email));
//   }
// }
