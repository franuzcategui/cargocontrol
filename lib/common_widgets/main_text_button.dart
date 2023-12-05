import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      height:  55.h,
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
