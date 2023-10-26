import 'package:cargocontrol/features/camion_saliendo/components/camion_saliendo_screen.dart';
import 'package:cargocontrol/common_widgets/keypad_screen.dart';
import 'package:flutter/material.dart';

class PlacaSaliendoKeypadScreen extends StatelessWidget {
  const PlacaSaliendoKeypadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyPadScreen(
        title: "Número de placa",
        subtitle: "Indique el número de placa del camión saliente",
        showCamera: true,
        onTextChanged: (value) {
          print(value);
        },
        onButtonTapped: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CamionSaliendoScreen()));
        });
  }
}
