import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CamionEntrandoSummarySubmitButton extends ConsumerWidget {
  const CamionEntrandoSummarySubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camionEntrandoState = ref.watch(camionEntrandoProvider);
    final camionEntrandoController = ref.read(camionEntrandoProvider.notifier);
    final bool isValidated = camionEntrandoState.isValid;
    return MainTextButton(
        text: 'ENVIAR',
        onTap: isValidated
            ? () => camionEntrandoController.submitCamionEntrandoForm()
            : null);
  }
}
