// import 'package:cargocontrol/utils/form_validators/email.dart';
// import 'package:cargocontrol/features/sign_up/controller/sign_up_controller.dart';
// import 'package:cargocontrol/common_widgets/login_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class EmailTextField extends ConsumerWidget {
//   const EmailTextField({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final signUpState = ref.watch(signUpProvider);
//     final bool showError =
//         signUpState.email.isNotValid && !signUpState.email.isPure;
//     final signUpController = ref.read(signUpProvider.notifier);
//
//     return LoginTextField(
//       hintText: 'Correo electrónico',
//       errorText: showError
//           ? Email.showEmailErrorMessage(signUpState.email.error)
//           : null,
//       onChanged: (email) => signUpController.onEmailChange(email),
//     );
//   }
// }
