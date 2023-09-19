import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class CargoDropdownButton extends StatelessWidget {
  final List<String> items;
  final String label;

  const CargoDropdownButton(this.items, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final List<DropdownMenuEntry<String>> entries =
        <DropdownMenuEntry<String>>[];
    for (final String values in items) {
      entries.add(DropdownMenuEntry(value: values, label: values));
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: DropdownMenu(
        // width: double.infinity,
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              labelStyle: const constants.TextStyles().bodyText1,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(
                  color: constants.kOutlineTextFieldColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(
                  color: constants.kMainColor,
                ),
              ),
            ),
        //width: deviceWidth,
        label: Text(
          label,
          style: const constants.TextStyles().bodyText1,
        ),
        hintText: 'Opciones',
        initialSelection: entries[0],
        dropdownMenuEntries: entries,
      ),
    );
  }
}
