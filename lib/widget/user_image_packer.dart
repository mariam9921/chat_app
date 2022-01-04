import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UserImagePacker extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const UserImagePacker(this.imagePicked);
  final void Function(File? pickedImage) imagePicked;
  @override
  _UserImagePackerState createState() => _UserImagePackerState();
}

class _UserImagePackerState extends State<UserImagePacker> {
  File? _pickedImage;
  void _pickImage() async {
    final pickedImageFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 70,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });

    widget.imagePicked(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.camera),
          label: const Text(
            'Chose photo',
          ),
        ),
      ],
    );
  }
}
