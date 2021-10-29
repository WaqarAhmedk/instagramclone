import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarHomePage extends StatelessWidget {
  const AppBarHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Image(
          image: AssetImage("assets/images/logo.png"),
          height: 90,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'chatlist');
            },
            icon: Icon(
              FontAwesomeIcons.comment,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
