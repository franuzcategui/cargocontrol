import 'package:cargocontrol/routes/route_manager.dart';
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
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.adminCreateIndustryScreen);
          },
        ),
        DashboardModalButton(
          title1: 'Registro de',
          title2: 'nuevo usuario',
          subtitle: 'Registro de buque a puerto',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.adminRegisterUserScreen);
          },
        ),
        DashboardModalButton(
          title1: 'Administrar',
          title2: ' buques',
          subtitle: 'Descargar reporte de descarga',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.adManageShipsScreen);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
