import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Items item1 = Items(
      title: "Calendar",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/calendar.png");

  Items item2 = Items(
    title: "Groceries",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img: "assets/food.png",
  );
  Items item3 = Items(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "assets/map.png",
  );
  Items item4 = Items(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "assets/festival.png",
  );
  Items item5 = Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
    img: "assets/todo.png",
  );
  Items item6 = Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/setting.png",
  );
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
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .get()
        .then((value) {
      print(value.data());
      name = value.data()!["name"];
      email = value.data()!["email"];
      print(name);
      print(email);
      setState(() {});
    });
    FirebaseFirestore.instance
        .collection("profilePictures")
        .doc(user)
        .get()
        .then((value) {
      print(value.data());
      pic = value.data()!["profilePicture"];

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
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
              decoration: BoxDecoration(
                color: purpleColor,
              ),
              accountEmail: Text(email ?? "Loading.."),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  name.toString()[0] == null ? "Loading.." : name.toString()[0],
                  style: TextStyle(
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
                  "History",
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
              onTap: () {
                Authentication().signOut();
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
                  "Hi $name",
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                        decoration: BoxDecoration(
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
              onTap: () {
                Navigator.pushNamed(context, qrScanScreenRoute);
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
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                  childAspectRatio: 1.0,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: myList.map((data) {
                    return Container(
                      decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            data.img!,
                            width: 42,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            data.title!,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            data.subtitle!,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            data.event!,
                          ),
                        ],
                      ),
                    );
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
