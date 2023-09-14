import 'package:cargocontrol/forgot_password/components/forgot_password_button.dart';
import 'package:cargocontrol/forgot_password/components/forgot_password_text_field.dart';
import 'package:cargocontrol/forgot_password/controller/forgot_password_controller.dart';
import 'package:cargocontrol/forgot_password/controller/forgot_password_state.dart';
import 'package:cargocontrol/sign_in/components/email_text_field.dart';
import 'package:cargocontrol/widgets/loading_sheet.dart';
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ForgotPasswordState>(forgotPasswordProvider,
        (previous, current) {
      if (current.status.isInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isFailure) {
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSuccess) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      appBar: AppBar(),
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Cambiar Contraseña',
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
                    height: 20,
                  ),
                  Text(
                    'Ingresa el correo electrónico registrado. Sigue los pasos en el correo a recibir para poder cambiar la contraseña',
                    style: const constants.TextStyles().bodyText1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ForgotPasswordTextField(),
                  const SizedBox(
                    height: 10,
                  )
                ]),
          ),

          //Log in buttons
          ForgotPasswordButton(),
          MainTextButton(
            text: 'REGRESAR',
            buttonStyle: ButtonThemeStyle.secondary,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
