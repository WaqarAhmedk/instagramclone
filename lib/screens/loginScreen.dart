import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/constants.dart';
import 'package:instagramclone/services/GetUsers.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DBUser users = DBUser();

  var useremail = "";
  var userpassword = "";

  var emailerror;
  var passworderror;

  bool email = true;
  bool password = true;
  bool loading = false;

  dynamic _validateemail(usermail) {
    if (useremail.length >= 8) {
      if (useremail.contains("@") && usermail.contains(".com")) {
        email = false;
        return null;
      } else {
        email = true;
        return "PLease provide a valid email";
      }
    } else {
      email = true;
      return "Email should be greater then 7 charcters";
    }
  }

  dynamic _validatepassword(ppassword) {
    if (ppassword.length < 5) {
      password = true;

      return "Password must be Gretaer Then 5";
    }
    password = false;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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

                                emailerror = _validateemail(useremail);
                                setState(() {
                                  loading = true;
                                });

                                if (password != true && email != true) {
                                  try {
                                    await _firebaseAuth
                                        .signInWithEmailAndPassword(
                                            email: useremail,
                                            password: userpassword);
                                    CircularProgressIndicator();
                                    Navigator.pushNamed(
                                        context, 'welcomescreen');
                                  } catch (e) {
                                    print(e);
                                    loading = false;
                                    setState(() {});
                                  }
                                } else {
                                  print("Bawa ji Rola e dasya gya na");
                                  loading = false;
                                  setState(() {});
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 70),
                            child: Row(
                              children: [
                                Text("Forgot your password ? "),
                                Text(
                                  "help signing in ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
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
                                  "Login with facebook",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.blue,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  "Register with Email",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
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
