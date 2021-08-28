import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/utils/firebase_untils.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final ProductRepository productRepository;

  //TODO: Implement ProfileController

  final count = 0.obs;

  RxBool isEditProfile = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool isLoadingOrder = RxBool(false);

  ProfileController(
      {@required this.productRepository, @required this.userRepository})
      : assert(userRepository != null && productRepository != null);

  Rx<UserModel> get userModel => LoginController.to.userLogged;
  Rx<UserModel> userCreate = Rx(UserModel());

  UserModel get currentUser => userModel.value;

  ProfileModel get currentProfile => userModel.value.profile;

  RxList<ProductOverViewModel> favoriteProducts =
      RxList<ProductOverViewModel>();

  RxList<OrderModel> orders = RxList();

  List<OrderModel> get unVerifiedOrders =>
      orders.where((_) => _.order_status == "Chờ xác nhận").toList();

  List<OrderModel> get verifiedOrders =>
      orders.where((_) => _.order_status == "Đã giao").toList();

  static ProfileController get to => Get.find<ProfileController>();

  @override
  void onInit() {
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
    currentUser.profile.gender = gender;
    update();
  }

  Future<void> updateProfile() async {
    ProfileUpdateModel profileUpdate = ProfileUpdateModel(
        first_name: currentProfile.first_name,
        last_name: currentProfile.last_name,
        phone_number: currentProfile.phone_number,
        address: currentProfile.address,
        email: currentProfile.email,
        gender: currentProfile.gender,
        date_of_birth: currentProfile.date_of_birth);
    await userRepository.updateProfile(profileUpdate);
    await getProfile();
    setOpenEditForm(false);
    update();
  }

  Future<void> getProfile() async {
    LoginController.to.userLogged.value.profile =
        await userRepository.getProfile();
  }

  void pickAvatarProfile(ImageSource imageSource) async {
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: imageSource);
    Get.back();
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await userRepository.updateAvatarProfile(imageFile);
      await getProfile();
    }
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

  void getFavoriteProducts() async {
    final List<ProductOverViewModel> data = await productRepository
        .getFavoriteProducts(LoginController.to.userLogged.value.userNo);
    favoriteProducts = data.obs;
    update();
  }

  void getOrders() async {
    isLoadingOrder.value = true;
    final List<OrderModel> data = await productRepository.getOrders();

    orders = data.obs;
    isLoadingOrder.value = false;
    update();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
