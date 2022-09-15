import 'dart:io';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//////////////////////////sign up method

  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());

      return e.message;
    } on PlatformException catch (e) {
      EasyLoading.showError(e.message.toString());

      return e.message;
    } on SocketException catch (e) {
      EasyLoading.showError(e.message.toString());

      return e.message;
    }
  }

  ////////////////// sign out
  Future signOut() async {
    await _auth.signOut();

    if (kDebugMode) {
      print('signed out');
    }
  }

  late EmailAuth auth;

  Future enterEmailAuth(email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
      return e.message;
    } on PlatformException catch (e) {
      EasyLoading.showError(e.message.toString());

      if (kDebugMode) {
        print(e.message);
      }
      return e.message;
    } on SocketException catch (e) {
      EasyLoading.showError(e.message.toString());

      if (kDebugMode) {
        print(e.message);
      }
      return e.message;
    }
  }

  Future resetPassword() async {
    try {
      // await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    }
  }
}
