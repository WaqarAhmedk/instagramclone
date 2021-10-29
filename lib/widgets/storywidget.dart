import 'package:flutter/material.dart';
import 'package:instagramclone/models/usermodel.dart';
import 'package:instagramclone/services/GetUsers.dart';

DBUser usersdb = DBUser();

class StoriesWidget extends StatefulWidget {
  @override
  _StoriesWidgetState createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  DBUser user = DBUser();
  List<UserModel> guser = [];

  void getuser() async {
    guser = await user.getUsersfromdb();
    setState(() {});
    // print(guser[1]['username']);
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return guser.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.white,
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: guser.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            guser[index].imagepath,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        guser[index].name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ));
  }
}
