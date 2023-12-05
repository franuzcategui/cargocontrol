import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InformationPreliminarWidget extends StatelessWidget {
  const InformationPreliminarWidget({Key? key}) : super(key: key);

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
            title: "Nombre de buque",
            subText: "10701"
        ),
        const CustomTile(
            title: "Procedencia",
            subText: "M.V. Patient Lake"
        ),
        const CustomTile(
            title: "Shipper",
            subText: "Damboriarena"
        ),
        const CustomTile(
            title: "Fecha en puerto",
            subText: "17/6/2023"
        ),
        const CustomTile(
            title: "UN/Locode",
            subText: "UYMVD"
        ),
      ],
    );
  }
}
