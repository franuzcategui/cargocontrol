import 'package:cargocontrol/widgets/cargo_choice_chips.dart';
import 'package:cargocontrol/widgets/cargo_dropdown_button.dart';
import 'package:cargocontrol/widgets/cargo_form_text_field.dart';
import 'package:cargocontrol/widgets/info_description.dart';
import 'package:cargocontrol/widgets/main_text_button.dart';
import 'package:cargocontrol/widgets/title_header.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        const TitleHeader(
            title: 'Información del buque',
            subtitle: 'Indique la información del buque a registrar'),
        Expanded(
          child: ListView(
            //itemExtent: 4,
            children: const [
              InfoDescription(),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoChoiceChips(
                name: 'Cargo',
                quantity: 5,
              ),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoFormTextField(hideText: false, hintText: 'hintText'),
              CargoDropdownButton(),
              MainTextButton(text: 'CONTINUAR'),
            ],
          ),
        ),
      ]),
    );
  }
}
