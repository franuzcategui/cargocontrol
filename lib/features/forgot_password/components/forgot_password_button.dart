// import 'package:cargocontrol/features/forgot_password/controller/forgot_password_controller.dart';
// import 'package:cargocontrol/common_widgets/main_text_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ForgotPasswordButton extends ConsumerWidget {
//   const ForgotPasswordButton({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final forgotPasswordState = ref.watch(forgotPasswordProvider);
//     final forgotPasswordController = ref.read(forgotPasswordProvider.notifier);
//     final bool isValidated = forgotPasswordState.isValid;
//     return MainTextButton(
//         text: 'ENVIAR CORREO ELECTRÓNICO',
//         onTap: isValidated
//             ? () => forgotPasswordController.forgotPassword()
//             : null);
//   }
// }
