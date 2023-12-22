import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_controller.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_noti_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';

class CreateIndustryScreen extends ConsumerStatefulWidget {
  const CreateIndustryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateIndustryScreen> createState() => _CreateIndustryScreenState();
}

class _CreateIndustryScreenState extends ConsumerState<CreateIndustryScreen> {
  TextEditingController keyPadTextFieldController = TextEditingController();

  @override
  void initState() {
    keyPadTextFieldController.addListener(_onTextChange);
    initiallization();
    super.initState();
  }

  initiallization()async{
    await Future.wait([
      ref.read(adVesselNotiController).getCurrentVessel(),
      ref.read(adIndustryNotiController).getAllIndustriesModel(),
    ]);

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
                title: "Información del",
                subtitle: "buque" ,
                description: "Indique la información del buque a registrar",
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.w),
                child: TextField(
                  maxLength: 1,
                  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,

                  style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size24),
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  enableSuggestions: false,
                  readOnly: true,
                  controller: keyPadTextFieldController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[1-4]')),
                  ],
                  decoration: const InputDecoration(
                    prefixText: '',
                  ),
                ),
              ),
              SizedBox(height: 80.h,),
              NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: (string) {
                  // RegExp digitOneToFourRegExp = RegExp(r'^[1-4]$');
                  // if (digitOneToFourRegExp.hasMatch(string) && keyPadTextFieldController.text.length < 1) {
                  setState(() {
                    keyPadTextFieldController.text += string;
                  });
                  // } else {
                  //   showSnackBar(context: context, content: 'You can register max 4 industries!');
                  // }
                },
                rightIcon: const Icon(FontAwesomeIcons.deleteLeft),
                rightButtonFn: () {
                  keyPadTextFieldController.text = '';
                },
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ref.watch(fetchgetAllIndustryNamesStream).
                  when(
                    data: (indsutryNames){
                      return CustomButton(
                        buttonText:  'CONTINUAR',
                        onPressed: (){
                          if(keyPadTextFieldController.text.isNotEmpty ){
                            if(int.parse(keyPadTextFieldController.text) < indsutryNames.length){
                              Navigator.pushNamed(context, AppRoutes.adminCreateIndustryInformationScreen,
                                  arguments: {
                                    'numberOfIndustries' : int.parse(keyPadTextFieldController.text[0])
                                  }
                              );
                            }else{
                              showSnackBar(context: context, content: 'You can register maximum ${indsutryNames.length} industries!');
                            }
                          }
                        },
                      );
                    },
                    error: (error, st){
                      debugPrintStack(stackTrace: st);
                      debugPrint(error.toString());
                      return SizedBox();
                    },
                    loading: (){
                      return LoadingWidget();
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

