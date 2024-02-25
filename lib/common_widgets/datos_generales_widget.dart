import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/custom_editable_tile.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';

class DatosGeneralesWidget extends StatelessWidget {
  const DatosGeneralesWidget({Key? key, required this.viajesModel, required this.onGuideNumberEdit})
      : super(key: key);
  final ViajesModel viajesModel;
  final Function() onGuideNumberEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Datos generales",
          style: getBoldStyle(
            color: context.textColor,
            fontSize: MyFonts.size14,
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        CustomEditableTile(
          title: "Número de guía",
          subText: viajesModel.guideNumber.toStringAsFixed(0),
          onTap: onGuideNumberEdit,
        ),
        CustomTile(title: "Nombre de buque", subText: viajesModel.vesselName),
        CustomTile(title: "Industria", subText: viajesModel.industryName),
        CustomTile(
            title: "Bodega", subText: viajesModel.cargoHoldCount.toString()),
        CustomTile(
            title: "Placa", subText: viajesModel.licensePlate.toString()),
      ],
    );
  }
}
