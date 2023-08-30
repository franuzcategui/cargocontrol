import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool hideText;

  const LoginTextField(
      {super.key, required this.hintText, this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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
