import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class CargoFormTextField extends StatelessWidget {
  final bool hideText;
  final String hintText;
  const CargoFormTextField(
      {super.key, required this.hideText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: TextFormField(
        obscureText: hideText,
        style: const constants.TextStyles().bodyText1,
        decoration: constants.DecorationStyles.inputTextDecoration1.copyWith(
          label: Text(hintText),
          hintText: hintText,
          hintStyle: const constants.TextStyles().bodyHintText1,
        ),
      ),
    );
  }
}
