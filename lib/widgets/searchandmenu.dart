import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchandListwidget extends StatefulWidget {
  @override
  _SearchandListwidgetState createState() => _SearchandListwidgetState();
}

class _SearchandListwidgetState extends State<SearchandListwidget> {
  List menu = ["Chats", "Rooms", "Requests"];

  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      color: Colors.white,
      height: 140,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.search,
                size: 20,
              ),
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 50,
            child: ListView.builder(
              itemCount: menu.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 27),
                  child: InkWell(
                    onTap: () {
                      selectedindex = index;
                      setState(() {});
                    },
                    child: Text(
                      menu[index],
                      style: selectedindex == index
                          ? TextStyle(
                              shadows: [
                                Shadow(
                                  offset: Offset(0, -5),
                                  color: Colors.black,
                                ),
                              ],
                              fontSize: 25,
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                            )
                          : TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
