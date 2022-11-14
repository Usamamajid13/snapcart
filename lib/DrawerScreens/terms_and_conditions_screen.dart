import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Terms And Conditions'),
        elevation: 10.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          // TODO: Add terms and conditions here
          "",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
