import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_functions/date_formatter.dart';
import '../../../../commons/common_imports/common_libs.dart';

class CoRecentRecordCard extends StatelessWidget {
  final bool isEntered;
  final bool isLeaving;
  final String driverName;
  final String guideNumber;
  final DateTime portEntryTime;
  const CoRecentRecordCard({Key? key, required this.isEntered, required this.isLeaving, required this.driverName, required this.guideNumber, required this.portEntryTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CustomTile(
          title: driverName,
          subText: isEntered? 'Entrada': 'Salida',
          isGoodSign: isEntered,
          hasWarning: isLeaving,
        ),
        CustomTile(
          title: guideNumber,
          subText: formatDateTimeForRecentRegisteries(portEntryTime),
        ),
        SizedBox(height: 10.h,),
        Divider(
          height: 1.h,
          color: context.textFieldColor,
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
