import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageScreen extends StatelessWidget {
  const FirebaseStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Storage')),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var imageFile = await pickImage();

              if (imageFile != null) {
                var imageLink = await getImageLink(imageFile);

                print(imageLink);
              }
            },
            child: const Text('Upload Image')),
      ),
    );
  }

  Future<File?> pickImage() async {
    print('Get Image Called');
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<String> getImageLink(File image) async {
    String imageLink = '';

    final fileName = basename(image.path);
    final destination = 'Images/$fileName';

    var task = uploadFile(destination, image);

    if (task == null) return '';

    final snapshot = await task.whenComplete(() {});
    imageLink = await snapshot.ref.getDownloadURL();

    print('Download-Link: $imageLink');

    return imageLink;
  }

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}
