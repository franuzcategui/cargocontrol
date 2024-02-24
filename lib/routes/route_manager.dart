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
import 'package:cargocontrol/features/coordinator/dashboard/views/co_all_recenties_screen.dart';
import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/co_truck_info_screen.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/co_truck_leaving_brief_screen.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/register_truck_entering_screen.dart';
import 'package:flutter/material.dart';

import '../features/admin/choferes/views/ad_choferes_details_screen.dart';
import '../features/admin/create_industry/widgets/industries_for_all_data.dart';
import '../features/admin/create_vessel/views/create_vessle_bodega_info_screen.dart';
import '../features/admin/dashboard/views/ad_all_recenties_screen.dart';
import '../features/admin/manage_ships/views/manage_ships_screen.dart';
import '../features/coordinator/register_truck_movement/views/co_select_chofer_sheet.dart';
import '../features/coordinator/register_truck_movement/views/co_truck_brief_screen.dart';
import '../features/coordinator/register_truck_movement/views/co_registration_successfull_screen.dart';
import '../features/coordinator/register_truck_movement/views/co_truck_leaving_information_screen.dart';
import '../features/coordinator/register_truck_movement/views/register_truck_leaving_screen.dart';
import '../features/dashboard/components/dashboard_screen.dart';
import '../features/industry/choferes/views/in_choferes_details_screen.dart';
import '../features/industry/dashboard/views/in_dashboard_screen.dart';
import '../features/industry/main_menu/views/in_main_menu_screen.dart';
import '../features/industry/manage_report/views/in_all_reports_screen.dart';
import '../features/industry/register_truck_movements/views/in_registration_success_screen.dart';
import '../features/industry/register_truck_movements/views/in_truck_arrival_info_sccreen.dart';
import '../features/industry/register_truck_movements/views/in_truck_arrivel_registration_screen.dart';
import '../features/industry/register_truck_movements/views/in_truck_unloading_brief_screen.dart';
import '../features/industry/register_truck_movements/views/in_truck_unloading_info_screen.dart';
import '../features/industry/register_truck_movements/views/in_truck_unloading_registery_screen.dart';
import '../features/industry/viajes/views/in_viajes_details_screen.dart';
import 'navigation.dart';

class AppRoutes {
  // Admin Section
  static const String adminMainMenuScreen = '/adminMainMenuScreen';
  static const String adminCreateVesselScreen = '/adminCreateVesselScreen';
  static const String adminCreateVesselBodegaInfoScreen =
      '/adminCreateVesselBodegaInfoScreen';
  static const String adminCreateVesselCompleteDataScreen =
      '/adminCreateVesselCompleteDataScreen';
  static const String registrationSuccessFullScreen =
      '/registrationSuccessFullScreen';

  static const String adminCreateIndustryScreen = '/adminCreateIndustryScreen';
  static const String adminCreateIndustryInformationScreen =
      '/adminCreateIndustryInformationScreen';
  static const String adminCreateIndustryCompleteDataScreen =
      '/adminCreateIndustryCompleteDataScreen';

  static const String adminRegisterUserScreen = '/adminRegisterUserScreen';

  static const String adminViajesDetailsScreen = '/adminViajesDetailsScreen';
  static const String adminViajesEditScreen = '/adminViajesEditScreen';

  static const String adManageShipsScreen = '/adManageShipsScreen';
  static const String adAllRecentiesScreen = '/adAllRecentiesScreen';

  // Coordinator Section
  static const String coMainMenuScreen = '/coMainMenuScreen';
  static const String registerTruckEnteringScreen =
      '/registerTruckEnteringScreen';
  static const String coTruckInfoScreen = '/coTruckInfoScreen';
  static const String coTruckBriefScreen = '/coTruckBriefScreen';
  static const String coTruckLeavingBriefScreen = '/coTruckLeavingBriefScreen';
  static const String coRegistrationSuccessFullScreen =
      '/coRegistrationSuccessFullScreen';
  static const String registerTruckLeavingScreen =
      '/registerTruckLeavingScreen';
  static const String coTruckLeavingInformationScreen =
      '/coTruckLeavingInformationScreen';
  static const String coAllRecentiesScreen = '/coAllRecentiesScreen';

