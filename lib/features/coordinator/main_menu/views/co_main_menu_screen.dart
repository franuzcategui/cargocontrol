import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/controllers/auth_controller.dart';
import '../controllers/co_main_menu_controller.dart';

class CoMainMenuScreen extends ConsumerStatefulWidget {
  const CoMainMenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoMainMenuScreenState();
}

class _CoMainMenuScreenState extends ConsumerState<CoMainMenuScreen> {


  @override
  void initState() {
    super.initState();
    initiallize();
  }

  initiallize()async{
    await ref.read(truckRegistrationNotiControllerProvider).getAllIndustriesModel();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return TextButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).logout(
                        context: context,
                        ref: ref
                    );
                  },
                  child: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      color: constants.kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
            },

          )
        ],
      ),
      body: ref.read(coMainMenuProvider).screens[ref.watch(coMainMenuProvider).index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(coMainMenuProvider).setIndex(value);
        },
        iconSize: 22,
        currentIndex:  ref.read(coMainMenuProvider).index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.truck,
            ),
            label: 'Viajes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.person,
            ),
            label: 'Choferes',
          ),
        ],
      )
    );
  }
}
