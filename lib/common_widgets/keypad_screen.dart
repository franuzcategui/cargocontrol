import 'dart:io';

import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/text_detector_view.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class KeyPadScreen extends StatefulWidget {
  final bool showCamera;
  final String title;
  final String subtitle;
  final void Function(String) onTextChanged;
  final void Function() onButtonTapped;
  const KeyPadScreen(
      {required this.title,
      required this.subtitle,
      required this.showCamera,
      required this.onTextChanged,
      required this.onButtonTapped,
      super.key});

  @override
  State<KeyPadScreen> createState() => _KeyPadScreenState();
}

class _KeyPadScreenState extends State<KeyPadScreen> {
  TextEditingController keyPadTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    keyPadTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.onTextChanged(keyPadTextFieldController.text);
    double deviceWidth = MediaQuery.of(context).size.width;
    bool showCamera =
        widget.showCamera && (Platform.isIOS || Platform.isAndroid);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TitleHeader(
            title: widget.title,
            subtitle: widget.subtitle,
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(deviceWidth / 5, 20, deviceWidth / 5, 0),
            child: TextField(
              maxLength: 6,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              style: const constants.TextStyles().keyPadInputText,
              autocorrect: false,
              textAlign: TextAlign.center,
              enableSuggestions: false,
              readOnly: true,
              controller: keyPadTextFieldController,
              decoration: constants.DecorationStyles.keyPadTextFieldDecoration1
                  .copyWith(
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
          ),
          const Spacer(),
          NumericKeyboard(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            onKeyboardTap: (string) {
              setState(() {
                keyPadTextFieldController.text += string;
              });
            },
            rightIcon: const Icon(FontAwesomeIcons.deleteLeft),
            rightButtonFn: () {
              keyPadTextFieldController.text = '';
            },
          ),
          MainTextButton(
            text: 'CONTINUAR',
            onTap: widget.onButtonTapped,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
