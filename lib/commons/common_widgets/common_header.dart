import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  const CommonHeader({super.key, required this.title, required this.subtitle, required this.description,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28)),
            Text(
              subtitle,
                style: getBoldStyle(color: context.mainColor, fontSize: MyFonts.size28)),
          ],
        ),
        Text(
            description,
            style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Divider(
                thickness: 4.h,
                color: context.mainColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Divider(
                thickness: 4.h,
                color:  context.tertiaryMainColor,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 4.h,
                color:  context.quaternaryMainColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
