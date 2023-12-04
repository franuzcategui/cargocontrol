import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class IndustriesForAllData extends StatelessWidget {
  const IndustriesForAllData({Key? key}) : super(key: key);

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
            Text("Industria #1", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            const CustomTile(
              title: 'Nombre',
              subText: 'C.A.C.S.A',
            ),
            const CustomTile(
              title: 'Comienzo de guia',
              subText: '1000',
            ),
            const CustomTile(
              title: 'Final de guia',
              subText: '2000',
            ),
            const CustomTile(
              title: 'Producto (Variedad)',
              subText: 'Paddy Rice',
            ),
            const CustomTile(
              title: 'Carga',
              subText: '6991105',
            ),
          ],
        );
      },

    );
  }
}
