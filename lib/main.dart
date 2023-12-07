import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/authentication/controller/authentication_state.dart';
import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:cargocontrol/features/dashboard/components/main_nav_bar.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/thems/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commons/common_imports/common_libs.dart';
import 'features/industry/main_menu/views/in_main_menu_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);

    Widget getHome() {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        return const InMainMenuScreen();
      } else if (authenticationState.status ==
          AuthenticationStatus.unauthenticated) {
        return const LoginScreen();
      } else {
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
            //Text is generally big on IOS ro that why we set text scale factor for IOS to 0.9
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: Theme.of(context).platform == TargetPlatform.iOS?0.8:1
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
