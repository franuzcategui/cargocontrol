import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/features/sign_in/controller/signin_controller.dart';
import 'package:cargocontrol/features/sign_in/controller/signin_state.dart';
import 'package:cargocontrol/features/forgot_password/components/forgot_password_screen.dart';
import 'package:cargocontrol/features/auth/widgets/login_widgets/email_text_field.dart';
import 'package:cargocontrol/features/auth/widgets/login_widgets/password_text_field.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../widgets/login_widgets/signin_button.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 160.h,
            ),
            Image.asset(constants.Images.logo),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: constants.DecorationStyles.shadow1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              builder: (context) =>
                                  const ForgotPasswordScreen()),
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
          ],
        ),
      ),
    );
  }
}
