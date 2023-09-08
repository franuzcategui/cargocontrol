import 'package:cargocontrol/sign_in/components/email_text_field.dart';
import 'package:cargocontrol/widgets/login_text_field.dart';
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const EmailTextField(),
                  const SizedBox(
                    height: 10,
                  )
                ]),
          ),

          //Log in buttons
          const MainTextButton(
            text: 'ENVIAR CORREO ELECTRÓNICO',
          ),
          const MainTextButton(
              text: 'REGRESAR', buttonStyle: ButtonThemeStyle.secondary),
        ],
      ),
    );
  }
}
