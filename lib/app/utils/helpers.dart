import 'package:intl/intl.dart';

class NumberHelper {
  static String currencyFormat(int value) {
    return NumberFormat('#,###').format(value);
  }
}

/*class ImageHelper {
  static Future<String> pickAvatarProfile(ImageSource imageSource) async {
    String imageUrl;
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: imageSource);
    Get.back();
    if (pickedFile != null) {
      String imageName;
      if (kIsWeb) {
        imageName = pickedFile.path.substring(
            pickedFile.path.lastIndexOf('/'), pickedFile.path.length - 1);
        imageUrl = await FirebaseHelper.uploadImageWeb('pickedFile, imageName);
      } else {
        File imageFile = File(pickedFile.path);
        imageName = imageFile.path.substring(
            imageFile.path.lastIndexOf('/'), imageFile.path.length - 1);
        imageUrl = await FirebaseHelper.uploadImage(imageFile, imageName);
      }
      return imageUrl;
    }
  }
}*/
