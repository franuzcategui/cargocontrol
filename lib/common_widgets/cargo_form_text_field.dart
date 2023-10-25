import 'dart:io';

import 'package:cargocontrol/screens/text_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoFormTextField extends StatefulWidget {
  final bool hideText;
  final String hintText;
  final Function(String) onChanged;
  final String? errorText;
  final bool showCamera;
  final bool onlyNumeric;
  const CargoFormTextField(
      {super.key,
      this.hideText = false,
      required this.hintText,
      required this.onChanged,
      this.showCamera = false,
      this.onlyNumeric = false,
      this.errorText});

  @override
  State<CargoFormTextField> createState() => _CargoFormTextFieldState();
}

class _CargoFormTextFieldState extends State<CargoFormTextField> {
  TextEditingController keyPadTextFieldController = TextEditingController();

  void initState() {
    keyPadTextFieldController.addListener(_onTextChange);
    super.initState();
  }

  @override
  void dispose() {
    keyPadTextFieldController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    final text = keyPadTextFieldController.text;
    widget.onChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    bool showCamera =
        widget.showCamera && (Platform.isIOS || Platform.isAndroid);
    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: widget.onlyNumeric ? TextInputType.number : null,
            controller: keyPadTextFieldController,
            obscureText: widget.hideText,
            style: const constants.TextStyles().bodyText1,
            decoration:
                constants.DecorationStyles.inputTextDecoration1.copyWith(
              label: Text(widget.hintText),
              hintText: widget.hintText,
              hintStyle: const constants.TextStyles().bodyHintText1,
              suffixIcon: showCamera
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TextDetectorScreen()),
                            );
                            setState(() {
                              keyPadTextFieldController.text = result;
                            });
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.camera,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  : null,
            ),
          ),
          if (widget.errorText != null)
            Text(
              widget.errorText!,
              style: constants.TextStyles(
                      color: Theme.of(context).colorScheme.error)
                  .bodyText1,
            ),
        ],
      ),
    );
  }
}
