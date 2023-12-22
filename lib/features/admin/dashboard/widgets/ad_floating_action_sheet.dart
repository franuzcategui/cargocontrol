import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/features/dashboard/components/dashboard_modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../create_vessel/controllers/ad_vessel_controller.dart';

class AdFloadtingActionSheet extends ConsumerWidget {
  const AdFloadtingActionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(fetchCurrentVesselsProvider).
            when(
              data: (vessel){
                return DashboardModalButton(
                  title1: 'Registro de',
                  isDisable: true,
                  title2: 'nuevo buque',
                  subtitle: 'Registro de buque a puerto',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.adminCreateVesselScreen);
                  },
                );
              },
              error: (error, st){
                return DashboardModalButton(
                  title1: 'Registro de',
                  isDisable: false,
                  title2: 'nuevo buque',
                  subtitle: 'Registro de buque a puerto',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.adminCreateVesselScreen);
                  },
                );
                // return SizedBox();
              },
              loading: (){
                return SizedBox();
              }
            );
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
