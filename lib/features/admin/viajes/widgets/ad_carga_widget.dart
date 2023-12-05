import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class AdCargaWidget extends StatelessWidget {
  const AdCargaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Carga", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        const CustomTile(
            title: "Producto (Variedad)",
            subText: "Paddy Rice"
        ),
        const CustomTile(
            title: "Peso bruto de salida",
            subText: "40,340"
        ),
        const CustomTile(
            title: "Peso bruto de llegada",
            subText: "40,340"
        ),
        const CustomTile(
            title: "Peso tara ",
            subText: "12,690"
        ),
        const CustomTile(
            title: "Peso neto de llegada",
            subText: "27,641"
        ),
        const CustomTile(
            title: "Deficit de chofer",
            subText: "9",
          isGoodSign: true,
        ),
        const CustomTile(
          title: "Deficit promedio industria",
          subText: "20",
        ),
        const CustomTile(
          title: "Deficit promedio de chofer",
          subText: "10",
          isGoodSign: true,
        ),
      ],
    );
  }
}
