import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/models/postsmodel.dart';
import 'package:instagramclone/models/usermodel.dart';
import 'package:instagramclone/services/GetPosts.dart';

class PostdataWidget extends StatefulWidget {
  @override
  _PostdataWidgetState createState() => _PostdataWidgetState();
}

class _PostdataWidgetState extends State<PostdataWidget> {
  List<Post> posts = [];
  PostsService _postsService = PostsService();
  dynamic callbackstatemethod() {
    this.setState(() {});
  }

  void getPosts() async {
    posts = await _postsService.getDbPosts();
    setState(() {});
  }

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? Center(
            child: Column(
            children: [
              CircularProgressIndicator(),
              Text("No data available"),
            ],
          ))
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            //scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostTop(
                        posts: posts,
                        index: index,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.network(
                          posts[index].pimage,
                          width: double.infinity,
                        ),
                      ),
                      PostReactionButtons(
                        posts: posts,
                        index: index,
                        callbackmethod: callbackstatemethod,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "100 likes",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  currentuser.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " " + posts[index].pdescription,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "view all 2 comments",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      currentuser.imagepath,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 40,
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Add a  Comment ",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class PostReactionButtons extends StatefulWidget {
  final index;
  final List<Post> posts;
  var callbackmethod;
  PostReactionButtons({
    required this.posts,
    required this.index,
    required this.callbackmethod,
  });

  @override
  State<PostReactionButtons> createState() => _PostReactionButtonsState();
}

class _PostReactionButtonsState extends State<PostReactionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: widget.posts[widget.index].isliked
                  ? IconButton(
                      onPressed: () async {
                        FirebaseFirestore _firestore =
                            FirebaseFirestore.instance;

                        FirebaseAuth _firebaseauth = FirebaseAuth.instance;

                        var responsedata =
                            await _firestore.collection("posts").get();
                        for (var item in responsedata.docs) {
                          if (item['pid'] == widget.posts[widget.index].pid) {
                            await _firestore
                                .collection("posts")
                                .doc(item.id)
                                .update({"isliked": false});
                            widget.callbackmethod();
                          }
                        }
                      },
                      icon: Icon(FontAwesomeIcons.solidHeart),
                      color: Colors.red,
                    )
                  : IconButton(
                      onPressed: () async {
                        FirebaseFirestore _firestore =
                            FirebaseFirestore.instance;
                        FirebaseAuth _firebaseauth = FirebaseAuth.instance;
                        print(widget.posts[widget.index].pid);
                        // await _firestore
                        //     .collection("posts")
                        //     .doc(_firebaseauth.currentUser!.uid)
                        //     .update({"isliked": true});
                        setState(() {});
                      },
                      icon: Icon(FontAwesomeIcons.heart),
                    ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.comment,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.share,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.save,
          ),
        ),
      ],
    );
  }
}

class PostTop extends StatelessWidget {
  final index;
  final List<Post> posts;
  PostTop({
    required this.posts,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(posts[index].sender.imagepath),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                posts[index].sender.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.ellipsisV),
          ),
        ],
      ),
    );
  }
}
