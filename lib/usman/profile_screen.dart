import 'package:flutter/material.dart';
import 'package:snapcart/Constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/account.png",
              scale: 5,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "USAMA MAJID",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          const SizedBox(
            height: 300,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    purpleColor.withOpacity(0.8),
                    purpleColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                "email@gmail.com",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    purpleColor.withOpacity(0.8),
                    purpleColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                "Joined 7 Sep 2022",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
