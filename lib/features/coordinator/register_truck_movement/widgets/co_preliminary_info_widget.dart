import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoPreliminarInfoWidget extends StatelessWidget {
  const CoPreliminarInfoWidget({Key? key}) : super(key: key);

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
            title: "Nombre de buque",
            subText: "M.V. Patient Lake"
        ),
        const CustomTile(
            title: "Industria",
            subText: "C.A.C.S.A."
        ),
      ],
    );
  }
}
