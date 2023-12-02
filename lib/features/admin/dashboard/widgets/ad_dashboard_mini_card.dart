import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class AdDashboardMiniCard extends StatelessWidget {
  final String title;
  final String value;
  const AdDashboardMiniCard({
    super.key, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: EdgeInsets.all(16.sp),
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
            ),

            Text(
              value,
              style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size24),
            ),
          ],
        ),
      ),
    );
  }
}
