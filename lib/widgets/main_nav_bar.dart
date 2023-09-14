import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/screens/choferes_screen.dart';
import 'package:cargocontrol/screens/dashboard_screen.dart';
import 'package:cargocontrol/screens/viajes_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavBar extends ConsumerStatefulWidget {
  const MainNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavBarState();
}

class _MainNavBarState extends ConsumerState<MainNavBar> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),
    const ViajesScreen(),
    const ChoferesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              onPressed: () {
                authController.onSignOut();
              },
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: constants.kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        iconSize: 22,
        unselectedItemColor: constants.kSecondaryMainColor,
        selectedItemColor: constants.kMainColor,
        backgroundColor: constants.kMainBackroundColor,
        currentIndex: _currentIndex,
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
      ),
    );
  }
}
