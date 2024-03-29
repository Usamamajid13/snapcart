import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_material/ticket_material.dart';

import '../Constants/constants.dart';
import '../QrValues/Qr.dart';

class SingleProductScreen extends StatefulWidget {
  final scannedBill;
  const SingleProductScreen(this.scannedBill, {Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  String? email;

  @override
  void initState() {
    getUser();
    if (kDebugMode) {
      print(widget.scannedBill.toString());
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Products'),
        elevation: 10.0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: TicketMaterial(
              height: 50,
              colorBackground: purpleColor,
              leftChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.scannedBill,
                  ),
                  Text(qrValues[widget.scannedBill]),
                ],
              ),
              rightChild: Image.asset(
                qrValues[widget.scannedBill] == "Medium Bread" ||
                        qrValues[widget.scannedBill] == "Small Bread" ||
                        qrValues[widget.scannedBill] == "Large Bread"
                    ? "assets/bread.png"
                    : qrValues[widget.scannedBill] == "Small Food Deal" ||
                            qrValues[widget.scannedBill] ==
                                "Medium Food Deal" ||
                            qrValues[widget.scannedBill] == "Large Food Deal"
                        ? "assets/burger.png"
                        : qrValues[widget.scannedBill] == "1.5 Litre Drink" ||
                                qrValues[widget.scannedBill] ==
                                    "2 Litre Drink" ||
                                qrValues[widget.scannedBill] ==
                                    "2.25 Litre Drink"
                            ? "assets/drink.png"
                            : qrValues[widget.scannedBill] == "1 Biscuits" ||
                                    qrValues[widget.scannedBill] ==
                                        "2 Biscuits" ||
                                    qrValues[widget.scannedBill] == "3 Biscuits"
                                ? "assets/biscuits.png"
                                : qrValues[widget.scannedBill] ==
                                            "1 Chocolate Bar" ||
                                        qrValues[widget.scannedBill] ==
                                            "2 Chocolate Bars" ||
                                        qrValues[widget.scannedBill] ==
                                            "3 Chocolate Bars"
                                    ? "assets/chocolate.png"
                                    : qrValues[widget.scannedBill] ==
                                                "1 Bag Rice" ||
                                            qrValues[widget.scannedBill] ==
                                                "2 Bag Rice" ||
                                            qrValues[widget.scannedBill] ==
                                                "3 Bag Rice"
                                        ? "assets/rice.png"
                                        : qrValues[widget.scannedBill] ==
                                                    "1 Bag Flour" ||
                                                qrValues[widget.scannedBill] ==
                                                    "2 Bag Flour"
                                            ? "assets/flour.png"
                                            : "assets/eggs.png",
                scale: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: TicketMaterial(
              height: 50,
              colorBackground: Colors.white,
              leftChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.scannedBill,
                  ),
                  const Text("Total Expenses"),
                ],
              ),
              rightChild: const Icon(Icons.emoji_food_beverage_rounded),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              uploadBill();
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
              Navigator.pushReplacementNamed(context, multipleScansScreenRoute,
                  arguments: widget.scannedBill);
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadBill() async {
    EasyLoading.show(status: "Loading...");

    var bread;
    var drink;
    var meals;
    var eggs;
    var biscuits;
    var flour;
    var rice;
    var chocolate;
    if (kDebugMode) {
      print(widget.scannedBill.toString().replaceAll("\$", ""));
    }

    await FirebaseFirestore.instance
        .collection("FoodItems")
        .doc(email)
        .get()
        .then((value) {
      bread = value["bread"];
      drink = value["drink"];
      meals = value["meals"];
      eggs = value["eggs"];
      biscuits = value["biscuits"];
      flour = value["flour"];
      rice = value["rice"];
      chocolate = value["chocolate"];
    });

    if (qrValues[widget.scannedBill] == "Medium Bread" ||
        qrValues[widget.scannedBill] == "Small Bread" ||
        qrValues[widget.scannedBill] == "Large Bread") {
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "bread":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
      bread = bread +
          double.parse(widget.scannedBill.toString().replaceAll('\$', ""));
    } else if (qrValues[widget.scannedBill] == "Small Food Deal" ||
        qrValues[widget.scannedBill] == "Medium Food Deal" ||
        qrValues[widget.scannedBill] == "Large Food Deal") {
      meals = meals +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "meals":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else if (qrValues[widget.scannedBill] == "1.5 Litre Drink" ||
        qrValues[widget.scannedBill] == "2 Litre Drink" ||
        qrValues[widget.scannedBill] == "2.25 Litre Drink") {
      drink = drink +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "drink":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else if (qrValues[widget.scannedBill] == "1 Biscuits" ||
        qrValues[widget.scannedBill] == "2 Biscuits" ||
        qrValues[widget.scannedBill] == "3 Biscuits") {
      biscuits = biscuits +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "biscuits":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else if (qrValues[widget.scannedBill] == "1 Chocolate Bar" ||
        qrValues[widget.scannedBill] == "2 Chocolate Bars" ||
        qrValues[widget.scannedBill] == "3 Chocolate Bars") {
      chocolate = chocolate +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "chocolate":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else if (qrValues[widget.scannedBill] == "1 Bag Flour" ||
        qrValues[widget.scannedBill] == "2 Bag Flour") {
      flour = flour +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "flour":
            double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else if (qrValues[widget.scannedBill] == "1 Bag Rice" ||
        qrValues[widget.scannedBill] == "2 Bag Rice" ||
        qrValues[widget.scannedBill] == "3 Bag Rice") {
      rice = rice +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "rice": double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
    } else {
      FirebaseFirestore.instance
          .collection("Bills")
          .doc(email)
          .collection("myBills")
          .add({
        "date": DateTime.now().millisecondsSinceEpoch,
        "totalBill": widget.scannedBill.toString().replaceAll("\$", ""),
        "email": email,
        "eggs": double.parse(widget.scannedBill.toString().replaceAll('\$', ""))
      });
      eggs = eggs +
          double.parse(
              widget.scannedBill.toString().replaceAll('\$', "").toString());
    }
    if (kDebugMode) {
      print({
        "bread": bread,
        "drink": drink,
        "meals": meals,
        "eggs": eggs,
      });
    }
    FirebaseFirestore.instance.collection("FoodItems").doc(email).set({
      "bread": bread,
      "drink": drink,
      "meals": meals,
      "eggs": eggs,
      "rice": rice,
      "flour": flour,
      "chocolate": chocolate,
      "biscuits": biscuits,
    }).then((value) {
      EasyLoading.showSuccess("Bill Saved Successfully!");
      Navigator.pushReplacementNamed(context, homeScreenRoute);
    });
    EasyLoading.dismiss();
  }
}
