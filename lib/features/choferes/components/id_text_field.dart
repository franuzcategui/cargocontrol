import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/utils/form_validators/id.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdTextField extends ConsumerWidget {
  const IdTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addChoferesState = ref.watch(choferesProvider);
    final bool showError =
        addChoferesState.id.isNotValid && !addChoferesState.id.isPure;
    final addChoferesController = ref.read(choferesProvider.notifier);

    return CargoFormTextField(
      hintText: 'Identificación',
      onlyNumeric: true,
      errorText:
          showError ? Id.showIdErrorMessage(addChoferesState.id.error) : null,
      onChanged: (id) => addChoferesController.onIdChange(id),
    );
  }
}
