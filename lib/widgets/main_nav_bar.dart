import 'package:cargocontrol/screens/choferes_screen.dart';
import 'package:cargocontrol/screens/dashboard_screen.dart';
import 'package:cargocontrol/screens/viajes_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/constants.dart' as constants;

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),
    const ViajesScreen(),
    const ChoferesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              onPressed: () {},
              child: const Text(
                'Cerrar sesión',
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