  // Industria Section
  static const String inDashboardScreen = '/inDashboardScreen';
  static const String inMainMenuScreen = '/inMainMenuScreen';
  static const String inRegisterTruckArrivalScreen =
      '/inRegisterTruckArrivalScreen';
  static const String inTruckArrivalInfoScreen = '/inTruckArrivalInfoScreen';
  static const String inRegisterTruckUnloadingScreen =
      '/inRegisterTruckUnloadingScreen';
  static const String inTruckUnloadingInfoScreen =
      '/inTruckUnloadingInfoScreen';
  static const String inTruckUnlaodingBriefScreen =
      '/inTruckUnlaodingBriefScreen';
  static const String inRegistrationSuccessFullScreen =
      '/inRegistrationSuccessFullScreen';
  static const String inViajesDetailsScreen = '/inViajesDetailsScreen';
  static const String inAllReportsScreen = '/inAllReportsScreen';
  static const String choferesDetailsScreen = '/choferesDetailsScreen';
  static const String inChoferesDetailsScreen = '/inChoferesDetailsScreen';


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
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CreateVesselBodegaInfoScreen(
            vesselName: args['vesselName'],
            procedencia: args['procedencia'],
            shipper: args['shipper'],
            unCode: args['unCode'],
            portDate: args['portDate'],
            // numberOfCargos : args['numberOfCargos'],
            weightUnitEnum: args['weightUnitEnum'],
          ),
        );
      case adminCreateVesselCompleteDataScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CreateVesselCompleteDataScreen(
            vesselName: args['vesselName'],
            procedencia: args['procedencia'],
            shipper: args['shipper'],
            unCode: args['unCode'],
            portDate: args['portDate'],
            numberOfWines: args['numberOfWines'],
            weightUnitEnum: args['weightUnitEnum'],
            bogedaModels: args['bogedaModels'],
          ),
        );
      case registrationSuccessFullScreen:
        return _buildRoute(const RegistrationSuccessFullScreen());

      case adminCreateIndustryScreen:
        return _buildRoute(const CreateIndustryScreen());
      case adminCreateIndustryInformationScreen:
        // final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CreateIndustryInformationScreen(
              // numberOfIndustries: args['numberOfIndustries'],
              ),
        );
      case adminCreateIndustryCompleteDataScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CreateIndustryCompleteDataScreen(
            industrySubModels: args['industrySubModels'], cargoHoldWeights: args['cargoHoldWeights'],
          ),
        );

      case adminRegisterUserScreen:
        return _buildRoute(const RegisterUserScreen());

      case adminViajesDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(AdViajesDetailsScreen(
          viajesModel: args['viajesModel'],
        ));
      case adminViajesEditScreen:
        return _buildRoute(const AdViajesEditScreen());

      case adManageShipsScreen:
        return _buildRoute(const AdManageShipsScreen());
      case adAllRecentiesScreen:
        return _buildRoute(const AdAllRecentiesScreen());

      // Coordinator Screens
      case coMainMenuScreen:
        return _buildRoute(const CoMainMenuScreen());
      case registerTruckEnteringScreen:
        return _buildRoute(const RegisterTruckEnteringScreen());
      case coTruckInfoScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CoTruckInfoScreen(
            guideNumber: args['guideNumber'],
          ),
        );
      case coTruckBriefScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          CoTruckBriefScreen(
            guideNumber: args['guideNumber'],
            plateNumber: args['plateNumber'],
            marchamo: args['marchamo'],
            emptyTruckWeight: args['emptyTruckWeight'],
          ),
        );
      case coTruckLeavingBriefScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(CoTruckLeavingBriefScreen(
          fullTruckWeight: args['fullTruckWeight'],
          pureCargoWeight: args['pureCargoWeight'],
        ));
      case coRegistrationSuccessFullScreen:
        return _buildRoute(const CoRegistrationSuccessFullScreen());
      case registerTruckLeavingScreen:
        return _buildRoute(const RegisterTruckLeavingScreen());
      case coTruckLeavingInformationScreen:
        return _buildRoute(const CoTruckLeavingInformationScreen());
      case coAllRecentiesScreen:
        return _buildRoute(const CoAllRecentiesScreen());

      // Industria Section
      case inDashboardScreen:
        return _buildRoute(const InDashboardScreen());
      case inMainMenuScreen:
        return _buildRoute(const InMainMenuScreen());
      case inRegisterTruckArrivalScreen:
        return _buildRoute(const InRegisterTruckArrivalScreen());
      case inTruckArrivalInfoScreen:
        return _buildRoute(const InTruckArrivalInfoScreen());
      case inRegisterTruckUnloadingScreen:
        return _buildRoute(const InRegisterTruckUnlaodingScreen());
      case inTruckUnloadingInfoScreen:
        return _buildRoute(const InTruckUnlaodingInfoScreen());
      case inTruckUnlaodingBriefScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          InTruckUnlaodingBriefScreen(
            cargoUnloadWeight: args['cargoUnloadWeight'],
          ),
        );
      case inRegistrationSuccessFullScreen:
        return _buildRoute(const InRegistrationSuccessFullScreen());
      case inViajesDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(InViajesDetailsScreen(
          viajesModel: args['viajesModel'],
        ));
      case choferesDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(ChoferesDetailsScreen(
          choferesModel: args['choferesModel'],
        ));

      case inChoferesDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(InChoferesDetailsScreen(
          choferesModel: args['choferesModel'],
        ));

      case inAllReportsScreen:
        return _buildRoute(const InAllReportsScreen());

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
