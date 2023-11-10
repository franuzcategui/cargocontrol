import 'package:cargocontrol/common_widgets/main_text_button.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddChoferButton extends ConsumerWidget {
  const AddChoferButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addChoferState = ref.watch(choferesProvider);
    final addChoferController = ref.read(choferesProvider.notifier);
    final bool isValidated = addChoferState.isValid;
    return MainTextButton(
        text: 'REGISTRAR',
        onTap: isValidated ? () => addChoferController.addChofer() : null);
  }
}
