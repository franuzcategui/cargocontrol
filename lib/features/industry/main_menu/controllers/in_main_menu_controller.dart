import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../coordinator/choferes/views/co_choferes_screen.dart';
import '../../dashboard/views/in_dashboard_screen.dart';
import '../../viajes/views/in_viajes_screen.dart';


final inMainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {

  final List<Widget> _screens = [
    const InDashboardScreen(),
    const InViajesScreen(),
    const CoChoferesScreen(),
  ];
  List<Widget> get screens => _screens;



  int _currentIndex = 0;
  int get index => _currentIndex;
  setIndex(int id) {
    _currentIndex = id;
    notifyListeners();
  }
}
