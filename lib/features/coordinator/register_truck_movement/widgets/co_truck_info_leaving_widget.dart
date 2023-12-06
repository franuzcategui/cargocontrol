import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTruckInfoLeavingWidget extends StatelessWidget {
  const CoTruckInfoLeavingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Información del camión", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        const CustomTile(
            title: "Placa",
            subText: "135526"
        ),
        const CustomTile(
            title: "Nombre de chofer",
            subText: "Juan Perez."
        ),
        const CustomTile(
            title: "Peso tara",
            subText: "12690"
        ),
        const CustomTile(
            title: "Peso bruto",
            subText: "40,340"
        ),
        const CustomTile(
            title: "Número de bodega",
            subText: "4"
        ),
      ],
    );
  }
}
