import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ConfirmPost extends StatefulWidget {
  final XFile image;

  ConfirmPost({
    required this.image,
  });
  @override
  State<ConfirmPost> createState() => _ConfirmPostState();
}

class _ConfirmPostState extends State<ConfirmPost> {
  bool loading = false;
  bool fbswitch = false;

  bool twiterswitch = false;

  bool tumblerswitch = false;
  TextEditingController _desccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          "New Post",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () async {
                  loading = true;
                  setState(() {});
                  FirebaseAuth _firebaseauth = FirebaseAuth.instance;

                  _firebaseauth.currentUser!.displayName;
                  var filename = File(widget.image.name);
                  var image = File(widget.image.path);

                  //   FirebaseFirestore _firstore = FirebaseFirestore.instance;
                  FirebaseStorage _firebasestorage = FirebaseStorage.instance;
                  var ref = _firebasestorage.ref("pimages/$filename");

                  await ref.putFile(image);

                  String senderid = _firebaseauth.currentUser!.uid;
                  var downurl = await ref.getDownloadURL();
                  print(downurl);

                  String pid = DateTime.now().toString();

                  FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  try {
                    await _firestore.collection("posts").add({
                      "isliked": false,
                      "pid": pid,
                      "pdesc": _desccontroller.text,
                      "pimage": downurl,
                      "senderid": senderid
                    });
                    Navigator.pushNamed(context, 'welcomescreen');
                  } catch (e) {
                    loading = false;
                    setState(() {});
                    print(e);
                    print("Eror uploading datain databas4e");
                  }
                },
                icon: Icon(
                  FontAwesomeIcons.check,
                  color: Colors.blue,
                  size: 30,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.file(
                          File(
                            widget.image.path,
                          ),
                          height: 80,
                          width: 70,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            controller: _desccontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter your caption here...",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Tag People",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Add Location",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 30),
                    child: Text(
                      "Also Post to ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/3.jpg"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Facebook",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Waqar Ahmed",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                            value: fbswitch,
                            onChanged: (value) {
                              fbswitch = value;
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Twitter",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Switch(
                            value: twiterswitch,
                            onChanged: (value) {
                              twiterswitch = value;
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tumbler",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Switch(
                            value: tumblerswitch,
                            onChanged: (value) {
                              tumblerswitch = value;
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
      ),
    );
  }
}
