import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../Model/single_product_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String? _chosenValue;
  @override
  void initState() {
    getMyHistory();
    super.initState();
  }

  List bills = [];
  int? lengthOfHistory;
  List docs = [];

  getMyHistory() async {
    bills.clear();
    docs.clear();
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
        docs.add(value.docs[i].id);
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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    iconEnabledColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    items: <String>[
                      'Last 3 Days',
                      'Last Week',
                      'Last Month',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: purpleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Filter ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                        if (_chosenValue == "Last Week") {
                          appleFilterOneWeek();
                        } else if (_chosenValue == "Last Month") {
                          appleFilterOneMonth();
                        } else if (_chosenValue == "Last 3 Days") {
                          appleFilterThreeDays();
                        }
                      });
                    },
                  ),
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
                  : docs.isEmpty
                      ? Center(
                          child: Text(
                            "No Documents Available",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (int i = 0; i < lengthOfHistory!; i++)
                              GestureDetector(
                                onTap: () {
                                  var details = SingleProductHistory(
                                    date: DateFormat('dd MMMM, yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            bills[i]["date"])),
                                    totalBill: "\$${bills[i]["totalBill"]}",
                                    type: "Single Product Purchase",
                                    key: bills[i].toString().contains("bread")
                                        ? "Bread"
                                        : bills[i].toString().contains("drink")
                                            ? "Drink"
                                            : bills[i]
                                                    .toString()
                                                    .contains("eggs")
                                                ? "Eggs"
                                                : bills[i]
                                                        .toString()
                                                        .contains("chocolate")
                                                    ? "Chocolate"
                                                    : bills[i]
                                                            .toString()
                                                            .contains("rice")
                                                        ? "Rice"
                                                        : bills[i]
                                                                .toString()
                                                                .contains(
                                                                    "flour")
                                                            ? "Flour"
                                                            : bills[i]
                                                                    .toString()
                                                                    .contains(
                                                                        "biscuits")
                                                                ? "Biscuits"
                                                                : "Meal",
                                  );
                                  Navigator.pushNamed(
                                      context, historyDetailScreenRoute,
                                      arguments: details);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: purpleColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        bills[i]["date"])),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Text("13",
                                      Row(
                                        children: [
                                          Text("\$${bills[i]["totalBill"]}",
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              print("deleting");
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var user = prefs.getString(
                                                  "currentUserEmail");
                                              print(docs[i]);
                                              print(user);
                                              var a = FirebaseFirestore.instance
                                                  .collection("Bills")
                                                  .doc(user)
                                                  .collection("myBills")
                                                  .doc(docs[i])
                                                  .delete()
                                                  .then((value) {
                                                EasyLoading.showSuccess(
                                                    "Deleted!");
                                              });
                                              print(a.toString());
                                              getMyHistory();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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

  appleFilterOneWeek() async {
    bills = [];
    if (kDebugMode) {
      print("filter");
    }
    lengthOfHistory = null;
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 7));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    FirebaseFirestore.instance
        .collection("Bills")
        .doc(user)
        .collection("myBills")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (now_1w.isBefore(DateTime.fromMillisecondsSinceEpoch(
            value.docs[i].data()["date"]))) {
          bills.add(value.docs[i].data());
          if (kDebugMode) {
            print("Here $i");
          }
        }
      }
      lengthOfHistory = bills.length;
      setState(() {});
    });
  }

  appleFilterOneMonth() async {
    bills = [];
    if (kDebugMode) {
      print("filter");
    }
    lengthOfHistory = null;
    var now = DateTime.now();
    var now_1m = DateTime(now.year, now.month - 1, now.day);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    FirebaseFirestore.instance
        .collection("Bills")
        .doc(user)
        .collection("myBills")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (now_1m.isBefore(DateTime.fromMillisecondsSinceEpoch(
            value.docs[i].data()["date"]))) {
          bills.add(value.docs[i].data());
          if (kDebugMode) {
            print("Here $i");
          }
        }
      }
      lengthOfHistory = bills.length;
      setState(() {});
    });
  }

  appleFilterThreeDays() async {
    bills = [];
    if (kDebugMode) {
      print("filter");
    }
    lengthOfHistory = null;
    var now = DateTime.now();
    var now_3d = now.subtract(const Duration(days: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    FirebaseFirestore.instance
        .collection("Bills")
        .doc(user)
        .collection("myBills")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (now_3d.isBefore(DateTime.fromMillisecondsSinceEpoch(
            value.docs[i].data()["date"]))) {
          bills.add(value.docs[i].data());
          if (kDebugMode) {
            print("Here $i");
          }
        }
      }
      lengthOfHistory = bills.length;
      setState(() {});
    });
  }
}
