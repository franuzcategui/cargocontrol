import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PesoTaraFormTextField extends ConsumerWidget {
  const PesoTaraFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camionEntrandoState = ref.watch(camionEntrandoProvider);
    final bool showError = camionEntrandoState.pesoTara.isNotValid &&
        !camionEntrandoState.pesoTara.isPure;
    final camionEntrandoController = ref.read(camionEntrandoProvider.notifier);

    return CargoFormTextField(
      onlyNumeric: true,
      hintText: 'Peso Tara',
      errorText: showError
          ? Peso.showPesoErrorMessage(camionEntrandoState.pesoTara.error)
          : null,
      onChanged: (pesoTara) =>
          camionEntrandoController.onPesoTaraChange(pesoTara),
    );
  }
}
