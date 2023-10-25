import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferFormTextField extends ConsumerWidget {
  const ChoferFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CargoFormTextField(
      hintText: 'Nombre de chofer',
      onChanged: (hello) {
        print(hello);
      },
    );
  }
}
