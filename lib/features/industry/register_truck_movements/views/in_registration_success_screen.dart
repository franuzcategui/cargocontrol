import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../controllers/in_truck_registration_noti_controller.dart';

class InRegistrationSuccessFullScreen extends StatelessWidget {
  const InRegistrationSuccessFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 812.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(AppAssets.logo, height: 78.h, width: 290.w,),
            ),
            Text(
              "Su registro ha sido exitoso",
              style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return CustomButton(
                  onPressed: ()async{
                    await ref.read(inTruckRegistrationNotiControllerProvider).setMatchedViajes(null);
                    await ref.read(inTruckRegistrationNotiControllerProvider).setCurrentIndustry(null);
                    await ref.read(inTruckRegistrationNotiControllerProvider).setViajesCargoModel(null);
                    await ref.read(inTruckRegistrationNotiControllerProvider).setViajesChoferesModel(null);
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.inMainMenuScreen, (route) => false);
                  },
                  buttonText: "CONTINUAR",
                );
              },
            ),
            SizedBox(height: 42.h,)
          ],
        ),
      ),
    );
  }
}
