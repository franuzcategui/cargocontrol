import 'dart:convert';

import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/dummy_data/data.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class CamionSaliendoSummaryScreen extends StatelessWidget {
  const CamionSaliendoSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> map = jsonDecode(jsonData);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleHeader(
            logo: true,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen de registro de camión',
                  style: constants.TextStyles().subtitleText2,
                ),
                const Divider(),
              ],
            ),
          ),
          InfoDescription(jsonObject: map, title: 'Información preliminar'),
          InfoDescription(jsonObject: map, title: 'Información preliminar'),
          const Spacer(),
          MainTextButton(
            text: "CONTINUAR",
            onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
