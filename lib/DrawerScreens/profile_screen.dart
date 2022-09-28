import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapcart/Constants/constants.dart';

import '../AuthController/firebase_uploads.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UploadTask? task;
  File? file;
  var urlDownload = "N/A";

  @override
  void initState() {
    getUser();
    super.initState();
  }

  String? name;
  String? email;
  String? pic;
  String? date;
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
      DateTime now = DateTime.fromMillisecondsSinceEpoch(value.data()!["date"]);
      date = DateFormat('dd MMMM, yyyy').format(now);
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          pic != null
              ? GestureDetector(
                  onTap: () {
                    dialogBox(context);
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(pic!),
                          fit: BoxFit.cover,
                        )),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    dialogBox(context);
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/account.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
          const SizedBox(
            height: 60,
          ),
          Text(
            name ?? "Loading..",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          const SizedBox(
            height: 300,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    purpleColor.withOpacity(0.8),
                    purpleColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                email ?? "Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    purpleColor.withOpacity(0.8),
                    purpleColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                date ?? "Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseUploads.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    print("Url == == ===  == " + urlDownload.toString());
    FirebaseFirestore.instance.collection("profilePictures").doc(email).set({
      "profilePicture": urlDownload,
    });
    getUser();
    setState(() {});
  }

  dialogBox(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Center(child: const Text('Choose your option')),
          content: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromCamera(context);
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.camera_alt,
                      size: 25,
                      color: purpleColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImageFromGallery(context);
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(Icons.photo),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  pickImageFromGallery(context) async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    file = File(imageFile!.path);
    String fileName = file!.path.split('/').last;
    print("This is the path of file ============" + file.toString());
    if (file != null) {
      EasyLoading.show(status: "Loading..");
      uploadFile();
      EasyLoading.dismiss();
    }
    Navigator.pop(context);
    setState(() {});
  }

  pickImageFromCamera(context) async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    file = File(imageFile!.path);
    String fileName = file!.path.split('/').last;
    if (file != null) {
      EasyLoading.show(status: "Loading..");
      uploadFile();
      EasyLoading.dismiss();
    }
    Navigator.pop(context);
    setState(() {});
  }
}
