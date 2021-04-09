import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserModel> getProfile(String userNo) async {
    UserModel user = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userNo')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user = UserModel.fromJson(documentSnapshot.data());
        return user;
      } else {
        print('user not exists');
        return user;
      }
    });
    return user;
  }
}
