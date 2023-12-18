// import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
// import 'package:cargocontrol/common_widgets/cargo_card.dart';
// import 'package:cargocontrol/features/choferes/components/add_choferes_modal.dart';
// import 'package:cargocontrol/features/choferes/components/choferes_list.dart';
// import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:cargocontrol/utils/constants.dart' as constants;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class ChoferesScreen extends ConsumerWidget {
//   const ChoferesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authenticationState = ref.watch(authProvider);
//     final String userType =
//         authenticationState.user.userType.toString().split('.').last;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text('Choferes', style: const constants.TextStyles().titleText3),
//       ),
//       floatingActionButton: userType == 'administrador'
//           ? FloatingActionButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                     backgroundColor: Colors.white,
//                     elevation: 0,
//                     context: context,
//                     builder: (context) => const AddChoferesModal());
//               },
//               backgroundColor: constants.kMainColor,
//               child: const FaIcon(
//                 FontAwesomeIcons.plus,
//                 color: Colors.white,
//               ),
//             )
//           : null,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               decoration:
//                   constants.DecorationStyles.searchBarDecoration1.copyWith(
//                 hintText: 'Buscar choferes',
//               ),
//             ),
//           ),
//           const ChoferesList(),
//         ],
//       ),
//     );
//   }
// }
