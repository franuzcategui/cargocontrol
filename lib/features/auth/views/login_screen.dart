import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/auth/controllers/auth_controller.dart';
import 'package:cargocontrol/features/auth/views/forgot_password_screen.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/loading_sheet.dart';
import '../widgets/login_widgets/signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailCtr.dispose();
    passCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
            Image.asset(AppAssets.logo, height: 78.h, width: 290.w,),
            Container(
              padding: EdgeInsets.all(20.sp),
              margin: EdgeInsets.all(20.sp),
              decoration: constants.DecorationStyles.shadow1,
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Bienvenido',
                            style:getRegularStyle(color: context.text3Color, fontSize: MyFonts.size24),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 4.h,
                              color: constants.kBrandColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomTextField(
                          controller: emailCtr,
                          hintText: '',
                          onChanged: (val){},
                          onFieldSubmitted: (val){},
                          obscure: false,
                          validatorFn: emailValidator,
                          label: 'Correo electrónico'
                      ),
                      CustomTextField(
                          controller: passCtr,
                          hintText: '',
                          validatorFn: passValidator,
                          onChanged: (val){},
                          onFieldSubmitted: (val){},
                          obscure: true,
                          label: 'Contraseña'
                      ),
                      TextButton(
                        child: Text(
                          'Se me olvidó la contraseña',
                          style: getBoldStyle(color: context.mainColor, fontSize: MyFonts.size12),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const ForgotPasswordScreen()),
                          // );
                        },
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ]),
              ),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return CustomButton(
                    onPressed: ()async{
                      if(formKey.currentState!.validate()){
                        await ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
                            email: emailCtr.text,
                            password: passCtr.text,
                            ref: ref,
                            context: context
                        );
                      }else{

                      }
                    },
                    buttonText: 'INICIAR SESIÓN'
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
