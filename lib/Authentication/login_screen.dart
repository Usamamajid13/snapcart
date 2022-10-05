import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthController/auth_controller.dart';
import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSecure = true;
  bool loginCheck = false;
  GlobalKey<FormState> globalFomKey = GlobalKey<FormState>();
  var utils = AppUtils();
  String? _email;
  String? _password;
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
        key: globalFomKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hi, Welcome Back!",
                        style: utils.largeLabelTextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    utils.textField(
                        validator: (val) =>
                            (!val.isNotEmpty || !val.toString().contains("@"))
                                ? "Please Enter A Valid Email"
                                : null,
                        obscureText: false,
                        onChange: (value) => _email = value,
                        hintText: "Enter your email",
                        labelText: "Email",
                        labelColor: purpleColor),
                    const SizedBox(
                      height: 15,
                    ),
                    utils.textField(
                        onChange: (value) => _password = value,
                        hintText: "Please Enter Your Password",
                        obscureText: isSecure,
                        labelText: "Password",
                        labelColor: purpleColor,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isSecure = !isSecure;
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: purpleColor,
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, forgotPasswordScreenRoute);
                          },
                          child: Text(
                            "Forgot Password",
                            style: utils.smallLableTextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: utils.bigButton(
                        onTap: () {
                          onTapSingIn();
                        },
                        width: MediaQuery.of(context).size.width * 0.9,
                        containerColor: purpleColor,
                        text: "Sign In",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        shadowColors: purpleColor,
                        textColor: Colors.white,
                        borderRadius: 10.0,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, signUpScreenRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: utils.smallTitleTextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Sign Up",
                            style:
                                utils.smallHeadingTextStyle(color: purpleColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSingIn() {
    if (!globalFomKey.currentState!.validate()) return;
    globalFomKey.currentState!.save();
    if (kDebugMode) {
      print(_email);
    }
    EasyLoading.show(status: "Loading...");
    Authentication()
        .signIn(email: _email.toString().trim(), password: _password.toString())
        .then((result) async {
      if (result == null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("currentUserEmail", _email.toString());
        EasyLoading.showSuccess("Log In Successful");
        Navigator.pushNamedAndRemoveUntil(
            context, homeScreenRoute, (route) => false);
      }
    });
  }
}
