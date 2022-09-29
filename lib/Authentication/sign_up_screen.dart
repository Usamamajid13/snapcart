import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthController/auth_controller.dart';
import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var retypePasswordController = TextEditingController();
  var utils = AppUtils();
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _name;
  String? _password;
  bool isObscure1 = true;
  bool isObscure2 = true;

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      scale: 4,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create an account",
                        style: utils.largeLabelTextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    utils.textField(
                        validator: (val) =>
                            (!val.isNotEmpty || !val.toString().contains("@"))
                                ? "Please Enter A Valid Email"
                                : null,
                        onChange: (value) => _email = value,
                        hintText: "Please Enter your email",
                        obscureText: false,
                        labelText: "Email",
                        labelColor: purpleColor),
                    const SizedBox(
                      height: 15,
                    ),
                    utils.textField(
                        onChange: (value) => _name = value,
                        hintText: "Please Enter Your Name",
                        labelText: "Name",
                        labelColor: purpleColor,
                        obscureText: false,
                        validator: (pas) {
                          if (pas!.isEmpty) {
                            return 'Please Enter Your Name !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    utils.textField(
                        // controller: passwordController,
                        onChange: (value) => _password = value,
                        hintText: "Please Enter Your Password",
                        labelText: "Password",
                        labelColor: purpleColor,
                        obscureText: isObscure1,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isObscure1 = !isObscure1;
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                        validator: (pas) {
                          if (pas!.isEmpty) {
                            return 'Please Enter Your Password !';
                          }
                          if (pas.length < 8) {
                            return 'Please enter more then 8 number';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    utils.textField(
                        controller: retypePasswordController,
                        hintText: "Please Enter Your Password",
                        labelText: "Retype Password",
                        labelColor: purpleColor,
                        obscureText: isObscure2,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isObscure2 = !isObscure2;
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                        validator: (pas) {
                          if (pas!.isEmpty) {
                            return 'Please Enter Your Password !';
                          }
                          if (pas.length < 8) {
                            return 'Please enter more then 8 number';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: utils.bigButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        containerColor: purpleColor,
                        text: "Sign Up",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        shadowColors: purpleColor,
                        textColor: Colors.white,
                        borderRadius: 10.0,
                        onTap: () => onTapSingIn(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, loginScreenRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: utils.smallTitleTextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Sign In",
                            style:
                                utils.smallHeadingTextStyle(color: purpleColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? kEmailValidator(String? emailValue) {
    if (emailValue!.isEmpty) {
      return 'Email is required !';
    }
    String p =
        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(emailValue)) {
      return null;
    } else {
      return 'Email Syntax is not Correct';
    }
  }

  void onTapSingIn() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    if (kDebugMode) {
      print(_email);
    }
    EasyLoading.show(status: "Loading...");
    Authentication()
        .signUp(email: _email.toString(), password: _password.toString())
        .then((result) async {
      if (result == null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(_email.toString())
            .set({
          "email": _email,
          "password": _password,
          "name": _name,
          "date": DateTime.now().millisecondsSinceEpoch,
        });
        FirebaseFirestore.instance.collection("FoodItems").doc(_email).set({
          "bread": 0.00,
          "drink": 0.00,
          "meals": 0.00,
          "eggs": 0.00,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("currentUserEmail", _email.toString());
        EasyLoading.showSuccess("Sign Up Successful");
        Navigator.pushNamed(context, uploadProfilePictureScreenRoute,
            arguments: _email);
      }
    });
    Timer(const Duration(seconds: 30), () {
      EasyLoading.dismiss();
    });
  }
}
