import 'package:cargocontrol/features/camion_destino/components/camion_destino_summary_screen.dart';
import 'package:cargocontrol/common_widgets/keypad_screen.dart';
import 'package:flutter/material.dart';

class PlacaDestinoKeypadScreen extends StatelessWidget {
  const PlacaDestinoKeypadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyPadScreen(
        title: "Número de placa",
        subtitle: "Indique el número de placa del camión llegando a destino",
        showCamera: true,
        onTextChanged: (value) {
          print(value);
        },
        onButtonTapped: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CamionDestinoSummaryScreen()));
        });
  }
}
