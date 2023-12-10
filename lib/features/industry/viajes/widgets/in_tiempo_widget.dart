import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InTiempoWidget extends StatelessWidget {
  const InTiempoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tiempo de viaje", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        const CustomTile(
            title: "Hora de salida",
            subText: "16:02:20"
        ),
        const CustomTile(
            title: "Hora de llegada",
            subText: "21:40:20"
        ),
        const CustomTile(
            title: "Tiempo a destino",
            subText: "3:00:20"
        ),
        const CustomTile(
            title: "Tiempo promedio a destino",
            subText: "2:00:20"
        ),
        const CustomTile(
            title: "Tiempo de retraso",
            subText: "160630"
        ),
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
