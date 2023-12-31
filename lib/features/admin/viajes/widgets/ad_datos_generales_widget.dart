import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';

class AdDatosGeneralesWidget extends StatelessWidget {
  const AdDatosGeneralesWidget({Key? key, required this.viajesModel}) : super(key: key);
 final ViajesModel viajesModel;


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
        CustomTile(
            title: "Número de guía",
            subText:viajesModel.guideNumber.toStringAsFixed(0),
        ),
        // todo usman: fetch vessel name by vessel Id
        const CustomTile(
            title: "Nombre de buque",
            subText: 'M.V. Patient Lake'
        ),
        // todo usman: fetch industry name by id
        const CustomTile(
            title: "Industria",
            subText: "C.A.C.S.A."
        ),
        const CustomTile(
            title: "Bodega",
            subText: "5"
        ),
       CustomTile(
            title: "Placa",
            subText: viajesModel.licensePlate.toString()
        ),
      ],
    );
  }
}
