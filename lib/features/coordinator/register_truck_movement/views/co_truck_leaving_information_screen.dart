import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/co_preliminary_leaving_info_widget.dart';

class CoTruckLeavingInformationScreen extends StatefulWidget {
  const CoTruckLeavingInformationScreen({Key? key}) : super(key: key);

  @override
  State<CoTruckLeavingInformationScreen> createState() => _CoTruckLeavingInformationScreenState();
}

class _CoTruckLeavingInformationScreenState extends State<CoTruckLeavingInformationScreen> {

  final fullTruckWeightCtr = TextEditingController();

  @override
  void dispose() {
    fullTruckWeightCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(
              title: "Información del",
              subtitle: "buque" ,
              description: "Indique la información del buque a registrar",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final truckCtr = ref.watch(truckRegistrationNotiControllerProvider);
                  return Column(
                    children: [
                      SizedBox(height: 28.h,),
                      CoPreliminarLeavingInfoWidget(
                        guideNumber: truckCtr.matchedViajes!.guideNumber.toString(),
                        plateNumber: truckCtr.matchedViajes!.licensePlate.toString(),
                        chofereName: truckCtr.matchedViajes!.chofereName,
                        truckWeight: truckCtr.matchedViajes!.entryTimeTruckWeightToPort.toString(),
                        bodegaId: truckCtr.matchedViajes!.cargoId.toString(),
                      ),
                      SizedBox(height: 20.h,),
                      Divider(height: 1.h,color: context.textFieldColor,),
                      SizedBox(height: 20.h,),

                      // SizedBox(height: 28.h,),
                      // ref.watch(getCurrentIndusry).when(
                      //     data: (currentIndustry){
                      //       return  NumberOfCargoHoldsWidget(
                      //         numberOfCargoHolds: currentIndustry.selectedVesselCargo.,
                      //         seletedCargosNumber: (int selectedValue){},
                      //       );
                      //     },
                      //     error: (error, st){
                      //       debugPrintStack(stackTrace: st);
                      //       debugPrint(error.toString());
                      //       return SizedBox.shrink();
                      //     },
                      //     loading: (){
                      //       return LoadingWidget(
                      //         loadingType: SpinKitPianoWave(
                      //           size: 20.sp,
                      //         ),
                      //       );
                      //     }
                      // ),
                      CustomTextField(
                          controller: fullTruckWeightCtr,
                          hintText: '',
                          onChanged: (val){},
                          onFieldSubmitted: (val){},
                          obscure: false,
                          label: 'Peso bruto',
                        inputType: TextInputType.number,
                      ),
                      SizedBox(height: 25.h,),
                      CustomButton(
                          onPressed: (){
                            if(fullTruckWeightCtr.text.isNotEmpty && truckCtr.selectedIndustry!= null){
                              double pureCargoWeight =   double.parse(fullTruckWeightCtr.text) - truckCtr.matchedViajes!.entryTimeTruckWeightToPort;
                              print('Entered Cargo Weight ${pureCargoWeight}');
                              print('Assigned Cargo ${truckCtr.selectedIndustry!.cargoAssigned}');
                              if(pureCargoWeight <= truckCtr.selectedIndustry!.cargoAssigned){
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.coTruckLeavingBriefScreen,
                                    arguments: {
                                      'fullTruckWeight': double.parse(fullTruckWeightCtr.text),
                                      'pureCargoWeight': pureCargoWeight,
                                    }
                                );
                              }else{
                                showSnackBar(context: context, content: 'Peso bruto is more then total carga!');
                              }
                            }else{
                              showSnackBar(context: context, content: 'Enter Peso bruto!');
                            }
                          },
                          buttonText: "CONTINUAR"
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

