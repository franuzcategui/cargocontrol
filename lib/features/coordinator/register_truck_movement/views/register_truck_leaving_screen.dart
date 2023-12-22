import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../../commons/common_widgets/text_detector_view.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';

class RegisterTruckLeavingScreen extends StatefulWidget {
  const RegisterTruckLeavingScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTruckLeavingScreen> createState() => _RegisterTruckLeavingScreenState();
}

class _RegisterTruckLeavingScreenState extends State<RegisterTruckLeavingScreen> {
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
                    decoration: InputDecoration(
                      prefixText: 'C - ',
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const TextDetectorScreen()),
                              );
                              setState(() {
                                keyPadTextFieldController.text = result;
                              });
                            },
                            icon: Image.asset(AppAssets.scanIcon, scale: 2.2.sp),
                          )
                        ],
                      ),
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
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return CustomButton(
                      buttonText:  'CONTINUAR',
                      isLoading: ref.watch(truckRegistrationNotiControllerProvider).isLoading,
                      onPressed: ()async{
                        if(keyPadTextFieldController.text.isNotEmpty){
                          await ref.read(truckRegistrationNotiControllerProvider).
                          getMatchedViajes(
                            plateNumber: keyPadTextFieldController.text,
                            context: context,
                            ref: ref,
                          );
                        }else{
                          showSnackBar(context: context, content: 'Enter Plate Number!');
                        }
                      },
                    );
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

