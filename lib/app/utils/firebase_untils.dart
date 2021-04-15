import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static Future<String> uploadImage(File imageFile, String imageName) async {
    String imageUrl;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$imageName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
   await taskSnapshot.ref
        .getDownloadURL()
        .then(
          (value) => imageUrl = value,
        );
    return imageUrl;
  }
}
