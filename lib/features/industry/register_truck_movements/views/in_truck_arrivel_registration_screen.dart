import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
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
import '../controllers/in_truck_registration_noti_controller.dart';

class InRegisterTruckArrivalScreen extends StatefulWidget {
  const InRegisterTruckArrivalScreen({Key? key}) : super(key: key);

  @override
  State<InRegisterTruckArrivalScreen> createState() => _InRegisterTruckArrivalScreenState();
}

class _InRegisterTruckArrivalScreenState extends State<InRegisterTruckArrivalScreen> {
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
                  title: "Número de ",
                  subtitle: "placa" ,
                  description: "Indique el número de placa del camión saliente",
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
                    final industryNotiCtr= ref.watch(inTruckRegistrationNotiControllerProvider);
                    return CustomButton(
                      buttonText:  'CONTINUAR',
                      onPressed: ()async{
                        await industryNotiCtr.getCurrentIndustry(
                          realIndustryId: ref.read(authNotifierCtr).userModel?.industryId?? '',
                          ref: ref,
                          context: context
                        );
                        await industryNotiCtr.
                        getMatchedViajesLinkedWithIndustry(
                          plateNumber: keyPadTextFieldController.text,
                          viajesStatusEnum: ViajesStatusEnum.portLeft,
                          pageName: AppRoutes.inTruckArrivalInfoScreen,
                          context: context,
                          ref: ref,
                          industryId: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel?.industryId ?? ''
                        );
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

