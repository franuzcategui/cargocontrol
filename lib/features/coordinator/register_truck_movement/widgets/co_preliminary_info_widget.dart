import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../utils/constants/font_manager.dart';

class CoPreliminarInfoWidget extends StatelessWidget {
  final double guideNumber;
  final String vesselName;
  final String industryName;
  const CoPreliminarInfoWidget({Key? key, required this.guideNumber, required this.vesselName, required this.industryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Información preliminar", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        CustomTile(
            title: "Número de guía",
            subText: guideNumber.toStringAsFixed(0),
        ),
        CustomTile(
            title: "Nombre de buque",
            subText: vesselName
        ),
        CustomTile(
            title: "Industria",
            subText: industryName
        ),
      ],
    );
  }
}
