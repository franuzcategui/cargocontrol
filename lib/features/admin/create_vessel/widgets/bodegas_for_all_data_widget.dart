import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class BodegasForAllData extends StatelessWidget {
  const BodegasForAllData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bodega #1", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            const CustomTile(
              title: 'Producto',
              subText: 'Paddy Rice',
            ),
            const CustomTile(
              title: 'Variedad',
              subText: 'Paddy Rice',
            ),
            const CustomTile(
              title: 'Carga',
              subText: '5592884',
            ),
          ],
        );
      },

    );
  }
}
