import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class DashboardMiniCard extends StatelessWidget {
  const DashboardMiniCard({
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
        width: 147,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              '0',
              style: const constants.TextStyles().cardText1,
            ),
          ],
        ),
      ),
    );
  }
}
