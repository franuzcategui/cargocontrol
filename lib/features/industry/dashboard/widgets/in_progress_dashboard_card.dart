import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class InProgressIndicatorCard extends StatelessWidget {
  final String title;
  final String deficit;
  final double barPercentage;
  final String divideNumber1;
  final String divideNumber2;
  final String numberOfTrips;
  const InProgressIndicatorCard({
    super.key, required this.title, required this.barPercentage, required this.divideNumber1, required this.divideNumber2, required this.numberOfTrips, required this.deficit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        width: 320.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 220.w
                  ),
                  child: Text(
                    title,
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ),
                SizedBox(width: 10.w,),
                deficit == '' || deficit == "0"?const SizedBox():
                Expanded(
                  child: Text(
                    'Deficit: $deficit',
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '${divideNumber1}/${divideNumber2}',
              style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 2.h,
            ),
            LinearProgressIndicator(
              backgroundColor: const Color.fromRGBO(239, 240, 244, 1),
              color: constants.kMainColor,
              value: barPercentage,
              minHeight: 5.h,
              borderRadius: BorderRadius.circular(20.r),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(barPercentage*100).toStringAsFixed(2)}%',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                Text(
                  'Viajes: ${numberOfTrips}',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
