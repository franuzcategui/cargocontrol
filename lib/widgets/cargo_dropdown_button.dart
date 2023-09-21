import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class CargoDropdownButton extends StatelessWidget {
  final List<Object> items;
  final String label;
  final void Function(Object?) onSelect;

  const CargoDropdownButton(
      {required this.items,
      required this.label,
      required this.onSelect,
      super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final List<DropdownMenuEntry<Object>> entries =
        <DropdownMenuEntry<Object>>[];
    for (final values in items) {
      entries.add(DropdownMenuEntry(
          value: values, label: values.toString().split('.').last));
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(deviceWidth / 20, 0, deviceWidth / 20, 15),
      child: DropdownMenu(
        width: (deviceWidth / 20) * 18,
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
        onSelected: onSelect,
      ),
    );
  }
}
