import 'dart:convert';

import 'package:cargocontrol/common_widgets/info_description.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/features/camion_entrando/components/camion_entrando_screen.dart';
import 'package:cargocontrol/features/camion_entrando/components/camion_entrando_summary_submit_button.dart';
import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_state.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/dummy_data/data.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class CamionEntrandoSummaryScreen extends ConsumerWidget {
  const CamionEntrandoSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<dynamic> map = jsonDecode(jsonData);
    ref.listen<CamionEntrandoState>(camionEntrandoProvider,
        (previous, current) {
      if (current.status.isInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isFailure) {
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSuccess) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
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
          const CamionEntrandoSummarySubmitButton(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
