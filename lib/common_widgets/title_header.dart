import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

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
            ? Image.asset(constants.Images.logo)
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
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Divider(
                  thickness: 4,
                  color: constants.kMainColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Divider(
                  thickness: 4,
                  color: constants.kTertiaryMainColor,
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 4,
                  color: constants.kQuaternaryMainColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
