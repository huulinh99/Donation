import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  @override
  InputImageState createState() => InputImageState();
}

class InputImageState extends State<InputImage> {
  final pageViewController = PageController();
  ImagePicker picker = ImagePicker();
  File displayImageFile;
  String path;
  String uploadPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text("Choice your picture"),
          ),
          Container(
              child: RaisedButton(
            onPressed: () => getImage(),
            child: Text("pick"),
          ))
        ],
      ),
    );
  }

  Future getImage() async {
    await picker
        .getImage(source: ImageSource.gallery)
        .then((value) => setState(() {
              displayImageFile = File(value.path);
            }));
  }

  // Future<String> uploadFile() async {
  //   StorageUploadTask uploadTask = storageReference.putFile(displayImageFile);
  //   await uploadTask.onComplete.then((value) => print(value));
  // }

}
