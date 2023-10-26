import 'dart:convert';

import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/features/camion_descarga/components/camion_descarga_summary_screen.dart';
import 'package:cargocontrol/features/camion_saliendo/components/peso_bruto_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/dummy_data/data.dart';

class CamionDescargaScreen extends StatelessWidget {
  const CamionDescargaScreen({super.key});

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
                'Indique la información del camión para su registro al destino',
          ),
          Column(
            children: [
              InfoDescription(jsonObject: map, title: 'Información preliminar'),
              PesoBrutoFormTextField(),
            ],
          ),
          const Spacer(),
          MainTextButton(
            text: "CONTINUAR",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CamionDescargaSummaryScreen(),
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
