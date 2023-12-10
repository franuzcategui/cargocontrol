import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InTruckLeavingDelCamionWidget extends StatelessWidget {
  const InTruckLeavingDelCamionWidget({Key? key}) : super(key: key);

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

        //
        const CustomTile(
            title: "Placa",
            subText: "135526"
        ),
        const CustomTile(
            title: "Nombre de chofer",
            subText: "Juan Perez"
        ),
        const CustomTile(
            title: "Producto",
            subText: "Paddy Rice"
        ),
        const CustomTile(
            title: "Número de bodega",
            subText: "4"
        ),
        const CustomTile(
            title: "Peso tara",
            subText: "12,690"
        ),
        const CustomTile(
            title: "Peso bruto de salida",
            subText: "40,340"
        ),
        const CustomTile(
            title: "Peso bruto de llegada",
            subText: "40,331"
        ),
      ],
    );
  }
}
