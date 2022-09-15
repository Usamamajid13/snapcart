import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapcart/Constants/constants.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;

  void checkUserExistence(BuildContext context) {
    if (_auth.currentUser == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, loginScreenRoute, (route) => false);

      return;
    }
    Navigator.pushNamedAndRemoveUntil(
        context, homeScreenRoute, (route) => false);
  }
}
