import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePic extends StatefulWidget {
  @override
  State<AddProfilePic> createState() => _AddProfilePicState();
}

class _AddProfilePicState extends State<AddProfilePic> {
  late File fimage;
  bool imagecheck = true;
  late var imagename;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Your Profile Pic",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              ImagePicker _imagepicker = ImagePicker();
              var pimage =
                  await _imagepicker.pickImage(source: ImageSource.gallery);
              imagename = pimage!.name;
              fimage = File(pimage.path);

              imagecheck = false;

              setState(() {});
            },
            child: CircleAvatar(
              radius: 60,
              child: Icon(Icons.add_a_photo),
              backgroundImage: imagecheck
                  ? null
                  : FileImage(
                      fimage,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              FirebaseStorage _firbasesotrage = FirebaseStorage.instance;

              var ref = _firbasesotrage.ref("profiles/$imagename");
              await ref.putFile(fimage);
              var durl = await ref.getDownloadURL();
              print(durl);
              FirebaseAuth _firebaseauth = FirebaseAuth.instance;
              String userid = _firebaseauth.currentUser!.uid;

              FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
              await _firebasefirestore
                  .collection("userdata")
                  .doc(userid)
                  .update(
                {"imagepath": durl},
              );
              Navigator.pushNamed(context, "welcomescreen");
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
