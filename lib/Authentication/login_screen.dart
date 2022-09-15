import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  bool _isLoading = false;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: globalFomKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hi, Welcome Back!",
                        style: utils.largeLabelTextStyle(),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  loginCheck = !loginCheck;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: loginCheck
                                        ? purpleColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        width: 1,
                                        color: loginCheck
                                            ? Colors.transparent
                                            : Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: loginCheck
                                      ? const Icon(
                                          Icons.check,
                                          size: 12.0,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          size: 12.0,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Remember Me",
                              style: utils.smallLableTextStyle(),
                            ),
                          ],
                        ),
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

    setState(() => _isLoading = true);
    Authentication()
        .signIn(email: _email.toString(), password: _password.toString())
        .then((result) {
      if (result == null) {
        Navigator.pushNamed(context, homeScreenRoute);
      }

      setState(() => _isLoading = false);
    });
  }
}
