import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';

class AdRecentRecordCard extends StatelessWidget {
  final bool isEntered;
  final bool isLeaving;
  const AdRecentRecordCard({Key? key, required this.isEntered, required this.isLeaving}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CustomTile(
          title: 'Juan Perez',
          subText: isEntered? 'Entrada': 'Salida',
          isGoodSign: isEntered,
          hasWarning: isLeaving,
        ),
        const CustomTile(
          title: '10701',
          subText: '12/2/22 2:00:12',
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
