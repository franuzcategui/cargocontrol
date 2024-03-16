import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/loading_screen.dart';
import 'package:cargocontrol/utils/thems/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'commons/common_imports/common_libs.dart';
import 'core/enums/account_type.dart';
import 'core/firebase_messaging/firebase_messaging_class.dart';
import 'core/firebase_messaging/service/notification_service.dart';
import 'core/services/database_service.dart';
import 'features/admin/main_menu/views/ad_main_menu_screen.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/controllers/auth_notifier_controller.dart';
import 'features/industry/main_menu/views/in_main_menu_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAuth();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.requestPermission(Permission.notification);
  LocalNotificationService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}


Future<void> initAuth() async {
  await Hive.initFlutter();
  // Done remove this line below
  final authService = AuthService();
}



class MyApp extends ConsumerStatefulWidget{
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initiateFirebaseMessaging();
  }


  initiateFirebaseMessaging() async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message: message, context: context, navigatorKey: navigatorKey);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.displayBackgroundNotifications(message: message, context: context, navigatorKey: navigatorKey);

    });
    messagingFirebase.uploadFcmToken();
  }

  @override
  Widget build(BuildContext context) {
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
      //fontSizeResolver: FontSizeResolvers.height,
      fontSizeResolver: kIsWeb?(num size, ScreenUtil instance) {
        // Define your custom logic to adjust font size based on screen height
        // For example, you can increase font size for larger screens

        double width=MediaQuery.of(context).size.width;
        double scaleFactor = 1.0;
        if (width < 600) {
          scaleFactor = 10.0; // Font size for smaller screens
        } else if (width < 1000) {
          scaleFactor = 11.1; // Font size for medium screens
        } else {
          scaleFactor = 12.2; // Font size for larger screens
        }
        return (MediaQuery.of(context).size.width /MediaQuery.of(context).size.height) * scaleFactor;
      }:FontSizeResolvers.height,
      rebuildFactor: RebuildFactors.none,
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
