import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/camion_descarga/components/placa_descarga_keypad.dart';
import 'package:cargocontrol/features/camion_destino/components/placa_destino_keypad.dart';
import 'package:cargocontrol/features/camion_entrando/components/guia_keypad_screen.dart';
import 'package:cargocontrol/features/camion_saliendo/components/camion_saliendo_screen.dart';
import 'package:cargocontrol/features/camion_saliendo/components/placa_saliendo_keypad_screen.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/form_validators/user_type.dart';
import 'package:cargocontrol/screens/form_screen.dart';
import 'package:cargocontrol/common_widgets/keypad_screen.dart';
import 'package:cargocontrol/features/sign_up/components/sign_up_screen.dart';
import 'package:cargocontrol/features/dashboard/components/dashboard_modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShipsBottomSheet extends ConsumerWidget {
  const ShipsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
            onPressed: (){},
            buttonText: 'DESCARGA DE BUQUE CULMINADA'
        ),
        CustomButton(
            onPressed: (){},
            buttonText: 'REGRESAR',
          backColor: context.secondaryMainColor,
        ),
        SizedBox(
          height: 22.h,
        ),
      ],
    );
  }
}
