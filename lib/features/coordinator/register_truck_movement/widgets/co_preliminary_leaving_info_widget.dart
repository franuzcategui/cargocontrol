import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoPreliminarLeavingInfoWidget extends StatelessWidget {
  final String guideNumber;
  final String plateNumber;
  final String chofereName;
  final String truckWeight;
  final String bodegaId;
  const CoPreliminarLeavingInfoWidget({Key? key, required this.guideNumber, required this.plateNumber, required this.chofereName, required this.truckWeight, required this.bodegaId}) : super(key: key);

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
        CustomTile(
            title: "Número de guía",
            subText: guideNumber
        ),
        CustomTile(
            title: "Placa",
            subText: plateNumber
        ),
        CustomTile(
            title: "Nombre del chofer",
            subText: chofereName
        ),
        CustomTile(
            title: "Peso tara",
            subText: truckWeight
        ),
        CustomTile(
            title: "Bogeda ID",
            subText: bodegaId
        ),
      ],
    );
  }
}
