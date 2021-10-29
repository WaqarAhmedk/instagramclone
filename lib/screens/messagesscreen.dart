import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/models/chatsmodel.dart';
import 'package:instagramclone/models/usermodel.dart';

class MessageScreen extends StatelessWidget {
  final UserModel user;

  MessageScreen({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 80,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(user.imagepath),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Active 43 minutes ago",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.video),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 600,
              child: ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  final cuser =
                      currentuser == messages[index].sender ? true : false;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: cuser
                          ? EdgeInsets.only(left: 70, top: 10)
                          : EdgeInsets.only(
                              right: 70,
                              top: 10,
                            ),
                      decoration: cuser
                          ? BoxDecoration(
                              color: Colors.deepPurple.shade400,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(50),
                              ),
                            )
                          : BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cuser
                            ? Text(
                                messages[index].text,
                                style: TextStyle(fontSize: 20),
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(user.imagepath),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 210,
                                    child: Text(
                                      messages[index].text,
                                      style: TextStyle(fontSize: 20),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 90,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: "Message...",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.camera,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
