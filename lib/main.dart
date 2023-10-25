import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:cargocontrol/authentication/controller/authentication_state.dart';
import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/features/sign_in/components/login_screen.dart';
import 'package:cargocontrol/features/dashboard/components/main_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart' as constants;

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
        return const MainNavBar();
      } else if (authenticationState.status ==
          AuthenticationStatus.unauthenticated) {
        return const LoginScreen();
      } else {
        return const LoginScreen();
      }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: constants.kColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData().textTheme),
      ),
      home: getHome(),
    );
  }
}
