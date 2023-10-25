import 'package:flutter/material.dart';
import 'package:cargocontrol/common_widgets/cargo_form_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacaFormTextField extends ConsumerWidget {
  const PlacaFormTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CargoFormTextField(
      hintText: 'Placa',
      onChanged: (hello) {
        print(hello);
      },
      showCamera: true,
    );
  }
}
