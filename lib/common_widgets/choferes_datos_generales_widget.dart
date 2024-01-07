import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';

class ChoferesDatosGeneralesWidget extends StatelessWidget {
  const ChoferesDatosGeneralesWidget({Key? key, required this.choferesModel}) : super(key: key);
 final ChoferesModel choferesModel;


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
            title: "Nombre",
            subText:choferesModel.firstName,
        ),
        if(choferesModel.lastName!="")
        CustomTile(
            title: "Apellido",
            subText: choferesModel.lastName
        ),
       CustomTile(
            title: "ID",
            subText: choferesModel.choferNationalId
        ),
       CustomTile(
            title: "Registro inicial",
            subText: ""
        ),
       CustomTile(
            title: "Puntuación",
            subText: ""
        ),
      ],
    );
  }
}
