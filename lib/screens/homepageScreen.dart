import 'package:flutter/material.dart';

import 'package:instagramclone/widgets/Postdatawidget.dart';
import 'package:instagramclone/widgets/appbarhomepage.dart';
import 'package:instagramclone/widgets/storywidget.dart';

class InstaHomePage extends StatefulWidget {
  @override
  _InstaHomePageState createState() => _InstaHomePageState();
}

class _InstaHomePageState extends State<InstaHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  AppBarHomePage(),
                  StoriesWidget(),
                  Divider(
                    color: Colors.black,
                  ),
                  PostdataWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
