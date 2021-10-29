import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/models/usermodel.dart';

class DBUser {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic getUsersfromdb() async {
    List<UserModel> dbuser = [];

    var data = await _firebaseFirestore.collection("userdata").get();

    for (var val in data.docs) {
      if (val.id == _firebaseAuth.currentUser!.uid) {
        dbuser.insert(
          0,
          UserModel(id: 1, name: val['username'], imagepath: val['imagepath']),
        );
      } else {
        dbuser.add(UserModel(
            id: 1, name: val['username'], imagepath: val['imagepath']));
      }
    }

    return dbuser;
  }
}
