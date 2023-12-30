import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/authentication/controller/authentication_state.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/core/enums/account_type.dart';
import 'package:cargocontrol/features/admin/main_menu/views/ad_main_menu_screen.dart';
import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:cargocontrol/utils/thems/loading_screen.dart';
import 'package:cargocontrol/utils/thems/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'commons/common_imports/common_libs.dart';
import 'core/services/database_service.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/industry/main_menu/views/in_main_menu_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAuth();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}


Future<void> initAuth() async {
  await Hive.initFlutter();
  final authService = AuthService();


}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authServiceProvider);

    Widget getHome(){
      String? uid = authenticationState.getAuth();
      if(uid != '' && uid != null){
        return ref.watch(fetchUserByIdProvider(uid)).when(
            data: (userModel){
              ref.read(authNotifierCtr).setFirstTimeModel(userModel);
              switch(userModel.accountType){
                case AccountTypeEnum.administrador:
                  return const AdMainMenuScreen();
                case AccountTypeEnum.coordinator:
                  return const CoMainMenuScreen();
                case AccountTypeEnum.industria:
                  return const InMainMenuScreen();
                default:
                  return const LoadingScreen();
              }
            },
            error: (error, st){
              debugPrintStack(stackTrace: st);
              debugPrint(error.toString());
              return const LoadingScreen();
            },
            loading: (){
              return const LoadingScreen();
            }
        );
      }else{
        return const LoginScreen();
      }
    }

    return ScreenUtilInit(
      designSize: const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (BuildContext context,Widget? child){
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: Theme.of(context).platform == TargetPlatform.iOS?1:1
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Cargo-App',
          theme: lightThemeData(context),
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: getHome(),
        );
      },
    );
  }
}
