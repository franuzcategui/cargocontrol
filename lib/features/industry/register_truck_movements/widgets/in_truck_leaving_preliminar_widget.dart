import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InTruckLeavingPreliminarInfoWidget extends StatelessWidget {
  const InTruckLeavingPreliminarInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ViajesModel model = ref.watch(inTruckRegistrationNotiControllerProvider).matchedViajes!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Información del camión", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            CustomTile(
                title: "Número de guía",
                subText: model.guideNumber.toStringAsFixed(0)
            ),
            CustomTile(
                title: "Nombre de buque",
                subText: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel!.vesselName
            ),
            CustomTile(
                title: "Industria",
                subText: ref.read(inTruckRegistrationNotiControllerProvider).currentIndustryModel!.industryName
            ),

          ],
        );
      },
    );
  }
}
