import 'package:cargocontrol/screens/forgot_password_screen.dart';
import 'package:cargocontrol/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:cargocontrol/widgets/main_text_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Bienvenido',
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
              const LoginTextField(hintText: 'correo electrónico'),
              const LoginTextField(
                hintText: 'contraseña',
                hideText: true,
              ),
              TextButton(
                child: const Text(
                  'Se me olvidó la contraseña',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: constants.kMainColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()),
                  );
                },
              ),
              const SizedBox(
                height: 70,
              )
            ]),
          ),

          //Log in buttons
          const MainTextButton(
            text: 'INICIAR SESIÓN',
          ),
          const MainTextButton(
              text: 'REGISTRARME', buttonStyle: ButtonThemeStyle.secondary),
        ],
      ),
    );
  }
}
