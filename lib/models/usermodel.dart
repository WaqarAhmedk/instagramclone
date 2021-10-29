class UserModel {
  final id;
  final name;
  final imagepath;

  UserModel({
    required this.id,
    required this.name,
    required this.imagepath,
  });
}

final currentuser =
    UserModel(id: 0, name: "waqar", imagepath: "assets/images/1.jpg");

final madsar =
    UserModel(id: "1", name: "Madssar", imagepath: "assets/images/2.jpg");
final usama =
    UserModel(id: "2", name: "Usama", imagepath: "assets/images/3.jpg");
final ikram =
    UserModel(id: "3", name: "Ikram", imagepath: "assets/images/4.jpg");
final ali = UserModel(id: "4", name: "ali", imagepath: "assets/images/1.jpg");
final hasan =
    UserModel(id: "5", name: "hasan", imagepath: "assets/images/2.jpg");
final khyam =
    UserModel(id: "6", name: "khyam", imagepath: "assets/images/4.jpg");

List<UserModel> users = [madsar, usama, ikram, hasan, khyam, ali];
