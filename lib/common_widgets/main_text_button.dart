import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

enum ButtonThemeStyle { primary, secondary }

class MainTextButton extends StatelessWidget {
  final String text;
  final ButtonThemeStyle? buttonStyle;
  final void Function()? onTap;

  const MainTextButton(
      {super.key,
      required this.text,
      this.buttonStyle = ButtonThemeStyle.primary,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: OutlinedButton(
        onPressed: onTap,
        style: buttonStyle == ButtonThemeStyle.primary
            ? constants.ButtonStyles.buttonStyle1
            : constants.ButtonStyles.buttonStyle2,
        child: Text(
          text,
          style: buttonStyle == ButtonThemeStyle.primary
              ? const constants.TextStyles().buttonText1
              : const constants.TextStyles(color: constants.kMainColor)
                  .buttonText1,
        ),
      ),
    );
  }
}
