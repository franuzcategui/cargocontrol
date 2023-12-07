import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/features/dashboard/components/dashboard_modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InFloadtingActionSheet extends ConsumerWidget {
  const InFloadtingActionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DashboardModalButton(
          title1: 'Registro de',
          title2: ' camión de llegada',
          subtitle: 'Registro de camión a destino',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.inRegisterTruckArrivalScreen);
          },
        ),
        DashboardModalButton(
          title1: 'Registrar camión',
          title2: ' camión descargando ',
          subtitle: 'Registrar camión entrando a la romana con carga',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.inRegisterTruckLeavingScreen);
          },
        ),

        DashboardModalButton(
          title1: 'Descargar',
          title2: ' reporte',
          subtitle: 'Descargar reporte de descarga',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.inAllReportsScreen);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
