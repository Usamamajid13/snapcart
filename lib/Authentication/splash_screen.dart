import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snapcart/Utils/app_utils.dart';

import '../Constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var utils = AppUtils();
  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            scale: 4,
          ),
          SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width,
          ),
          const Text(
            "Snap Cart",
            style: TextStyle(
              color: purpleColor,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Buy Scan And Save",
            style: utils.mediumTitleTextStyle(color: purpleColor),
          ),
        ],
      ),
    );
  }

  splashNavigator() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, catalogScreenRoute);
    });
  }
}
