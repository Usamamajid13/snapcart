import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapcart/AuthController/auth_controller.dart';
import '../Constants/constants.dart';
import '../Model/item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Items? item1;
  Items? item2;
  Items? item3;
  Items? item4;
  Items? item5;
  Items? item6;
  Items? item7;
  Items? item8;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  String? name;
  String? email;
  String? pic;
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
      if (kDebugMode) {
        print(value.data());
      }
      name = value.data()!["name"];
      email = value.data()!["email"];
      if (kDebugMode) {
        print(name);
      }
      if (kDebugMode) {
        print(email);
      }
      setState(() {});
    });
    FirebaseFirestore.instance
        .collection("profilePictures")
        .doc(user)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.data());
      }
      pic = value.data()!["profilePicture"];

      setState(() {});
    });
    getAllBills();
  }

  var bread = 0.0;
  var drink = 0.0;
  var meals = 0.0;
  var eggs = 0.0;
  var flour = 0.0;
  var rice = 0.0;
  var chocolate = 0.0;
  var biscuits = 0.0;
  List<Items>? myList = [];

  getAllBills() async {
    myList!.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("currentUserEmail");
    FirebaseFirestore.instance
        .collection("FoodItems")
        .doc(user)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      bread = value["bread"].toDouble();
      drink = value["drink"].toDouble();
      meals = value["meals"].toDouble();
      eggs = value["eggs"].toDouble();
      flour = value["flour"].toDouble();
      rice = value["rice"].toDouble();
      chocolate = value["chocolate"].toDouble();
      biscuits = value["biscuits"].toDouble();
      if (kDebugMode) {
        print(bread);
      }
      if (kDebugMode) {
        print(drink);
      }
      if (kDebugMode) {
        print(meals);
      }
      if (kDebugMode) {
        print(eggs);
      }
      item1 = Items(
          title: "Eggs",
          event: "\$${eggs.toStringAsFixed(2)}",
          img: "assets/eggs.png");
      myList!.add(item1!);
      setState(() {});
      item2 = Items(
          title: "Bread",
          event: "\$${bread.toStringAsFixed(2)}",
          img: "assets/bread.png");
      myList!.add(item2!);
      setState(() {});
      item3 = Items(
          title: "Drinks",
          event: "\$${drink.toStringAsFixed(2)}",
          img: "assets/drink.png");
      myList!.add(item3!);
      setState(() {});
      item4 = Items(
          title: "Food Deals",
          event: "\$${meals.toStringAsFixed(2)}",
          img: "assets/burger.png");
      myList!.add(item4!);
      setState(() {});

      item5 = Items(
          title: "Rice",
          event: "\$${rice.toStringAsFixed(2)}",
          img: "assets/rice.png");
      myList!.add(item5!);
      setState(() {});

      item6 = Items(
          title: "Flour",
          event: "\$${flour.toStringAsFixed(2)}",
          img: "assets/flour.png");
      myList!.add(item6!);
      setState(() {});
      item7 = Items(
          title: "Chocolate",
          event: "\$${chocolate.toStringAsFixed(2)}",
          img: "assets/chocolate.png");
      myList!.add(item7!);
      setState(() {});
      item8 = Items(
          title: "Biscuits",
          event: "\$${biscuits.toStringAsFixed(2)}",
          img: "assets/biscuits.png");
      myList!.add(item8!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _key,
      appBar: AppBar(
        title: const Text("Snap Cart"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        backgroundColor: purpleColor,
      ), //AppBar
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name ?? "Loading..."),
              decoration: const BoxDecoration(
                color: purpleColor,
              ),
              accountEmail: Text(email ?? "Loading.."),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  name.toString()[0] == null ? "Loading.." : name.toString()[0],
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: purpleColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, profileScreenRoute);
                getUser();
              },
              child: const ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, historyScreenRoute);
                getUser();
              },
              child: const ListTile(
                title: Text(
                  "Single Product History",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, multipleHistoryScreenRoute);
                getUser();
              },
              child: const ListTile(
                title: Text(
                  "Multiple Product History",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(
                    context, termsAndConditionsScreenRoute);
                getUser();
              },
              child: const ListTile(
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.restore_page_sharp,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, privacyScreenRoute);
                getUser();
              },
              child: const ListTile(
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.paste_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Authentication().signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, loginScreenRoute, (route) => false);
              },
              child: const ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hi ${name == null ? "User" : name}",
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  pic != null
                      ? Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                pic!,
                              ),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/account.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, qrScanScreenRoute);
                  getUser();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 50,
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
                        "Scan",
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
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Total Expenses",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Container(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              myList == null
                  ? const Center(
                      child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ))
                  : Center(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          for (int i = 0; i < myList!.length; i++)
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: purpleColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    myList![i].img!,
                                    width: 42,
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    myList![i].title!,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    myList![i].event! == null
                                        ? "\$0.0"
                                        : myList![i].event!,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Expenses: ${(bread + meals + eggs + drink).toStringAsFixed(2)} Dollars",
                      ),
                    ],
                  ),
                ),
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
