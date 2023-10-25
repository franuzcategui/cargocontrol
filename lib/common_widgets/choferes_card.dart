import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class ChoferesCard extends StatelessWidget {
  const ChoferesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        height: 100,
        width: 400,
        decoration: constants.DecorationStyles.shadow2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID 20348',
                  style: const constants.TextStyles().bodyText1,
                ),
                Text(
                  'Viajes 25',
                  style: const constants.TextStyles().bodyText1,
                ),
              ],
            ),
            Text(
              'Juan Perez - 4.8',
              style: const constants.TextStyles().cardText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deficit 500',
                  style: const constants.TextStyles().bodyText1,
                ),
                Text(
                  'Retraso promedio 1:00:00',
                  style: const constants.TextStyles().bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
