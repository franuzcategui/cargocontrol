import 'package:cargocontrol/widgets/loading_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

enum ButtonThemeStyle { primary, secondary }

class MainTextButton extends StatelessWidget {
  final String text;
  final ButtonThemeStyle? buttonStyle;

  const MainTextButton(
      {super.key,
      required this.text,
      this.buttonStyle = ButtonThemeStyle.primary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: OutlinedButton(
        onPressed: () {
          LoadingSheet.show(context);
        },
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
