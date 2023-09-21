import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

// class CargoChoiceChipsData {
//   String name;
//   int quantity;
//   CargoChoiceChipsData(this.name, this.quantity);
// }

class CargoChoiceChips extends StatefulWidget {
  final String name;
  final List<String> categories;
  const CargoChoiceChips(
      {super.key, required this.name, required this.categories});

  @override
  State<CargoChoiceChips> createState() => _CargoChoiceChipsState();
}

class _CargoChoiceChipsState extends State<CargoChoiceChips> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const constants.TextStyles().infoTitle1,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildCategoryChips(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryChips() {
    return List<Widget>.generate(
      widget.categories.length,
      (index) => CargoChoiceChip(
        name: widget.categories[index],
        selected: _selectedIndex == index,
        onSelected: (selected) {
          setState(() {
            _selectedIndex = selected ? index : 0;
          });
        },
      ),
    ).toList();
  }
}

class CargoChoiceChip extends StatelessWidget {
  final String name;
  final void Function(bool) onSelected;
  final bool selected;
  const CargoChoiceChip(
      {super.key,
      required this.name,
      required this.onSelected,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(name),
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      side: const BorderSide(
        color: constants.kOutlineTextFieldColor,
      ),
      selectedColor: constants.kMainBackroundColor,
      elevation: 2,
      selectedShadowColor: constants.kMainColor,
      onSelected: onSelected,
      padding: const EdgeInsets.all(12),
    );
  }
}
