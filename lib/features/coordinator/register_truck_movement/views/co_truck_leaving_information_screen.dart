import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_functions/find_bodega_id_by_cargo_hold_id.dart';
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
              title: "Información del ",
              subtitle: "camión" ,
              description: "Indique la información del camión para su registro en la romana",
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
                        guideNumber: truckCtr.matchedViajes!.guideNumber.toStringAsFixed(0),
                        plateNumber: truckCtr.matchedViajes!.licensePlate.toString(),
                        chofereName: truckCtr.matchedViajes!.chofereName,
                        truckWeight: truckCtr.matchedViajes!.entryTimeTruckWeightToPort.toString(),
                        bodegaId: findCargoIndexById(truckCtr.vesselModel!.cargoModels,truckCtr.matchedViajes!.cargoId).toString(),
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
                        onlyNumber: true,
                          label: 'Peso bruto',
                        inputType: TextInputType.number,
                      ),
                      SizedBox(height: 25.h,),
                      CustomButton(
                          onPressed: (){
                            if(double.parse(fullTruckWeightCtr.text)<truckCtr.matchedViajes!.entryTimeTruckWeightToPort){
                              showSnackBar(context: context, content: 'Peso bruto cannot be less than peso tara!');
                              return;
                            }

                            truckCtr.allIndustriesModels.forEach((industry) {
                              if(industry.industryId == truckCtr.matchedViajes!.industryId){
                                truckCtr.setSelectedIndustry(industry);
                              }
                            });
                            if(fullTruckWeightCtr.text.isNotEmpty && truckCtr.selectedIndustry != null ){
                              double pureCargoWeight =   double.parse(fullTruckWeightCtr.text) - truckCtr.matchedViajes!.entryTimeTruckWeightToPort;
                              if(pureCargoWeight <= (truckCtr.selectedIndustry!.cargoAssigned-truckCtr.selectedIndustry!.cargoUnloaded)){
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.coTruckLeavingBriefScreen,
                                    arguments: {
                                      'fullTruckWeight': double.parse(fullTruckWeightCtr.text),
                                      'pureCargoWeight': pureCargoWeight,
                                    }
                                );
                              }else{
                                showSnackBar(context: context, content: 'Peso bruto is more then total carga! Max is can be ${(truckCtr.selectedIndustry!.cargoAssigned-truckCtr.selectedIndustry!.cargoUnloaded)}');
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

