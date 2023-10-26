import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PesoLlegadaFormTextField extends ConsumerWidget {
  const PesoLlegadaFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CargoFormTextField(
      onlyNumeric: true,
      hintText: 'Peso Bruto de llegada',
      onChanged: (hello) {
        print(hello);
      },
    );
  }
}
