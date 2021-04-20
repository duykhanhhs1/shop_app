import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final ProductRepository productRepository;

  //TODO: Implement ProfileController

  final count = 0.obs;

  RxBool isEditProfile = RxBool(false);
  RxBool isLoading = RxBool(false);

  ProfileController({@required this.productRepository, @required this.userRepository}) : assert(userRepository != null && productRepository != null);

  Rx<UserModel> userModel = LoginController.to.userLogged;
  Rx<UserModel> userCreate = Rx(UserModel());
  UserModel get currentUser=> userModel.value;

  RxList<ProductOverViewModel> favoriteProducts = RxList<ProductOverViewModel>();

  static ProfileController get to => Get.find<ProfileController>();

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

  void setGender(String gender) {
    currentUser.gender = gender;
    update();
  }

  Future<void> updateUser() async {
    await userRepository.updateUser(currentUser);
    setOpenEditForm(false);
    update();
  }

  // void setGender(String value) {
  //   userCreate.value.gender = value;
  //   update();
  // }

  // void getProfile(String userNo) async{
  //   isLoading.value = true;
  //   final UserModel data = _login.userLogged.value;
  //   userModel = data.obs;
  //   isLoading.value = false;
  //   update();
  // }

  void getFavoriteProducts() async{
    final List<ProductOverViewModel> data = await productRepository
        .getFavoriteProducts(LoginController.to.userLogged.value.userNo);
    favoriteProducts = data.obs;
    update();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
