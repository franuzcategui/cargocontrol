import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../widgets/co_preliminary_info_widget.dart';
import '../widgets/co_truck_info_widget.dart';

class CoTruckBriefScreen extends ConsumerStatefulWidget {
  final double guideNumber;
  final String plateNumber;
  final double marchamo;
  final double emptyTruckWeight;
  const CoTruckBriefScreen({Key? key, required this.guideNumber, required this.plateNumber, required this.marchamo, required this.emptyTruckWeight}) : super(key: key);

  @override
  ConsumerState<CoTruckBriefScreen> createState() => _CoTruckBriefScreenState();
}

class _CoTruckBriefScreenState extends ConsumerState<CoTruckBriefScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "" ,
              logo: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h,),
                  Text("Resumen de registro de camión", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final truckNotiCtr = ref.read(truckRegistrationNotiControllerProvider);
                      return Column(
                        children: [
                          CoPreliminarInfoWidget(
                            guideNumber: widget.guideNumber,
                            vesselName: truckNotiCtr.selectedIndustry?.vesselName ?? '',
                            industryName: truckNotiCtr.selectedIndustry?.industryName ?? '',
                          ),
                          SizedBox(height: 20.h,),
                          Divider(height: 1.h,color: context.textFieldColor,),
                          SizedBox(height: 28.h,),
                          CoTruckInfoWidget(
                            choferName: '${truckNotiCtr.selectedChofere?.firstName}',
                            emptyTruckWeight: widget.emptyTruckWeight,
                            marchamo: widget.marchamo,
                            plateNumber: widget.plateNumber,
                          ),
                          SizedBox(height: 20.h,),
                          Divider(height: 1.h,color: context.textFieldColor,),

                          SizedBox(height: 26.h,),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              return CustomButton(
                                isLoading: ref.watch(truckRegistrationControllerProvider),
                                onPressed: ()async{
                                  if(truckNotiCtr.selectedChofere!= null){
                                    await ref.watch(truckRegistrationControllerProvider.notifier).registerTruckEnteringToPort(
                                        choferesModel: truckNotiCtr.selectedChofere!,
                                        guideNumber: widget.guideNumber,
                                        plateNumber: widget.plateNumber,
                                        marchamo: widget.marchamo,
                                        emptyTruckWeight: widget.emptyTruckWeight,
                                        vesselName: truckNotiCtr.selectedIndustry?.vesselName ?? '',
                                        industryName: truckNotiCtr.selectedIndustry?.industryName ?? '',
                                        industryId: truckNotiCtr.selectedIndustry?.industryId ?? '',
                                        productName: truckNotiCtr.selectedIndustry?.selectedVesselCargo.productName ?? '',
                                        choferesname: truckNotiCtr.selectedChofere?.firstName?? '',
                                        choferesId: truckNotiCtr.selectedChofere?.choferNationalId?? '',
                                        industrySubModel: truckNotiCtr.selectedIndustry!,
                                        cargoId: truckNotiCtr.selectedIndustry?.selectedVesselCargo.cargoId ?? '',
                                        ref: ref,
                                        context: context
                                    );
                                  }
                                },
                                buttonText: "CONFIRMAR"
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

