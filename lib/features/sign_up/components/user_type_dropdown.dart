// import 'package:cargocontrol/utils/form_validators/user_type.dart';
// import 'package:cargocontrol/features/sign_up/controller/sign_up_controller.dart';
// import 'package:cargocontrol/common_widgets/cargo_dropdown_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class UserTypeDropdown extends ConsumerWidget {
//   const UserTypeDropdown({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final signUpState = ref.watch(signUpProvider);
//     final bool showError =
//         signUpState.userType.isNotValid && !signUpState.userType.isPure;
//     final signUpController = ref.read(signUpProvider.notifier);
//     return CargoDropdownButton(
//       items: UserTypeOptions.values.map((e) => e).toList(),
//       label: 'Tipo de usuario',
//       onSelect: (value) =>
//           signUpController.onUserTypeChange(value as UserTypeOptions),
//     );
//   }
// }
