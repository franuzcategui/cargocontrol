import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/account_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/sign_up/components/email_text_field.dart';
import 'package:cargocontrol/features/sign_up/components/password_text_field.dart';
import 'package:cargocontrol/features/sign_up/components/sign_up_button.dart';
import 'package:cargocontrol/features/sign_up/components/user_type_dropdown.dart';
import 'package:cargocontrol/features/sign_up/controller/sign_up_controller.dart';
import 'package:cargocontrol/features/sign_up/controller/sign_up_state.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/common_widgets/main_text_button.dart';

import '../../../../commons/common_widgets/custom_dropdown.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {

  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  bool isIndustry = false;

  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: constants.kMainBackroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(constants.Images.logo, width: 290.w, height: 78.h,),
            Container(
              padding: EdgeInsets.all(20.sp),
              margin: EdgeInsets.all(20.sp),
              decoration: constants.DecorationStyles.shadow1,
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  children: [
                    Text(
                      'Registro de usuario',
                      style: getRegularStyle(color: context.text3Color),
                    ),
                    SizedBox(
                      width: 20.h,
                    ),
                    Expanded(
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: context.brandColor,
                          borderRadius: BorderRadius.circular(24.r)
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomDropDown(
                    list: const [
                      "administrator",
                      "coordinador",
                      "industria",
                    ],
                    labelText: "Tipo de usuario",
                  onChange: (val){
                      if(val == AccountTypeEnum.industria.type){
                        setState(() {
                          isIndustry = true;
                        });
                      }else{
                        setState(() {
                          isIndustry = false;
                        });
                      }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                isIndustry ?
                Column(
                  children: [
                    CustomDropDown(
                      list: const [
                        "intra Industry",
                        "Hoal Industry",
                        "Kapito Industry",
                      ],
                      labelText: "Industrias",
                      onChange: (val){

                      },
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                  ],
                ): const SizedBox.shrink(),

                CustomTextField(
                    controller: emailCtr,
                    hintText: "",
                    onChanged: (val){},
                    onFieldSubmitted: (val){},
                    obscure: false,
                    label: "correo electrónico"
                ),
                CustomTextField(
                    controller: passCtr,
                    hintText: "",
                    onChanged: (val){},
                    onFieldSubmitted: (val){},
                    obscure: false,
                    label: "contraseña"
                ),
                const SizedBox(
                  height: 60,
                )
              ]),
            ),
            //Log in buttons
            CustomButton(
                onPressed: (){},
                buttonText: "REGISTRO"
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w ),
              child: MainTextButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'REGRESAR',
                  buttonStyle: ButtonThemeStyle.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
