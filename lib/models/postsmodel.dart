import 'package:instagramclone/models/usermodel.dart';

class Post {
  final String pid;
  final UserModel sender;
  final pimage;
  final pdescription;
  final bool isliked;

  Post({
    required this.pid,
    required this.sender,
    required this.pimage,
    required this.pdescription,
    required this.isliked,
  });
}
