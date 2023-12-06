import 'package:cargocontrol/features/admin/create_industry/views/create_industry_complete_data_screen.dart';
import 'package:cargocontrol/features/admin/create_industry/views/create_industry_information_screen.dart';
import 'package:cargocontrol/features/admin/create_industry/views/create_industry_screen.dart';
import 'package:cargocontrol/features/admin/create_vessel/views/create_vessel_complete_data_screen.dart';
import 'package:cargocontrol/features/admin/create_vessel/views/create_vessel_screen.dart';
import 'package:cargocontrol/features/admin/create_vessel/views/registration_successfull_screen.dart';
import 'package:cargocontrol/features/admin/main_menu/views/ad_main_menu_screen.dart';
import 'package:cargocontrol/features/admin/register_user/views/register_user_screen.dart';
import 'package:cargocontrol/features/admin/viajes/views/ad_viages_edit_screen.dart';
import 'package:cargocontrol/features/admin/viajes/views/ad_viajes_details_screen.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/co_truck_info_screen.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/register_truck_entering_screen.dart';
import 'package:flutter/material.dart';

import '../features/admin/create_industry/widgets/industries_for_all_data.dart';
import '../features/admin/create_vessel/views/create_vessle_bodega_info_screen.dart';
import '../features/admin/manage_ships/views/manage_ships_screen.dart';
import '../features/dashboard/components/dashboard_screen.dart';
import 'navigation.dart';

class AppRoutes {
  // Admin Section
  static const String adminMainMenuScreen = '/adminMainMenuScreen';
  static const String adminCreateVesselScreen = '/adminCreateVesselScreen';
  static const String adminCreateVesselBodegaInfoScreen = '/adminCreateVesselBodegaInfoScreen';
  static const String adminCreateVesselCompleteDataScreen = '/adminCreateVesselCompleteDataScreen';
  static const String registrationSuccessFullScreen = '/registrationSuccessFullScreen';

  static const String adminCreateIndustryScreen = '/adminCreateIndustryScreen';
  static const String adminCreateIndustryInformationScreen = '/adminCreateIndustryInformationScreen';
  static const String adminCreateIndustryCompleteDataScreen = '/adminCreateIndustryCompleteDataScreen';

  static const String adminRegisterUserScreen = '/adminRegisterUserScreen';

  static const String adminViajesDetailsScreen = '/adminViajesDetailsScreen';
  static const String adminViajesEditScreen = '/adminViajesEditScreen';

  static const String adManageShipsScreen = '/adManageShipsScreen';

  // Coordinator Section
  static const String coMainMenuScreen = '/coMainMenuScreen';
  static const String registerTruckEnteringScreen = '/registerTruckEnteringScreen';
  static const String coTruckInfoScreen = '/coTruckInfoScreen';




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
      case registrationSuccessFullScreen:
        return _buildRoute(const RegistrationSuccessFullScreen());

      case adminCreateIndustryScreen:
        return _buildRoute(const CreateIndustryScreen());
      case adminCreateIndustryInformationScreen:
        return _buildRoute(const CreateIndustryInformationScreen());
      case adminCreateIndustryCompleteDataScreen:
        return _buildRoute(const CreateIndustryCompleteDataScreen());

      case adminRegisterUserScreen:
        return _buildRoute(const RegisterUserScreen());

      case adminViajesDetailsScreen:
        return _buildRoute(const AdViajesDetailsScreen());
      case adminViajesEditScreen:
        return _buildRoute(const AdViajesEditScreen());

      case adManageShipsScreen:
        return _buildRoute(const AdManageShipsScreen());

    // Coordinator Screens
      case coMainMenuScreen:
        return _buildRoute(const CoMainMenuScreen());
      case registerTruckEnteringScreen:
        return _buildRoute(const RegisterTruckEnteringScreen());
      case coTruckInfoScreen:
        return _buildRoute(const CoTruckInfoScreen());




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
