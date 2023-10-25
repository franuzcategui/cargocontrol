import 'package:cargocontrol/features/sign_up/components/email_text_field.dart';
import 'package:cargocontrol/features/sign_up/components/password_text_field.dart';
import 'package:cargocontrol/features/sign_up/components/sign_up_button.dart';
import 'package:cargocontrol/features/sign_up/components/user_type_dropdown.dart';
import 'package:cargocontrol/features/sign_up/controller/sign_up_controller.dart';
import 'package:cargocontrol/features/sign_up/controller/sign_up_state.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpProvider, (previous, current) {
      if (current.status.isInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSuccess) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "Has registrado al usuario exitosamente");
      }
    });
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: constants.kMainBackroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(constants.Images.logo),
          //Square login section
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: constants.DecorationStyles.shadow1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Text(
                    'Registro de usuario',
                    style: const constants.TextStyles().headlineText1,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 4,
                      color: constants.kBrandColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const UserTypeDropdown(),
              const EmailTextField(),
              const PasswordTextField(),
              const SizedBox(
                height: 70,
              )
            ]),
          ),

          //Log in buttons
          const SignUpButton(),
          MainTextButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: 'REGRESAR',
              buttonStyle: ButtonThemeStyle.secondary),
        ],
      ),
    );
  }
}
