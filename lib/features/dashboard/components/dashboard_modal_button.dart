import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class DashboardModalButton extends StatelessWidget {
  final String title1;
  final String title2;
  final String subtitle;
  final bool isDisable;
  final void Function() onTap;
  const DashboardModalButton(
      {super.key,
      required this.title1,
      required this.title2,
      required this.subtitle,
      this.isDisable = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: OutlinedButton(
        onPressed: isDisable ? null: onTap,
        style: constants.ButtonStyles.buttonStyle3,

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              text: '$title1 ',
              style:
                  const constants.TextStyles(color: Colors.black).buttonText2,
              children: [
                TextSpan(
                  text: title2,
                  style: const constants.TextStyles().buttonText2,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subtitle,
            style: const constants.TextStyles().bodyText1,
          ),
        ]),
      ),
    );
  }
}
