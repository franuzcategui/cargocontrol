import 'package:cargocontrol/features/camion_entrando/components/info_camion_screen.dart';
import 'package:cargocontrol/screens/keypad_screen.dart';
import 'package:flutter/material.dart';

class GuiaKeyPadScreen extends StatelessWidget {
  const GuiaKeyPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyPadScreen(
        title: "Número de guia",
        subtitle: "Indique el número de guía del camión entrante",
        showCamera: false,
        onTextChanged: (value) {
          print(value);
        },
        onButtonTapped: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InfoCamionScreen()));
        });
  }
}
