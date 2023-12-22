import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../controllers/in_truck_registration_noti_controller.dart';
import '../widgets/in_preminar_info_widget.dart';

class InTruckArrivalInfoScreen extends StatefulWidget {
  const InTruckArrivalInfoScreen({Key? key}) : super(key: key);

  @override
  State<InTruckArrivalInfoScreen> createState() => _InTruckArrivalInfoScreenState();
}

class _InTruckArrivalInfoScreenState extends State<InTruckArrivalInfoScreen> {

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

                  SizedBox(height: 28.h,),
                  const InPreliminarInfoWidget(),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  SizedBox(height: 226.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final truckCtr = ref.watch(inTruckRegistrationNotiControllerProvider);
                      return CustomButton(
                          onPressed: ()async{
                            ref.read(inTruckRegistrationControllerProvider.notifier).registerTruckEnteringInIndustry(
                                viajesModel: truckCtr.matchedViajes!,
                                industrySubModel: truckCtr.currentIndustryModel!,
                                ref: ref,
                                context: context
                            );
                            Navigator.pushNamed(context, AppRoutes.inRegistrationSuccessFullScreen);
                          },
                          buttonText: "REGISTRAR LLEGADA"
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

