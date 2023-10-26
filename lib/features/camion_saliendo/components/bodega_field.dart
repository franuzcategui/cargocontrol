import 'package:cargocontrol/common_widgets/cargo_choice_chips.dart';
import 'package:flutter/material.dart';

class BodegaField extends StatelessWidget {
  const BodegaField({super.key});

  @override
  Widget build(BuildContext context) {
    return CargoChoiceChips(
      name: "Número de bodega",
      categories: ['1', '2', '3', '4', '5'],
      onChange: (hello) {
        print('funciono');
      },
    );
  }
}
