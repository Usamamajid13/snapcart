import 'dart:io';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
      return e.message;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      return e.message;
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

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

  Future signOut() async {
    await _auth.signOut();
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
}
