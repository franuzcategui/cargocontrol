import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class AdDatosGeneralesWidget extends StatelessWidget {
  const AdDatosGeneralesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Datos generales", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        const CustomTile(
            title: "Número de guía",
            subText: "10701"
        ),
        const CustomTile(
            title: "Nombre de buque",
            subText: "M.V. Patient Lake"
        ),
        const CustomTile(
            title: "Industria",
            subText: "C.A.C.S.A."
        ),
        const CustomTile(
            title: "Bodega",
            subText: "5"
        ),
        const CustomTile(
            title: "Placa",
            subText: "160630"
        ),
      ],
    );
  }
}
