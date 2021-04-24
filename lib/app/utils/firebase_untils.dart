import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseHelper {
  static Future<String> uploadImage(
      String folderName, File imageFile, String imageName) async {
    String imageUrl;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$folderName/$imageName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then(
          (value) => imageUrl = value,
        );
    return imageUrl;
  }

  static Future<String> uploadImageWeb(
      String folderName, PickedFile imageFile, String imageName) async {
    Uint8List data = await imageFile.readAsBytes();
    String imageUrl;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$folderName/$imageName.jpg');
    UploadTask uploadTask = firebaseStorageRef.putData(data);
    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then(
          (value) => imageUrl = value,
        );
    return imageUrl;
  }
}
