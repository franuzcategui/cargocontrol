import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool hideText;
  final Function(String) onChanged;
  final String? errorText;

  const LoginTextField(
      {super.key,
      required this.hintText,
      this.hideText = false,
      required this.onChanged,
      this.errorText});

  //late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    print(myFocusNode.hasFocus);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: myFocusNode,
            onChanged: onChanged,
            obscureText: hideText,
            style: const constants.TextStyles().bodyText1,
            decoration:
                constants.DecorationStyles.inputTextDecoration1.copyWith(
              label: Text(hintText),
              hintText: hintText,
              hintStyle: const constants.TextStyles().bodyHintText1,
            ),
          ),
          if (errorText != null && myFocusNode.hasFocus)
            Text(
              errorText!,
              style: const constants.TextStyles(color: Colors.red).bodyText1,
            ),
        ],
      ),
    );
  }
}
