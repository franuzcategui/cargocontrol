import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:cargocontrol/screens/text_detector_view.dart';
import 'package:cargocontrol/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class KeyPadScreen extends StatefulWidget {
  const KeyPadScreen({super.key});

  @override
  State<KeyPadScreen> createState() => _KeyPadScreenState();
}

class _KeyPadScreenState extends State<KeyPadScreen> {
  //String stringInput = '';
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
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TitleHeader(
            title: 'Número de placa',
            subtitle: 'Indique el número de placa del camión saliente',
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
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TextDetectorScreen()),
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
                ),
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
            onTap: () {},
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
