import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CustomEditableTile extends StatelessWidget {
  final String title;
  final String subText;
  final bool hasWarning;
  final bool isGoodSign;
  final Function() onTap;
  const CustomEditableTile(
      {Key? key,
      required this.title,
      required this.subText,
      this.hasWarning = false,
      this.isGoodSign = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.h,
        top: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: getRegularStyle(
                    color: context.textColor,
                    fontSize: MyFonts.size12,
                  ),
                ),
                InkWell(
                    splashColor: Colors.transparent,
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0.h),
                      child: Icon(Icons.edit ,size: 20.w,),
                    )),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 150.w, minWidth: 65.w),
            child: Text(
              subText,
              style: getRegularStyle(
                color: hasWarning
                    ? context.errorColor
                    : isGoodSign
                        ? context.brandColor
                        : context.textColor,
                fontSize: MyFonts.size12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
