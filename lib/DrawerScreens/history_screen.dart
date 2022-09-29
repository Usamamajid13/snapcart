import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    getMyHistory();
    super.initState();
  }

  List bills = [];
  int? lengthOfHistory;
  getMyHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    FirebaseFirestore.instance
        .collection("Bills")
        .doc(user)
        .collection("myBills")
        .get()
        .then((value) {
      lengthOfHistory = value.docs.length;
      for (int i = 0; i < value.docs.length; i++) {
        bills.add(value.docs[i].data());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('History'),
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "HISTORY LIST",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 14,
                width: MediaQuery.of(context).size.width,
              ),
              lengthOfHistory == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        for (int i = 0; i < lengthOfHistory!; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 70,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Record ${i + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd MMMM, yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              bills[i]["date"])),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                // Text("13",
                                Text("\$${bills[i]["totalBill"]}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
