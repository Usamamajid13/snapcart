import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_material/ticket_material.dart';

import '../Constants/constants.dart';
import '../QrValues/Qr.dart';

class MultipleProductsScreen extends StatefulWidget {
  final scannedBill;
  const MultipleProductsScreen(this.scannedBill, {Key? key}) : super(key: key);

  @override
  State<MultipleProductsScreen> createState() => _MultipleProductsScreenState();
}

class _MultipleProductsScreenState extends State<MultipleProductsScreen> {
  String? email;

  @override
  void initState() {
    getUser();
    if (kDebugMode) {
      print(widget.scannedBill.toString());
    }
    getPreviousBills();
    super.initState();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    if (kDebugMode) {
      print(user);
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .get()
        .then((value) {
      email = value.data()!["email"];
      setState(() {});
    });
  }

  List<String> listOfBills = [];
  getPreviousBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var oldBills = prefs.getStringList("bills");
    if (oldBills != null) {
      listOfBills = oldBills;
      listOfBills.add(widget.scannedBill);
      prefs.setStringList("bills", listOfBills);
    } else {
      listOfBills.add(widget.scannedBill);
      prefs.setStringList("bills", listOfBills);
    }
    setState(() {});
    calculateTotalBill();
  }

  double bill = 0;
  double breadBill = 0;
  double drinksBill = 0;
  double mealsBill = 0;
  double eggsBill = 0;

  calculateTotalBill() {
    for (int i = 0; i < listOfBills.length; i++) {
      bill = bill +
          double.parse(
              listOfBills[i].toString().replaceAll('\$', "").toString());
    }
    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "Medium Bread" ||
          qrValues[listOfBills[i]] == "Small Bread" ||
          qrValues[listOfBills[i]] == "Large Bread") {
        breadBill = breadBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }
    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "1.5 Litre Drink" ||
          qrValues[listOfBills[i]] == "2 Litre Drink" ||
          qrValues[listOfBills[i]] == "2.25 Litre Drink") {
        drinksBill = drinksBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }
    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "Small Food Deal" ||
          qrValues[listOfBills[i]] == "Medium Food Deal" ||
          qrValues[listOfBills[i]] == "Large Food Deal") {
        mealsBill = mealsBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }

    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "36 Eggs" ||
          qrValues[listOfBills[i]] == "24 Eggs" ||
          qrValues[listOfBills[i]] == "12 Eggs") {
        eggsBill = eggsBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }

    if (kDebugMode) {
      print("Total Bill = = = = = == = = $bill");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Multiple Products'),
        elevation: 10.0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          breadBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          breadBill.toString(),
                        ),
                        Text("Total Bread"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/bread.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          drinksBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          drinksBill.toString(),
                        ),
                        Text("Total Drinks"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/drink.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          mealsBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          mealsBill.toString(),
                        ),
                        Text("Total Meals"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/burger.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          eggsBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          eggsBill.toString(),
                        ),
                        Text("Total Eggs"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/eggs.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: TicketMaterial(
              height: 50,
              colorBackground: Colors.white,
              leftChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "\$${bill.toStringAsFixed(2)}",
                  ),
                  const Text("Total Expenses"),
                ],
              ),
              rightChild: const Icon(Icons.emoji_food_beverage_rounded),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // uploadBill();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.calculate_sharp,
                      color: purpleColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Save Bill",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, doubleScannerScreenRoute);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.qr_code_scanner,
                    color: purpleColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Scan More",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  // uploadBill() async {
  //   EasyLoading.show(status: "Loading...");
  //
  //   var bread;
  //   var drink;
  //   var meals;
  //   var eggs;
  //   if (kDebugMode) {
  //     print(widget.scannedBill.toString().replaceAll("\$", ""));
  //   }
  //
  //   await FirebaseFirestore.instance
  //       .collection("FoodItems")
  //       .doc(email)
  //       .get()
  //       .then((value) {
  //     bread = value["bread"];
  //     drink = value["drink"];
  //     meals = value["meals"];
  //     eggs = value["eggs"];
  //   });
  //   if (kDebugMode) {
  //     print({
  //       "bread": bread,
  //       "drink": drink,
  //       "meals": meals,
  //       "eggs": eggs,
  //     });
  //   }
  //   if (qrValues[widget.scannedBill] == "Medium Bread" ||
  //       qrValues[widget.scannedBill] == "Small Bread" ||
  //       qrValues[widget.scannedBill] == "Large Bread") {
  //     FirebaseFirestore.instance
  //         .collection("Bills")
  //         .doc(email)
  //         .collection("myBills")
  //         .add({
  //       "date": DateTime.now().millisecondsSinceEpoch,
  //       "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
  //       "email": email,
  //       "bread":
  //           double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
  //     });
  //     bread = bread +
  //         double.parse(widget.scannedBill.toString().replaceAll('\$', ""));
  //   } else if (qrValues[widget.scannedBill] == "Small Food Deal" ||
  //       qrValues[widget.scannedBill] == "Medium Food Deal" ||
  //       qrValues[widget.scannedBill] == "Large Food Deal") {
  //     meals = meals +
  //         double.parse(
  //             widget.scannedBill.toString().replaceAll('\$', "").toString());
  //     FirebaseFirestore.instance
  //         .collection("Bills")
  //         .doc(email)
  //         .collection("myBills")
  //         .add({
  //       "date": DateTime.now().millisecondsSinceEpoch,
  //       "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
  //       "email": email,
  //       "meals":
  //           double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
  //     });
  //   } else if (qrValues[widget.scannedBill] == "1.5 Litre Drink" ||
  //       qrValues[widget.scannedBill] == "2 Litre Drink" ||
  //       qrValues[widget.scannedBill] == "2.25 Litre Drink") {
  //     drink = drink +
  //         double.parse(
  //             widget.scannedBill.toString().replaceAll('\$', "").toString());
  //     FirebaseFirestore.instance
  //         .collection("Bills")
  //         .doc(email)
  //         .collection("myBills")
  //         .add({
  //       "date": DateTime.now().millisecondsSinceEpoch,
  //       "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
  //       "email": email,
  //       "drink":
  //           double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
  //     });
  //   } else {
  //     FirebaseFirestore.instance
  //         .collection("Bills")
  //         .doc(email)
  //         .collection("myBills")
  //         .add({
  //       "date": DateTime.now().millisecondsSinceEpoch,
  //       "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
  //       "email": email,
  //       "eggs": double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
  //     });
  //     eggs = eggs +
  //         double.parse(
  //             widget.scannedBill.toString().replaceAll('\$', "").toString());
  //   }
  //   if (kDebugMode) {
  //     print({
  //       "bread": bread,
  //       "drink": drink,
  //       "meals": meals,
  //       "eggs": eggs,
  //     });
  //   }
  //   FirebaseFirestore.instance.collection("FoodItems").doc(email).set({
  //     "bread": bread,
  //     "drink": drink,
  //     "meals": meals,
  //     "eggs": eggs,
  //   }).then((value) {
  //     EasyLoading.showSuccess("Bill Saved Successfully!");
  //     Navigator.pushReplacementNamed(context, homeScreenRoute);
  //   });
  //   EasyLoading.dismiss();
  // }
}
