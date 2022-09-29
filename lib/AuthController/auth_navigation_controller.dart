import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapcart/Constants/constants.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;

  Future<void> checkUserExistence(BuildContext context) async {
    if (_auth.currentUser == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, catalogScreenRoute, (route) => false);

      return;
    }
    if (kDebugMode) {
      print(_auth.currentUser!.email.toString());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("currentUserEmail", _auth.currentUser!.email.toString());
    Navigator.pushNamedAndRemoveUntil(
        context, homeScreenRoute, (route) => false);
  }
}
