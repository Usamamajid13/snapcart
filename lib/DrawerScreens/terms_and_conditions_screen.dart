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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Please read these terms and conditions carefully operated by Snap Cart  ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Conditions of use ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "By using this Application, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. If you do not want to be bound by the terms of this Agreement, you are advised to stop using the App accordingly. Snap Cart only grants use and access of this App, its products, and its services to those who have accepted its terms. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Privacy policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Before you continue using our App, we advise you to read our privacy policy given in our App Menu regarding our user data collection. It will help you better understand our practices. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Intellectual property ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You agree that all materials, products, and services provided on this App are the property of Snap Cart, its affiliates, directors, officers, employees, agents, suppliers, or licensors including all copyrights, trade secrets, trademarks, patents, and other intellectual property. You also agree that you will not reproduce or redistribute the Snap Cart intellectual property in any way, including electronic, digital, or new trademark registrations. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "User accounts ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "As a user of this App, you may be asked to register with us and provide private information. You are responsible for ensuring the accuracy of this information, and you are responsible for maintaining the safety and security of your identifying information. You are also responsible for all activities that occur under your account or password. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "If you think there are any possible issues regarding the security of your account on the App, inform us immediately so we may address them accordingly. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Disputes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Any dispute related in any way to your use of this App or to products you purchase from us shall be arbitrated by state or federal court of Pakistan and you consent to exclusive jurisdiction and venue of such courts. ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Indemnification",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You agree to indemnify Snap Cart and its affiliates and hold Snap Cart harmless against legal claims and demands that may arise from your use or misuse of our services. We reserve the right to select our own legal counsel.  ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Limitation on liability ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Snap Cart is not liable for any damages that may occur to you as a result of your misuse of our App. \n \nSnap Cart reserves the right to edit, modify, and change this Agreement at any time. We shall let our users know of these changes through electronic mail. This Agreement is an understanding between Snap Cart and the user, and this supersedes and replaces all prior agreements regarding the use of this App.",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
