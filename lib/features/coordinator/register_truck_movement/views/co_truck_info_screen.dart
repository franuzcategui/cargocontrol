import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/co_select_chofer_sheet.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';

import '../../../../commons/common_functions/bottom_sheet_component.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../utils/constants/assets_manager.dart';

class CoTruckInfoScreen extends StatefulWidget {
  const CoTruckInfoScreen({Key? key}) : super(key: key);

  @override
  State<CoTruckInfoScreen> createState() => _CoTruckInfoScreenState();
}

class _CoTruckInfoScreenState extends State<CoTruckInfoScreen> {

  final scanCtr = TextEditingController();
  final labelCtr = TextEditingController();
  final driverNameCtr = TextEditingController();
  final emptyTruckWeightCtr = TextEditingController();


  @override
  void dispose() {
    scanCtr.dispose();
    labelCtr.dispose();
    driverNameCtr.dispose();
    emptyTruckWeightCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(
                title: "Información del",
                subtitle: "camión" ,
                description: "Indique la información del camión para su registro en la romana",
              ),
              SizedBox(
                height: 28.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Información preliminar", style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),),
                    SizedBox(
                      height: 24.h,
                    ),
                    const CustomTile(
                        title: 'Número de guía',
                        subText: '10701'
                    ),
                    const CustomTile(
                        title: 'Nombre de buque',
                        subText: 'M.V. Patient Lake'
                    ),
                    const CustomTile(
                        title: 'Industria',
                        subText: 'C.A.C.S.A.'
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: context.textFieldColor,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                        controller: scanCtr,
                        hintText: '',
                        onChanged: (val){},
                        onFieldSubmitted: (val){},
                        obscure: false,
                        label: 'Placa',
                      inputType: TextInputType.number,
                      tailingIcon: InkWell(
                          onTap: (){},
                          splashColor: MyColors.transparentColor,
                          focusColor:  MyColors.transparentColor,
                          highlightColor:  MyColors.transparentColor,
                          child: Image.asset(AppAssets.scanIcon, scale: 2.2,)),
                    ),

                    CustomTextField(
                        controller: labelCtr,
                        hintText: '',
                        onChanged: (val){},
                        onFieldSubmitted: (val){},
                        obscure: false,
                        label: 'Marchamo'
                    ),

                    CustomTextField(
                        controller: driverNameCtr,
                        hintText: '',
                        onChanged: (val){},
                        onFieldSubmitted: (val){},
                        obscure: false,
                        label: 'Nombre de chofer (buscar por ID)',
                      tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2.2,),
                      readOnly: true,
                      onTap: (){
                        bottomSheetComponent(
                          context,
                          CoSelectChoferScreen(
                            selectChofer: (String name){
                              setState(() {
                                driverNameCtr.text = name;
                              });
                            },
                          ),
                          isDismissible: true,
                        );
                        // showModalBottomSheet(
                        //     backgroundColor: Colors.transparent,
                        //     elevation: 0,
                        //     context: context,
                        //     builder: (context) => CoSelectChoferScreen(
                        //       selectChofer: (String name){
                        //
                        //       },
                        //     ));
                      },
                    ),

                    CustomTextField(
                        controller: emptyTruckWeightCtr,
                        hintText: '',
                        onChanged: (val){},
                        onFieldSubmitted: (val){},
                        obscure: false,
                        label: 'Peso tara'
                    ),
                    SizedBox(
                      height: 63.h,
                    ),
                    Center(
                      child: CustomButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AppRoutes.coTruckBriefScreen);
                          },
                          buttonText: 'CONTINUAR'
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
  }
}
