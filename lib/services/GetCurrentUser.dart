import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/models/usermodel.dart';

class GetCurrentUser {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getcurrentuser() async {
    final id = _firebaseAuth.currentUser!.uid;

    var result = await _firestore.collection("userdata").doc(id).get();
    var user = UserModel(
        id: id, name: result['username'], imagepath: result['imagepath']);

    return user;
  }
}
