import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/models/postsmodel.dart';
import 'package:instagramclone/models/usermodel.dart';

class PostsService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic getDbPosts() async {
    List<Post> dbposts = [];
    var posts = await _firebaseFirestore.collection("posts").get();

    for (var post in posts.docs) {
      var docid = post.id;
      var user = await getUsersfromdb(post['senderid']);

      dbposts.add(
        Post(
          pid: post['pid'],
          sender: user,
          pimage: post['pimage'],
          pdescription: post['pdesc'],
          isliked: post['isliked'],
        ),
      );
    }
    return dbposts;
  }

  dynamic getUsersfromdb(senderid) async {
    var data =
        await _firebaseFirestore.collection("userdata").doc(senderid).get();
    var usermodel =
        UserModel(id: 1, name: data['username'], imagepath: data['imagepath']);

    return usermodel;
  }
}
