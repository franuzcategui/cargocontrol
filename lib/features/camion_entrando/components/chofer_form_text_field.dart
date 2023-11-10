import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferFormTextField extends ConsumerWidget {
  const ChoferFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camionEntrandoState = ref.watch(camionEntrandoProvider);
    final bool showError = camionEntrandoState.nombreChofer.isNotValid &&
        !camionEntrandoState.nombreChofer.isPure;
    final camionEntrandoController = ref.read(camionEntrandoProvider.notifier);

    return CargoFormTextField(
      hintText: 'Nombre de chofer',
      errorText: showError
          ? Chofer.showChoferErrorMessage(
              camionEntrandoState.nombreChofer.error)
          : null,
      onChanged: (chofer) => camionEntrandoController.onChoferChange(chofer),
    );
  }
}
