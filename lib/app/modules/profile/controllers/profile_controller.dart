import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class ProfileController extends GetxController {
  final UserRepository repository;

  //TODO: Implement ProfileController

  final count = 0.obs;

  RxBool isEditProfile = RxBool(false);
  RxBool isLoading = RxBool(false);

  ProfileController({@required this.repository}) : assert(repository != null);

  Rx<UserModel> userModel = LoginController.to.userLogged;
  Rx<UserModel> userCreate = Rx(UserModel());
  UserModel get currentUser=> userModel.value;

  static ProfileController get to => Get.find<ProfileController>();

 // static LoginController get _login => Get.find<LoginController>();

  @override
  void onInit()  {
    //getProfile(_login.userLogged.value.userNo);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void setOpenEditForm(bool value) {
    isEditProfile.value = value;
    update();
  }

  void setGender (String gender ){
      currentUser.gender = gender;
      update();
  }

  Future<void> updateUserProfile({String userNo,String name, String gender , String phone , String des}) async {
    await repository.updateUserProfile(userNo,name,gender,phone,des);
    update();
  }

  // void getProfile(String userNo) async{
  //   isLoading.value = true;
  //   final UserModel data = _login.userLogged.value;
  //   userModel = data.obs;
  //   isLoading.value = false;
  //   update();
  // }

  @override
  void onClose() {}

  void increment() => count.value++;
}
