import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/screens/login_screen.dart';
import 'package:cargocontrol/widgets/main_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart' as constants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: constants.kColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData().textTheme),
      ),
      home: const LoginScreen(),
    );
  }
}
