import 'package:cargocontrol/sign_in/components/signin_button.dart';
import 'package:cargocontrol/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/sign_in/controller/signin_state.dart';
import 'package:cargocontrol/forgot_password/forgot_password_screen.dart';
import 'package:cargocontrol/sign_in/components/email_text_field.dart';
import 'package:cargocontrol/sign_in/components/password_text_field.dart';
import 'package:cargocontrol/widgets/loading_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(signInprovider, (previous, current) {
      if (current.status.isInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSuccess) {
        Navigator.of(context).pop();
      }
    });
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
              const EmailTextField(),
              const PasswordTextField(),
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
          const SignInButton(),
          MainTextButton(
              onTap: () {},
              text: 'REGISTRARME',
              buttonStyle: ButtonThemeStyle.secondary),
        ],
      ),
    );
  }
}
