import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class ProgressIndicatorCard extends StatelessWidget {
  const ProgressIndicatorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: const EdgeInsets.all(20),
        height: 100,
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descarga total',
              style: const constants.TextStyles().cardTitle1,
            ),
            const SizedBox(
              height: 4,
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
