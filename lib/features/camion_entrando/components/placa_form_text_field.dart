import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacaFormTextField extends ConsumerWidget {
  const PlacaFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camionEntrandoState = ref.watch(camionEntrandoProvider);
    final bool showError = camionEntrandoState.placa.isNotValid &&
        !camionEntrandoState.placa.isPure;
    final camionEntrandoController = ref.read(camionEntrandoProvider.notifier);

    return CargoFormTextField(
      hintText: 'Placa',
      errorText: showError
          ? Placa.showPlacaErrorMessage(camionEntrandoState.placa.error)
          : null,
      onChanged: (placa) => camionEntrandoController.onPlacaChange(placa),
      showCamera: true,
    );
  }
}
