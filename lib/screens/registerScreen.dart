import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var username = "";
  var useremail = "";
  var userpassword = "";

  var namerror;
  var emailerror;
  var passworderror;

  bool buser = true;
  bool bemail = true;
  bool bpassword = true;

  dynamic _validateemail(usermail) {
    if (useremail.length >= 8) {
      if (useremail.contains("@") && usermail.contains(".com")) {
        bemail = false;
        return null;
      } else {
        bemail = true;
        return "PLease provide a valid email";
      }
    } else {
      bemail = true;
      return "Email should be greater then 7 charcters";
    }
  }

  dynamic _validateusername(username) {
    if (username.length < 5) {
      buser = true;
      return "User Name must be Gretaer Then 5";
    }
    buser = false;
    return null;
  }

  dynamic _validatepassword(ppassword) {
    if (ppassword.length < 5) {
      bpassword = true;

      return "Password must be Gretaer Then 5";
    }
    bpassword = false;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onChanged: (value) {
                          username = value;
                        },
                        cursorHeight: 30,
                        cursorWidth: 2,
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        decoration: namerror != null
                            ? kinputdecoration.copyWith(errorText: namerror)
                            : kinputdecoration.copyWith(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onTap: () {
                          namerror = _validateusername(username);
                          setState(() {});
                        },
                        onChanged: (value) {
                          useremail = value;
                        },
                        cursorHeight: 30,
                        cursorWidth: 2,
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        decoration: emailerror != null
                            ? kinputdecoration.copyWith(
                                hintText: "Email",
                                errorText: emailerror,
                              )
                            : kinputdecoration.copyWith(
                                hintText: "Email",
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        cursorHeight: 30,
                        cursorWidth: 2,
                        onTap: () {
                          emailerror = _validateemail(useremail);

                          setState(() {});
                        },
                        onChanged: (value) {
                          userpassword = value;
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        decoration: passworderror != null
                            ? kinputdecoration.copyWith(
                                hintText: "Password",
                                errorText: passworderror,
                              )
                            : kinputdecoration.copyWith(
                                hintText: "Password",
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 390,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          passworderror = _validatepassword(userpassword);
                          namerror = _validateusername(username);
                          emailerror = _validateemail(useremail);

                          setState(() {});

                          if (buser != true &&
                              bpassword != true &&
                              bemail != true) {
                            try {
                              final createduser = await _firebaseAuth
                                  .createUserWithEmailAndPassword(
                                      email: useremail, password: userpassword);
                              try {
                                await _firestore
                                    .collection("userdata")
                                    .doc(createduser.user!.uid)
                                    .set({
                                  "username": username,
                                  "email": useremail,
                                });
                                print("user created and data updated");

                                Navigator.pushNamed(context, 'addprofileimage');
                              } catch (e) {
                                print(e);
                              }
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            print("Bawa ji Rola e dasya gya na");
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                      child: Row(
                        children: [
                          Text("Already have account ? "),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 390,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.black,
                            height: 1,
                            width: 150,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: Colors.black,
                            height: 1,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Register with facebook",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
