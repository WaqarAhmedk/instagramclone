import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/screens/confirmpost.dart';

// ignore: must_be_immutable
class AddPostPage extends StatelessWidget {
  ImagePicker _imagePicker = ImagePicker();

  opengallery(BuildContext context) async {
    var selectedimage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedimage != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmPost(image: selectedimage),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    opengallery(context);
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
