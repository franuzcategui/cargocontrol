import 'package:cargocontrol/screens/form_screen.dart';
import 'package:cargocontrol/screens/keypad_screen.dart';
import 'package:cargocontrol/sign_up/components/sign_up_screen.dart';
import 'package:cargocontrol/widgets/dashboard_modal_button.dart';
import 'package:flutter/material.dart';

class DashboardButtonModal extends StatelessWidget {
  const DashboardButtonModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DashboardModalButton(
          title1: 'Registrar camión',
          title2: 'entrando',
          subtitle: 'Registrar camión entrando a la romana sin carga',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeyPadScreen()),
            );
          },
        ),
        DashboardModalButton(
            title1: 'Registrar camión',
            title2: 'entrando',
            subtitle: 'Registrar camión entrando a la romana sin carga',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            }),
        DashboardModalButton(
          title1: 'Registrar camión',
          title2: 'entrando',
          subtitle: 'Registrar camión entrando a la romana sin carga',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}
