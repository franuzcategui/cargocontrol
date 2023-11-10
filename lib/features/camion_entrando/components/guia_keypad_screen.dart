import 'package:cargocontrol/features/camion_entrando/components/camion_entrando_screen.dart';
import 'package:cargocontrol/common_widgets/keypad_screen.dart';
import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuiaKeyPadScreen extends ConsumerWidget {
  const GuiaKeyPadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camionEntrandoState = ref.watch(camionEntrandoProvider);
    final bool showError = camionEntrandoState.numeroGuia.isNotValid &&
        !camionEntrandoState.numeroGuia.isPure;
    final camionEntrandoController = ref.read(camionEntrandoProvider.notifier);

    return KeyPadScreen(
        title: "Número de guia",
        subtitle: "Indique el número de guía del camión entrante",
        showCamera: false,
        onTextChanged: (value) {
          camionEntrandoController.onNumeroGuiaChange(value);
          print(value);
        },
        onButtonTapped: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CamionEntrandoScreen()));
        });
  }
}
