import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/ships_lists.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';

class AdManageShipsScreen extends StatelessWidget {
  const AdManageShipsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Registro de buques", style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
             SizedBox(height: 24.h,),
             AdShipsList(),

          ],
        ),
      ),
    );
  }
}
