import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../controllers/in_truck_registration_noti_controller.dart';
import '../widgets/in_truck_leaving_del_camion_widget.dart';
import '../widgets/in_truck_leaving_preliminar_widget.dart';

class InTruckUnlaodingBriefScreen extends ConsumerStatefulWidget {
  final double cargoUnloadWeight;
  const InTruckUnlaodingBriefScreen({Key? key, required this.cargoUnloadWeight}) : super(key: key);

  @override
  ConsumerState<InTruckUnlaodingBriefScreen> createState() => _InTruckUnlaodingBriefScreenState();
}

class _InTruckUnlaodingBriefScreenState extends ConsumerState<InTruckUnlaodingBriefScreen> {


  @override
  void initState() {
    super.initState();
    initiallization();
  }

  initiallization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await ref.read(inTruckRegistrationNotiControllerProvider).getViajesCargo(
          vesselId: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel!.vesselId,
          cargoId: ref.read(inTruckRegistrationNotiControllerProvider).matchedViajes!.cargoId,
          context: context,
          ref: ref
      );
    });
  }

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
                  const InTruckLeavingPreliminarInfoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  InTruckLeavingDelCamionWidget(
                    cargoUnloadWeight: widget.cargoUnloadWeight,
                  ),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),

                  SizedBox(height: 26.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                        isLoading: ref.watch(inTruckRegistrationNotiControllerProvider).isLoading,
                        onPressed: ()async{
                            await ref.read(inTruckRegistrationNotiControllerProvider).getChoferesModel(
                              ref: ref,
                              context: context,
                              nationalIdNumber: ref.read(inTruckRegistrationNotiControllerProvider).matchedViajes!.chofereId
                            );

                            if(ref.read(inTruckRegistrationNotiControllerProvider).viajesChoferesModel!= null){
                              await ref.read(inTruckRegistrationControllerProvider.notifier).registerTruckUnloadingInIndustry(
                                choferesModel: ref.read(inTruckRegistrationNotiControllerProvider).viajesChoferesModel!,
                                cargoUnloadWeight: widget.cargoUnloadWeight,
                                industrySubModel: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel!,
                                viajesModel: ref.read(inTruckRegistrationNotiControllerProvider).matchedViajes!,
                                context: context,
                                ref: ref,
                              );
                            }
                          },
                          buttonText: "CONFIRMAR"
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

