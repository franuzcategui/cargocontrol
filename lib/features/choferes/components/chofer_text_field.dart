import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferTextField extends ConsumerWidget {
  const ChoferTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addChoferesState = ref.watch(choferesProvider);
    final bool showError =
        addChoferesState.id.isNotValid && !addChoferesState.id.isPure;
    final addChoferesController = ref.read(choferesProvider.notifier);

    return CargoFormTextField(
      hintText: 'Nombre de chofer',
      errorText: showError
          ? Chofer.showChoferErrorMessage(addChoferesState.nombreChofer.error)
          : null,
      onChanged: (chofer) => addChoferesController.onChoferChange(chofer),
    );
  }
}
