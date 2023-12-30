import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_noti_controller.dart';
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
import '../../../../core/enums/viajes_status_enum.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';

class InRegisterTruckUnlaodingScreen extends StatefulWidget {
  const InRegisterTruckUnlaodingScreen({Key? key}) : super(key: key);

  @override
  State<InRegisterTruckUnlaodingScreen> createState() => _InRegisterTruckUnlaodingScreenState();
}

class _InRegisterTruckUnlaodingScreenState extends State<InRegisterTruckUnlaodingScreen> {
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
                    final truckCtr = ref.watch(inTruckRegistrationNotiControllerProvider);
                    return CustomButton(
                      buttonText:  'CONTINUAR',
                      isLoading: truckCtr.isLoading,
                      onPressed: ()async{
                        if(truckCtr.currentIndustryModel!= null ){
                          await ref.read(inTruckRegistrationNotiControllerProvider).
                          getMatchedViajesLinkedWithIndustry(
                              plateNumber: keyPadTextFieldController.text,
                              viajesStatusEnum: ViajesStatusEnum.industryEntered,
                              pageName: AppRoutes.inTruckUnloadingInfoScreen,
                              context: context,
                              ref: ref,
                              industryId: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel?.industryId ?? ''
                          );
                          await ref.read(inTruckRegistrationNotiControllerProvider).
                          getCurrentVessel(ref: ref);
                        }else{
                          await truckCtr.getCurrentIndustry(
                              realIndustryId: ref.read(authNotifierCtr).userModel?.industryId?? '',
                              ref: ref,
                              context: context
                          );
                          await ref.read(inTruckRegistrationNotiControllerProvider).
                          getMatchedViajesLinkedWithIndustry(
                              plateNumber: keyPadTextFieldController.text,
                              viajesStatusEnum: ViajesStatusEnum.industryEntered,
                              pageName: AppRoutes.inTruckUnloadingInfoScreen,
                              context: context,
                              ref: ref,
                              industryId: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel?.industryId ?? ''
                          );
                          await ref.read(inTruckRegistrationNotiControllerProvider).
                          getCurrentVessel(ref: ref);
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

