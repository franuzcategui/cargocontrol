import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTruckInfoWidget extends StatelessWidget {
  final String plateNumber;
  final double marchamo;
  final String choferName;
  final double emptyTruckWeight;
  const CoTruckInfoWidget({Key? key, required this.plateNumber, required this.marchamo, required this.choferName, required this.emptyTruckWeight}) : super(key: key);

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
        CustomTile(
            title: 'Placa',
            subText: plateNumber
        ),
        CustomTile(
            title: 'Marchamo',
            subText: "$marchamo"
        ),
        CustomTile(
            title: 'Nombre de chofer',
            subText: choferName
        ),
        CustomTile(
            title: 'Peso tara',
            subText: '$emptyTruckWeight'
        ),
      ],
    );
  }
}
