import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/models/usermodel.dart';
import 'package:instagramclone/screens/messagesscreen.dart';
import 'package:instagramclone/services/GetCurrentUser.dart';
import 'package:instagramclone/widgets/searchandmenu.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late UserModel loggedin;
  bool waitfruser = true;
  GetCurrentUser _currentUser = GetCurrentUser();
  getcurrentuser() async {
    loggedin = await _currentUser.getcurrentuser();

    setState(() {
      waitfruser = false;
    });
  }

  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return waitfruser
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 80,
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  loggedin.name,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.video),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.edit),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 70,
                child: Column(
                  children: [
                    SearchandListwidget(),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: users.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: RecentchatList(
                                index: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class RecentchatList extends StatelessWidget {
  final index;

  RecentchatList({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                print("Story of ${users[index].name} will be opened");
              },
              child: CircleAvatar(
                maxRadius: 40,
                backgroundImage: AssetImage(users[index].imagepath),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MessageScreen(
                      user: users[index],
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    users[index].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Active 2h ago",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.camera),
        ),
      ],
    );
  }
}
