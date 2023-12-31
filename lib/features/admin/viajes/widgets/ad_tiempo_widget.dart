import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class AdTiempoWidget extends StatelessWidget {
  const AdTiempoWidget({Key? key, required this.viajesModel}) : super(key: key);
  final ViajesModel viajesModel;

  String formatDuration(Duration duration) {
    DateTime referenceTime = DateTime(2000, 1, 1, 0, 0, 0);
    DateTime formattedTime = referenceTime.add(duration);
    DateFormat formatter = DateFormat('H:mm:ss');
    return formatter.format(formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    if (viajesModel.viajesStatusEnum.type == ViajesStatusEnum.portEntered.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(height: 20.h,),
          Center(
            child: Text(
              "Viajes Has Not left Port Yet",
              style: getMediumStyle(
                color: context.textColor,
                fontSize: MyFonts.size12,
              ),
            ),
          ),
          SizedBox(height: 20.h,),


        ],
      );
    } else  if (viajesModel.viajesStatusEnum.type == ViajesStatusEnum.portLeft.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          CustomTile(
              title: "Hora de salida",
              subText:
              DateFormat('HH:mm:ss').format(viajesModel.exitTimeToPort)),
        ],
      );
    }
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          CustomTile(
              title: "Hora de salida",
              subText:
              DateFormat('HH:mm:ss').format(viajesModel.exitTimeToPort)),
          CustomTile(
              title: "Hora de llegada",
              subText:
              DateFormat('HH:mm:ss').format(viajesModel.timeToIndustry)),
          CustomTile(
            title: "Tiempo a destino",
            subText: formatDuration(viajesModel.timeToIndustry
                .difference(viajesModel.exitTimeToPort)),
          ),
          CustomTile(title: "Tiempo promedio a destino", subText: "2:00:20"),
          const CustomTile(
            title: "Tiempo de retraso",
            subText: "1:00:00",
            hasWarning: true,
          ),
          const CustomTile(
            title: "Tiempo promedio de retraso chofer",
            subText: "2:00:00",
            hasWarning: true,
          ),
        ],
      );
    }
  }
}
