import 'package:cargocontrol/features/admin/create_vessel/views/create_vessel_complete_data_screen.dart';
import 'package:cargocontrol/features/admin/create_vessel/views/create_vessel_screen.dart';
import 'package:cargocontrol/features/admin/main_menu/views/ad_main_menu_screen.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:flutter/material.dart';

import '../features/admin/create_vessel/views/create_vessle_bodega_info_screen.dart';
import '../features/dashboard/components/dashboard_screen.dart';
import 'navigation.dart';

class AppRoutes {
  // Admin Section
  static const String adminMainMenuScreen = '/adminMainMenuScreen';
  static const String adminCreateVesselScreen = '/adminCreateVesselScreen';
  static const String adminCreateVesselBodegaInfoScreen = '/adminCreateVesselBodegaInfoScreen';
  static const String adminCreateVesselCompleteDataScreen = '/adminCreateVesselCompleteDataScreen';





  static const String loginScreen = '/loginScreen';
  static const String dashboardScreen = '/dashboardScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Admin Screens
      case adminMainMenuScreen:
        return _buildRoute(const AdMainMenuScreen());
      case adminCreateVesselScreen:
        return _buildRoute(const CreateVesselScreen());
      case adminCreateVesselBodegaInfoScreen:
        return _buildRoute(const CreateVesselBodegaInfoScreen());
      case adminCreateVesselCompleteDataScreen:
        return _buildRoute(const CreateVesselCompleteDataScreen());




      case dashboardScreen:
        return _buildRoute(const DashboardScreen());
      case loginScreen:
        return _buildRoute(const LoginScreen());
      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }

  static _buildRoute(Widget widget, {int? duration = 400}) {
    return forwardRoute(widget, duration);
  }
}
