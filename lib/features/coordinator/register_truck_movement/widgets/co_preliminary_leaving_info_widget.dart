import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoPreliminarLeavingInfoWidget extends StatelessWidget {
  const CoPreliminarLeavingInfoWidget({Key? key}) : super(key: key);

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
        const CustomTile(
            title: "Número de guía",
            subText: "10701"
        ),
        const CustomTile(
            title: "Placa",
            subText: "135526"
        ),
        const CustomTile(
            title: "Nombre del chofer",
            subText: "Juan Perez"
        ),
        const CustomTile(
            title: "Peso tara",
            subText: "12690"
        ),
      ],
    );
  }
}
