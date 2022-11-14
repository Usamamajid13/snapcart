import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Privacy Policy'),
        elevation: 10.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          // TODO: Add privacy policy here

          "",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
