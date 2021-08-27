import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/utils/keys.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final UserRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  static LoginController get to => Get.find<LoginController>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxBool isProcessing = RxBool(false);
  RxBool isLoginByToken = RxBool(false);
  Rx<UserModel> userLogged = Rx(UserModel());

  bool get isLogged => userLogged.value.email != null;

  final GetStorage _store = GetStorage();

  @override
  void onInit() async {
    await verifyUser();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> verifyUser() async {
    final String storedToken = await _store.read(AppStorageKey.ACCESS_TOKEN);
    if (storedToken != null) {
      ProfileModel profile = await repository.getProfile();
      userLogged.value.profile = profile;
      userLogged.value.email = profile.email;
      Get.offAllNamed(Routes.HOME);
    } else
      Get.offAllNamed(Routes.HOME);
  }

  Future<void> logout() async {
    _store.remove(AppStorageKey.ACCESS_TOKEN);
    emailController.clear();
    passwordController.clear();
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
    isProcessing.value = false;
  }

  //signIn
  Future<void> login({String username, String password}) async {
    isProcessing.value = true;
    UserModel data = await repository.login(username, password);
    if (data != null) {
      _store.write(AppStorageKey.ACCESS_TOKEN, data.authentication_token);
      ProfileModel profile = await repository.getProfile();
      data.profile = profile;
      userLogged = data.obs;
      Get.offAllNamed(Routes.HOME);
      isProcessing.value = false;
    } else {
      Get.snackbar('Lỗi', 'Sai tên đăng nhập hoặc mật khẩu, vui lòng thử lại.',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      isProcessing.value = false;
    }
  }

  //Edit User Profile

  void navigateUser(String uid) async {
    await getUserLogged(uid);
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> getUserLogged(String userNo) async {
    UserModel data = await repository.getUserLogged(userNo);
    userLogged = data.obs;
    update();
  }

  void register() async {
    isProcessing.value = true;
    await repository.register(
        email: emailController.text,
        password: passwordController.text,
        user: usernameController.text);
    isProcessing.value = false;
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar('Success', 'Register success',
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.green);
  }
}
