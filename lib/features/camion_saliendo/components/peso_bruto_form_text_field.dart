import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PesoBrutoFormTextField extends ConsumerWidget {
  const PesoBrutoFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CargoFormTextField(
      onlyNumeric: true,
      hintText: 'Peso Bruto',
      onChanged: (hello) {
        print(hello);
      },
    );
  }
}
