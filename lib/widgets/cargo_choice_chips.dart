import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

// class CargoChoiceChipsData {
//   String name;
//   int quantity;
//   CargoChoiceChipsData(this.name, this.quantity);
// }

class CargoChoiceChips extends StatelessWidget {
  final String name;
  final int quantity;
  const CargoChoiceChips(
      {super.key, required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const constants.TextStyles().infoTitle1,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < quantity; i++)
                CargoChoiceChip(name: (i + 1).toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class CargoChoiceChip extends StatelessWidget {
  final String name;
  const CargoChoiceChip({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(name),
      selected: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      side: const BorderSide(
        color: constants.kOutlineTextFieldColor,
      ),
      selectedColor: constants.kMainBackroundColor,
      padding: const EdgeInsets.all(12),
    );
  }
}
