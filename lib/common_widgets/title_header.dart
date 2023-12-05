import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool logo;
  const TitleHeader({super.key, this.title, this.subtitle, this.logo = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        logo
            ? Image.asset(constants.Images.logo, height: 78.h, width: 290.w,)
            : Column(
                children: [
                  Text(title!, style: const constants.TextStyles().titleText3),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle!,
                    style: const constants.TextStyles().subtitleText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Divider(
                thickness: 4.w,
                color: context.mainColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Divider(
                thickness: 4.w,
                color: context.tertiaryMainColor,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 4.w,
                color: context.quaternaryMainColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
