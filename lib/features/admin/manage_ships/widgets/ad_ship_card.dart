import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/ships_bottom_sheet.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class AdShipCard extends StatelessWidget {
  const AdShipCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: constants.DecorationStyles.shadow2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Montevideo',
                  style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                Row(
                  children: [
                    Text(
                      'Fecha de salida:',
                      style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                    ),
                    Text(
                      ' En puerto',
                      style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 14.h,),
            Text(
              'MV Ejemplo',
              style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size14),
            ),
            SizedBox(height: 14.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Damboriarena',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        context: context,
                        isDismissible: true,
                        builder: (context) => const ShipsBottomSheet());
                  },
                  child: Text(
                    'Descargar',
                    style: getBoldStyle(color: context.mainColor, fontSize: MyFonts.size12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
