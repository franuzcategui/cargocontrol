import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../admin/choferes/views/ad_choferes_screen.dart';
import '../../../admin/viajes/views/ad_viajes_screen.dart';
import '../../dashboard/views/co_dashboard_screen.dart';


final coMainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {

  final List<Widget> _screens = [
    const CoDashboardScreen(),
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
