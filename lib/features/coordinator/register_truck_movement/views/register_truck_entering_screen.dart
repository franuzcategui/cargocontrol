import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';

class RegisterTruckEnteringScreen extends StatefulWidget {
  const RegisterTruckEnteringScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTruckEnteringScreen> createState() => _RegisterTruckEnteringScreenState();
}

class _RegisterTruckEnteringScreenState extends State<RegisterTruckEnteringScreen> {
  TextEditingController keyPadTextFieldController = TextEditingController();

  @override
  void initState() {
    keyPadTextFieldController.addListener(_onTextChange);
    super.initState();
  }

  @override
  void dispose() {
    keyPadTextFieldController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    final text = keyPadTextFieldController.text;

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 812.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonHeader(
                  title: "Número de",
                  subtitle: "guía" ,
                  description: "Indique el número de guía del camión entrante",
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: TextField(
                    maxLength: 6,
                    maxLengthEnforcement:
                    MaxLengthEnforcement.truncateAfterCompositionEnds,
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size24),
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    enableSuggestions: false,
                    readOnly: true,
                    controller: keyPadTextFieldController,
                    decoration: const InputDecoration(
                      prefixText: 'C - ',
                    ),
                  ),
                ),
                SizedBox(height: 80.h,),
                NumericKeyboard(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onKeyboardTap: (string) {
                    setState(() {
                      keyPadTextFieldController.text += string;
                    });
                  },
                  rightIcon: const Icon(FontAwesomeIcons.deleteLeft),
                  rightButtonFn: () {
                    keyPadTextFieldController.text = '';
                  },
                ),
                CustomButton(
                  buttonText:  'CONTINUAR',
                  onPressed: (){
                    Navigator.pushNamed(context, AppRoutes.coTruckInfoScreen);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        ),
      );
  }
}

