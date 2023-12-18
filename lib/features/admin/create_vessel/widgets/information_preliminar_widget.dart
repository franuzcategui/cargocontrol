import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class InformationPreliminarWidget extends StatelessWidget {
  final String vesselName;
  final String procedencia;
  final String shipper;
  final DateTime entryDate;
  final String unlcode;
  const InformationPreliminarWidget({Key? key, required this.vesselName, required this.procedencia, required this.shipper, required this.entryDate, required this.unlcode}) : super(key: key);

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
            title: "Nombre de buque",
            subText: vesselName
        ),
        CustomTile(
            title: "Procedencia",
            subText: procedencia
        ),
        CustomTile(
            title: "Shipper",
            subText: shipper
        ),
        CustomTile(
            title: "Fecha en puerto",
            subText: DateFormat('dd/MM/yyyy').format(entryDate)
        ),
        CustomTile(
            title: "UN/Locode",
            subText: unlcode
        ),
      ],
    );
  }
}
