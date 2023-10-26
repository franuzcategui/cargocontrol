import 'dart:convert';

import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/features/camion_saliendo/components/bodega_field.dart';
import 'package:cargocontrol/features/camion_saliendo/components/camion_saliendo_summary_screen.dart';
import 'package:cargocontrol/features/camion_saliendo/components/peso_bruto_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/dummy_data/data.dart';

class CamionSaliendoScreen extends StatelessWidget {
  const CamionSaliendoScreen({super.key});

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
              BodegaField(),
              PesoBrutoFormTextField(),
            ],
          ),
          const Spacer(),
          MainTextButton(
            text: "CONTINUAR",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CamionSaliendoSummaryScreen(),
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
