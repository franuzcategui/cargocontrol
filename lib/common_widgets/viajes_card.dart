import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class ViajesCard extends StatelessWidget {
  const ViajesCard({super.key});

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
                  'Camión Juan Perez - 135526',
                  style: const constants.TextStyles().bodyText1,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: constants.DecorationStyles.viajesChipDecoration,
                  child: Text(
                    'En camino',
                    style:
                        const constants.TextStyles(color: constants.kMainColor)
                            .chipText1,
                  ),
                ),
              ],
            ),
            Text(
              'Carga 40,340 - Paddy Rice',
              style: const constants.TextStyles().cardText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No Guia 10701',
                  style: const constants.TextStyles().bodyText1,
                ),
                Text(
                  'Hora de salida 20:55:12',
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
