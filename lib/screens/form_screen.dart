import 'dart:convert';

import 'package:cargocontrol/common_widgets/cargo_choice_chips.dart';
import 'package:cargocontrol/common_widgets/cargo_dropdown_button.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/dummy_data/data.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> map = jsonDecode(jsonData);
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const TitleHeader(
            title: 'Información del buque',
            subtitle: 'Indique la información del buque a registrar'),
        Expanded(
          child: ListView(
            //itemExtent: 4,
            children: [
              InfoDescription(
                title: 'Información preliminar',
                jsonObject: map,
              ),
              CargoFormTextField(
                hideText: false,
                hintText: 'hintText',
                onChanged: (hello) {},
              ),
              const CargoChoiceChips(
                name: 'Cargo',
                categories: ['1', '2', '3', '4', '5'],
              ),
              CargoFormTextField(
                hideText: false,
                hintText: 'hintText',
                onChanged: (hello) {},
              ),
              CargoFormTextField(
                hideText: false,
                hintText: 'hintText',
                onChanged: (hello) {},
              ),
              CargoFormTextField(
                hideText: false,
                hintText: 'hintText',
                onChanged: (hello) {},
              ),
              CargoFormTextField(
                hideText: false,
                hintText: 'hintText',
                onChanged: (hello) {},
              ),
              CargoDropdownButton(
                items: const ['prueba1', 'prueba2'],
                label: 'label',
                onSelect: (value) {
                  print(value);
                },
              ),
              MainTextButton(
                text: 'CONTINUAR',
                onTap: () {},
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
