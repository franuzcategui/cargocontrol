import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
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

class AdFloadtingActionSheet extends ConsumerWidget {
  const AdFloadtingActionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DashboardModalButton(
          title1: 'Registro de',
          title2: 'nuevo buque',
          subtitle: 'Registro de buque a puerto',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.adminCreateVesselScreen);
          },
        ),
        DashboardModalButton(
          title1: 'Registro de',
          title2: 'industria ',
          subtitle: 'Registro de guia de industria',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
        DashboardModalButton(
          title1: 'Registro de',
          title2: 'nuevo usuario',
          subtitle: 'Registro de buque a puerto',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
        DashboardModalButton(
          title1: 'Descargar',
          title2: 'reporte',
          subtitle: 'Descargar reporte general',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormScreen()),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
