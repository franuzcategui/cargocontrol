import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/features/choferes/components/add_chofer_button.dart';
import 'package:cargocontrol/features/choferes/components/chofer_text_field.dart';
import 'package:cargocontrol/features/choferes/components/id_text_field.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class AddChoferesModal extends ConsumerWidget {
  const AddChoferesModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ChoferesState>(choferesProvider, (previous, current) {
      if (current.status.isInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isFailure) {
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSuccess) {
        Navigator.pop(context);
        ErrorDialog.show(context, "El chofer se ha registrado exitosamente");
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TitleHeader(
          title: 'Agregar nuevo chofer',
          subtitle: 'Registrar a nuevo chofer',
        ),
        ChoferTextField(),
        IdTextField(),
        AddChoferButton(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
