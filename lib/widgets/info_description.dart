import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class InfoDescription extends StatelessWidget {
  const InfoDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información preliminar',
              style: const constants.TextStyles().infoTitle1,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Número de guía',
                    style: const constants.TextStyles().bodyText1,
                  ),
                  Text(
                    '45353454324',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Número de guía',
                    style: const constants.TextStyles().bodyText1,
                  ),
                  Text(
                    '45353454324',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Número de guía',
                    style: const constants.TextStyles().bodyText1,
                  ),
                  Text(
                    '45353454324',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Número de guía',
                    style: const constants.TextStyles().bodyText1,
                  ),
                  Text(
                    '45353454324',
                    style: const constants.TextStyles().bodyText1,
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
