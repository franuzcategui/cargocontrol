// import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
// import 'package:cargocontrol/features/camion_descarga/components/placa_descarga_keypad.dart';
// import 'package:cargocontrol/features/camion_destino/components/placa_destino_keypad.dart';
// import 'package:cargocontrol/features/camion_entrando/components/guia_keypad_screen.dart';
// import 'package:cargocontrol/features/camion_saliendo/components/camion_saliendo_screen.dart';
// import 'package:cargocontrol/features/camion_saliendo/components/placa_saliendo_keypad_screen.dart';
// import 'package:cargocontrol/utils/form_validators/user_type.dart';
// import 'package:cargocontrol/screens/form_screen.dart';
// import 'package:cargocontrol/common_widgets/keypad_screen.dart';
// import 'package:cargocontrol/features/sign_up/components/sign_up_screen.dart';
// import 'package:cargocontrol/features/dashboard/components/dashboard_modal_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class DashboardButtonModal extends ConsumerWidget {
//   const DashboardButtonModal({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authenticationState = ref.watch(authProvider);
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         if (authenticationState.user.userType == "coordinador")
//           coordinadorButtons(context),
//         if (authenticationState.user.userType == "administrador")
//           administradorButtons(context),
//         if (authenticationState.user.userType == "industria")
//           industriaButtons(context),
//         DashboardModalButton(
//           title1: 'Descargar',
//           title2: 'reporte',
//           subtitle: 'Descargar reporte general',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const FormScreen()),
//             );
//           },
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).padding.bottom,
//         ),
//       ],
//     );
//   }
//
//   Widget industriaButtons(BuildContext context) {
//     return Column(
//       children: [
//         DashboardModalButton(
//           title1: 'Registrar camión',
//           title2: 'en destino',
//           subtitle: 'Registrar camión llegando a destino',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const PlacaDestinoKeypadScreen()),
//             );
//           },
//         ),
//         DashboardModalButton(
//           title1: 'Registrar camión',
//           title2: 'descargando',
//           subtitle: 'Registrar camión descargando en destino',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const PlacaDescargaKeypadScreen()),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget administradorButtons(BuildContext context) {
//     return Column(
//       children: [
//         DashboardModalButton(
//           title1: 'Crear',
//           title2: 'usuario',
//           subtitle: 'Crear usuario en sístema',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SignUpScreen()),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget coordinadorButtons(BuildContext context) {
//     return Column(
//       children: [
//         DashboardModalButton(
//           title1: 'Registrar camión',
//           title2: 'entrando',
//           subtitle: 'Registrar camión entrando a la romana sin carga',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const GuiaKeyPadScreen()),
//             );
//           },
//         ),
//         DashboardModalButton(
//             title1: 'Registrar camión',
//             title2: 'saliendo',
//             subtitle: 'Registrar camión saliendo a la romana con carga',
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PlacaSaliendoKeypadScreen()),
//               );
//             }),
//       ],
//     );
//   }
// }
