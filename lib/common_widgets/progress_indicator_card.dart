import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class ProgressIndicatorCard extends StatelessWidget {
  const ProgressIndicatorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: EdgeInsets.all(20.sp),
        height: 100.h,
        width: 320.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descarga total',
              style: const constants.TextStyles().cardTitle1,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '0/0',
              style: const constants.TextStyles().cardText1,
            ),
            const SizedBox(
              height: 2,
            ),
            const LinearProgressIndicator(
              backgroundColor: Color.fromRGBO(239, 240, 244, 1),
              color: constants.kMainColor,
              value: 0.5,
              minHeight: 5,
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '5%',
                  style: const constants.TextStyles().bodyText1,
                ),
                Text(
                  'Viajes: 10',
                  style: const constants.TextStyles().bodyText1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
