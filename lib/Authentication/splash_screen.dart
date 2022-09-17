import 'dart:async';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Icon(
          Icons.qr_code,
          size: 100,
          color: purpleColor,
        ),
      ),
    );
  }

  splashNavigator() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, loginScreenRoute);
    });
  }
}
