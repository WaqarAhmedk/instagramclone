import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/models/usermodel.dart';
import 'package:instagramclone/screens/addpostscreen.dart';
import 'package:instagramclone/screens/homepageScreen.dart';
import 'package:instagramclone/screens/notificationsscreen.dart';
import 'package:instagramclone/screens/profileScreen.dart';
import 'package:instagramclone/screens/searchscreen.dart';
import 'package:instagramclone/services/GetCurrentUser.dart';

class Welcomecreen extends StatefulWidget {
  Welcomecreen({Key? key}) : super(key: key);

  @override
  _WelcomecreenState createState() => _WelcomecreenState();
}

class _WelcomecreenState extends State<Welcomecreen> {
  late UserModel cuser;
  bool waitfruser = true;
  int _selectedindex = 0;

  List<Widget> items = [
    InstaHomePage(),
    SearchPage(),
    AddPostPage(),
    Notifications(),
    Profile(),
  ];

  GetCurrentUser _currentUser = GetCurrentUser();
  void getcurrentuser() async {
    cuser = await _currentUser.getcurrentuser();

    setState(() {
      waitfruser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getcurrentuser();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectedindex = index;

          setState(() {});
        },
        currentIndex: _selectedindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plusSquare),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: waitfruser
                ? CircularProgressIndicator()
                : Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(cuser.imagepath),
                    ),
                  ),
            label: "",
          ),
        ],
      ),
      body: items.elementAt(_selectedindex),
    );
  }
}
