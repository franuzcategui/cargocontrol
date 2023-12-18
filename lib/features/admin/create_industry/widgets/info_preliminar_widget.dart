import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_functions/date_formatter.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InfoPreliminarIndustryWidget extends StatelessWidget {

   InfoPreliminarIndustryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final adVesselNotiCtr = ref.read(adVesselNotiController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Información preliminar", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            CustomTile(
                title: "Nombre de buque",
                subText: adVesselNotiCtr.vesselModel?.vesselName ?? ''
            ),
             CustomTile(
                title: "Procedencia",
                subText: adVesselNotiCtr.vesselModel?.exitPort ?? "M.V. Patient Lake"
            ),
             CustomTile(
                title: "Shipper",
                subText: adVesselNotiCtr.vesselModel?.shipper ?? "Damboriarena"
            ),
             CustomTile(
                title: "Fecha en puerto",
                subText: formatDate(adVesselNotiCtr.vesselModel?.exitDate)
            ),
             CustomTile(
                title: "UN/Locode",
                subText: adVesselNotiCtr.vesselModel?.unlcode ?? "UYMVD"
            ),
          ],
        );
      },
    );
  }
}
