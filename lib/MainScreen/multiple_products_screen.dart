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
  double flourBill = 0;
  double riceBill = 0;
  double chocolateBill = 0;
  double biscuitsBill = 0;

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
    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "1 Bag Flour" ||
          qrValues[listOfBills[i]] == "2 Bag Flour") {
        flourBill = flourBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }

    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "1 Bag Rice" ||
          qrValues[listOfBills[i]] == "2 Bag Rice" ||
          qrValues[listOfBills[i]] == "3 Bag Rice") {
        riceBill = riceBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }

    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "1 Biscuits" ||
          qrValues[listOfBills[i]] == "2 Biscuits" ||
          qrValues[listOfBills[i]] == "3 Biscuits") {
        biscuitsBill = biscuitsBill +
            double.parse(
                listOfBills[i].toString().replaceAll('\$', "").toString());
      }
    }

    for (int i = 0; i < listOfBills.length; i++) {
      if (qrValues[listOfBills[i]] == "1 Chocolate Bar" ||
          qrValues[listOfBills[i]] == "2 Chocolate Bars" ||
          qrValues[listOfBills[i]] == "3 Chocolate Bars") {
        chocolateBill = chocolateBill +
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
                        const Text("Total Bread"),
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
                        const Text("Total Drinks"),
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
                        const Text("Total Meals"),
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
                        const Text("Total Eggs"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/eggs.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          flourBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          flourBill.toString(),
                        ),
                        const Text("Total Flour Bags"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/flour.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          riceBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          riceBill.toString(),
                        ),
                        const Text("Total Rice Bags"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/rice.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          chocolateBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          chocolateBill.toString(),
                        ),
                        const Text("Total Chocolates"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/chocolate.png",
                      scale: 14,
                    ),
                  ),
                )
              : Container(),
          biscuitsBill != 0.0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TicketMaterial(
                    height: 50,
                    colorBackground: purpleColor,
                    leftChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          biscuitsBill.toString(),
                        ),
                        const Text("Total Biscuits"),
                      ],
                    ),
                    rightChild: Image.asset(
                      "assets/biscuits.png",
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

  uploadBill() async {
    EasyLoading.show(status: "Loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bread;
    var drink;
    var meals;
    var eggs;
    var rice;
    var flour;
    var chocolate;
    var biscuits;
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
      rice = value["rice"];
      flour = value["flour"];
      chocolate = value["chocolate"];
      biscuits = value["biscuits"];
    });

    FirebaseFirestore.instance
        .collection("MultipleBills")
        .doc(email)
        .collection("myBills")
        .add({
      "date": DateTime.now().millisecondsSinceEpoch,
      "totalBill": bill,
      "email": email,
      "bread": breadBill,
      "drink": drinksBill,
      "meals": mealsBill,
      "eggs": eggsBill,
      "biscuits": biscuitsBill,
      "flour": flourBill,
      "rice": riceBill,
      "chocolate": chocolateBill,
    });
    bread = bread + breadBill;
    drink = drink + drinksBill;
    meals = meals + mealsBill;
    eggs = eggs + eggsBill;
    rice = rice + riceBill;
    chocolate = chocolate + chocolateBill;
    flour = flour + flourBill;
    biscuits = biscuits + biscuitsBill;

    FirebaseFirestore.instance.collection("FoodItems").doc(email).set({
      "bread": bread,
      "drink": drink,
      "meals": meals,
      "eggs": eggs,
      "flour": flour,
      "biscuits": biscuits,
      "rice": rice,
      "chocolate": chocolate,
    }).then((value) {
      prefs.remove("bills");
      EasyLoading.showSuccess("Bill Saved Successfully!");
      Navigator.pushReplacementNamed(context, homeScreenRoute);
    });
    EasyLoading.dismiss();
  }
}
