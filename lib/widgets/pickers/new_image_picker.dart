import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePiker extends StatefulWidget {
  final Function(File pickedImage) imagePickFun;

  UserImagePiker(this.imagePickFun);

  @override
  _UserImagePikerState createState() => _UserImagePikerState();
}

class _UserImagePikerState extends State<UserImagePiker> {
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFun(_pickedImage);
    } else {
      print('No Image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: Icon(Icons.photo_camera_outlined),
              label:
                  Text('Add photo \n from Camera', textAlign: TextAlign.center),
            ),
            FlatButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label: Text('Add photo \n from Gallery',
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ],
    );
  }
}
