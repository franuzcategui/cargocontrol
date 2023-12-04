import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class RegistrationSuccessFullScreen extends StatelessWidget {
  const RegistrationSuccessFullScreen({Key? key}) : super(key: key);

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
            CustomButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.adminMainMenuScreen, (route) => false);
                },
                buttonText: "CONTINUAR",
            ),
            SizedBox(height: 42.h,)
          ],
        ),
      ),
    );
  }
}
