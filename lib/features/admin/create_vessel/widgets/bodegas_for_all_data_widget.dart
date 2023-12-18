import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../utils/constants/font_manager.dart';

class BodegasForAllData extends StatelessWidget {
  final List<VesselCargoModel> carogModels;
  const BodegasForAllData({Key? key, required this.carogModels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: carogModels.length,
      itemBuilder: (BuildContext context, int index) {
        VesselCargoModel model = carogModels[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bodega #${index+1}", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            CustomTile(
              title: 'Producto',
              subText: model.productName,
            ),
            CustomTile(
              title: 'Tipo',
              subText: model.tipo,
            ),
            CustomTile(
              title: 'Origin',
              subText: model.origen,
            ),
            CustomTile(
              title: 'Cosecha',
              subText: model.cosecha,
            ),
            CustomTile(
              title: 'Variedad',
              subText: model.variety,
            ),
            CustomTile(
              title: 'Carga',
              subText: model.pesoTotal.toString(),
            ),
          ],
        );
      },

    );
  }
}
