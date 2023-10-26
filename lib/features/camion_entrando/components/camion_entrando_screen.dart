import 'dart:convert';

import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/features/camion_entrando/components/chofer_form_text_field.dart';
import 'package:cargocontrol/features/camion_entrando/components/peso_tara_form_text_field.dart';
import 'package:cargocontrol/features/camion_entrando/components/placa_form_text_field.dart';
import 'package:cargocontrol/features/camion_entrando/components/camion_entrando_summary_screen.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/dummy_data/data.dart';

class CamionEntrandoScreen extends StatelessWidget {
  const CamionEntrandoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> map = jsonDecode(jsonData);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleHeader(
            title: 'Información del camión',
            subtitle:
                'Indique la información del camión para su registro en la romana',
          ),
          Column(
            children: [
              InfoDescription(jsonObject: map, title: 'Información preliminar'),
              PlacaFormTextField(),
              ChoferFormTextField(),
              PesoTaraFormTextField(),
            ],
          ),
          const Spacer(),
          MainTextButton(
            text: "CONTINUAR",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CamionEntrandoSummaryScreen(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
