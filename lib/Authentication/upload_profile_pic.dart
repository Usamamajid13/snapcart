import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapcart/Constants/constants.dart';
import 'package:snapcart/Utils/app_utils.dart';

import '../AuthController/firebase_uploads.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  final email;
  const UploadProfilePictureScreen(this.email, {Key? key}) : super(key: key);

  @override
  State<UploadProfilePictureScreen> createState() =>
      _UploadProfilePictureScreenState();
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  var utils = AppUtils();
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 1,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upload Profile Picture",
                  style: utils.largeLabelTextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  dialogBox(context);
                },
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: purpleColor,
                      shape: BoxShape.circle,
                    ),
                    child: task != null
                        ? Center(child: buildUploadStatus(task!))
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.upload,
                                color: Colors.black,
                                size: 25,
                              ),
                            ],
                          ))),
              ),
              const SizedBox(
                height: 1,
              ),
              Align(
                alignment: Alignment.center,
                child: utils.bigButton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  containerColor: purpleColor,
                  text: "Upload",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  shadowColors: purpleColor,
                  textColor: Colors.white,
                  borderRadius: 10.0,
                  onTap: () => Navigator.pushNamed(context, homeScreenRoute),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ));
  }

  var urlDownload = "N/A";

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseUploads.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print("Url == == ===  == $urlDownload");
    }
    FirebaseFirestore.instance
        .collection("profilePictures")
        .doc(widget.email)
        .set({
      "profilePicture": urlDownload,
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("currentUserEmail", widget.email.toString());
  }

  dialogBox(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Center(child: Text('Choose your option')),
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
                    child: const Icon(
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
                    child: const Center(
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
    if (kDebugMode) {
      print("This is the path of file ============$file");
    }
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
    if (file != null) {
      EasyLoading.show(status: "Loading..");
      uploadFile();
      EasyLoading.dismiss();
    }
    Navigator.pop(context);
    setState(() {});
  }
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);
          return Text(
            percentage == "100.00" ? "Uploaded" : "$percentage%",
            style: TextStyle(
                color: Colors.white,
                fontSize: percentage == "100.00" ? 16 : 16,
                fontWeight: FontWeight.bold),
          );
        } else {
          return Container();
        }
      },
    );
