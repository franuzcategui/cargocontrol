import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subText;
  const CustomTile({Key? key, required this.title, required this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.h,
        top:  8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: getRegularStyle(
            color: context.textColor,
            fontSize: MyFonts.size12,
          ),),
          Text(subText, style: getRegularStyle(
            color: context.textColor,
            fontSize: MyFonts.size12,
          ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
