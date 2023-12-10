import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTruckInfoWidget extends StatelessWidget {
  const CoTruckInfoWidget({Key? key}) : super(key: key);

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
            title: "Marchamo",
            subText: "3462343"
        ),
        const CustomTile(
            title: "Nombre de chofer",
            subText: "Juan Perez."
        ),
        const CustomTile(
            title: "Peso tara",
            subText: "12690"
        ),
      ],
    );
  }
}
