import 'package:flutter/material.dart';
import 'package:instagramclone/screens/chatlist.dart';
import 'package:instagramclone/screens/homepageScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagramclone/screens/loginScreen.dart';
import 'package:instagramclone/screens/profilepic.dart';
import 'package:instagramclone/screens/registerScreen.dart';
import 'package:instagramclone/screens/welcomescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InstaGram());
}

class InstaGram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Text("error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Text("Connection establishing please waits"),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: LoginPage(),
          routes: {
            'addprofileimage': (contex) => AddProfilePic(),
            'welcomescreen': (context) => Welcomecreen(),
            'register': (context) => RegisterPage(),
            'login': (context) => LoginPage(),
            'homepage': (context) => InstaHomePage(),
            'chatlist': (context) => ChatList(),
          },
        );
      },
    );
  }
}
