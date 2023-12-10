import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../choferes/views/co_choferes_screen.dart';
import '../../dashboard/views/co_dashboard_screen.dart';
import '../../viajes/views/co_viajes_screen.dart';


final coMainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {

  final List<Widget> _screens = [
    const CoDashboardScreen(),
    const CoViajesScreen(),
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
