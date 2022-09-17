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
          "Static Variable built the Privacy Policy Generator app as a Free app."
          ""
          " This SERVICE is provided by Static Variable at no extra cost and is intended for use as is."
          "This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Privacy Policy Generator unless otherwise defined in this Privacy Policy. ",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
