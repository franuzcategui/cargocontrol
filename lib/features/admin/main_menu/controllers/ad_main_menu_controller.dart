import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../choferes/components/choferes_screen.dart';
import '../../choferes/views/ad_choferes_screen.dart';
import '../../dashboard/views/ad_dashboard_screen.dart';
import '../../viajes/views/ad_viajes_screen.dart';

final adMainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {

  final List<Widget> _screens = [
    const AdDashboardScreen(),
    const AdViajesScreen(),
    const AdChoferesScreen(),
  ];
  List<Widget> get screens => _screens;



  int _currentIndex = 0;
  int get index => _currentIndex;
  setIndex(int id) {
    _currentIndex = id;
    notifyListeners();
  }
}
