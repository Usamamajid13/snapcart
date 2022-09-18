import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Authentication/catalog_screen.dart';
import 'Authentication/forgot_password.dart';
import 'Authentication/login_screen.dart';
import 'Authentication/sign_up_screen.dart';
import 'Authentication/splash_screen.dart';
import 'Constants/constants.dart';
import 'MainScreen/home_screen.dart';
import 'DrawerScreens/privacy_screen.dart';
import 'DrawerScreens/terms_and_conditions_screen.dart';
import 'DrawerScreens/history_screen.dart';
import 'DrawerScreens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = purpleColor
    ..textColor = Colors.white
    ..maskColor = purpleColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapcart',
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreenRoute,
      builder: EasyLoading.init(),
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        loginScreenRoute: (context) => const LoginScreen(),
        forgotPasswordScreenRoute: (context) => const ForgotPasswordScreen(),
        signUpScreenRoute: (context) => const SignUpScreen(),
        homeScreenRoute: (context) => const HomeScreen(),
        privacyScreenRoute: (context) => const PrivacyScreen(),
        termsAndConditionsScreenRoute: (context) => const TermsAndConditions(),
        historyScreenRoute: (context) => const HistoryScreen(),
        profileScreenRoute: (context) => const ProfileScreen(),
        catalogScreenRoute: (context) => const CatalogScreen(),
      },
    );
  }
}
